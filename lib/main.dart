import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list2/comment_bloc.dart';
import 'package:infinite_list2/comment_event.dart';
import 'package:infinite_list2/service.dart';

import 'infiniteList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Flutter demo",
      home: BlocProvider(
        create: (context) {
          final commentBloc = CommentBloc();
          commentBloc.add(CommentFetchedEvent());
          return commentBloc;
        },
        child: InfiniteList(),
      ),
    );
  }
}
