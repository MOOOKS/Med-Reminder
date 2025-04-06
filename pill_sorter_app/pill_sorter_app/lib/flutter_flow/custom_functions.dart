
import '/backend/schema/structs/index.dart';

String? displayTimeList(List<String> timeCard) {
  // loop through each element in the timeCard argument, in the loop add the element to a new string variable. After the loop is done make the return value that new string variable
  String? result = '';
  for (final time in timeCard) {
    if (result != null) {
      result = "$result$time, ";
    }
  }
  return result;
}

int findIndexOfMedCard(
  MedicationStruct pageParam,
  List<MedicationStruct> medList,
) {
  // loop through each item in medlist, check if each item is equal to pageParam. If it is return the index of pageParam in medList
  for (int i = 0; i < medList.length; i++) {
    if (medList[i] == pageParam) {
      return i;
    }
  }
  return -1;
}

bool? showTodaysMeds(
  DateTime? currentDate,
  DateTime? startDate,
  String? frequency,
) {
  if (currentDate == null || startDate == null || frequency == null) {
    return false;
  }

  int days = currentDate.difference(startDate).inDays;
  int frequencyDays;

  switch (frequency) {
    case 'Daily':
      frequencyDays = 1;
      break;
    case 'Every Other Day':
      frequencyDays = 2;
      break;
    case 'Weekly':
      frequencyDays = 7;
      break;
    case 'Biweekly':
      frequencyDays = 14;
      break;
    case 'Monthly':
      frequencyDays = 30;
      break;
    case 'Every 3 Months':
      frequencyDays = 90;
      break;
    case 'Every 6 Months':
      frequencyDays = 182;
      break;
    case 'Yearly':
      frequencyDays = 365;
      break;
    default:
      return false;
  }

  print(days);
  print(frequencyDays);
  if (days == 0) {
    return true;
  } else {
    return (days / frequencyDays) >= 1 && (days % frequencyDays) == 0;
  }
}

int? indexOfLastItem(List<MedicationStruct>? medList) {
  // return the index of the last item in the list medList
  if (medList == null || medList.isEmpty) {
    return null;
  }

  return medList.length - 1;
}

List<int>? toInt(List<String>? stringTimes) {
  // Takes the string list stringTimes, for each element put only the numbers in that element into a new list called intTimes this is an integer list. If the number  had a PM next to it and it is not 12 PM add 12 to the number and put it in the integer list. After going through all elements in stringTimes and adding them to intTimes, return intTimes.
  if (stringTimes == null) {
    return null;
  }

  List<int> intTimes = [];
  for (String time in stringTimes) {
    int hour = int.parse(time.replaceAll(RegExp(r'[^0-9]'), ''));
    if (time.contains('PM') && hour != 12) {
      hour += 12;
    }
    intTimes.add(hour);
  }

  return intTimes;
}

int? indexOfCard(
  MedicationStruct? card,
  List<MedicationStruct>? cardList,
) {
  // return the index of card in cardList if card is not in cardList return null
  if (card == null || cardList == null) {
    return null;
  }

  for (int i = 0; i < cardList.length; i++) {
    if (cardList[i] == card) {
      return i;
    }
  }

  return null;
}

List<int> convertToIntHours(List<String?> stringHours) {
  return stringHours.map((time) {
    // Remove AM/PM and trim any extra spaces
    String? cleanTime = time?.replaceAll(RegExp(r'AM|PM'), '').trim();

    // Convert to int
    int hour = int.parse(cleanTime!);

    // If it's PM and not 12 PM, add 12 to convert to 24-hour format
    if (time!.contains("PM") && hour != 12) {
      hour += 12;
    }
    // If it's 12 AM (midnight), convert to 0
    else if (time.contains("AM") && hour == 12) {
      hour = 0;
    }

    return hour;
  }).toList();
}
