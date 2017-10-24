

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_DEPOSIT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_DEPOSIT ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_DEPOSIT 
before insert on dpt_deposit
for each row
begin
   insert into dpt_deposit_all (deposit_id
	, branch, kf
   )
   values (:new.deposit_id
	, :new.branch, :new.kf
   );
end;




/
ALTER TRIGGER BARS.TBI_DPT_DEPOSIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_DEPOSIT.sql =========*** End
PROMPT ===================================================================================== 
