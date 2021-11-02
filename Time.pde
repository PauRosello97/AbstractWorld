class Time{
  int time = 0;
  int lastDay = 0;
  
  final int HOUR_DURATION = 500;
  final int DAY_DURATION = HOUR_DURATION*24;
  
  Time(){
  }
  
  int update(){
    time = millis();  
    if(time-lastDay>DAY_DURATION){
      lastDay = time;
      return NEW_DAY;
    }
    return 0;
  }
   
}
