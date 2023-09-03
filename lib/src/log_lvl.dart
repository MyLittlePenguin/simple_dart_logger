class LogLvl {
  static const trace = 1;
  static const debug = 1 << 1;
  static const info = 1 << 2;
  static const warning = 1 << 3;
  static const error = 1 << 4;

  static const all = trace | debug | info | warning | error;
}
