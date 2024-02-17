# Dart core library

## dart:io

### class File & class Directory(两个均是继承自 abstract FileSystemEntity)

- FIle
    - 仅仅用来操作真正的文件
- Directory
    - 仅仅针对文件夹(即使按照规定Directory也是特殊文件)

### File

#### FileRead

- read file async

  ```dart
    void main() async {
      File fileByRead = File("write.txt");
      if (!await fileByRead.exists()) {
        fileByRead.createSync();
        stderr.write("该文件不存在，已创建");
      }
  
      /// 使用流的方式读取
      Stream<List<int>> inputStream = fileByRead.openRead();
  
      /// 1. Stream<List<int>> 绑定到 utf8 解码器上面得到对应的 Stream<String>
      /// 2. 将得到的 Stream<String> 通过 Stream 的方法 transform 在行分割器下面进行分割
      /// 这样实现了边读边处理
      Stream<String> lines =
      (utf8.decoder.bind(inputStream)).transform(const LineSplitter());
      var t1 = 0;
      try {
        await for (final _ in lines) {
          print('t1 ${t1++}');
        }
        print('file is now closed');
      } catch (e) {
        print(e);
      }


      Stream<List<int>> inputStream2 = fileByRead.openRead();
      var t2 = 0;
      /// stream等的操作只要没有 async 和 await 关键字就是异步的
      inputStream2.listen((data) { // 每次输入缓冲区满了就会被监听到
        print('t2: ${t2++}');
      });
    
      print('${t1}, ${t2}');
    }
    ```

#### FileWrite

```dart
void main() async {
  File fileByWrite = File('write.txt');
  if (await fileByWrite.exists() == false) {
    await fileByWrite.create();
    stderr.write('文件不存在，已经创建');
  }

  /// 表示的是覆盖写
  IOSink ioSink = fileByWrite.openWrite(mode: FileMode.write);
  ioSink.write('io_write');

  /// ioSink.add(List<int> data) # 用来写二进制文件
  await ioSink.flush();
  await ioSink.close();
  print('closed');


  sleep(const Duration(seconds: 10));
  return;
}
```

### Directory

```dart
void main() async {
  Directory directory = Directory('F:\\language');
  if (directory.existsSync()) {
    /// directory.list() // 返回一个 Stream<FileSystemEntity>
    List<FileSystemEntity> fFileList = directory.listSync(recursive: true);
    print(fFileList.length);
  }
}
```

## dart:async

### dart 的事件循环相关的重要概念

- Dart 使用的是单线程模型

- 事件循环（Event Loop）：
  Dart使用事件循环来处理异步事件。事件循环不断地从事件队列中取出事件，并将其分发给相应的处理器(
  意思是EventLoop里面的是正在处理的)。
    - Dart中，"事件" 通常指的是用户输入、网络请求、定时器等异步操作的触发或完成。 Dart
      本身并没有直接定义 "事件" 这个特定的数据类型，但在处理异步编程时，你可能会遇到与事件相关的值、对象或概念
    - 在事件驱动的编程环境中，事件队列中的事件不一定需要等到事件循环里面的所有任务都处理完才开始执行。
      事件循环的基本工作原理是不断地从事件队列中取出事件并执行相应的处理代码，而不会等待先前的任务完成。
    - 事件队列中的事件按照添加的顺序进行排列，事件循环会按照顺序一个一个地处理这些事件。如果在事件循环执行过程中新的事件被添加到事件队列，这些新事件也会被依次处理。
    - 在事件循环中，任务可以是正在轮询执行的，而事件队列中的任务则等待执行。这涉及到事件循环的核心概念，其中事件循环从事件队列中取出任务并执行，同时可能触发新的任务进入队列。


- 微任务队列（Microtask Queue）： Dart中有一个微任务队列，用于存储微任务。微任务是优先于事件队列中的任务执行的任务。例如，Future
  的完成事件通常会在微任务中执行。
    - 触发时机： 微任务是在当前事件循环的末尾执行的。当 Dart 执行一段代码（例如一个 Future 的完成回调或
      Dart 代码中的 scheduleMicrotask）时，产生的微任务会在当前事件循环的同一轮中被执行，而不会等待下一个事件循环。
    - 执行顺序(时间)：
      微任务的执行优先级高于事件队列中的任务。这意味着在当前事件循环中产生的微任务会在下一个事件循环之前执行完毕(
      也就是说Microtask会放在当前时间循环的最后执行)。
- 事件队列（Event Queue）： 事件队列存储着待处理的事件，这些事件可能包括IO操作完成、计时器触发等。事件循环从事件队列中取出事件并进行处理。
    - 触发时机(也就是入该队的时间)：
      事件通常指异步操作的触发或完成，如用户输入、定时器、IO操作完成等。这些事件被添加到事件队列中，事件循环会在当前事件循环的末尾或下一个事件循环时处理这些事件。
    - 执行顺序(时间)： 事件在事件队列中按照添加的顺序排列，按照事件循环的规则被一个个地处理。在下一个EventLoop里面执行

### Future

- Future((){});
    - 将一个event/task 加入到 EventQueue 里面
    - 对应的是 EventQueue 里面的 event/task
- Future.microtask((){});
    - 将一个 event/task 丢进到微任务队列中，因为微任务很多时候都是收尾工作，所以优先级比事件队列里面的优先级高
    - 对应的是 Microtask Queue 里面的 event/task
- Future.value()
    - Dart 中用于创建一个已经完成(resolved)的 Future 对象的静态方法。这个方法返回一个包含指定值的
      Future，并且这个 Future 对象的状态是已完成的。
    -
    当我们的task不需要像普通的task一样最后还需要形成一个收尾工作的时候，而是**<span style="color:red">
    仅仅是对一个值的的包装</span>**的时候，就应该使用Future.value()
- Future.sync(() {})
    - Future.sync(() {}) 创建的 Future
      对象，会尽力在当前事件循环中同步执行传入的同步代码块，而不会引入额外的事件循环(
      microtask,意思就是和之前的一起执行)。
      这样做的目的是将同步代码块按照异步的方式包装成一个 Future 对象

### Stream

- StreamController<T>()
- async* yield
- StreamController<T>.broadcast()
- 并非所有情况都要手动关闭 StreamController。
    - 在某些情况下，例如在使用 async* 生成器函数创建的 Stream 中，Dart 会在生成器完成时自动关闭流。
    - 但在其他情况下，尤其是在手动添加事件到流中的情况下，手动关闭是个好的实践。

## dart:convert

- 直接使用第三方库最好

## dart:math

### 常量(const)

```dart
import 'dart:math' as math;

void main() {
  /// eg
  print(math.e);
  print(math.log2e);
  print(math.ln2);
  print(math.pi);
  print(math.sqrt2);
}
```

### 函数(fn)

```dart
import 'dart:math' as core_math;

void main() {
  print(core_math.sin(0));

  /// log == ln
  print(core_math.log(core_math.e));

  print(core_math.exp(0));
  print(core_math.exp(1));
}
```

### 随机数(random)

```dart
import 'dart:math';

void main() {
  Random random = Random();

  /// [0, max)
  print(random.nextInt(111));

  /// default max = 1.0
  print(random.nextDouble());
}
```

## dart:core

- This library is automatically imported into every Dart program.

## isolate

```dart
import 'dart:io';
import 'dart:isolate';

Future<void> isolateFun(SendPort sendPort) async {
  print(1);
  sendPort.send('Msg from isolate');
  // await Future.delayed(const Duration(seconds: 3));
  sleep(const Duration(seconds: 3));
}

void main() async {
  ReceivePort receivePort = ReceivePort();
  SendPort sendPort = receivePort.sendPort;

  /// 可以知道 这里的 await 仅仅是等待 子 isolate 的创建结束，并不是执行完成
  Isolate isolate = await Isolate.spawn(
      isolateFun, sendPort); // sendPort 为 isolateFun 接收的那个参数
  print(2);
  receivePort.listen((message) {
    print(message);

    /// receivePort close 之后才能让 子 isolate 终止
    receivePort.close();
  }).onDone(() {
    /// 在receivePort.close();执行之后就会调用 onDone
    print('object');
    isolate.kill();
  });
}

```

## dart:html