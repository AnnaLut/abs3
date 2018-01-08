CREATE OR REPLACE TRIGGER tau_accounts_ATM  BEFORE UPDATE OF ostc  ON accounts   FOR EACH ROW  WHEN (   old.tip IN ( 'AT7','AT8')     )
BEGIN
  If   :old.OPT = 1 then RETURN; end if; -- для таких счетов этот триггер НЕ МОЖЕТ работать 
  -------------------------------------------------------------------------------------------
  If    :new.OSTC > :old.OSTC and :old.pap = 2   OR   :new.OSTC < :old.OSTC and :old.pap = 1  then 
        insert into ATM_REF1( acc, ref1) values ( :old.acc, gl.aRef);

  ElsIf :new.OSTB < :old.OSTB and :old.pap = 2   OR   :new.OSTB > :old.OSTB and :old.pap = 1  then 
        If pul.GET('ATM_R1') is not null then        insert into ATM_REF2( ref1,ref2) values ( to_number(pul.GET('ATM_R1')), gl.aRef); end if;
  Else RETURN ;

  end  if;

END tau_accounts_ATM ;
/
 
