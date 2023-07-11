import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/shared/component/components.dart';

class SearshScreen extends StatelessWidget {
  var searshController = TextEditingController();

  SearshScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).searsh;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defalutFormfeild(
                  controller: searshController,
                  type: TextInputType.text,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearsh(value);
                  },
                  valdiate: (value) {
                    if (value!.isEmpty) {
                      return 'searsh must not be empty';
                    }
                  },
                  label: 'searsh',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: buildNewsItem(list, context, isSearsh: true))
            ],
          ),
        );
      },
    );
  }
}
