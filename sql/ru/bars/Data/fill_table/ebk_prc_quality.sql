begin
  Insert into EBK_PRC_QUALITY
    ( ID, PRC_QLY )
  Values
    ( 1, 10 );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert into EBK_PRC_QUALITY
    ( ID, PRC_QLY )
  Values
    ( 2, 30 );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert into EBK_PRC_QUALITY
    ( ID, PRC_QLY )
  Values
    ( 3, 50 );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert into EBK_PRC_QUALITY
    ( ID, PRC_QLY )
  Values
    ( 4, 70 );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

begin
  Insert into EBK_PRC_QUALITY
    ( ID, PRC_QLY )
  Values
    ( 5, 90 );
exception
  when DUP_VAL_ON_INDEX then
    null;
end;
/

COMMIT;
