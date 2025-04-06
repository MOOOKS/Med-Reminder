import '../noti_service.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_page_model.dart';
export 'edit_page_model.dart';

class EditPageWidget extends StatefulWidget {
  const EditPageWidget({super.key});

  static String routeName = 'EditPage';
  static String routePath = '/editPage';

  @override
  State<EditPageWidget> createState() => _EditPageWidgetState();
}

class _EditPageWidgetState extends State<EditPageWidget> {
  late EditPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditPageModel());
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
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF181818),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      width: 226.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: const Color(0x13FFFFFF),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Edit',
                        style: FlutterFlowTheme.of(context).displayLarge.override(
                          fontFamily: 'Inter Tight',
                          color: FlutterFlowTheme.of(context).tertiary,
                          letterSpacing: 0.0,
                          shadows: [
                            Shadow(
                              color: FlutterFlowTheme.of(context).tertiary,
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 20.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 120.0),
                      child: Builder(
                        builder: (context) {
                          final medCard = FFAppState().MedicationList.toList();

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(medCard.length, (medCardIndex) {
                              final medCardItem = medCard[medCardIndex];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                                child: Container(
                                  width: screenWidth * 0.9,
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2B343B),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          valueOrDefault<String>(
                                            medCardItem.name,
                                            'Med Name',
                                          ),
                                          style: FlutterFlowTheme.of(context).headlineLarge.override(
                                            fontFamily: 'Inter Tight',
                                            color: const Color(0xFFD2D2D2),
                                            fontSize: 28.0,
                                            letterSpacing: 0.0,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await NotiService().cancelAllPendingNotificationIDsOfBase(
                                              FFAppState().MedicationList[medCard.indexOf(medCardItem)].id);
                                          FFAppState().removeFromMedicationList(medCardItem);
                                          safeSetState(() {});
                                        },
                                        text: '',
                                        icon: const Icon(Icons.delete, size: 20.0),
                                        options: FFButtonOptions(
                                          width: 40.0,
                                          height: 40.0,
                                          padding: EdgeInsets.zero,
                                          iconPadding: EdgeInsets.zero,
                                          color: FlutterFlowTheme.of(context).error,
                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                            fontFamily: 'Inter Tight',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                          elevation: 0.0,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          context.pushNamed(
                                            EditSubmissionWidget.routeName,
                                            queryParameters: {
                                              'medCard': serializeParam(
                                                medCardItem,
                                                ParamType.DataStruct,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        text: '',
                                        icon: const Icon(Icons.edit, size: 20.0),
                                        options: FFButtonOptions(
                                          width: 40.0,
                                          height: 40.0,
                                          padding: EdgeInsets.zero,
                                          iconPadding: EdgeInsets.zero,
                                          color: FlutterFlowTheme.of(context).primary,
                                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                            fontFamily: 'Inter Tight',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                          elevation: 0.0,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 30.0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.pushNamed(
                          HomePageWidget.routeName,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.topToBottom,
                              duration: Duration(milliseconds: 5),
                            ),
                          },
                        );
                      },
                      text: 'Done',
                      icon: const Icon(Icons.check_circle, size: 30.0),
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 66.0,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        iconPadding: EdgeInsets.zero,
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Inter Tight',
                          color: Colors.white,
                          fontSize: 30.0,
                          letterSpacing: 0.0,
                        ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
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
