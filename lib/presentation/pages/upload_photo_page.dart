import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/upload_photo_bloc/upload_photo_bloc.dart';
import '../blocs/upload_photo_bloc/upload_photo_event.dart';
import '../blocs/upload_photo_bloc/upload_photo_state.dart';

class UploadPhotoPage extends StatefulWidget {
  final String token;

  const UploadPhotoPage({super.key, required this.token});

  @override
  State<UploadPhotoPage> createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File? selectedImage;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  void uploadImage() {
    if (selectedImage != null) {
      context.read<UploadPhotoBloc>().add(
        UploadPhotoRequested(
          file: selectedImage!,
          token: widget.token,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadPhotoBloc, UploadPhotoState>(
      listener: (context, state) {
        if (state is UploadPhotoSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fotoğraf yüklendi ✅')),
          );
          // Profil sayfasına yönlendirme yapılabilir
        } else if (state is UploadPhotoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hata: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Column(
                children: [
                  // Geri Dön Butonu
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    'Profil Detayı',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Fotoğraflarınızı Yükleyin',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Resources out incentivize relaxation floor loss cc.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: selectedImage != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(selectedImage!, fit: BoxFit.cover),
                      )
                          : const Center(
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state is UploadPhotoLoading ? null : uploadImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is UploadPhotoLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Devam Et', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
