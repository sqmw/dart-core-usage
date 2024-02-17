import './stream/stream_create.dart';
import 'stream/stream_handle.dart';
///
/// stream.listen() == await for()
///
/// Stream 是用于处理异步事件序列的抽象类。
/// 通过使用 Stream，可以处理各种异步数据流，
///     例如从网络获取的数据、用户输入、定时器事件等。
///
void main() {
  ///
  // createStreamByStreamController();
  // createStreamByYield();
  ///
  // handleStreamWithFor();
  handleStreamWithListen();
  ///
}
