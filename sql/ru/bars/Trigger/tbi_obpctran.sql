

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OBPCTRAN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OBPCTRAN ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OBPCTRAN 
before insert on obpc_tran
for each row
declare
  l_idn number;
begin
  select s_obpctran.nextval into l_idn from dual;
  :new.idn := l_idn;
end;
/
ALTER TRIGGER BARS.TBI_OBPCTRAN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OBPCTRAN.sql =========*** End **
PROMPT ===================================================================================== 
