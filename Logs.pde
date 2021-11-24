// 1, 2 and 3 reserved for NEX_DAY, NEW_MONTH and NEW_SEASON
final int OPPOSITE_COLORS_LOVE = 4;
final int MUTATION = 5;
final int BIRTH = 6;

void log(int log){
  if(LOGGING){
    String message = "";
    switch (log){
      case OPPOSITE_COLORS_LOVE:
        message = "Their families are not okay with it... but love goes first";
        break; 
      case MUTATION:
        message = "Mutation";
        break;     
      case BIRTH:
        message = "A new Human is born";
        break;
    }
    println(message);
  }  
}
