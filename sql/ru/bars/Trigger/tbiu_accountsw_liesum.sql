

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIESUM.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACCOUNTSW_LIESUM ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACCOUNTSW_LIESUM 
before insert or update ON BARS.ACCOUNTSW
for each row
 WHEN (
new.tag = 'LIE_SUM'
      ) declare
   l_pr number;
   l_sum varchar2(254);
begin
   select decode(trim(TRANSLATE(:new.value,'0123456789',' ')),null,0,1)
     into l_pr
     from dual;
   if l_pr=1 then
      bars_error.raise_nerror('CAC', 'ACCOUNTSW_LIESUM_ERROR');
    --  raise_application_error(-20001, 'Допустимий формат суми - в коп_йках');
   end if;
   l_sum:=replace(:new.value,' ','');
   :new.value:=l_sum;
end;
/
ALTER TRIGGER BARS.TBIU_ACCOUNTSW_LIESUM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIESUM.sql =========*
PROMPT ===================================================================================== 
