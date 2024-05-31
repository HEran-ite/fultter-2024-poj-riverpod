import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/room.dart';
import 'package:hotel_booking/presentation/pages/rooms_catagories.dart';
import 'package:image_picker/image_picker.dart';


void showEditDialog(BuildContext context, WidgetRef ref, RoomCategory category, int itemIndex) {
  TextEditingController descriptionController = TextEditingController(text: category.descriptions[itemIndex]);
  TextEditingController priceController = TextEditingController(text: category.prices[itemIndex].toString());
  String? imagePath;
  String? base64Image;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 252, 241, 230),
        title: const Text('Edit Room'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imagePath = pickedFile.path;
                      final bytes = await pickedFile.readAsBytes();
                      base64Image = base64Encode(bytes);
                    }
                  } catch (e) {
                    print('Error picking image: $e');
                  }
                },
                child: const Text('Select Image'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final description = descriptionController.text;
              final price = int.parse(priceController.text);
              final updatedImage = base64Image ?? category.images[itemIndex];

              ref.read(roomCategoriesProvider.notifier).updateCategory(
                category.id,
                category.title,
                description,
                price,
                updatedImage,
              );
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
