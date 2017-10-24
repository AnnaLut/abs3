

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SS_DEB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SS_DEB ***

  CREATE OR REPLACE TRIGGER BARS.TU_SS_DEB 
   -- триггер - ловушка траншей
   BEFORE UPDATE OF ostc
   ON accounts
   FOR EACH ROW
     WHEN (    old.tip IN ('SS ', 'SP ')
         AND NEW.ostc < OLD.ostc
         AND NEW.pap = 1
         AND REGEXP_LIKE (old.nls, '^[2][0].[2,3,7]')) DECLARE
   l_pr   INT;               -- Признак наличия сторнирования (больше единицы)
BEGIN
   SELECT COUNT (sos)
     INTO l_pr
     FROM opldok
    WHERE REF = gl.aref AND tt = 'BAK';

   IF l_pr = 0
   THEN
      CCT.tranSh1 (p_nbs     => :old.NBS,
                   p_acc     => :old.ACC,
                   P_S       => -:new.ostc + :old.ostc,
                   P_FDAT    => gl.bdate,
                   P_ref     => gl.aRef,
                   P_ost     => -:new.ostc,
                   P_tip     => :old.TIP,
                   p_mdate   => :old.mdate,
                   p_accc    => :old.accc);
   END IF;
END tu_SS_DEB;



/
ALTER TRIGGER BARS.TU_SS_DEB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SS_DEB.sql =========*** End *** =
PROMPT ===================================================================================== 
