prompt type/number_list.sql
  CREATE OR REPLACE TYPE BARS.NUMBER_LIST as table of number(38, 12)
/

 show err;
 
PROMPT *** Create  grants  NUMBER_LIST ***
grant EXECUTE                                                                on NUMBER_LIST     to BARSUPL;
grant EXECUTE                                                                on NUMBER_LIST     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NUMBER_LIST     to BARS_DM;
grant EXECUTE                                                                on NUMBER_LIST     to UPLD;
grant EXECUTE                                                                on NUMBER_LIST     to WR_ALL_RIGHTS;
grant EXECUTE                                                                on NUMBER_LIST     to BARS_INTGR;
