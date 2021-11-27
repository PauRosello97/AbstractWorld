class Time{
  int time = 0;
  int lastHour = 0;
  int lastDay = 0;
  int lastMonth = 0;
  int lastSeason = 0;
  
  final int HOUR_DURATION = 1000;
  final int DAY_DURATION = HOUR_DURATION*24;
  final int MONTH_DURATION = DAY_DURATION*10;
  final int SEASON_DURATION = MONTH_DURATION*3;
  
  Time(){
  }
  
  int update(){
    time = millis();  
    if(time-lastSeason>SEASON_DURATION){
      lastSeason = time;
      lastMonth = time;
      lastDay = time;
      lastHour = time;
      return NEW_SEASON;
    }else if(time-lastMonth>MONTH_DURATION){
      lastMonth = time;
      lastDay = time;
      lastHour = time;
      return NEW_MONTH;
    }else if(time-lastDay>DAY_DURATION){
      lastDay = time;
      lastHour = time;
      return NEW_DAY;
    }else if(time-lastHour>HOUR_DURATION){
      lastHour = time;
      return NEW_HOUR;
    }
    return 0;
  }
   
}
