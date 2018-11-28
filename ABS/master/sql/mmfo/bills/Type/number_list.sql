prompt type/number_list.sql
CREATE OR REPLACE TYPE BILLS.NUMBER_LIST as table of number(38, 12)
/
show err;
 
PROMPT *** Create  grants  NUMBER_LIST ***
grant EXECUTE                                                                on NUMBER_LIST     to BARS_ACCESS_DEFROLE;

