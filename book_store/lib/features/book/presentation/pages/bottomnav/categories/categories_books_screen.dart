import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/user_book_args.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
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

    context.read<BookBloc>().add(GetBooksByType(widget.bookTypeId));
    // context.read<AuthBloc>().add(AuthGetUser());
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Gọi lại sự kiện để load dữ liệu khi quay lại
  //   context.read<BookBloc>().add(GetBooksByType(widget.bookTypeId));
  // }

  Widget buildItem(BuildContext context, int index, String title, String image,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.network(
        image,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          // Show CircularProgressIndicator while loading
          if (loadingProgress == null) {
            return child; // Image fully loaded
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null, // Progress indicator with loaded byte ratio
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          // Show error icon if image fails to load
          return const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
          );
        },
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<BookBloc>().add(GetAllBookType());
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: Loader(size: 50.0, color: Colors.black));
          } else if (state is BookItemSuccess) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisExtent: 280,
                    crossAxisSpacing: 15, // Horizontal spacing
                    mainAxisSpacing: 15, // Vertical spacing
                  ),
                  itemCount: state.bookItem.length,
                  itemBuilder: (context, index) {
                    final book = state.bookItem[index];
                    return buildItem(
                      context,
                      index,
                      book.title,
                      book.image,
                      onTap: () {
                        context.pushNamed(
                          AppRoute.detailBook.name,
                          extra: UserBookArgs(
                            book: state.bookItem[index],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          } else if (state is BookItemFail) {
            return const Center(
                child: TextCustom(
                    textAlign: TextAlign.center,
                    text: "No books available in this category",
                    fontSize: 30,
                    color: Colors.black));
          }
          return const Center(child: Loader(size: 50.0, color: Colors.black));
        },
      ),
    );
  }
}
