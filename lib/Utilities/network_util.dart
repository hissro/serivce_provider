import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkUtil
{

  static final NetworkUtil _instance = NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;
  final JsonDecoder _decoder = const JsonDecoder();


  Future<dynamic> get(String url)
  {
    print ('get Start ${url}');
    return http.get(Uri.parse(url), headers:
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).then((http.Response response)
    {
      final String res = response.body;
      final int statusCode = response.statusCode;

      // print('Res: ${response.body}');
      // print('statusCode: ${response.statusCode}');
      debugPrint('NetworkUtil Get :  ${response.body}');

      if (statusCode == 200)
      {
        return json.decode(res);
      }

      if (statusCode == 404) {
        return _decoder.convert(res);
      } else {
        throw Exception("Error while fetching data");
      }
    }, onError: ( e )
    {
      print (' On Error  ${e}');
      return
        {
        "responce":false,
        "data":[]
        };

    });
  }



  Future<dynamic> post(String url, {body, encoding})
  {
    print ('Post Start  ${body}');
    return http.post(Uri.parse(url), body: body, headers: {}, encoding: encoding).then((http.Response response)
    {
      final String res = response.body;
      final int statusCode = response.statusCode;

      debugPrint('NetworkUtil Post :  ${response.body}');

      // print( res.toString() );
      if (statusCode < 200)
      {
        throw Exception("Error while fetching data");
      } else {
        return _decoder.convert(res);
      }
    }, onError: (e)
    {
      debugPrint('NetworkUtil onError:  $e');
      return e;
    });
  }


}
