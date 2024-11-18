import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(GetPurchaseBookEvent());
  }

  Widget buildItem(context, index, BookItem book) {
    return Image.network(
      book.image,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Library',
      ),
      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: Loader(size: 50.0, color: Colors.black));
          } else if (state is PurchaseBookSuccess) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 280,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          AppRoute.readingBook.name,
                          extra:
                              'https://firebasestorage.googleapis.com/v0/b/bookstore-59884.appspot.com/o/images%2F374a111f-3fcb-4e72-b0e7-82e2b5dd2e74.pdf?alt=media&token=6ae0e6df-5c46-4a2f-9aea-5b50ab024c7d&fbclid=IwY2xjawGhXlhleHRuA2FlbQIxMAABHV9GWsFmW-0cQB3ZddW55leO5WxuUyvSosBfu5W8Jbg6NJhA5jDlL4LZzQ_aem_O65eTRDhupzUs14EU89FnQ',
                        );
                      },
                      child:
                          buildItem(context, index, state.purchaseBook[index]));
                },
                itemCount: state.purchaseBook.length,
              ),
            );
          }
          return const Center(
              child: TextCustom(
                  text: "Your library is currently empty!",
                  fontSize: 22,
                  color: Colors.black));
        },
      ),
    );
  }
}
