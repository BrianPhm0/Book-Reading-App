import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/book.dart';
import 'package:book_store/features/book/data/model/book_model.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/book_bloc.dart';
import 'package:book_store/features/book/presentation/pages/detail_book_bottom_sheet.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar_leading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    // Dùng `addPostFrameCallback` để đảm bảo cây widget đã được xây dựng
    final state = context.read<BookBloc>().state;
    if (state is! BooksByTypeSuccess) {
      context.read<BookBloc>().add(GetBooksByType(widget.bookTypeId));
    }
  }

  Widget buildItem(BuildContext context, int index, String title,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),

        child: Image.asset(
          'assets/book_cover/book_cover.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarLeading(
        title: widget.bookTypeName,
        customLeadingIcon: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () {
            context.goNamed(AppRoute.categories.name);
          },
        ),
      ),
      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {
          if (state is BookFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.toString())),
            );
          }
        },
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: Loader(size: 50.0, color: Colors.black));
          } else if (state is BooksByTypeSuccess) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 280,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) => buildItem(
                    context, index, state.booksByType[index].title, onTap: () {
                  _showDetailBookSheet(context, state.booksByType[index]);
                  print(state.booksByType[index]);
                }),
                itemCount: state.booksByType.length,
              ),
            );
          } else if (state is BookFailure) {
            return Center(child: Text(state.toString()));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  void _showDetailBookSheet(BuildContext context, Book book) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DetailBookBottomSheet(book: book);
        },
        isScrollControlled: true);
  }
}
