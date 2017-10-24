

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_NBUR_KOR_DATA_F95.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_NBUR_KOR_DATA_F95 ***

  CREATE OR REPLACE TRIGGER BARS.TBI_NBUR_KOR_DATA_F95 
before insert ON BARS.NBUR_KOR_DATA_F95
for each row
/******************************************************************************
   NAME:       TBI_NBUR_KOR_DATA_F95
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        21.11.2016      tetiana.virko       1. Created this trigger.

   NOTES:
******************************************************************************/
declare
   l_max_id NUMBER;
BEGIN
   if nvl(trim(:NEW.id), 0) <= 0 THEN
       l_max_id := 0;

       SELECT max(id) + 1
       INTO l_max_id
       FROM NBUR_KOR_DATA_F95;

       :NEW.id := l_max_id;
   END IF;
END TBI_NBUR_KOR_DATA_F95;
/
ALTER TRIGGER BARS.TBI_NBUR_KOR_DATA_F95 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_NBUR_KOR_DATA_F95.sql =========*
PROMPT ===================================================================================== 
