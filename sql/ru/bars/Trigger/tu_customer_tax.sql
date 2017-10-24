

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CUSTOMER_TAX.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CUSTOMER_TAX ***

  CREATE OR REPLACE TRIGGER BARS.TU_CUSTOMER_TAX 
before update of  C_REG,  C_DST on customer
for each row
-- nmk_ customer.nmk%type;
begin
--   nmk_:= substr( nvl(:new.NMKK,:new.NMK),1,38);

   update ree_tmp R  set  c_reg = :new.C_REG,  c_dst = :new.C_DST
    where exists (select 1 from accounts
                  where rnk=:new.RNK and nls = r.NLS and kv=r.KV)
      and fn_o is null;

end tu_customer_TAX;
/
ALTER TRIGGER BARS.TU_CUSTOMER_TAX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CUSTOMER_TAX.sql =========*** End
PROMPT ===================================================================================== 
