# Flutter Pagination Plus

[![pub package](https://img.shields.io/pub/v/flutter_pagination_plus.svg)](https://pub.dev/packages/flutter_pagination_plus)

The `flutter_pagination_plus` package for Flutter is designed that implement **pagination** for list.

<p align="center">
  <img src="https://raw.githubusercontent.com/mithun1st/flutter_pagination_plus/master/example/screenshots/animation.gif" width="500" alt="example">
</p>


## Features

- **onChangeNextPage()**
- **itemBuilder(context, index)**

## Getting started

> Add the package to your `pubspec.yaml` file:
```yaml
dependencies:
  flutter_pagination_plus: <latest version>
```

> Import the Package:
```dart
import 'package:flutter_pagination_plus/flutter_pagination_plus.dart';
```

> Implement Widget:
```dart
FlutterPaginationPlus<User>(
    list: _userList,
    onChangeNextPage: () async {
      _userList.addAll(await _generateList());
    },
    itemBuilder: (ctx, index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          tileColor: Colors.blueGrey,
          title: Text('${_userList[index]} $index'),
        ),
      );
    },
  ),
```


## Limitation

| Android | iOS | MacOS | Web | Linux | Windows |
| :-----: | :-: | :---: | :-: | :---: | :----: |
|   ✅    | ✅  |  ✅   |   ✅   |  ✅   |   ✅   |


## Additional information

`flutter_pagination_plus` plugin is developed by [Mahadi Hassan](https://www.linkedin.com/in/mithun1st/)
> mithun.2121@yahoo.com | [LinkedIn](https://www.linkedin.com/in/mithun1st/) | [GitHub](https://www.github.com/mithun1st/) | [Website](https://mithun1st.blogspot.com/)
