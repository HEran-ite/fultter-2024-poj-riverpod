import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/domain/entities/room.dart';
import 'package:hotel_booking/presentation/providers/rooms_provider.dart';
import 'package:image_picker/image_picker.dart';

void showEditDialog(BuildContext context, WidgetRef ref, RoomCategory category) {
  TextEditingController descriptionController = TextEditingController(text: category.description);
  TextEditingController priceController = TextEditingController(text: category.price.toString());
  String? imagePath;
  String? base64Image;
  String selectedCategory = category.category;

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
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: <String>['VIP', 'Middle', 'Economy'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  selectedCategory = newValue!;
                },
                decoration: const InputDecoration(labelText: 'Category'),
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
              final updatedImage = base64Image ?? category.image;
              final id = category.id; // Adding the id argument

              ref.read(roomCategoriesProvider.notifier).updateCategory(
                id,
                category.title,
                description,
                price,
                updatedImage,
                selectedCategory // Adding the missing category argument
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
