import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _model.loadCheckmarks();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF181818),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, -1.0),
                child: Container(
                  width: 226.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: const Color(0x13FFFFFF),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: Text(
                    'Today',
                    style: FlutterFlowTheme.of(context).displayLarge.override(
                      fontFamily: 'Inter Tight',
                      color: FlutterFlowTheme.of(context).primary,
                      letterSpacing: 0.0,
                      shadows: [
                        Shadow(
                          color: FlutterFlowTheme.of(context).primary,
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
                        // 👇 Add it here
    Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: FFButtonWidget(
        onPressed: () async {
          await launchURL('https://docs.google.com/forms/d/e/1FAIpQLSc-dF9BoaC0dbJbynPNIX2vaQWnaKcaIjqc03q_CkitZkhYNg/viewform?usp=dialog');
        },
        text: 'Give Feedback',
        icon: const Icon(Icons.feedback, size: 24.0),
        options: FFButtonOptions(
          height: 50.0,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: 'Inter Tight',
            color: Colors.white,
            fontSize: 20.0,
          ),
          elevation: 2.0,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
              Expanded(
                child: SingleChildScrollView(
                  child: Builder(
                    builder: (context) {
                      final medCard = FFAppState().MedicationList.toList();
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(medCard.length, (medCardIndex) {
                          final medCardItem = medCard[medCardIndex];
                          return Visibility(
                            visible: functions.showTodaysMeds(
                                getCurrentTimestamp,
                                medCardItem.startEndDate,
                                valueOrDefault<String>(
                                  medCardItem.days,
                                  'Daily',
                                )) ??
                                true,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity:
                                            VisualDensity.compact,
                                            materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(25),
                                            ),
                                          ),
                                          unselectedWidgetColor:
                                          FlutterFlowTheme.of(context).alternate,
                                        ),
                                        child: CheckboxListTile(
                                          value: _model.checkboxListTileValueMap[medCardItem] ??= false,
                                          onChanged: (newValue) async {
                                            if (newValue == true) {
                                              safeSetState(() => _model.toggleCheck(medCardItem));
                                              debugPrint("toggle");
                                            }
                                          },
                                          title: Text(
                                            '${medCardItem.pillCount.toString()}x ${valueOrDefault<String>(
                                              medCardItem.name,
                                              'New Med',
                                            )}',
                                            style: FlutterFlowTheme.of(context).displayMedium.override(
                                              fontFamily: 'Inter Tight',
                                              color: FlutterFlowTheme.of(context).alternate,
                                              letterSpacing: 0.0,
                                            ),
                                          ),
                                          subtitle: RichText(
                                            text: TextSpan(
                                              children: medCardItem.times.asMap().entries.map((entry) {
                                                int idx = entry.key;
                                                String time = entry.value;
                                                bool isChecked = _model.checkedTimesMap[medCardItem]?[idx] ?? false;

                                                return TextSpan(
                                                  text: (isChecked ? '✓ ' : '') + time + ", ",
                                                  style: TextStyle(
                                                    color: isChecked ? Colors.green : FlutterFlowTheme.of(context).alternate,
                                                    fontSize: isChecked ? 30.0 : 25.0,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                );
                                              }).toList(),
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).alternate,
                                                fontSize: 25.0,
                                              ),
                                            ),
                                          ),
                                          tileColor: const Color(0x13FFFFFF),
                                          activeColor: FlutterFlowTheme.of(context).primary,
                                          checkColor: FlutterFlowTheme.of(context).info,
                                          dense: false,
                                          controlAffinity: ListTileControlAffinity.trailing,
                                          contentPadding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).divide(
                          const SizedBox(height: 20.0),
                          filterFn: (medCardIndex) {
                            final medCardItem = medCard[medCardIndex];
                            return functions.showTodaysMeds(
                                getCurrentTimestamp,
                                medCardItem.startEndDate,
                                valueOrDefault<String>(
                                  medCardItem.days,
                                  'Daily',
                                )) ?? true;
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 30.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              EditPageWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.topToBottom,
                                  duration: Duration(milliseconds: 100),
                                ),
                              },
                            );
                          },
                          text: 'Edit',
                          icon: const Icon(Icons.edit, size: 40.0),
                          options: FFButtonOptions(
                            height: 66.0,
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Inter Tight',
                              color: Colors.white,
                              fontSize: 40.0,
                            ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              SubmissionWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.topToBottom,
                                  duration: Duration(milliseconds: 100),
                                ),
                              },
                            );
                          },
                          text: 'New',
                          icon: const Icon(Icons.add_circle, size: 40.0),
                          options: FFButtonOptions(
                            height: 66.0,
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Inter Tight',
                              color: Colors.white,
                              fontSize: 40.0,
                            ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
