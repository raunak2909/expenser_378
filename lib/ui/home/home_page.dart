/*
import 'package:expenser_378/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    height: 150,
                    padding: EdgeInsets.all(11),
                    child: Column(
                      children: [
                        Text(
                          'Logout?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setInt(AppConstants.PREF_USER_ID_KEY, 0);
                                Navigator.pushReplacementNamed(context, AppRoutes.LOGINPAGE);
                              },
                              child: Text("Yes", style: TextStyle(color: Colors.red, fontSize: 16)),
                            ),
                            SizedBox(width: 11),
                            OutlinedButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: Text("No", style: TextStyle(color: Colors.green, fontSize: 16))),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
        backgroundColor: Colors.green,
      ),
    );
  }
}
*/


import 'dart:math';

import 'package:expenser_378/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/routes/app_routes.dart';
import 'bloc/expense_bloc.dart';
import 'bloc/expense_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _Home_PageState();
}

class _Home_PageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Row(
        children: [
          Container(
              width: 25,
              height: 25,
              child: Image.asset("assets/images/logo_expansive.png", width: 50, height: 50, fit: BoxFit.fill,)),
          Text("Monety",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black
          ),),
        ],
      ),),

      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: AssetImage("assets/images/soumik_profile.jpg"),
                              fit: BoxFit.cover)
                      ),
                    ) ,
                    SizedBox(width: 5,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Morning",style: TextStyle(fontSize: 18,color: Colors.black54),),
                        Text("Soumik Nath",style: TextStyle(fontSize: 20,),)
                      ],
                    ),

                    Spacer(),

                    Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('This month',style: TextStyle(fontSize: 20),),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    )
                  ],
                ),

              ),

              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Expense total',style: TextStyle(color: Colors.white,fontSize: 15),),
                      Text('\$3734',style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),),
                      Row(
                        children: [
                          Container(
                              color:Colors.red,
                              child: Text('\$-240',style: TextStyle(color: Colors.white,fontSize: 15),)),
                          SizedBox(width: 10,),
                          Text('than last month',style: TextStyle(color: Colors.white,fontSize: 15),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Text('Expense List',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),

              Expanded(
                child: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state){

                  if(state is ExpenseLoadingState){
                    return Center(child: CircularProgressIndicator(),);
                  }

                  if(state is ExpenseLoadedState) {
                    return state.allExp.isNotEmpty ? ListView.builder(
                      itemCount: state.allExp.length,
                        itemBuilder: (_, index){

                        String imgPath = AppConstants.mCatList.where((e){
                          return e.catId == state.allExp[index].cat_id;
                        }).toList()[0].catImg;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 11.0),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100,
                                borderRadius: BorderRadius.circular(11)
                              ),
                              child: Image.asset(imgPath),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.allExp[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Text(state.allExp[index].desc,style: TextStyle(fontSize: 15,color: Colors.black87),),
                              ],
                            ),
                            Spacer(),
                            Text('-\$ ${state.allExp[index].amt}',style: TextStyle(fontSize: 20,color: Colors.pink.shade200),)
                          ],
                        ),
                      );
                    }) : Center(
                      child: Text("No Expenses Found!!",style: TextStyle(fontSize: 20),)
                    );
                  }

                  if(state is ExpenseErrorState) {
                   return Center(child: Text(state.errorMsg),);
                  }


                  return Container();
                }),
              )

              /*Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: Colors.black38
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Tuesday,18',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Spacer(),
                          Text('\$ 1380',style: TextStyle(fontSize: 20),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),

                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            color: Colors.lightBlue.shade50,
                            child: Icon(Icons.shopping_cart,color: Colors.blue,),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shop',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text('Buy new clothes',style: TextStyle(fontSize: 15,color: Colors.black87),),
                            ],
                          ),
                          Spacer(),
                          Text('-\$ 90',style: TextStyle(fontSize: 20,color: Colors.pink.shade200),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            color: Colors.orange.shade50,
                            child: Icon(Icons.mobile_friendly,color: Colors.orange,),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Electronic',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text('Buy new iphone 14',style: TextStyle(fontSize: 15,color: Colors.black87),),
                            ],
                          ),
                          Spacer(),
                          Text('-\$ 1290',style: TextStyle(fontSize: 20,color: Colors.pink.shade200),)
                        ],
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: Colors.black38
                    ),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Monday,15',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          Spacer(),
                          Text('\$ 80',style: TextStyle(fontSize: 20),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),

                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            color: Colors.red.shade50,
                            child: Icon(Icons.car_repair,color: Colors.red,),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Transportaion',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              Text('Trip to Malang',style: TextStyle(fontSize: 15,color: Colors.black87),),
                            ],
                          ),
                          Spacer(),
                          Text('-\$ 60',style: TextStyle(fontSize: 20,color: Colors.pink.shade200),)
                        ],
                      ),


                    ],
                  ),
                ),
              ),*/




            ],
          ),
        ),

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, AppRoutes.ADDEXPENSEPAGE);
      }, child: Icon(Icons.add),),
    );

  }
}