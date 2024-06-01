import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/presentation/providers/rooms_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

void showAddNewDialog(BuildContext context, WidgetRef ref) {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String? imagePath;
  String? base64Image;
  String selectedCategory = 'VIP';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 252, 241, 230),
        title: const Text('Add New Room Category'),
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

                      // Compress the image
                      img.Image originalImage = img.decodeImage(bytes)!;
                      img.Image resizedImage = img.copyResize(originalImage, width: 600); // Resize the image to a smaller size
                      final compressedBytes = img.encodeJpg(resizedImage, quality: 80); // Compress the image with 80% quality

                      base64Image = base64Encode(compressedBytes);
                    }
                  } catch (e) {
                    print('Error picking image: $e');
                  }
                },
                child: const Text('Select Image'),
              ),
              
               TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
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
              final title = titleController.text;
              final description = descriptionController.text;
              final price = int.tryParse(priceController.text);

              if (base64Image != null && title.isNotEmpty && description.isNotEmpty && price != null) {
                ref.read(roomCategoriesProvider.notifier).addCategory(
                  title,
                  base64Image!,
                  description,
                  price,
                  selectedCategory,
                );
                Navigator.of(context).pop();
              } else {
                print('Please fill in all fields and select an image.');
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
