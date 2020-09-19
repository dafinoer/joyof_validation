import 'package:validation_ektp/utils/strings.dart';

class Region {
  final String id;
  final String name;

  const Region({this.id, this.name});

  factory Region.fromJson(Map data) {
    return Region(
      id: data.containsKey(Strings.ID) && data[Strings.ID] != null
          ? data[Strings.ID]
          : '',
      name: data.containsKey(Strings.NAME) && data[Strings.NAME] != null
          ? data[Strings.NAME]
          : "",
    );
  }
}
