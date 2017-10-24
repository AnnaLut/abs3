

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_PERSON_DOCVALIDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_PERSON_DOCVALIDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_PERSON_DOCVALIDATE 
after insert or update or delete of PASSP,SER,NUMDOC,PDATE,ORGAN
ON PERSON
for each row
declare
  -----------------------------------------------------------------------------
  -- Деактуалізація стану документів після зміни паспортних даних клієнта
  -----------------------------------------------------------------------------
  l_rnk   person.rnk%type;
begin

  if (deleting) then
    l_rnk := :old.rnk;
  else
    l_rnk := :new.rnk;
  end if;

  EBP.SET_VERIFIED_STATE( l_rnk, 0 );

end;
/
ALTER TRIGGER BARS.TAIUD_PERSON_DOCVALIDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_PERSON_DOCVALIDATE.sql =======
PROMPT ===================================================================================== 
