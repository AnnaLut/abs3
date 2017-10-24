

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_CUSTOMER_NMKV.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_CUSTOMER_NMKV ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_CUSTOMER_NMKV 
  BEFORE INSERT OR UPDATE ON "BARS"."CUSTOMER"
  REFERENCING FOR EACH ROW
     WHEN (new.custtype = 3) begin
  if    inserting
     or updating and
        (   :new.nmkv is null
         or     ascii(substr(trim(:new.nmkv),1,1)) >= 192
            and ascii(substr(trim(:new.nmkv),1,1)) <= 223
         or ascii(substr(trim(:new.nmkv),1,1))  = 165 ) then
     :new.nmkv := f_translate_kmu(trim(:new.nmk));
  end if;
end;



/
ALTER TRIGGER BARS.TBIU_CUSTOMER_NMKV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_CUSTOMER_NMKV.sql =========*** 
PROMPT ===================================================================================== 
