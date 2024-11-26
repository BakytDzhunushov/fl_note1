import 'package:fl_note1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fl_note1/features/home/presentation/pages/notebook_page.dart';
import 'package:fl_note1/features/home/presentation/widgets/notes_search_delegate.dart';
import 'package:fl_note1/homes/my_home_page.dart';
//import 'package:fl_note1/homes/my_home_page.dart';
import 'package:fl_note1/homes/my_home_page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../user_profile/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthSuccess) {
            return Drawer(
              backgroundColor: const Color.fromARGB(255, 148, 200, 70),
              child: ListView(children: [
                DrawerHeader(
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      color: Colors.lightGreen,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilePage(),
                                  ));
                            },
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/5987/5987429.png',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${state.user!.displayName}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            state.user!.email.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ])),
                ListTile(
                  leading: const Icon(Icons.note_add, color: Colors.white),
                  title: const Text(
                    'Мои заметки',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage1(),
                                  ));
                    //Navigator.pop(context); // Меню жабылат
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.note_add, color: Colors.white),
                  title: const Text(
                    'Наши заметки',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MyHomePage(title: 'Наши заметки'),
                                  ));
                    //Navigator.pop(context); // Меню жабылат
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.white),
                  title: const Text('Настройки',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode, color: Colors.white),
                  title: const Text('Темная тема',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  trailing:
                      const Icon(Icons.chevron_right, color: Colors.white),
                )
              ]),
            );
          } else if (state is AuthFailure) {
            return const Center(
              child: Text('Error'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue[700],
        automaticallyImplyLeading: true,
        title: const Text(
          "Мои заметки",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NotesSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NoteBookPage()));
            },
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green[200],
              child: const Icon(Icons.create_new_folder, color: Colors.white),
            ),
            title: const Text(
              "Задачи на работе",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Не забудьте записать планы"),
                Text(
                    "${DateTime.now().hour}:${DateTime.now().minute}   ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}"),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.purpleAccent,
              ),
              onPressed: () {},
            ),
          ),
          separatorBuilder: (context, index) => const Divider(
            indent: 20,
            endIndent: 20,
          ),
          itemCount: 5,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteBookPage(),
            ),
          );
        },
      ),
    );
  }
}