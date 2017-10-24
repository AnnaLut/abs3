

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPTBRATES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_DPTBRATES ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_DPTBRATES 
BEFORE INSERT OR UPDATE ON BARS.DPT_BRATES
for each row
declare
  l_brtype  BRATES.BR_TYPE%TYPE;
  l_msg     varchar2(4000);
begin

  If :new.BASEY is null then
     :new.BASEY := 0;
  End if;

  begin
    select BR_TYPE
      into l_brtype
      from BRATES
     where BR_ID = :new.br_id;

    If l_brtype != 2 then
      l_msg := 'Спроба вставки не ступінчастої базової ставки!' || chr(10) ||
               dbms_utility.format_call_stack;
      bars_audit.error(l_msg);
      raise_application_error(-20000, l_msg, true);
    Else
      null;
    End if;

  end;

end tbiu_dptbrates;
/
ALTER TRIGGER BARS.TBIU_DPTBRATES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_DPTBRATES.sql =========*** End 
PROMPT ===================================================================================== 
