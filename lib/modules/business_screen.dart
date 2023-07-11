import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/web_view.dart';
import 'package:news_app/shared/component/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.business.isNotEmpty,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildNewsItem(
                    cubit.business[index],
                    context,
                  ),
              separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
              itemCount: cubit.business.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildNewsItem(article, context, {isSearsh = false}) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('${article['publishedAt']}',
                        style: const TextStyle(color: Colors.grey))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
