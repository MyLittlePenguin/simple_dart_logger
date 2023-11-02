/// Console codes for setting the foreground color.
final class TermColor {
  final int value;

  const TermColor._(this.value);

  static final _magic = "\x1b";

  static const reset = TermColor._(0);
  static const black = TermColor._(30);
  static const red = TermColor._(31);
  static const green = TermColor._(32);
  static const yellow = TermColor._(33);
  static const blue = TermColor._(34);
  static const magenta = TermColor._(35);
  static const cyan = TermColor._(36);
  static const lightGrey = TermColor._(37);

  @override
  String toString() {
    return "$_magic[${value}m";
  }

  /// Adds relevant color codes to color the [msg] accordingly and returns the result.
  String colorize(String msg) => "$this$msg${TermColor.reset}";
}
