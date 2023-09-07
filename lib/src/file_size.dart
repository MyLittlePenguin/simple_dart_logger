/// [FileSize] contains information about the size of a file.
sealed class FileSize {
  /// Size measured in bytes.
  final int bytes;
  const FileSize(this.bytes);
}

/// Wrapper for [FileSize] measured in Bytes.
class Bytes extends FileSize {
  const Bytes(int size) : super(size);
}

/// Wrapper for [FileSize] measured in KiBytes.
/// Quick reminder: 1 KiByte = 1024 Byte
class KiBytes extends FileSize {
  const KiBytes(int size) : super(size * 1024);
}

/// Wrapper for [FileSize] measured in KBytes.
/// Quick reminder: 1 KByte = 1000 Byte
class KBytes extends FileSize {
  const KBytes(int size) : super(size * 1000);
}

/// Wrapper for [FileSize] measured in MebiBytes.
/// Quick reminder: 1 MebiByte = 1024^2 Byte
class MiBytes extends FileSize {
  const MiBytes(int size) : super(size * 1024 * 1024);
}

/// Wrapper for [FileSize] measured in MBytes.
/// Quick reminder: 1 MByte = 10^6 Byte
class MBytes extends FileSize {
  const MBytes(int size) : super(size * 1000000);
}

/// Wrapper for [FileSize] measured in GiBytes.
/// Quick reminder: 1 GiByte = 1024^3 Byte
class GiBytes extends FileSize {
  const GiBytes(int size) : super(size * 1024 * 1024 * 1024);
}

/// Wrapper for [FileSize] measured in GBytes.
/// Quick reminder: 1 GByte = 10^9 Byte
class GBytes extends FileSize {
  const GBytes(int size) : super(size * 1000000000);
}
