


import 'package:flutter/material.dart';
import 'package:validation_ektp/utils/strings.dart';

class CardHomeWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(padding: EdgeInsets.all(16.9),child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(Strings.HELP, style: theme.textTheme.headline6,),
        ),
        Text(Strings.DESKRIPSI)
      ],),),
    );
  }
}