import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list2/comment_bloc.dart';
import 'package:infinite_list2/comment_event.dart';
import 'package:infinite_list2/comment_state.dart';

class InfiniteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InfiniteList();
  }
}

class _InfiniteList extends State<InfiniteList> {
  late CommentBloc _commentBloc;
  final _scrollController = ScrollController();
  final _scrollThreadhold = 250.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentBloc = BlocProvider.of(context);
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        _commentBloc.add(CommentFetchedEvent());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.all(10),
          child:
              BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
            if (state is CommentStateInitial) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            }
            if (state is CommentStateFailure) {
              return Center(
                child: Center(
                  child: Text("Cannot load comments from Server!"),
                ),
              );
            }
            if (state is CommentStateSuccess) {
              final currentState = state as CommentStateSuccess;
              if (currentState.comments.isEmpty) {
                return Center(
                  child: Text("Text is empty!"),
                );
              }
              return ListView.builder(
                controller: _scrollController,
                itemBuilder: ((context, index) {
                  if (index >= state.comments.length) {
                    return Container(
                      alignment: Alignment.center,
                      child: Center(
                          child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 5.5,
                        ),
                      )),
                    );
                  } else {
                    return ListTile(
                      title: Text(
                        state.comments[index].email.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Text(state.comments[index].id.toString()),
                      isThreeLine: true,
                      subtitle: Text(
                        state.comments[index].body.toString(),
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                }),
                itemCount: state.hasReachedEnd
                    ? state.comments.length
                    : state.comments.length + 1,
              );
            }
            return Center(
              child: Text("if u see this text, u worng something!@@"),
            );
          })),
    );
  }
}
