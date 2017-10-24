

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_DPT_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_DPT_PAYMENTS ***

  CREATE OR REPLACE TRIGGER BARS.TU_DPT_PAYMENTS 
before update of ostb, ostc, ostf on accounts
for each row
 WHEN ((old.tip = 'DEP')     and
   (new.ostb != old.ostb  or
    new.ostc != old.ostc  or
    new.ostf != old.ostf)) declare
   l_dptid  dpt_payments.dpt_id%type;
   l_ref    dpt_payments.ref%type;
   l_kf     dpt_payments.kf%type := gl.kf;
begin


  if (gl.aref is null) then
     return;
  end if;

  select deposit_id into l_dptid from dpt_deposit where acc = :new.acc;
  begin
    insert into dpt_payments (dpt_id, ref
	, kf
	)
    values (l_dptid, gl.aref
	, l_kf
	);
  exception
    when dup_val_on_index then
      null;
  end;

exception
  when no_data_found then null;
end tu_dpt_payments;
/
ALTER TRIGGER BARS.TU_DPT_PAYMENTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_DPT_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
