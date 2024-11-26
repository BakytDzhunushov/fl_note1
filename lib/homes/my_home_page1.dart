import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_note1/homes/add_node_page1.dart';
import 'package:fl_note1/model/node_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key});

  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {

  Stream<QuerySnapshot> readNodes() {
    final db = FirebaseFirestore.instance;
    return db.collection('nodes').snapshots();
  }

Future<void> updateNode(Node node) async{
  final db = FirebaseFirestore.instance;
  await db.collection("nodes").doc(node.id).update({'isCompleted': !node.isCompleted});
} 

Future<void> deleteNode(Node node) async{
  final db = FirebaseFirestore.instance;
  await db.collection("nodes").doc(node.id).delete();
}
  Future<void> editNode(Node node) async {
  final db = FirebaseFirestore.instance;
  await db.collection("nodes").doc(node.id); //.create({'isCompleted': !node.isCompleted});
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Заметки'),
      ),
      body: StreamBuilder(stream: readNodes(),
        builder:(context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final List <Node> nodes = snapshot.data!.docs.map((e) => 
          Node.fromMap(e.data() as Map<String, dynamic>)).toList(); //..id=e.id
          return ListView.builder(itemCount: nodes.length,            
            itemBuilder: (BuildContext, int Index) {
              final Node = nodes[Index];
              return Card(
                child: ListTile(
                    title: Text(Node.title),
                    trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(value: Node.isCompleted,
                          onChanged: (value) async {await updateNode(Node);},),
                          IconButton(onPressed: () async {await deleteNode(Node);}, icon: Icon(Icons.delete),),
                          IconButton(onPressed: () async {await editNode(Node);}, icon: Icon(Icons.create),),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(Node.description ?? ''),
                        Text(Node.author),
                      ],
                    ),
                  ),
              );
            });
        } else {return const Center(child: Text("Error!"));}
      },),      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const AddNodePage1(),));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}