import 'package:book_store/core/common/widgets/loader.dart';
import 'package:book_store/features/book/presentation/bloc/book/bloc/category/book_bloc.dart';
import 'package:book_store/features/book/presentation/providers/route.dart';
import 'package:book_store/features/book/presentation/widgets/app_bar.dart';
import 'package:book_store/features/book/presentation/widgets/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    // Chỉ gọi sự kiện để lấy loại sách khi cây widget đã được xây dựng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<BookBloc>().state;
      if (state is! BookTypeSuccess) {
        context.read<BookBloc>().add(GetAllBookType());
      }
    });
  }

  Widget buildItem(BuildContext context, int index, String bookType,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        child: Stack(children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/categories/${index % 8}.png', // Sử dụng tên danh mục cho hình ảnh
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextCustom(
                  textAlign: TextAlign.center,
                  text: bookType,
                  fontSize: 20,
                  maxLines: 3,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Categories',
      ),
      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {
          if (state is BookFailure) {
            // Hiển thị thông báo lỗi nếu có
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.toString())),
            );
          }
        },
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: Loader(size: 50.0, color: Colors.black));
          } else if (state is BookTypeSuccess) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 130,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) => buildItem(
                  context,
                  index,
                  state.bookType[index].bookTypeName,
                  onTap: () {
                    context
                        .read<BookBloc>()
                        .add(GetBooksByType(state.bookType[index].bookTypeId));
                    context.pushNamed(AppRoute.categoriyBooks.name,
                        extra: state.bookType[index]);
                  },
                ),
                itemCount: state.bookType.length, // Sử dụng độ dài danh mục
              ),
            );
          } else if (state is BookFailure) {
            return const Center(
                child: TextCustom(
                    text: "No books available in this category",
                    fontSize: 20,
                    color: Colors.black));
          }
          return Center(
            child: Text('Unknown state: ${state.toString()}'),
          );
        },
      ),
    );
  }
}
