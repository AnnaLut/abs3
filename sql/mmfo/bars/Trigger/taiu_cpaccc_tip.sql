

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPACCC_TIP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CPACCC_TIP ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CPACCC_TIP 
 after insert or update ON BARS.CP_ACCC  for each row
declare
 KV_ int;
BEGIN
 If (:new.s2VD is null AND :new.s2VP is null ) or :new.RYN is null then
    RETURN;
 end if;
 -----------------------------------------------------------------
 select nvl(kv,0) into KV_ from bars.cp_ryn where ryn=:new.RYN;
 for k in (select acc, tip, a.nls
           from bars.accounts a
           where nls in
                 ( nvl(:new.s2VD,:new.s2VP), nvl(:new.s2VP,:new.s2VD) )
            and a.kv= decode(KV_,0, a.kv, KV_)
           )
 loop
    If k.nls = :new.s2VD and k.tip <> '2VD' then
       update bars.accounts set tip='2VD' where acc=k.acc;
    end if;

    If k.nls = :new.s2VP and k.tip <> '2VP' then
       update bars.accounts set tip='2VP' where acc=k.acc;
    end if;
 end loop;
END TaIU_CPACCC_TIP;
/
ALTER TRIGGER BARS.TAIU_CPACCC_TIP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CPACCC_TIP.sql =========*** End
PROMPT ===================================================================================== 
