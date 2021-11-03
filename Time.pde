class Time{
  int time = 0;
  int lastDay = 0;
  int lastSeason = 0;
  
  final int HOUR_DURATION = 500;
  final int DAY_DURATION = HOUR_DURATION*24;
  final int MONTH_DURATION = DAY_DURATION*30;
  final int SEASON_DURATION = MONTH_DURATION*3;
  
  Time(){
  }
  
  int update(){
    time = millis();  
    if(time-lastSeason>SEASON_DURATION){
      lastSeason = time;
      return NEW_SEASON;
    }else if(time-lastDay>DAY_DURATION){
      lastDay = time;
      return NEW_DAY;
    }
    return 0;
  }
   
}
