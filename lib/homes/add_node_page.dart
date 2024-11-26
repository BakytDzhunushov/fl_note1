import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_note1/model/node_model.dart';
import 'package:flutter/material.dart';

class AddNodePage extends StatefulWidget {
  const AddNodePage({super.key});

  @override
  State<AddNodePage> createState() => _AddNodePageState();
}

class _AddNodePageState extends State<AddNodePage> {
  final _formkey = GlobalKey<FormState>();
  bool _isCompleted = false;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _author = TextEditingController();

  Future <void> addNode() async {
    final db = FirebaseFirestore.instance;
    final node = Node(title: _title.text, description: _description.text, 
    isCompleted: _isCompleted, author: _author.text);
    await db.collection("nodes").add(node.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Node Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(hintText: 'Title',
                border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _description,
                maxLines: 8,
                decoration: const InputDecoration(hintText: 'description',
                border: OutlineInputBorder()),
              ),
              CheckboxListTile(
                  title: const Text('Is Completed'),
                  value: _isCompleted,
                  onChanged: (v) {
                    setState(() {
                      _isCompleted = v ?? false;
                    });
                  }),
              const SizedBox(height: 20),
              TextFormField(
                controller: _author,
                decoration: const InputDecoration(hintText: 'the author',
                border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(onPressed: () async {
                if (_formkey.currentState!.validate()) {await addNode();}
              }, 
              icon: const Icon(Icons.publish), label: const Text('Add Node')),
            ],
          ),
        ),
      ),
    );
  }
}
