

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_BCK_TRANS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_BCK_TRANS ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_BCK_TRANS 
after update of sos on oper
for each row
 WHEN ( new.sos<0 ) declare
  l_isref  number;
begin
    select count(*) into l_isref from cc_trans_ref where ref = :new.ref;

    if l_isref > 0 then
         cct.otm_back(:new.ref);
    end if;

end;
/
ALTER TRIGGER BARS.TU_OPER_BCK_TRANS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_BCK_TRANS.sql =========*** E
PROMPT ===================================================================================== 
