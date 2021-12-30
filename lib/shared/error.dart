import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({ Key? key, this.message = 'something went wrong'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('oops.. \n' + message, style: const TextStyle(fontSize: 20),) ,
    );
  }
}