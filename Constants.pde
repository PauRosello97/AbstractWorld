/*   Objectives   */
final int NO_OBJECTIVE = 0;
final int FIND_FOOD = 1;
final int REPRODUCE = 2;

/*      Time      */
final int NOTHING = 0;
final int NEW_HOUR = 1;
final int NEW_DAY = 2;
final int NEW_MONTH = 3;
final int NEW_SEASON = 4;

/*     Seasons    */
final int WINTER = 0;
// In WINTER partners of the same color are even better candidates.
// In WINTER every day appears [0-24] food
final int SPRING = 1;
// In SPRING partners of all colors all equally good.
// In SUMMER every hour appears [0-1] food
final int SUMMER = 2;
// In SUMMER every month the oldest human dies.
// In SUMMER every hour appears [0-3] food
final int FALL = 3;
// In FALL every hour appears [0-3] food
