

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_1004.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_ACCOUNTS_1004 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_ACCOUNTS_1004 
before update of ostb on accounts for each row
 WHEN ( old.nbs = '1004' ) begin
  if :old.ob22='01' and ( mod((:old.ostb-:new.ostb)/100,1) <> 0 ) then
	 raise_application_error(-20000, 'Сумма снятия/пополнения счета 1004 должна быть кратной 1!');
  end if;
end;
/
ALTER TRIGGER BARS.TBU_ACCOUNTS_1004 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_ACCOUNTS_1004.sql =========*** E
PROMPT ===================================================================================== 
