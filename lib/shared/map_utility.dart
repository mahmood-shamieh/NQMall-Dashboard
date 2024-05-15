extension StringConverter on Map {
  Map<String, String> processMap() {
    Map<String, String> result = {};
    forEach((key, value) {
      // Convert both key and value to String and add to result
      if (value != null) result[key.toString()] = value.toString();
    });

    return result;
  }
}
