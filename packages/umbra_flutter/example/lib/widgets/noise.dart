import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:umbra_flutter/umbra_flutter.dart';

/// {@template noise}
/// A Flutter Widget for the `noise` shader.
/// {@endtemplate}
class Noise extends UmbraWidget {
  /// {@macro noise}
  const Noise({
    super.key,
    super.blendMode = BlendMode.src,
    super.child,
    super.errorBuilder,
    super.compilingBuilder,
    required double time,
    required Vector2 scale,
    required double amplifier,
    required Vector2 frequency,
    required Image image,
  })  : _time = time,
        _scale = scale,
        _amplifier = amplifier,
        _frequency = frequency,
        _image = image,
        super();

  static Future<FragmentProgram>? _cachedProgram;

  final double _time;

  final Vector2 _scale;

  final double _amplifier;

  final Vector2 _frequency;

  final Image _image;

  @override
  List<double> getFloatUniforms() {
    return [
      _time,
      _scale.x,
      _scale.y,
      _amplifier,
      _frequency.x,
      _frequency.y,
    ];
  }

  @override
  List<ImageShader> getSamplerUniforms() {
    return [
      ImageShader(
        _image,
        TileMode.clamp,
        TileMode.clamp,
        UmbraShader.identity,
      ),
    ];
  }

  @override
  Future<FragmentProgram> program() {
    return _cachedProgram ??
        FragmentProgram.compile(
          spirv: Uint8List.fromList(base64Decode(_spirv)).buffer,
        );
  }
}

const _spirv =
    'AwIjBwAAAQAKAA0AJAEAAAAAAAARAAIAAQAAAAsABgABAAAAR0xTTC5zdGQuNDUwAAAAAA4AAwAAAAAAAQAAAA8ABwAEAAAABAAAAG1haW4AAAAAFwEAAB0BAAAQAAMABAAAAAgAAAADAAMAAQAAAEABAAAEAAoAR0xfR09PR0xFX2NwcF9zdHlsZV9saW5lX2RpcmVjdGl2ZQAABAAIAEdMX0dPT0dMRV9pbmNsdWRlX2RpcmVjdGl2ZQAFAAQABAAAAG1haW4AAAAABQAFAAoAAABoYXNoKGYxOwAAAAAFAAMACQAAAG4AAAAFAAUAEAAAAG5vaXNlKHZmMzsAAAUAAwAPAAAAeAAAAAUABQATAAAAZmJtKHZmMzsAAAAABQADABIAAABwAAAABQAHABsAAABmcmFnbWVudCh2ZjI7dmYyOwAAAAUAAwAZAAAAdXYAAAUABQAaAAAAZnJhZ0Nvb3JkAAAABQADACQAAABwAAAABQADACcAAABmAAAABQADADQAAABuAAAABQADAEUAAAByZXMABQAEAEkAAABwYXJhbQAAAAUABABOAAAAcGFyYW0AAAAFAAQAVQAAAHBhcmFtAAAABQAEAFoAAABwYXJhbQAAAAUABABkAAAAcGFyYW0AAAAFAAQAaQAAAHBhcmFtAAAABQAEAHEAAABwYXJhbQAAAAUABAB2AAAAcGFyYW0AAAAFAAMAhAAAAGYAAAAFAAQAhgAAAHBhcmFtAAAABQAEAJsAAABwYXJhbQAAAAUABACmAAAAcGFyYW0AAAAFAAQAsQAAAHBhcmFtAAAABQAEALwAAABwYXJhbQAAAAUABADGAAAAcGFyYW0AAAAFAAUAzwAAAHBvc2l0aW9uAAAAAAUABADRAAAAc2NhbGUAAAAFAAQA2gAAAHRpbWUAAAAABQAEAOEAAABub2lzZQAAAAUABADiAAAAcGFyYW0AAAAFAAQA5QAAAHZhbHVlAAAABQAFAOcAAABmcmVxdWVuY3kAAAAFAAUA+QAAAGFtcGxpZmllcgAAAAUABAD9AAAAY29sb3IAAAAFAAQAAQEAAGltYWdlAAAABQAFAAgBAAByZXNvbHV0aW9uAAAFAAMAFQEAAHV2AAAFAAYAFwEAAGdsX0ZyYWdDb29yZAAAAAAFAAQAHQEAAF9DT0xPUl8ABQAEAB4BAABwYXJhbQAAAAUABAAgAQAAcGFyYW0AAABHAAMACgAAAAAAAABHAAMACQAAAAAAAABHAAMAEAAAAAAAAABHAAMADwAAAAAAAABHAAMAEwAAAAAAAABHAAMAEgAAAAAAAABHAAMAGwAAAAAAAABHAAMAGQAAAAAAAABHAAMAGgAAAAAAAABHAAMAHQAAAAAAAABHAAMAHgAAAAAAAABHAAMAIAAAAAAAAABHAAMAIQAAAAAAAABHAAMAJAAAAAAAAABHAAMAJQAAAAAAAABHAAMAJgAAAAAAAABHAAMAJwAAAAAAAABHAAMAKAAAAAAAAABHAAMAKQAAAAAAAABHAAMAKgAAAAAAAABHAAMAKwAAAAAAAABHAAMALAAAAAAAAABHAAMALwAAAAAAAABHAAMAMAAAAAAAAABHAAMAMQAAAAAAAABHAAMAMgAAAAAAAABHAAMAMwAAAAAAAABHAAMANAAAAAAAAABHAAMAOAAAAAAAAABHAAMAOwAAAAAAAABHAAMAPQAAAAAAAABHAAMAPgAAAAAAAABHAAMAQgAAAAAAAABHAAMAQwAAAAAAAABHAAMARAAAAAAAAABHAAMARQAAAAAAAABHAAMARgAAAAAAAABHAAMASAAAAAAAAABHAAMASQAAAAAAAABHAAMASgAAAAAAAABHAAMASwAAAAAAAABHAAMATQAAAAAAAABHAAMATgAAAAAAAABHAAMATwAAAAAAAABHAAMAUQAAAAAAAABHAAMAUgAAAAAAAABHAAMAUwAAAAAAAABHAAMAVAAAAAAAAABHAAMAVQAAAAAAAABHAAMAVgAAAAAAAABHAAMAVwAAAAAAAABHAAMAWQAAAAAAAABHAAMAWgAAAAAAAABHAAMAWwAAAAAAAABHAAMAXQAAAAAAAABHAAMAXgAAAAAAAABHAAMAYAAAAAAAAABHAAMAYQAAAAAAAABHAAMAYgAAAAAAAABHAAMAYwAAAAAAAABHAAMAZAAAAAAAAABHAAMAZQAAAAAAAABHAAMAZgAAAAAAAABHAAMAaAAAAAAAAABHAAMAaQAAAAAAAABHAAMAagAAAAAAAABHAAMAbAAAAAAAAABHAAMAbQAAAAAAAABHAAMAbgAAAAAAAABHAAMAcAAAAAAAAABHAAMAcQAAAAAAAABHAAMAcgAAAAAAAABHAAMAcwAAAAAAAABHAAMAdQAAAAAAAABHAAMAdgAAAAAAAABHAAMAdwAAAAAAAABHAAMAeQAAAAAAAABHAAMAegAAAAAAAABHAAMAfAAAAAAAAABHAAMAfQAAAAAAAABHAAMAfwAAAAAAAABHAAMAgAAAAAAAAABHAAMAgQAAAAAAAABHAAMAhAAAAAAAAABHAAMAhgAAAAAAAABHAAMAhwAAAAAAAABHAAMAiAAAAAAAAABHAAMAiQAAAAAAAABHAAMAlgAAAAAAAABHAAMAlwAAAAAAAABHAAMAmQAAAAAAAABHAAMAmwAAAAAAAABHAAMAnAAAAAAAAABHAAMAnQAAAAAAAABHAAMAngAAAAAAAABHAAMAnwAAAAAAAABHAAMAoAAAAAAAAABHAAMAoQAAAAAAAABHAAMAogAAAAAAAABHAAMApAAAAAAAAABHAAMApgAAAAAAAABHAAMApwAAAAAAAABHAAMAqAAAAAAAAABHAAMAqQAAAAAAAABHAAMAqgAAAAAAAABHAAMAqwAAAAAAAABHAAMArAAAAAAAAABHAAMArQAAAAAAAABHAAMArwAAAAAAAABHAAMAsQAAAAAAAABHAAMAsgAAAAAAAABHAAMAswAAAAAAAABHAAMAtAAAAAAAAABHAAMAtQAAAAAAAABHAAMAtgAAAAAAAABHAAMAtwAAAAAAAABHAAMAuAAAAAAAAABHAAMAugAAAAAAAABHAAMAvAAAAAAAAABHAAMAvQAAAAAAAABHAAMAvgAAAAAAAABHAAMAvwAAAAAAAABHAAMAwAAAAAAAAABHAAMAwQAAAAAAAABHAAMAwgAAAAAAAABHAAMAwwAAAAAAAABHAAMAxAAAAAAAAABHAAMAxgAAAAAAAABHAAMAxwAAAAAAAABHAAMAyAAAAAAAAABHAAMAyQAAAAAAAABHAAMAygAAAAAAAABHAAMAywAAAAAAAABHAAMAzAAAAAAAAABHAAMAzwAAAAAAAABHAAMA0QAAAAAAAABHAAQA0QAAAB4AAAABAAAARwADANQAAAAAAAAARwADANUAAAAAAAAARwADANYAAAAAAAAARwADANcAAAAAAAAARwADANgAAAAAAAAARwADANkAAAAAAAAARwADANoAAAAAAAAARwAEANoAAAAeAAAAAAAAAEcAAwDbAAAAAAAAAEcAAwDcAAAAAAAAAEcAAwDeAAAA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';
