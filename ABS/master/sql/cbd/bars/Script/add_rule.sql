begin
Insert into BARS.LCS_LIMITS
   (ID, NAME, ACTIVE_FLAG, ACTIVE_START_DATE, ACTIVE_END_DATE, 
    ATTRS, PERIOD_ID, S_EQ_LIMIT, RESERVE_DAYS_CNT, MV_NAME, 
    STATUS_ID, STATUS_DESCRIPTION, FILTER_CLAUSE, FILTER_DATE, SUM_FILTER_CLAUSE)
 Values
   (8, 'Переказ:відправка за межі України/грн.екв за календарний тиждень двократний розмір (299 999,99) ', 1, TO_DATE('02/07/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/01/2022 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    'PASPN', '2', 29999999, 365, 'MV_', 
    '1', 'введено згідно постанови НБУ', '''436'',''CN1'',''CAA'',''CAB'',''CAS'',''CFS'',''CFO'',''CFB'',''CNU'',''MUU'',''MUJ'',''CVB'',''CVO'',''CVS''', 'CALDATE', '''CFS'',''CFO'',''CFB'',''CNU'',''MUU'',''MUJ'',''CVB'',''CVO'',''CVS''');
exception  when dup_val_on_index
  then    null;
end;
/

begin
Insert into BARS.LCS_LIMITS
   (ID, NAME, ACTIVE_FLAG, ACTIVE_START_DATE, ACTIVE_END_DATE, 
    ATTRS, PERIOD_ID, S_EQ_LIMIT, RESERVE_DAYS_CNT, MV_NAME, 
    STATUS_ID, STATUS_DESCRIPTION, FILTER_CLAUSE, FILTER_DATE, SUM_FILTER_CLAUSE)
 Values
   (9, 'Переказ:відправка за межі України/грн.екв за календарний місяць - восьмикратний розмір(1 199 999,92)', 1, TO_DATE('02/07/2018 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/01/2022 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    'PASPN', '3', 119999992, 365, 'MV_', 
    '1', 'введено згідно постанови НБУ', '''436'',''CN1'',''CAA'',''CAB'',''CAS'',''CFS'',''CFO'',''CFB'',''CNU'',''MUU'',''MUJ'',''CVB'',''CVO'',''CVS''', 'CALDATE', '''CFS'',''CFO'',''CFB'',''CNU'',''MUU'',''MUJ'',''CVB'',''CVO'',''CVS''');
exception  when dup_val_on_index
  then    null;
end;
/


begin
Insert into BARS.LCS_LIMITS
   (ID, NAME, ACTIVE_FLAG, ACTIVE_START_DATE, ACTIVE_END_DATE, 
    ATTRS, PERIOD_ID, S_EQ_LIMIT, RESERVE_DAYS_CNT, MV_NAME, 
    STATUS_ID, STATUS_DESCRIPTION, FILTER_CLAUSE, FILTER_DATE, SUM_FILTER_CLAUSE)
 Values
   (10, 'Переказ:відправка за межі України/грн.екв.150 т./день', 1, TO_DATE('01/01/2014 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), TO_DATE('01/01/2022 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    'PASPN', '1', 15000000, 365, 'MV_', 
    '1', 'введено згідно постанови НБУ', '''436'',''CN1'',''CAA'',''CAB'',''CAS''', 'CALDATE', '''CFS'',''CFO'',''CFB'',''CNU'',''MUU'',''MUJ'',''CVB'',''CVO'',''CVS''');
exception  when dup_val_on_index
  then    null;
end;
/


COMMIT;


update BARS.LCS_LIMITS set ACTIVE_FLAG = 0 where ID = 2;

commit;

update BARS.LCS_LIMITS set S_EQ_LIMIT = 15000000 where ID = 5;

commit;

update BARS.LCS_LIMITS set ACTIVE_FLAG = 1, FILTER_DATE = 'CALDATE', SUM_FILTER_CLAUSE = '''CNU'',''MUU'',''MUJ'',''436'',''CN1'',''CAA'',''CAB'',''CAS'''   where ID = 6;

commit;