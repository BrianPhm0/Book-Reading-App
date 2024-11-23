
Yêu cầu hệ thống
Trước khi chạy ứng dụng, hãy đảm bảo rằng các yêu cầu sau đã được cài đặt trên máy tính của bạn:

Flutter SDK: Tải xuống và cài đặt Flutter từ flutter.dev.
Dart SDK: Được cài đặt cùng với Flutter SDK.
Android Studio hoặc VS Code: Để phát triển và chạy ứng dụng.
Device Emulator hoặc Thiết bị vật lý: Để kiểm tra ứng dụng.
Git: Để quản lý mã nguồn.


Cách chạy ứng dụng
1. Cài đặt Flutter
Làm theo hướng dẫn tại Flutter Install để cài đặt Flutter SDK.
Đảm bảo cấu hình biến môi trường cho flutter (thêm đường dẫn Flutter SDK vào $PATH).

2. kiểm tra cấu hình môi trường - flutter doctor

3. clone repositoty 

4. cài đặt các dependencies - flutter pub get

5. Nếu chạy bằng web - Vào file api_config.dart đổi baseUrl = 'http://localhost:7274/api';

6. Nếu chạy bằng máy ảo - Vào file api_config.dart đổi baseUrl = 'http://10.0.2.2:7274/api';

Lệnh hữu ích khác
Build ứng dụng:
Android APK: - flutter build apk --release
iOS App: - flutter build ios --release

Xóa bộ nhớ cache: - flutter clean

Kiểm tra lỗi định dạng code: - flutter analyze
