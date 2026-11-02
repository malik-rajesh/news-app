import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/Models/news_channel_headlines_model.dart';
import 'package:my_news_app/Screens/cateogires_screen.dart';
import 'package:my_news_app/View_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList{ bbcNews, aryNews, independent, reuters, cnn, alJazeera}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu ;

  final format = DateFormat("MMM dd, yyyy");

  String name = "bbc-news" ;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;


    return Scaffold(
      appBar: AppBar(

        leading: IconButton(
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CateogiresScreen()));
          },

          icon: Image.asset("images/category_icon.png",
            width: 30,
            height: 30,
            ),
        ),
        title: Text(" The News Chanel",style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.w700),),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
              icon: Icon(Icons.more_vert_sharp,color: Colors.green,),
              onSelected: (FilterList item){

              if(FilterList.bbcNews.name== item.name){
                name = 'bbc-news';
              }
              if(FilterList.aryNews.name==item.name){
                name = "ary-news";
              }
              if(FilterList.aryNews.name==item.name){
                name = "al-jazeera-english";
              }
              setState(() {

              });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[

            PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child:Text("BBC News"),
            ),
                PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                  child:Text("Ary News"),
                ),
                PopupMenuItem<FilterList>(
                  value: FilterList.alJazeera,
                  child:Text("al-jazeera-english"),
                ),

          ]
          )
        ],
      ),

      body: ListView(
        children: [
              SizedBox(
               height: height * .55,
               width: width,
                child: FutureBuilder <NewsChannelsHeadlinesModel>(
                  future: newsViewModel.fetchNewsChannelsHeadlinesApi(),
                  builder:(BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
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
                          return SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: height * .02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),

                                    child: CachedNetworkImage(imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context , url) => Container(
                                        child: spinkit2,),
                                      errorWidget: (context, url , error) => Icon(Icons.error_outline,color: Colors.red,),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white38,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(15),
                                      height: height * .22,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            child: Text(snapshot.data!.articles! [index].title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                            GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.black,),
                                          ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles! [index].source! .name.toString(),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.black,),
                                                ),
                                                Text(format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                  GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black,),
                                                ),

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },

                  ) ,
              ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.green,
  size: 50.0,
);
