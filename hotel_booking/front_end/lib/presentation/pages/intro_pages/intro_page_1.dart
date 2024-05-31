//intro page1
import 'package:flutter/material.dart';




class IntroPage1 extends StatelessWidget{
  const IntroPage1({Key?key}): super(key:key);
  
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('lib/images/blur_hotel.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.6), // Adjust the opacity and color as needed
                BlendMode.dstATop,
              ),
        ),
        
       ),
      child: Center(
        child:Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[Icon(
              Icons.bed ,
              size:80,
              color: Color.fromARGB(255, 95, 65, 65),
            ),
            SizedBox(width: 10,),
            Text(
              'Oasis', 
              style: TextStyle(
                fontSize:65,
                fontWeight:FontWeight.bold,
                color: Color.fromARGB(255, 95, 65, 65),
              ),
            
            ),]),

            SizedBox(height:20),
            Text(
              'Discover Your',
              style: TextStyle(
                fontSize:21,
                fontWeight: FontWeight.normal,
                color:Color.fromARGB(255, 79, 68, 68),
              ),
            ),
            Text(
              'Oasis',
              style:TextStyle(
                fontSize:36,
                fontWeight:FontWeight.bold,
                color:Color.fromARGB(255, 95, 65, 65)
              )
            
            ),
             Text(
              'Where Every Stay',
              style: TextStyle(
                fontSize:21,
                fontWeight: FontWeight.normal,
                color:Color.fromARGB(255, 79, 68, 68),
              ),
            ),
            Text(
              'is a Dream Come True!',
              style: TextStyle(
                fontSize:21,
                fontWeight: FontWeight.normal,
                color:Color.fromARGB(255, 79, 68, 68),
              ),
            ),
          ],
          ),)
    );
  }
}
