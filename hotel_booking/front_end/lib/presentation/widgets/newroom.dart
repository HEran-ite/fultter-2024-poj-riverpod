import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_booking/presentation/pages/rooms_catagories.dart';
import 'package:image_picker/image_picker.dart';


void showAddNewDialog(BuildContext context, WidgetRef ref) {
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
              if (base64Image != null) {
                ref.read(roomCategoriesProvider.notifier).addCategory(
                      selectedCategory,
                      base64Image!,
                      descriptionController.text,
                      int.parse(priceController.text),
                    );
                Navigator.of(context).pop();
              } else {
                print('No image selected');
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
