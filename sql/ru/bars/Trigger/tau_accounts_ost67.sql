

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_OST67.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_OST67 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_OST67 
 after update of ostb on accounts for each row
 WHEN ( substr(old.nbs,1,1) in ('6','7')      ) declare
  l_Branch3 varchar2(22);
begin
  begin
     select substr(trim(value),1,22)
     into l_Branch3
     from operw where ref =gl.aRef and tag= 'TOBO3';

     update opldok set txt = l_Branch3
     where txt not like '/%/'
       and ref  =  gl.aref
       and stmt =  gl.astmt ;

  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;

end tau_accounts_ost67;
/
ALTER TRIGGER BARS.TAU_ACCOUNTS_OST67 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_OST67.sql =========*** 
PROMPT ===================================================================================== 
