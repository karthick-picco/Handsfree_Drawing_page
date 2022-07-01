# drawing_page

Handsfree_Sketching
  A package for handsfree sketching with gesturedetector using custompaint widget
## Getting Started

   This package enables you to draw in a blank page with your own hands-free with following features:
   Able to change the pen color for each and every gesture moments.
   Able to change the strokewidth of the sketch pen
   Option to set opacity for the drawing
   
## Platform Support
   Step 1: 
     import 'package:drawing_page/screen.dart'
   Step 2:
     After finishing your drawing page 
         declare the screen class as final gesture=Screens();
         declare the essential need of selected color,strokecap,opacity and strokewidth.
   Step 3 
     After that setup the drawing path on the gesuture detector movements on panupdate,panstart and panend.
        
        GestureDetector(
         onTap:(){
            onPanUpdate: (details){
                setState(() {
                  points=gesture.PanUpdate(context, details,selectedColor,3.0,opacity);  
                 });
           },
           onPanStart: (details){
            setState(() {
              points=gesture.PanStart(context, details,selectedColor,3.0,opacity);
              
            });
           },
           onPanEnd: (details){
            setState(() {
              points=gesture.PanEnd(context, details);
              
            });
           },
       }
       ),
        
   
