//import 'dart:js_interop';

import 'package:fl_note1/model/node_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNodePage1 extends StatefulWidget {
  const AddNodePage1({super.key});

  @override
  State<AddNodePage1> createState() => _AddNodePage1State();
}

class _AddNodePage1State extends State<AddNodePage1> {
  final _formkey = GlobalKey<FormState>();
  bool _isCompleted = false;
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _author = TextEditingController();

  Future<void> addNode() async {
    final db = FirebaseFirestore.instance;
    final node = Node(
        title: _title.text,
        description: _description.text,
        isCompleted: _isCompleted,
        author: _author.text);
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
                decoration: const InputDecoration(
                    hintText: 'Title', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text title';
                      } return null; },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _description,
                maxLines: 8,
                decoration: const InputDecoration(
                    hintText: 'description', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text description';
                      } return null; },
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
                decoration: const InputDecoration(
                    hintText: 'the author', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text author';
                      } return null; },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      showDialog(context: context, builder: (BuildContext context){
                        return const CupertinoAlertDialog(
                          title: Text('Please waiting'),
                          content: Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 30),
                            child: CupertinoActivityIndicator(radius: 20,
                            color: Colors.blue,),),),
                        );
                      });
                      await addNode();
                      Navigator.pop(
                      context,
                    );
                      //Navigator.popUntil(context, (Route) => Route.isFirst);
                    }
                  },
                  icon: const Icon(Icons.publish),
                  label: const Text('Add Node')),
            ],
          ),
        ),
      ),
    );
  }
}