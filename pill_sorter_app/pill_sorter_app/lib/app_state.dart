import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _MedicationList = prefs
              .getStringList('ff_MedicationList')
              ?.map((x) {
                try {
                  return MedicationStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _MedicationList;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<MedicationStruct> _MedicationList = [];
  List<MedicationStruct> get MedicationList => _MedicationList;
  set MedicationList(List<MedicationStruct> value) {
    _MedicationList = value;
    prefs.setStringList(
        'ff_MedicationList', value.map((x) => x.serialize()).toList());
  }

  void addToMedicationList(MedicationStruct value) {
    MedicationList.add(value);
    prefs.setStringList('ff_MedicationList',
        _MedicationList.map((x) => x.serialize()).toList());
  }

  void removeFromMedicationList(MedicationStruct value) {
    MedicationList.remove(value);
    prefs.setStringList('ff_MedicationList',
        _MedicationList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromMedicationList(int index) {
    MedicationList.removeAt(index);
    prefs.setStringList('ff_MedicationList',
        _MedicationList.map((x) => x.serialize()).toList());
  }

  void updateMedicationListAtIndex(
    int index,
    MedicationStruct Function(MedicationStruct) updateFn,
  ) {
    MedicationList[index] = updateFn(_MedicationList[index]);
    prefs.setStringList('ff_MedicationList',
        _MedicationList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInMedicationList(int index, MedicationStruct value) {
    MedicationList.insert(index, value);
    prefs.setStringList('ff_MedicationList',
        _MedicationList.map((x) => x.serialize()).toList());
  }

  int _medicationCount = 0;
  int get medicationCount => _medicationCount;
  set medicationCount(int value) {
    _medicationCount = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
