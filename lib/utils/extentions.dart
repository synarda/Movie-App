extension IntX on int {
  String get secondsToTimeZero {
    int seconds = this;
    final hours = (seconds / 3600).floor();
    seconds -= hours * 3600;
    final minutes = (seconds / 60).floor();
    seconds -= minutes * 60;

    if (hours == 0) {
      return "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
    }
    return "${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  }
}
