// Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

// LocalStorageUtil
import '../../tools/shared_preferences_util.dart';

class BooksState {
  final List<Map<String, dynamic>> books;
  final Map<String, dynamic>? currentBook;

  const BooksState({this.books = const [], this.currentBook});

  // 创建新状态的方法 - 类似于 Vue 的响应式更新
  BooksState copyWith({
    List<Map<String, dynamic>>? books,
    Map<String, dynamic>? currentBook,
  }) {
    return BooksState(
      books: books ?? this.books,
      currentBook: currentBook ?? this.currentBook,
    );
  }
}

class BooksNotifier extends StateNotifier<BooksState> {
  BooksNotifier() : super(const BooksState()) {
    _loadCurrentBookFromCache();
  }

  // 从缓存中加载当前书籍
  void _loadCurrentBookFromCache() {
    final bookId = SharedPreferencesUtil.getInt('currentBookId');
    final bookName = SharedPreferencesUtil.getString('currentBookName');
    final bookDescription = SharedPreferencesUtil.getString(
      'currentBookDescription',
    );
    final bookColor = SharedPreferencesUtil.getString('currentBookColor');

    if (bookId != null && bookName != null) {
      final currentBook = {
        'id': bookId,
        'name': bookName,
        'description': bookDescription ?? '',
        'color': bookColor ?? '',
      };
      state = state.copyWith(currentBook: currentBook);
    }
  }

  // 更新当前选中的书籍
  void selectBook(Map<String, dynamic> book) {
    state = state.copyWith(currentBook: book);
    SharedPreferencesUtil.setInt('currentBookId', book['id']);
    SharedPreferencesUtil.setString('currentBookName', book['name']);
    SharedPreferencesUtil.setString(
      'currentBookDescription',
      book['description'],
    );
    SharedPreferencesUtil.setString('currentBookColor', book['color']);
  }

  // 更新书籍列表
  void updateBooks(List<Map<String, dynamic>> books) {
    print('更新书籍列表: $books');
    state = state.copyWith(books: books);
  }
}

final booksProvider = StateNotifierProvider<BooksNotifier, BooksState>((ref) {
  return BooksNotifier();
});
