

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_PERSON_PASSP15.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_PERSON_PASSP15 ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_PERSON_PASSP15 
BEFORE INSERT OR UPDATE of PASSP ON BARS.PERSON
for each row
BEGIN
  --COBUSUPABS-4855 з 01.01.2017 просимо вилучити з довідників документів ідентифікації клієнтів тимчасове посвідчення, що підтверджує особу громадянина.
  if :new.passp = 15 and trunc(sysdate) >= to_date('01/01/2017','dd/mm/yyyy') then
     bars_error.raise_nerror('CAC', 'KL_PASSP_15');
  end if;
end;
/
ALTER TRIGGER BARS.TBIU_PERSON_PASSP15 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_PERSON_PASSP15.sql =========***
PROMPT ===================================================================================== 
