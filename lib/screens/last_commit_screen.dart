import 'package:flutter/material.dart';
import 'package:github_api/models/last_commit_model.dart';
import 'package:github_api/models/repository_model.dart';
import 'package:github_api/service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/loader.dart';
class LastCommit extends StatelessWidget {
  final Repository repository;
  const LastCommit({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18,18,18,18),
        color: const Color.fromRGBO(31, 44, 52, 1),
        constraints: const BoxConstraints(
          minHeight: 220,
        ),
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<LastCommitModel>(
          future: ServiceAPI().getLastCommit(repository),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Loader();
            }
            String date = DateFormat.yMd().add_jm().format(snapshot.data!.commitAt);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Last Commit', style: TextStyle(color: Colors.white54, fontSize: 22),),
                    IconButton(
                      onPressed: () {Navigator.pop(context);},
                      icon: const Icon(Icons.close, color: Colors.black, size: 24,),
                    ),
                  ],
                ),
                const SizedBox(height: 18,),
                Text(
                  'Author : ${snapshot.data!.author}',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,8),
                  child: Text(
                    snapshot.data!.message,
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  'Updated at $date',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14,),
                InkWell(
                  onTap: () => launchUrl(Uri.parse(repository.url)),
                  child: const Text(
                    'Click here to visit Github Repository',
                    style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontSize: 16),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
