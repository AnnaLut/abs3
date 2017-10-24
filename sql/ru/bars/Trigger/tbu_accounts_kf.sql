

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_KF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_KF ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_KF 
before update of kf on accounts
declare
  l_msg    varchar2(4000);
begin
  l_msg := 'Караул!!! Модификация accounts.kf! Срочно обратитесь к Щетенюку Сергею или Дмитрию Гедзу.'
  ||chr(10)||dbms_utility.format_call_stack;
  bars_audit.error(l_msg);
  raise_application_error(-20000, l_msg, true);
end;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_KF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_KF.sql =========*** End
PROMPT ===================================================================================== 
