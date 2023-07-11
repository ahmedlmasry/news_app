import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business_screen.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.science.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildNewsItem(cubit.science[index], context),
              separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
              itemCount: cubit.science.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
