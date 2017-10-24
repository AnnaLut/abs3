

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_SP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACCOUNTS_SP ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACCOUNTS_SP 
  AFTER UPDATE OF ostc ON accounts
  FOR EACH ROW
 WHEN (
new.tip in  ('SP ','SPN')
      ) declare
 l_nd number;
BEGIN

    IF :new.ostc = 0 AND :new.ostc<>:old.ostc then
      begin
        select nd into l_nd from nd_acc where acc = :new.acc;
        delete from nd_txt  where tag = decode(:new.tip,'SP ','DATSP','DASPN')  and nd = l_nd;
      exception when no_data_found then null;
      end;
    END IF;


END  tu_accounts_sp;
/
ALTER TRIGGER BARS.TU_ACCOUNTS_SP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACCOUNTS_SP.sql =========*** End 
PROMPT ===================================================================================== 
