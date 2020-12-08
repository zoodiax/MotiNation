import 'package:flutter/material.dart';
import 'package:motination/shared/constants.dart';
import '../src/UI/Run/running.dart';
import '../src/UI/Workout/workoutInfo.dart';
import '../src/UI/shop.dart';
import '../src/UI/profile.dart';



Widget bottomBar(int index, BuildContext context){
  return BottomNavigationBar(
            currentIndex: index,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: blue,
            backgroundColor: bgColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer,),
                label: 'Running',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Workout',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: 'Shop',
              ),
            ],
            onTap: (indexTab) {
                if (indexTab == index) return null;
                if (indexTab == 0)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                if (indexTab == 1)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Running()),
                );
                if (indexTab == 2)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorkoutInfo()),
                );

                if (indexTab== 3)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Shoping()),
                  );
                
              });

}

