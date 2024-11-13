part of '../../main.dart';

var bold = FontWeight.bold;
var normal = FontWeight.normal;
var blue = Colors.blue;
var black = Colors.black;
// style
TextStyle myStyle(double size, FontWeight? weight, Color? color) {
  return TextStyle(
    fontSize: 15,
    fontWeight: bold,
    color: color,
  );
}

// Heading 1
TextStyle heading1 = const TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w900,
);

// Heading 2
TextStyle heading2 = const TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: Colors.black54,
);

// Heading 2
TextStyle body1 = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.black54,
);

// Heading 2
TextStyle body2 = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.black54,
);

//padding
EdgeInsets paddingScreen = const EdgeInsets.only(right: 20, left: 20, top: 10);

EdgeInsets paddingNormal =
    const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
EdgeInsets paddingSmall =
    const EdgeInsets.symmetric(horizontal: 5, vertical: 5);