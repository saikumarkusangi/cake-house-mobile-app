import 'package:flutter/material.dart';


class TextFieldForm extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String hintText;
   TextFieldForm({super.key,
  required this.controller,
  required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border:const  OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38
          )
        ),
        focusedBorder:const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          color:Colors.deepOrange
          )
        ) ,
        enabledBorder:const  OutlineInputBorder(
          borderSide: BorderSide(
          color:Colors.black38
          )
        )
      ),
      validator:(val){
      
          if(val == null || val.isEmpty ){
            return 'Enter your $hintText';
          }
          return null;
      } ,

      );
  
  }
}