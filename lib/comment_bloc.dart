import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list2/comment_event.dart';
import 'package:infinite_list2/comment_state.dart';
import 'package:infinite_list2/service.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final NUMBER_OF_COMMENTS_PER_PAGE = 20;
  CommentBloc() : super(CommentStateInitial());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    try {
      final hasReachedEndOfOnePage = (state is CommentStateSuccess &&
          (state as CommentStateSuccess).hasReachedEnd);
      if (event is CommentFetchedEvent && !hasReachedEndOfOnePage) {
        if (state is CommentStateInitial) {
          final commnents =
              await getCommentFormAPI(0, NUMBER_OF_COMMENTS_PER_PAGE);
          yield CommentStateSuccess(comments: commnents, hasReachedEnd: false);
        } else if (state is CommentStateSuccess) {
          final currentState = state as CommentStateSuccess;

          int finalIndexOfCurrentPage = (currentState).comments.length;
          final comments = await getCommentFormAPI(
              finalIndexOfCurrentPage, NUMBER_OF_COMMENTS_PER_PAGE);
          if (comments.isEmpty) {
            (currentState).cloneWith(true);
          } else
            yield CommentStateSuccess(
                comments: currentState.comments + comments,
                hasReachedEnd: false);
        }
      }
    } catch (exception) {
      yield CommentStateFailure();
    }
  }
}
