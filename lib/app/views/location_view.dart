import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/location_controller.dart';

class LocationView extends GetView<LocationController> {
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cari Lokasi Anda",
          style: TextStyle(color: Colors.white), // Warna teks menjadi putih
        ),
        backgroundColor:
            const Color.fromARGB(255, 45, 45, 45), // Warna background AppBar
      ),
      body: Container(
        color: Colors.grey[900], // Background abu-abu gelap
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSmoothTextField(
                controller: latitudeController,
                label: "Lintang",
              ),
              const SizedBox(height: 16),
              _buildSmoothTextField(
                controller: longitudeController,
                label: "Bujur",
              ),
              const SizedBox(height: 16),
              _buildSmoothButton(
                label: "Search Location",
                onPressed: () {
                  final lat = double.tryParse(latitudeController.text) ?? 0.0;
                  final lon = double.tryParse(longitudeController.text) ?? 0.0;
                  controller.searchLocation(lat, lon);
                },
              ),
              const SizedBox(height: 16),
              _buildSmoothButton(
                label: "Open in Google Maps",
                onPressed: controller.openGoogleMaps,
              ),
              const SizedBox(height: 16),
              Obx(() => Text(
                    "Lokasi Saat ini: Lintang ${controller.latitude}, Bujur ${controller.longitude}",
                    style: const TextStyle(color: Colors.white),
                  )),

              // Animated Container untuk menampilkan kotak bawah
              const SizedBox(height: 16),
              Obx(() {
                if (controller.latitude != 0.0 && controller.longitude != 0.0) {
                  return AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 300), // Durasi animasi
                    curve: Curves.easeInOut,
                    height:
                        300, // Menyesuaikan dengan tinggi peta atau konten lainnya
                    decoration: BoxDecoration(
                      color: Colors.grey[800], // Warna kotak
                      borderRadius: BorderRadius.circular(8), // Border radius
                    ),
                    child: Center(
                      child: Text(
                        "Peta Lokasi", // Gantilah ini dengan widget peta Anda
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Tidak tampilkan kotak jika koordinat kosong
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Helper untuk TextField
  Widget _buildSmoothTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[800], // Warna abu-abu untuk latar kolom
      ),
      keyboardType: TextInputType.number,
    );
  }

  // Helper untuk ElevatedButton
  Widget _buildSmoothButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[850], // Warna tombol abu-abu gelap
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        shadowColor: Colors.black,
      ).merge(
        ButtonStyle(
          overlayColor:
              WidgetStateProperty.all(Colors.grey[700]), // Animasi hover/klik
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
