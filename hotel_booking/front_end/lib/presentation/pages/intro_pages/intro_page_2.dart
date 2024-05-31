// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class IntroPage2 extends StatelessWidget{
  const IntroPage2({Key?key}): super(key:key);
  
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/images/blur_hotel.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5), // Adjust the opacity and color as needed
                BlendMode.dstATop,
              ),
        ),
        
       ),
      child: Center(
        child:Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            

            SizedBox(height:20),
             Text(
      'Escape to Tranquility',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        color: Color.fromARGB(255, 40, 41, 42),
      ),
    ),
    SizedBox(height: 20),
    Text(
      'Luxury stays at your fingertips.',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Color.fromARGB(255, 79, 68, 68),
      ),
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    Text(
      'Discover exquisite accommodations.',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.grey[700],
      ),
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    Text(
      'Book your dream stay today!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.grey[700],
      ),
      textAlign: TextAlign.center,
    ),

          ],
          ),)
    );
  }
}
