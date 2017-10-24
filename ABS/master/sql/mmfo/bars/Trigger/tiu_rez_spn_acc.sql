

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_REZ_SPN_ACC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_REZ_SPN_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TIU_REZ_SPN_ACC 
  before update or insert of nls,kv ON BARS.REZ_SPN for each row

--declare

--  l_acc int;
-- l_obs23 int; l_kat23 int; l_k23 number;  l_cus   int;
begin
   begin
      select acc into :new.acc from accounts where nls=:new.nls and kv=:new.kv;
   exception when no_data_found  THEN
      raise_application_error(-20000,'Рахунок не знайдено!');
   end;


end tiu_REZ_SPN_ACC;


/
ALTER TRIGGER BARS.TIU_REZ_SPN_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_REZ_SPN_ACC.sql =========*** End
PROMPT ===================================================================================== 
