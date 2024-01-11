import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eg_news_app/cubit/states.dart';
import 'package:eg_news_app/modules/business/business_screen.dart';
import 'package:eg_news_app/modules/technology/technology_screen.dart';
import 'package:eg_news_app/modules/science/science_screen.dart';
import 'package:eg_news_app/modules/sports/sports_screen.dart';
import 'package:eg_news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
          Icons.business_outlined,
      ),
      label: 'بيزنس',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.science_outlined,
      ),
      label: 'علوم',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.sports_outlined,
      ),
      label: 'رياضة',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.phone_android,
      ),
      label: 'تكنولوجيا',
    ),
  ];

  List<Widget> screens =
  [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    TechnologyScreen(),
  ];

  
  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index == 0){}
      getScience();
    if(index == 1){}
    getSports();
    if(index == 2){}
    getTechnology();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    if(business.length == 0)
    {
      DioHelper.getData(
        url: 'v4/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apikey':'0bca96337c88c5cea2ac8df096c7a321',
        },
      ).then((value)
      {
        // print(value.data['articles'][0]['title']);
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else
      {
        emit(NewsGetBusinessSuccessState());
      }
  }

  List<dynamic> science = [];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0)
    {
      DioHelper.getData(
        url: 'v4/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey':'0bca96337c88c5cea2ac8df096c7a321',
        },
      ).then((value)
      {
        // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
      {
        emit(NewsGetScienceSuccessState());
      }
  }

  List<dynamic> sports = [];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getData(
        url: 'v4/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apikey':'0bca96337c88c5cea2ac8df096c7a321',
        },
      ).then((value)
      {
        // print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
      {
        emit(NewsGetSportsSuccessState());
      }
  }

  List<dynamic> technology = [];
  void getTechnology()
  {
    emit(NewsGetTechnologyLoadingState());
    if(technology.length == 0)
    {
      DioHelper.getData(
        url: 'v4/top-headlines',
        query: {
          'country':'eg',
          'category':'technology',
          'apikey':'0bca96337c88c5cea2ac8df096c7a321',
        },
      ).then((value)
      {
        // print(value.data['articles'][0]['title']);
        technology = value.data['articles'];
        print(technology[0]['title']);
        emit(NewsGetTechnologySuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetTechnologyErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetTechnologySuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());


    DioHelper.getData(
      url: 'v4/search',
      query: {
        'q':'$value',
        'apikey':'0bca96337c88c5cea2ac8df096c7a321',
      },
    ).then((value)
    {
      // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}