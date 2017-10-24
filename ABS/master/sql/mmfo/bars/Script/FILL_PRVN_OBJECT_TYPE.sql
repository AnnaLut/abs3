begin
Insert into BARS.PRVN_OBJECT_TYPE
   (ID, NAME, PRD_TP)
 Values
   ('XOZ', 'Госп. Дебіторка', 21);
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    NULL;
end;
/
COMMIT; 