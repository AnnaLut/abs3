

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_CASH_BRANCH_LIMIT_1.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_CASH_BRANCH_LIMIT_1 ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_CASH_BRANCH_LIMIT_1 
  INSTEAD OF UPDATE OR INSERT OR DELETE ON V_CASH_BRANCH_LIMIT_1 FOR EACH ROW
BEGIN
   IF inserting then
       insert into CASH_BRANCH_LIMIT (BRANCH, KV, DAT_LIM, L_T, LIM_P, LIM_M)
       VALUES(:new.BRANCH, :new.KV, :new.DAT_LIM, '1', :new.LIM_P, :new.LIM_M);
   ELSIF updating then
       update CASH_BRANCH_LIMIT set lim_p=:new.lim_p, lim_m=:new.lim_m
       where branch=:new.branch and kv=:new.kv and DAT_LIM=:new.DAT_LIM and L_T=:old.L_T;
   ELSE
       delete from CASH_BRANCH_LIMIT  where branch=:old.branch and kv=:old.kv and DAT_LIM=:old.DAT_LIM and L_T=:old.L_T;
 end IF;
END;



/
ALTER TRIGGER BARS.TIUD_CASH_BRANCH_LIMIT_1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_CASH_BRANCH_LIMIT_1.sql =======
PROMPT ===================================================================================== 
