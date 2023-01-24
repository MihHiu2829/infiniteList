import 'package:equatable/equatable.dart';
import 'package:infinite_list2/comment.dart';

abstract class CommentState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CommentStateInitial extends CommentState {}

class CommentStateFailure extends CommentState {}

class CommentStateSuccess extends CommentState {
  final List<Comment> comments;
  final bool hasReachedEnd;
    CommentStateSuccess(
      {required this.comments, required this.hasReachedEnd});
  @override
  // TODO: implement props
  List<Object?> get props => [comments, hasReachedEnd];

  CommentStateSuccess cloneWith(bool hasReachedEnd ) {
    return CommentStateSuccess(
        comments: this.comments, hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}
