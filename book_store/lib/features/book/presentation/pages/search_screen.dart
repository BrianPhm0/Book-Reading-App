import 'dart:async';

import 'package:book_store/core/common/widgets/dialog.dart';
import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/business/entities/book_by_category/book_item.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/pages/bottomnav/categories/user_book_args.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  final List<BookItem> _allBooks = [];
  final List<BookItem> _filteredBooks = [];
  final int _pageNumber = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _preloadBooks();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _controller.addListener(_onSearchChanged);
  }

  Future<void> _preloadBooks() async {
    // Load initial book data once when the screen loads
    context
        .read<BookBloc>()
        .add(SearchBookEvent('', _pageNumber.toString(), _pageSize.toString()));
  }

  void _onSearchChanged() {
    // Filter books locally as user types, without triggering an API call
    setState(() {
      _filteredBooks.clear();
      _filteredBooks.addAll(
        _allBooks.where((book) =>
            book.title.toLowerCase().contains(_controller.text.toLowerCase())),
      );
    });
  }

  void _handleSearchSubmit() {
    // Call the API on submit and update `_allBooks` with new results
    context.read<BookBloc>().add(
          SearchBookEvent(
              _controller.text, _pageNumber.toString(), _pageSize.toString()),
        );
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleCancel() {
    _controller.clear();
    _focusNode.unfocus();
    setState(() {
      _filteredBooks.clear();
      _filteredBooks.addAll(_allBooks); // Reset to show all preloaded books
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Search',
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {
          if (state is SearchBookSuccess) {
            setState(() {
              _allBooks.clear();
              _allBooks.addAll(state.searchBook);
              _filteredBooks.clear();
              _filteredBooks.addAll(_allBooks); // Display updated book list
            });
          }
        },
        builder: (context, state) {
          if (state is BookLoading && _allBooks.isEmpty) {
            return const Center(child: Loader(size: 50.0, color: Colors.black));
          } else {
            return GestureDetector(
              onTap: () {}, // Prevents losing focus when tapping outside
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _isFocused
                                ? MediaQuery.of(context).size.width * 0.7
                                : MediaQuery.of(context).size.width,
                            child: TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              style: const TextStyle(
                                fontFamily: 'Schyler',
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.grey[50],
                                filled: true,
                                hintStyle:
                                    const TextStyle(fontFamily: 'Schyler'),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                suffixIcon: _controller.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.close_rounded,
                                            color: Colors.grey),
                                        onPressed: _handleCancel,
                                      )
                                    : null,
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                hintText: "Search",
                              ),
                              onSubmitted: (_) => _handleSearchSubmit(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Visibility(
                          visible: _isFocused,
                          child: InkWell(
                            onTap: _handleCancel,
                            child: const TextCustom(
                              text: "Cancel",
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredBooks.length,
                        itemBuilder: (context, index) {
                          return _buildReview(
                              context, index, _filteredBooks[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildReview(
    BuildContext context,
    int index,
    BookItem book,
  ) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRoute.detailBook.name,
          extra: UserBookArgs(
            book: book,
          ),
        );
      },
      child: ListTile(
        leading: const Icon(
          Icons.search_rounded,
          size: 20,
        ),
        title: TextCustom(
            text: book.title, maxLines: 1, fontSize: 20, color: Colors.black),
      ),
    );
  }
}
