import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_details.dart';
import 'blocs/comments_provider.dart';
class App extends StatelessWidget{
  Widget build(context){
    return CommentsProvider(
      child: StoriesProvider(
      child: MaterialApp(
        title: 'News!',
        onGenerateRoute: routes,
      ),
    ) ,
    );
  }

  Route routes(RouteSettings settings){
    if(settings.name=='/'){
      return MaterialPageRoute(
            builder: (context){
              final storiesBloc=StoriesProvider.of(context);
              storiesBloc.fetchTopIds();

              return NewsList();
            });
    }else{
      return MaterialPageRoute(
        builder: (context){
          //extract the id from settings.name and pass into NewsDetail
          //a fantastic location to do some intialization or data fetching for NewsDetail
          final commentsbloc=CommentsProvider.of(context);
         final itemId= int.parse(settings.name.replaceFirst('/', ''));
//fetching data
          commentsbloc.fetchItemWithComments(itemId);

          return NewsDetail(
            itemId:itemId,
          );
        }
      );
    }

          
        
  }
}