

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_SMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_SMS ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_SMS 
after update of ostc ON BARS.ACCOUNTS for each row
 WHEN (
new.send_sms='Y' and (old.ostc<>new.ostc or old.dos<>new.dos or old.kos<>new.kos)
      ) declare
l_nlsb varchar2(15);
l_nlsa varchar2(15);
begin

  select T1.NLSA, T1.NLSB
  into l_nlsa, l_nlsb  from oper t1 where T1.REF = GL.AREF;

   insert
      into acc_balance_changes(id, change_time, rnk, acc, ostc, dos_delta, kos_delta, ref, tt, nlsb, nlsa)
    select s_accbalch.nextval, sysdate, :new.rnk, :new.acc, :new.ostc,
           case when (:new.dapp<>:old.dapp or :new.dappq<>:old.dappq) then :new.dos else :new.dos-:old.dos end,
           case when (:new.dapp<>:old.dapp or :new.dappq<>:old.dappq) then :new.kos else :new.kos-:old.kos end,
           GL.AREF,GL.ATT, l_nlsb, l_nlsa
      from dual;
end;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_SMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_SMS.sql =========*** En
PROMPT ===================================================================================== 
