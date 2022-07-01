// ignore_for_file: sort_child_properties_last, constant_identifier_names, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';




class DrawingPainter extends CustomPainter {
  DrawingPainter({required this.pointsList});
  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = [];
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
    
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;
  DrawingPoints({required this.points, required this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color,Eraser}

class Screens{
  List<DrawingPoints> points = [];
   StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
   
  
   
  
  PanUpdate(context,details,selectedColor,strokeWidth,opacity){
    if(details==null){
        selectedColor=selectedColor;
        opacity=opacity;
        strokeWidth=strokeWidth;
    }
    else{
       selectedColor=selectedColor;
        opacity=opacity;
        strokeWidth=strokeWidth;
      RenderBox? renderBox = context.findRenderObject() as RenderBox;
              points.add(DrawingPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeCap
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
                    return points;
    }
            }
            PanStart(context,details,selectedColor,strokeWidth,opacity){
              if(details==null){
        selectedColor=selectedColor;
        opacity=opacity;
        strokeWidth=strokeWidth;
    }
    else{
      RenderBox renderBox = context.findRenderObject() as RenderBox;
             points.add(DrawingPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeCap
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth));
                    return points;
    }
  }
  PanEnd(context,details){
   
  points.add(null as DrawingPoints);
 return points;
  }
  Future generateImage(kCanvasSize) async {
        
   ByteData imgBytes;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromPoints(Offset(0.0, 0.0), Offset(kCanvasSize, kCanvasSize)));

    final stroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    // canvas.drawRect(Rect.fromLTWH(0.0, 0.0, kCanvasSize, kCanvasSize), stroke);

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
  List<Offset> offsetPoints = [];
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        
        canvas.drawLine(points[i].points, points[i + 1].points,
            points[i].paint);
      } else if (points[i] != null && points[i + 1] == null) {
        
        offsetPoints.clear();
        offsetPoints.add(points[i].points);
        offsetPoints.add(Offset(
            points[i].points.dx + 0.1, points[i].points.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, points[i].paint);
      }
    }

    final picture = recorder.endRecording();
    final img = await picture.toImage(400, 600);
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);
 imgBytes = pngBytes!;
 return imgBytes;

    
  }
  }



  
  
