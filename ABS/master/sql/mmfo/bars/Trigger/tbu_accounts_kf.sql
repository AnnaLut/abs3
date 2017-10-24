

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_KF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_KF ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_KF 
   BEFORE UPDATE OF kf
   ON accounts
DECLARE
   l_msg   VARCHAR2 (4000);
BEGIN
   l_msg :=
         'Караул!!! Модификация accounts.kf! Срочно обратитесь к Щетенюку Сергею или Дмитрию Гедзу.'
      || CHR (10)
      || DBMS_UTILITY.format_call_stack;
   bars_audit.error (l_msg);
   raise_application_error (-20000, l_msg, TRUE);
END;



/
ALTER TRIGGER BARS.TBU_ACCOUNTS_KF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_KF.sql =========*** End
PROMPT ===================================================================================== 
