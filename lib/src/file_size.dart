sealed class FileSize {
  final int bytes;
  const FileSize(this.bytes);
}

class Bytes extends FileSize {
  const Bytes(int size): super(size);
}

class KiBytes extends FileSize {
  const KiBytes(int size): super(size * 1024);
}

class KBytes extends FileSize {
  const KBytes(int size): super(size * 1000);
}

class MiBytes extends FileSize {
  const MiBytes(int size): super(size * 1024 * 1024);
}

class MBytes extends FileSize {
  const MBytes(int size): super(size * 1000000);
}

class GiBytes extends FileSize {
  const GiBytes(int size): super(size * 1024 * 1024 * 1024);
}

class GBytes extends FileSize {
  const GBytes(int size): super(size * 1000000000);
}
