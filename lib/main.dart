import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/component/bloc_observer.dart';
import 'package:news_app/shared/network/cache_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

import 'layout/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  // bool isDark = CacheHelper.getData(key: 'isDark');
}

class MyApp extends StatelessWidget {
//  final bool isDark;
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..changeAppMode(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.dark,
              home: const NewsLayout());
        },
      ),
    );
  }
}
