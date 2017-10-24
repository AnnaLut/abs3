

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_PROFIX.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_PROFIX ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_PROFIX 
after update of sos on bars.oper
for each row
 WHEN (old.sos!=5 and new.sos=5 and new.tt in ('CN1','CN2','CN3','CN4','CUV','CNU')) declare
  l_transaction_id varchar2(200);
begin
  begin
    select value
    into   l_transaction_id
    from   operw
    where  ref=:new.ref and tag='TR_ID';
  exception when no_data_found then
    return;
  end;
  if :new.tt in ('CN1') then
    profix_service(:new.ref, l_transaction_id, 'SendConfirm');
  elsif :new.tt in ('CN2','CUV','CNU') then
    profix_service(:new.ref, l_transaction_id, 'PayoutConfirm');
  elsif :new.tt in ('CN3','CN4') then
    profix_service(:new.ref, l_transaction_id, 'ReturnConfirm');
  end if;
end tau_oper_profix;
/
ALTER TRIGGER BARS.TAU_OPER_PROFIX DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_PROFIX.sql =========*** End
PROMPT ===================================================================================== 
