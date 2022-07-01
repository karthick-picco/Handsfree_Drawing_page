// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, override_on_non_overriding_member, prefer_typing_uninitialized_variables, avoid_print, unnecessary_null_comparison, unused_local_variable


import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:drawing_page/screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  
}
const kCanvasSize = 400.0;
class MyApp extends StatefulWidget {
  final Random rd=Random();
  final int numColors=Colors.primaries.length;

  
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  
  double strokeWidth = 3.0;
  double eraserwidth=5.0;
  final gesture=Screens();
  bool _iserasing=false;
  
  ByteData? imgBytes;
  List<DrawingPoints> points = [];
  bool showBottomList = false;
  double opacity = 1.0;
  
  Color selectedColor=Colors.black;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black
  ];
  @override
  List<Widget> 
   getColorList() {
    List<Widget> listWidget = [];
    for (Color color in colors) {
      listWidget.add(colorCircle(color));
    }
    
    Widget colorPicker = ClipOval(
      child: Container(
        padding: const EdgeInsets.only(bottom: 16.0),
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.red, Colors.green, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
      ),
    );
    listWidget.add(colorPicker);
    return listWidget;
  }
  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
          var details;
          gesture.PanUpdate(context, details,selectedColor,strokeWidth,opacity);
          
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  
  }
  @override
 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text("Drawing Page"),
        //   centerTitle: true,
        // ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Color.fromARGB(255, 36, 224, 206)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.album),
                            onPressed: () {
                              setState(() {
                                if (selectedMode == SelectedMode.StrokeWidth) {
                                  showBottomList = !showBottomList;
                                }
                                selectedMode = SelectedMode.StrokeWidth;
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.opacity),
                            onPressed: () {
                              setState(() {
                                if (selectedMode == SelectedMode.Opacity) {
                                  showBottomList = !showBottomList;
                                }
                                selectedMode = SelectedMode.Opacity;
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.square),
                            onPressed: () {
                              
                              setState(() {
                                selectedMode=SelectedMode.Eraser;
                                showBottomList = !showBottomList;
                               _iserasing=true;
                              });
                            }),
                            IconButton(
                            icon: Icon(Icons.color_lens),
                            onPressed: () {
                              setState(() {
                                if (selectedMode == SelectedMode.Color) {
                                  showBottomList = !showBottomList;
                                }
                                selectedMode = SelectedMode.Color;
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _iserasing=false;
                                selectedColor=Colors.black;
                                showBottomList = false;
                                points.clear();
                                imgBytes=null;
                                
                              });
                            }),
                            TextButton(onPressed: (){
                              var imagesize=400.0;
                              setState(() {
                                gesture.generateImage(imagesize).then((value) => {
                                  setState((){
                                    imgBytes=value;
                                     
                                  }),
                                });
                              });
                              
                             
                            }, child: Text("Done",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)),
                      ],
                    ),
                    Visibility(
                      child: (selectedMode == SelectedMode.Color)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: getColorList(),
                            )
                          : Slider(
                              value: (selectedMode == SelectedMode.StrokeWidth)
                                  ? strokeWidth
                                  : selectedMode == SelectedMode.Eraser ? eraserwidth:opacity,
                              max: (selectedMode == SelectedMode.StrokeWidth)
                                  ? 50.0
                                  : selectedMode == SelectedMode.Eraser ? 15.0: 1.0,
                              min: 0.0,
                              onChanged: (val) {
                                setState(() {
                                  if (selectedMode == SelectedMode.StrokeWidth) {
                                    strokeWidth = val;
                                  }
                                  else if(selectedMode == SelectedMode.Eraser){
                                      eraserwidth=val;
                                  }
                                   else {
                                    opacity = val;
                                  }
                                });
                              }),
                      visible: showBottomList,
                    ),
                  ],
                ),
              )),
        ),
        body: imgBytes==null ? GestureDetector(
           onPanUpdate: (details){
            if(_iserasing==true){
              
              setState(() {
                selectedColor=Colors.white;
             points=gesture.PanUpdate(context, details,selectedColor,eraserwidth,opacity);  
             
            });
            }
            else{
              
              setState(() {
             points=gesture.PanUpdate(context, details,selectedColor,strokeWidth,opacity);  
             
            });
            }
            
           },
           onPanStart: (details){
            if(_iserasing==true){
              setState(() {
                selectedColor=Colors.white;
             points=gesture.PanStart(context, details,selectedColor,eraserwidth,opacity);  
             
            });
            }
            else{
              setState(() {
              points=gesture.PanStart(context, details,selectedColor,strokeWidth,opacity);
              
            });
            }
           },
           onPanEnd: (details){
             setState(() {
              points=gesture.PanEnd(context, details);
              
            });
           },
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            
             color:Colors.yellow[100],
            child: CustomPaint(

            size: Size.infinite,
            painter: DrawingPainter(
              pointsList: points,
            ),
          ),
          ),
        ) : Center(
          child: Image.memory(
                  Uint8List.view(imgBytes!.buffer),
                  width: kCanvasSize,
                  height: kCanvasSize,
                ),
        ),
      ),
      
    );
    
  }
}



