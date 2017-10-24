

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_PROVNU_PO1.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_PROVNU_PO1 ***

  CREATE OR REPLACE TRIGGER BARS.TU_PROVNU_PO1 
instead of update ON PROVNU_PO1 for each row
declare  p_ref number;
begin
      if :old.sos=5 and :new.sos=0 then
         select ref into p_ref from oper  where ref=:old.ref;
         ful_bak(p_ref);
         insert into  oper_visa (ref,  dat,  userid,  groupid, status)
         values            (:old.ref,sysdate,user_id, null,      3);
      end if;
end;



/
ALTER TRIGGER BARS.TU_PROVNU_PO1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_PROVNU_PO1.sql =========*** End *
PROMPT ===================================================================================== 
