begin
Insert into BARS.PRVN_EVENT_TYPE
   (ID, NAME)
 Values
   (5, '����������');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    NULL;
end;
/
COMMIT; 