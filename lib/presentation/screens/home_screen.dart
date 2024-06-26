import 'package:api_example/data/models/post_model.dart';
import 'package:api_example/logic/cubits/post_cubit/post_cubit.dart';
import 'package:api_example/logic/cubits/post_cubit/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API Handling"),
      ),
      body: SafeArea(
          child: BlocConsumer<PostCubit, PostState>(
        listener: (context, state) {
          if (state is PostErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.errorMsg),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: snackBar));
          }
        },
        builder: (context, state) {
          if (state is PostLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is PostSuccessState) {
            return buildPostView(state.posts);
          }
          return Center(
            child: Text("An Error Occured!"),
          );
        },
      )),
    );
  }

  Widget buildPostView(List<PostModel> posts) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          PostModel post = posts[index];
          return ListTile(
            title: Text(post.title.toString()),
            subtitle: Text(post.body.toString()),
          );
        });
  }
}
