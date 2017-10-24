

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIEDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_ACCOUNTSW_LIEDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_ACCOUNTSW_LIEDATE 
before insert or update ON BARS.ACCOUNTSW
for each row
 WHEN (
new.tag = 'LIE_DATE'
      ) declare
   l_dat varchar2(10);
begin
  select to_char(to_date(replace(:new.value,'/','.'),'dd.mm.yyyy'),'dd.mm.yyyy') into l_dat from dual;
  :new.value := l_dat;
exception when others then
  if sqlcode = -01858 then
     raise_application_error(-20001, 'Невірний формат дати');
  else
     raise;
  end if;
end;
/
ALTER TRIGGER BARS.TBIU_ACCOUNTSW_LIEDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_ACCOUNTSW_LIEDATE.sql =========
PROMPT ===================================================================================== 
