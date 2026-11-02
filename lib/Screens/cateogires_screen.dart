import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/Models/categories_new_model.dart';

import '../View_model/news_view_model.dart';

class CateogiresScreen extends StatefulWidget {
  const CateogiresScreen({super.key});

  @override
  State<CateogiresScreen> createState() => _CateogiresScreenState();
}

class _CateogiresScreenState extends State<CateogiresScreen> {

  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMM dd, yyyy");
  String categoryName = "general";

  List<String> categoriesList = [
      "General",
      "Entertainment",
      "Health",
      "Sports",
      "Business",
      "Technology",
  ];


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
   appBar: AppBar(

   ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    categoryName= categoriesList[index];
                    setState(() {

                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color:categoryName == categoriesList[index]? Colors.blue: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Center(child: Text(categoriesList[index].toString(),style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white,
                        ),)),
                      ),
                    ),
                  ),
                );
              }
              ),
            ),
            
            Expanded(
              child: FutureBuilder <CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder:(BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.green,
                      ),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context , index){
              
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context , url) => Container(
                                  child: Center(
                                    child: SpinKitCircle(
                                      size: 50,
                                      color: Colors.green,
                                    ),
                                  ),),
                                errorWidget: (context, url , error) => Icon(Icons.error_outline,color: Colors.red,),
                              ),
                            ),
                          ],
                        ) ;
                      },
                    );
                  }
                },
              
              ),
            ) ,
          ],
        ),
      ),
    );
  }
}

