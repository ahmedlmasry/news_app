import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/network/cache_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  void changeIndex(int index) {
    currentindex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsChangeBottomNavState());
  }

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  List<dynamic> business = [];

  void getBusiness() {
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '2c7f86357a0b47dea2c1f30794d868b4',
    }).then((value) {
      business = value.data['articles'];

      //  print(value.data['articles'][0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '2c7f86357a0b47dea2c1f30794d868b4',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        // print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '2c7f86357a0b47dea2c1f30794d868b4',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        // print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> searsh = [];

  void getSearsh(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '2c7f86357a0b47dea2c1f30794d868b4',
    }).then((value) {
      searsh = value.data['articles'];

      print(searsh[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }
  }
}
