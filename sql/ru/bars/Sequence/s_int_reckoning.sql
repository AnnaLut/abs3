

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_INT_RECKONING.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_INT_RECKONING ***
begin 
  execute_immediate ('CREATE SEQUENCE  BARS.S_INT_RECKONING  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 709569 CACHE 20 NOORDER  NOCYCLE ');
  exception when others then
    null;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_INT_RECKONING.sql =========*** En
PROMPT ===================================================================================== 
