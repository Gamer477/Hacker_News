import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main(){
  test('FetchTipIds returns a list of ids', ()async{
    //setup of test case
    //final sum=1+3;
    final newsApi=NewsApiProvider();
   newsApi.client= MockClient((request) async{
      return Response(json.encode([1,2,3,4]),200);
    });

    //expectation هدفها اني اشوف شوية value أللي انا متوقعها
    //expect(sum,4);
    final ids=await newsApi.fetchTopIds();
    expect(ids, [1,2,3,4]);
    //اول قيمة فنشكن اكسيبكت بتاخدها هي الحاجة اللي هعملها تست والتانية الي هتوقع تطلعلها
  });
  test('FetchItem return itemModel', ()async{
    final newsApi=NewsApiProvider();

    newsApi.client=MockClient((request) async{
      final jsonMap={'id':123};
      return Response(json.encode(jsonMap),200);
    });
    final item=await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
  
  
  
}