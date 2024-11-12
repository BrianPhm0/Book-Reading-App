import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';

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
    return BlocConsumer<BookBloc, BookState>(
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
        } else if (state is PurchaseBookSuccess) {
          if (state.purchaseBook.isEmpty) {
            return const Center(child: Text('No purchased books found.'));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(
              title: 'Library',
            ),
            body: Container(
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
                          extra: 'assets/ebook/harry_potter.pdf',
                        );
                      },
                      child:
                          buildItem(context, index, state.purchaseBook[index]));
                },
                itemCount: state.purchaseBook.length,
              ),
            ),
          );
        }
        return Center(
          child: Text('Unknown state: ${state.toString()}'),
        );
      },
    );
  }
}
