prompt ---------------------------------------------------------------
prompt fill BARS.BPK_TAGS
prompt ---------------------------------------------------------------

begin
  Insert into BARS.BPK_TAGS
    ( TAG ,NAME,TYPE )
  Values
    ( 'FLAGINSURANCE', 'Страхування кредиту', null);
exception 
    when DUP_VAL_ON_INDEX then
    null;
end;
/

commit;

