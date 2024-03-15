int calculateReadingTime({required String content}){
  final words = content.split(RegExp(r'\s+'));
  final wordCount = words.length;
  final time = (wordCount / 200).round();
  if(time == 0){
    return 1;
  }
  return time;
}