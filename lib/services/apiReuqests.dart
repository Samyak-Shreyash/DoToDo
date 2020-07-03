//
//import 'package:dotodo/models/task.dart';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart';
//import 'jwtConfig.dart';
//
  //class TaskActions {
  //  final String _baseUrl = "https://us-central1-dotodo-web.cloudfunctions.net/app";
//
//   get _token async => await JWTConfig().readJWTToken(key: "jwt");
//
//  Future<Map<String, String>> getHeaders() async
//  {
//    Map<String, String> headers = {
//      'authorization': await _token,
//      'Content-Type': 'application/json; charset=UTF-8'};
//  return headers;
//  }
//
//  Future<void> deleteTask(Task task) async {
//    final _queryParameters = {
//      'taskID': task.id,
//    };
//    try {
////      Uri _url = Uri.http(_baseUrl, '/tasks', _queryParameters);
//      Uri _url = Uri.parse(_baseUrl+'/tasks/'+_queryParameters['taskID']);
//      print(_url);
//      Response _response = await delete(_url,
//        headers: await getHeaders(),);
//      print(_response.statusCode);
//    }
//    catch(e)
//    {
//      print(e);
//    }
////    return response.statusCode == 207 ? true : false;
//  }
//
//  Future<void> renameTask(Task task) async {
//
//    final _queryParameters = {
//      'taskID': task.id,
//    };
//    try {
//
//      Uri _url = Uri.parse(_baseUrl+'/tasks/'+_queryParameters['taskID']);
//      print(_url);
//      Response _response = await delete(_url,
//        headers: await getHeaders(),);
//      print(_response.statusCode);
//    }
//    catch(e)
//    {
//      print(e);
//    }
////    return response.statusCode == 207 ? true : false;
//  }
//
//}
