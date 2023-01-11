import 'package:flutter/material.dart';
import 'package:github_api/common/loader.dart';
import 'package:github_api/models/repository_model.dart';
import 'package:github_api/screens/last_commit_screen.dart';
import 'package:github_api/service.dart';
import 'package:intl/intl.dart';
class GitRepositoriesScreen extends StatefulWidget {
  const GitRepositoriesScreen({Key? key}) : super(key: key);

  @override
  State<GitRepositoriesScreen> createState() => _GitRepositoriesScreenState();
}

class _GitRepositoriesScreenState extends State<GitRepositoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GitHub Repositories"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        color: Colors.black,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  'freeCodeCamp',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Text(
                  'Repositories : ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(),
              FutureBuilder(
                future: ServiceAPI().fetchRepositories(),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Loader();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {

                      Repository repository = snapshot.data![index];
                      String date = '${DateFormat.yMd().format(repository.createdAt)}\n${DateFormat.jm().format(repository.createdAt)}';
                      String updateDate = DateFormat.yMMMMd('en_US').format(repository.updatedAt);

                      return Material(
                        color: Colors.black,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context){
                                      return LastCommit(repository: repository);
                                    }
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: ListTile(
                                  title: Text(
                                    repository.name,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          repository.description,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 18),
                                        Row(
                                          children: [
                                            const Icon(Icons.remove_red_eye, color: Colors.blueGrey, size: 18),
                                            const SizedBox(width : 3),
                                            Text(repository.viewers.toString(), style: const TextStyle(color: Colors.blueGrey, fontSize: 12),),
                                            const SizedBox(width : 16),
                                            Text("Updated on $updateDate", style: const TextStyle(color: Colors.grey, fontSize: 12),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(),
                                      Text(
                                        date,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(color: Color.fromRGBO(37, 45, 50, 1)),
                          ],
                        ),
                      );
                    }
                  );
                },
              )
            ],

          ),
        ),
      ),
    );
  }
}
