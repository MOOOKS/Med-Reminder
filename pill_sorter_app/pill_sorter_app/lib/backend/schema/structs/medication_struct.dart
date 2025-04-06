// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MedicationStruct extends BaseStruct {
  // Constructor now includes an optional `ID` parameter.
  MedicationStruct({
    String? name,
    String? notes,
    int? pillCount,
    String? days,
    List<String>? times,
    bool? active,
    DateTime? startEndDate,
    int? id,  // New ID parameter
  })  : _name = name,
        _notes = notes,
        _pillCount = pillCount,
        _days = days,
        _times = times,
        _active = active,
        _startEndDate = startEndDate,
        _id = id;

  // "ID" field - uniquely identifies each medication item.
  int? _id;  // Store the ID
  int get id => _id ?? 0;  // Default to 0 if no ID is set
  set id(int? val) => _id = val;  // Set the ID

  bool hasId() => _id != null;

  // "Name" field.
  String? _name;
  String get name => _name ?? 'New Medication';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "Notes" field.
  String? _notes;
  String get notes => _notes ?? '';
  set notes(String? val) => _notes = val;

  bool hasNotes() => _notes != null;

  // "PillCount" field.
  int? _pillCount;
  int get pillCount => _pillCount ?? 1;
  set pillCount(int? val) => _pillCount = val;

  void incrementPillCount(int amount) => pillCount = pillCount + amount;

  bool hasPillCount() => _pillCount != null;

  // "Days" field.
  String? _days;
  String get days => _days ?? 'Daily';
  set days(String? val) => _days = val;

  bool hasDays() => _days != null;

  // "Times" field.
  List<String>? _times;
  List<String> get times => _times ?? const [];
  set times(List<String>? val) => _times = val;

  void updateTimes(Function(List<String>) updateFn) {
    updateFn(_times ??= []);
  }

  bool hasTimes() => _times != null;

  // "Active" field.
  bool? _active;
  bool get active => _active ?? true;
  set active(bool? val) => _active = val;

  bool hasActive() => _active != null;

  // "StartEndDate" field.
  DateTime? _startEndDate;
  DateTime? get startEndDate => _startEndDate;
  set startEndDate(DateTime? val) => _startEndDate = val;

  bool hasStartEndDate() => _startEndDate != null;

  static MedicationStruct fromMap(Map<String, dynamic> data) =>
      MedicationStruct(
        id: castToType<int>(data['ID']),  // Extract ID from map
        name: data['Name'] as String?,
        notes: data['Notes'] as String?,
        pillCount: castToType<int>(data['PillCount']),
        days: data['Days'] as String?,
        times: getDataList(data['Times']),
        active: data['Active'] as bool?,
        startEndDate: data['StartEndDate'] as DateTime?,
      );

  static MedicationStruct? maybeFromMap(dynamic data) => data is Map
      ? MedicationStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
    'ID': _id,  // Add ID to map
    'Name': _name,
    'Notes': _notes,
    'PillCount': _pillCount,
    'Days': _days,
    'Times': _times,
    'Active': _active,
    'StartEndDate': _startEndDate,
  }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
    'ID': serializeParam(_id, ParamType.int),  // Serialize ID
    'Name': serializeParam(_name, ParamType.String),
    'Notes': serializeParam(_notes, ParamType.String),
    'PillCount': serializeParam(_pillCount, ParamType.int),
    'Days': serializeParam(_days, ParamType.String),
    'Times': serializeParam(_times, ParamType.String, isList: true),
    'Active': serializeParam(_active, ParamType.bool),
    'StartEndDate': serializeParam(_startEndDate, ParamType.DateTime),
  }.withoutNulls;

  static MedicationStruct fromSerializableMap(Map<String, dynamic> data) =>
      MedicationStruct(
        id: deserializeParam(data['ID'], ParamType.int, false),  // Deserialize ID
        name: deserializeParam(data['Name'], ParamType.String, false),
        notes: deserializeParam(data['Notes'], ParamType.String, false),
        pillCount: deserializeParam(data['PillCount'], ParamType.int, false),
        days: deserializeParam(data['Days'], ParamType.String, false),
        times: deserializeParam<String>(data['Times'], ParamType.String, true),
        active: deserializeParam(data['Active'], ParamType.bool, false),
        startEndDate: deserializeParam(data['StartEndDate'], ParamType.DateTime, false),
      );

  @override
  String toString() => 'MedicationStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MedicationStruct &&
        name == other.name &&
        notes == other.notes &&
        pillCount == other.pillCount &&
        days == other.days &&
        listEquality.equals(times, other.times) &&
        active == other.active &&
        startEndDate == other.startEndDate &&
        id == other.id;  // Compare ID for equality
  }

  @override
  int get hashCode => const ListEquality().hash([name, notes, pillCount, days, times, active, startEndDate, id]);  // Include ID in hashCode
}

MedicationStruct createMedicationStruct({
  String? name,
  String? notes,
  int? pillCount,
  String? days,
  bool? active,
  DateTime? startEndDate,
  int? id,  // Accept ID when creating
}) =>
    MedicationStruct(
      name: name,
      notes: notes,
      pillCount: pillCount,
      days: days,
      active: active,
      startEndDate: startEndDate,
      id: id,  // Pass ID to constructor
    );
