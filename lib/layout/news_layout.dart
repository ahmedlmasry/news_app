import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News Layout'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              cubit.changeIndex(index);
            },
            currentIndex: cubit.currentindex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), label: 'Business'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports), label: 'Sports'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science), label: 'Science'),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        );
      },
    );
  }
}
