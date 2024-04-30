import 'package:api_example/data/models/post_model.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostSuccessState extends PostState {
  final List<PostModel> posts;
  PostSuccessState(this.posts);
}

class PostErrorState extends PostState {
  final String errorMsg;
  PostErrorState(this.errorMsg);
}
