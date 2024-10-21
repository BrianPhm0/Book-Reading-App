import 'package:book_store/core/common/cubits/cubit/user_cubit.dart';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/business/entities/user.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/book_bloc.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/detail_book_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBooksScreen extends StatefulWidget {
  final int bookTypeId;
  final String bookTypeName;

  const CategoriesBooksScreen({
    super.key,
    required this.bookTypeId,
    required this.bookTypeName,
  });

  @override
  State<CategoriesBooksScreen> createState() => _CategoriesBooksScreenState();
}

class _CategoriesBooksScreenState extends State<CategoriesBooksScreen> {
  @override
  void initState() {
    super.initState();
    final state = context.read<BookBloc>().state;
    if (state is! BooksByTypeSuccess) {
      context.read<BookBloc>().add(GetBooksByType(widget.bookTypeId));
      // context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    }
  }

  Widget buildItem(BuildContext context, int index, String title,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'assets/book_cover/book_cover.png',
        fit: BoxFit.contain, // Maintains the original aspect ratio
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.bookTypeName,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Biểu tượng quay lại
          onPressed: () {
            context.read<BookBloc>().add(GetAllBookType());
            Navigator.of(context).pop(); // Quay lại trang trước đó
          },
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, authState) {
          // print(authState);
          User? user;
          if (authState is UserLoggedIn) {
            user = authState.user;
            print(user);
          }
          return BlocConsumer<BookBloc, BookState>(
            listener: (context, state) {
              if (state is BookFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.toString())),
                );
              }
            },
            builder: (context, state) {
              // print("catebook: + ${state}");

              if (state is BookLoading) {
                return const Center(
                    child: Loader(size: 50.0, color: Colors.black));
              } else if (state is BooksByTypeSuccess) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        mainAxisExtent: 280,
                        crossAxisSpacing: 15, // Horizontal spacing
                        mainAxisSpacing: 15, // Vertical spacing
                      ),
                      itemBuilder: (context, index) => buildItem(
                        context,
                        index,
                        state.booksByType[index].title,
                        onTap: () {
                          _showDetailBookSheet(
                              context, state.booksByType[index], user!);
                        },
                      ),
                      itemCount: state.booksByType.length,
                    );
                  },
                );
              } else if (state is BookFailure) {
                return Center(child: Text(state.toString()));
              }
              return const Center(child: Text('Unknown state'));
            },
          );
        },
      ),
    );
  }

  void _showDetailBookSheet(BuildContext context, Book book, User user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DetailBookBottomSheet(
          book: book,
          user: user,
        );
      },
      isScrollControlled: true,
    );
  }
}
