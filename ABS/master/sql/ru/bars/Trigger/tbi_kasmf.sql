

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_KASMF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_KASMF ***

  CREATE OR REPLACE TRIGGER BARS.TBI_KASMF 
 before insert on KAS_MF
for each row
begin
 :new.idm := NVL (:new.idm , to_number (pul.get_mas_ini_val ('KAS_IDM') ) ) ;
end tbi_KASMF;
/
ALTER TRIGGER BARS.TBI_KASMF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_KASMF.sql =========*** End *** =
PROMPT ===================================================================================== 
