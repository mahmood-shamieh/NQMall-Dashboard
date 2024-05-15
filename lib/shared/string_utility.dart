extension CapitalizeExtension on String {
  String capitalizeFirstChar() {
    if (this.isEmpty) return "";
    return this[0].toUpperCase() + this.substring(1);
  }
}
