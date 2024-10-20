import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  File? image;
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  bool isFlashOn = false;

  // Lấy camera có sẵn và khởi tạo camera controller
  Future<void> availableCamerasAndInitialize() async {
    try {
      // Lấy danh sách camera có sẵn
      final cameras = await availableCameras();
      // Chọn camera đầu tiên trong danh sách
      final firstCam = cameras.first;

      // Khởi tạo controller với camera đã chọn
      _controller = CameraController(
        firstCam,
        ResolutionPreset.high,
      );

      // Khởi tạo camera và lưu lại Future để sử dụng trong FutureBuilder
      setState(() {
        _initializeControllerFuture = _controller.initialize();
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Gọi hàm khởi tạo camera khi bắt đầu widget
    availableCamerasAndInitialize();
  }

  @override
  void dispose() {
    // Đảm bảo giải phóng camera controller khi không còn sử dụng
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chụp ảnh xác thực ở đây'),
      ),
      // Sử dụng FutureBuilder để đợi camera khởi tạo xong
      body: _initializeControllerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Khi camera đã khởi tạo, hiển thị preview
                  return Stack(
                    children: [
                      SizedBox(
                          height: screenH, child: CameraPreview(_controller)),
                      Positioned(
                        top: 20,
                        right: 5,
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isFlashOn = !isFlashOn;
                                    });
                                  },
                                  icon: isFlashOn
                                      ? const Icon(Icons.flash_on_outlined,
                                          color: Colors.white70)
                                      : const Icon(
                                          Icons.flash_off_rounded,
                                          color: Colors.white60,
                                        )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  // Khi camera chưa khởi tạo xong, hiển thị vòng tròn loading
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.5),
        shape: const CircleBorder(),
        heroTag: "CameraTag",
        onPressed: () async {
          try {
            // Đợi camera khởi tạo xong trước khi chụp ảnh
            await _initializeControllerFuture;
            // Chụp ảnh
            final imageFile = await _controller.takePicture();
            // Trả về file ảnh đã chụp
            Navigator.pop(context, File(imageFile.path));

            // setState(() {
            //   image = File(imageFile.path);
            // });
          } catch (e) {
            print('Error taking picture: $e');
          }
        },
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
