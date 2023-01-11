import 'package:github_api/models/repository_model.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'models/last_commit_model.dart';

class ServiceAPI{
  Future<List<Repository>> fetchRepositories() async {
    List<Repository> repositories = [];
    try{
      Response response = await get(Uri.parse('https://api.github.com/users/freeCodeCamp/repos'));
      List listResponse = jsonDecode(response.body);
      for(int i = 0; i < listResponse.length; i++){
        Repository repository = Repository.fromMap(listResponse[i]);
        if(repository.isPublic) repositories.add(repository);
      }
    }
    catch(e){
      if(kDebugMode)print(e);
    }
    return repositories;
  }

  Future<LastCommitModel> getLastCommit(Repository repository) async{
    Response response = await get(Uri.parse(repository.commitUrl));
    List listResponse = jsonDecode(response.body);
    LastCommitModel lastCommitModel = LastCommitModel.fromMap(listResponse[0]['commit']);
    return lastCommitModel;
  }
}