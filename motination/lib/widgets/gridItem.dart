
import 'package:flutter/material.dart';
import 'package:motination/shared/constants.dart';

gridItem(IconData icon, Color iconColor, String heading, String body, BuildContext context){

return Center(
                              child: Container(
                                height: 200,
                                width: 175,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: boxColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(1),
                                        spreadRadius: 3,
                                        blurRadius: 7,
                                        offset: Offset(0, 2),
                                      )
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      icon,
                                      color: iconColor,
                                      size: 70,
                                    ),
                                    Spacer(),
                                    Text(heading,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    Text(body,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2),
                                  ],
                                ),
                              ),
                            );

}