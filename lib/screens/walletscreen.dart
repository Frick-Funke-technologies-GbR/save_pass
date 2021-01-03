import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_pass/widgets/bottomnavigationbar.dart';
import 'package:save_pass/widgets/drawer.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.grey[300],
    //   ),
    // );
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: CustomDrawer(false, true, false),
      bottomNavigationBar: CustomBottomNavigationBarWalletScr(),
      floatingActionButton: FloatingActionButton(
        // disabledElevation: ,
        
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      // floatingActionButton: SpeedDialFloatingActionButton(
      //   actions: [
      //     SpeedDialAction(
      //       child: Icon(Icons.folder_open),
      //       label: Text(
      //         'Explorer',
      //         style: TextStyle(
      //           fontFamily: 'roboto_light',
      //           fontSize: 10,
      //           color: Colors.grey[500], 
      //         ),
      //       ),
      //     ),
      //     SpeedDialAction(
      //       child: Icon(Icons.image),
      //     ),
      //     SpeedDialAction(
      //       child: Icon(Icons.credit_card),
      //     ),
      //   ],
      //   childOnFold: Icon(Icons.add),
      //   childOnUnfold: Icon(Icons.add),
      //   useRotateAnimation: true,
      //   onAction: _onSpeedDialAction,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _onSpeedDialAction(int selectedActionIndex) {
    print('$selectedActionIndex Selected');
  }
}
