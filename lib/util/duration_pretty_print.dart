extension DurationPrettyPrint on Duration {
  /// Small method to get the duration in the `mm:ss` format.
  String prettyPrint() {
    final List<String> dividedTime = toString().split(":");
    return "${dividedTime[1]}:${dividedTime[2].split(".")[0]}";
  }

  static Duration createFromPrettyPrint(String prettyPrintString) {
    List<String> prettyPrintStringList = prettyPrintString.split(":");
    return Duration(
      minutes: int.parse(prettyPrintStringList[0]),
      seconds: int.parse(prettyPrintStringList[1]),
    );
  }
}
