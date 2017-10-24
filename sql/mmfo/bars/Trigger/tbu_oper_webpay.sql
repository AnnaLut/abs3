

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_OPER_WEBPAY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_OPER_WEBPAY ***

  CREATE OR REPLACE TRIGGER BARS.TBU_OPER_WEBPAY 
before update of sos
on oper for each row
    WHEN (
old.sos IN (1,3) AND new.sos = 5 and new.tobo <> '0'
      ) declare
-- Блокує фактичну оплату документів з веб
sess_  varchar2(64) :=bars_login.get_session_clientid;
flag_  varchar2(64);
begin
   SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
   flag_:=SYS_CONTEXT('BARS_GLPARAM','WEBPAY');
   SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);
   IF flag_='N' AND sys_context('userenv','proxy_user') = 'APPSERVER' then
--      bars_error.raise_nerror('KLB', 'CLOSE_PAY_DOCS');
      raise_application_error(-(20203),'\'||'9454 - Оплату документів заблоковано технологом',TRUE);
   end if;
end;


/
ALTER TRIGGER BARS.TBU_OPER_WEBPAY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_OPER_WEBPAY.sql =========*** End
PROMPT ===================================================================================== 
