import 'package:flutter/material.dart';







class CategoryCard extends StatelessWidget {

  final Icon icon;

  final String title;

  final Function press;

  const CategoryCard({

    Key key,

    this.icon,

    this.title,

    this.press,

  }) : super(key: key);



  @override

  Widget build(BuildContext context) {

    return ClipRRect(

      borderRadius: BorderRadius.circular(13),

      child: Container(

        // padding: EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(13),

          boxShadow: [

            BoxShadow(

              offset: Offset(0, 17),

              blurRadius: 17,

              spreadRadius: -23,

              color: Colors.blue,

            ),

          ],

        ),

        child: Material(

          color: Colors.transparent,

          child: InkWell(

            onTap: press,

            child: Padding(

              padding: const EdgeInsets.all(20.0),

              child: Column(

                children: <Widget>[

                  Spacer(),

                 Icon(
                   Icons.add
                 ),

                  Spacer(),

                  Text(

                    title,

                    textAlign: TextAlign.center,

                    style: Theme.of(context)

                        .textTheme

                        .headline4

                        .copyWith(fontSize: 15),

                  )

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }

}