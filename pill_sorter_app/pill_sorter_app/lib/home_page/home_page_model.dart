import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for CheckboxListTile widget.
  Map<MedicationStruct, bool> checkboxListTileValueMap = {};
  List<MedicationStruct> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  Map<MedicationStruct, List<bool>> checkedTimesMap = {};

  // Load the check mark states from SharedPreferences
  Future<void> loadCheckmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var medCard in FFAppState().MedicationList) {
      String todayKey = 'date_${medCard.id}';
      String checkKey = 'med_${medCard.id}';

      String today = DateTime.now().toIso8601String().substring(0, 10);
      String? savedDate = prefs.getString(todayKey);

      debugPrint('Loading medCard ${medCard.id}');
      debugPrint('Saved date: $savedDate, Today: $today');

      if (savedDate != today) {
        debugPrint('Resetting checkmarks for medCard ${medCard.id}');
        checkedTimesMap[medCard] = List.generate(medCard.times.length, (_) => false);
        await prefs.setString(todayKey, today);
        await prefs.setString(checkKey, List.generate(medCard.times.length, (_) => false.toString()).join(','));
      } else {
        String? savedCheckmarks = prefs.getString(checkKey);
        if (savedCheckmarks != null) {
          List<bool> checkmarks = savedCheckmarks
              .split(',')
              .map((e) => e == 'true')
              .toList();
          checkedTimesMap[medCard] = checkmarks;
          debugPrint('Loaded checkmarks for medCard ${medCard.id}: $checkmarks');
        } else {
          checkedTimesMap[medCard] = List.generate(medCard.times.length, (_) => false);
          debugPrint('Initialized checkmarks as false for medCard ${medCard.id}');
        }
      }
    }
  }

  // Save the check mark states to SharedPreferences
  Future<void> saveCheckmarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var medCard in FFAppState().MedicationList) {
      List<bool>? checkmarks = checkedTimesMap[medCard];
      if (checkmarks != null) {
        String checkmarksString = checkmarks.map((e) => e.toString()).join(',');
        await prefs.setString('med_${medCard.id}', checkmarksString);
        debugPrint('Saved checkmarks for medCard ${medCard.id}: $checkmarksString');
      }
    }
  }

  void toggleCheck(MedicationStruct medItem) {
    if (!checkedTimesMap.containsKey(medItem)) {
      checkedTimesMap[medItem] = List.generate(medItem.times.length, (_) => false);
    }

    List<bool> checks = checkedTimesMap[medItem]!;
    int index = checks.indexWhere((checked) => !checked);
    if (index != -1) {
      checks[index] = true;
      debugPrint('Checked time at index $index for medCard ${medItem.id}');
    }
    saveCheckmarks();
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
