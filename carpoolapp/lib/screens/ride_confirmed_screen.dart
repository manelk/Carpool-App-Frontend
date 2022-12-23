import 'package:carpoolapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RideConfirmedWidget extends StatefulWidget {
  const RideConfirmedWidget({Key? key}) : super(key: key);

  @override
  State<RideConfirmedWidget> createState() => _RideConfirmedWidgetState();
}

class _RideConfirmedWidgetState extends State<RideConfirmedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // FlutterFlowIconButton(
              //   borderColor: Colors.transparent,
              //   borderRadius: 30,
              //   buttonSize: 46,
              //   fillColor: FlutterFlowTheme.of(context).primaryBackground,
              //   icon: Icon(
              //     Icons.close_rounded,
              //    // color: FlutterFlowTheme.of(context).secondaryText,
              //     size: 20,
              //   ),
              //   onPressed: () async {
              //     //context.pop();
              //   },
              // ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: Color(0xFF008CFF),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
          child: Text(
            'Ride Confirmed!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4B39EF),
            ),
            // style: FlutterFlowTheme.of(context).title1.override(
            //   fontFamily: 'Lexend Deca',
            //   color: Color(0xFF4B39EF),
            //   fontSize: 24,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
          child: Text(
            'Your ride has been confirmed, it may take few minutes in order for your driver to go through and show up in your list.',
            textAlign: TextAlign.center,
            // style: FlutterFlowTheme.of(context).bodyText2,
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
          child: Container(
            width: 300,
            height: 70,
            decoration: BoxDecoration(
              // color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(
              //   color: FlutterFlowTheme.of(context).primaryBackground,
              // ),
            ),
          ),
        ),
            // Generated code for this bottomButtonArea Widget...
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Colors.white54,
                        onPrimary: Colors.black,
                        fixedSize: Size(150, 50),
                        textStyle: TextStyle(fontFamily: 'DM Sans', fontSize: 19),
                      ),
                      child: const Text("Go Home"),
                    ),
                  ],
                ),
              ),
            )

          ])),
    );
  }
}
