

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTDEPOSITCLOS_BDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPTDEPOSITCLOS_BDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPTDEPOSITCLOS_BDATE 
before insert on dpt_deposit_clos
for each row
declare
  l_msg  varchar2(500);
begin
  /* тригер для відлову закриття депозитів ранішеше поточнох банківської дати */
  if ( :NEW.BDATE <> gl.bdate ) then
    begin
      l_msg := ( 'DPT_DEPOSIT_CLOS.BDATE('||to_char(:new.BDATE, 'dd.mm.yyyy')||') <> gl.bdate('||to_char(:new.BDATE, 'dd.mm.yyyy')||')'||dbms_utility.format_call_stack() );
      bars_audit.info( l_msg );
      raise_application_error( -20666, l_msg, TRUE );
    end;
  End if;
End;
/
ALTER TRIGGER BARS.TBI_DPTDEPOSITCLOS_BDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTDEPOSITCLOS_BDATE.sql =======
PROMPT ===================================================================================== 
