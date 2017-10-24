

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_KURS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAY_KURS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAY_KURS 
  before insert on zayavka for each row
declare
  l_sab number;
begin

  :new.kurs_kl := case when nvl(:new.kurs_z,0) = 0 then 'Курс уповноваженого банку'
                                                   else trim(to_char(:new.kurs_z,'9999999999999990.9999'))
                  end;
end;
/
ALTER TRIGGER BARS.TBI_ZAY_KURS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAY_KURS.sql =========*** End **
PROMPT ===================================================================================== 
