library govt_documents_validator;

var mult = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
  [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
  [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
  [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
  [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
  [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
  [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
  [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
  [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
];
var perm = [
  [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
  [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
  [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
  [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
  [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
  [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
  [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
];
var i, j, x;

String reverseString(String gstNum) {
  var chars = gstNum.split('');
  return chars.reversed.join();
}

int listElementsSum(List a) {
  num sum = 0;
  if (a.length <= 1) {
    return a[0];
  } else {
    for (num e in a) {
      sum += e;
    }
  }
  return sum.toInt();
}

class AadharValidator {
  bool validate(String aadharNum) {
    if (aadharNum.length == 12 && RegExp(r'^[0-9]+$').hasMatch(aadharNum)) {
      try {
        i = aadharNum.length;
        j = 0;
        x = 0;
        while (i > 0) {
          i -= 1;
          String curr = aadharNum[i];
          var index = int.parse(curr);
          x = mult[x][perm[(j % 8)][index]];
          j += 1;
        }
        if (x == 0) {
          return true;
        } else {
          return false;
        }
      } on Exception catch (_) {
        print("Invalid Aadhar Number");
      }
    }
    return false;
  }
}

class PANValidator {
  bool validate(String panNum) {
    String? validMatch;
    RegExp re = RegExp("[A-Z]{5}[0-9]{4}[A-Z]{1}");
    if (panNum.length == 10) {
      Iterable<Match> match = re.allMatches(panNum);
      if (match.isNotEmpty) {
        for (Match m in match) {
          validMatch = m.group(0) ?? '';
        }
        if (validMatch != null && validMatch.isNotEmpty) {
          return true;
        }
        return false;
      }
      return false;
    }
    return false;
  }
}

class GSTValidator {
  bool validate(String gstNum) {
    var check, lmo, gst, csum;
    check = reverseString(gstNum)[0];
    lmo = gstNum.substring(0, 14);
    List l = [], m = [], n = [];
    gst = lmo.split('');
    for (var i = 0; i < gst.length; ++i) {
      if (RegExp(r'^[0-9]+$').hasMatch(gst[i])) {
        l.add(int.parse(gst[i]));
      } else {
        l.add(lmo.codeUnitAt(i) - 55);
      }
    }
    for (var i = 0; i < l.length; ++i) {
      m.add(l[i] * (i % 2 + 1));
    }
    for (var i = 0; i < m.length; ++i) {
      n.add(((m[i] / 36) + (m[i] % 36)).truncate());
    }
    var sum = listElementsSum(n);

    csum = 36 - sum % 36;
    csum = csum < 10 ? csum.toString() : String.fromCharCode(csum + 55);
    bool val = csum == check ? true : false;
    return val;
  }
}
