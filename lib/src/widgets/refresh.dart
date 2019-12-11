import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
class Refresh extends StatelessWidget{
  final Widget child;
  /* يبقي كل لما استخدم كلاس الريفرش واباصيله شيلد هيروح للانستنس وبعد كده هيروح للريفرش انيدكتور*/
  Refresh({this.child});
  Widget build(context){
    final bloc =StoriesProvider.of(context);//give us access to the bloc
    return RefreshIndicator(
      child: child,
      onRefresh: ()async{
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}