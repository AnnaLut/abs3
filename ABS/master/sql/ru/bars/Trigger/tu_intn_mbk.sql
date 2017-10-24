

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_INTN_MBK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_INTN_MBK ***

  CREATE OR REPLACE TRIGGER BARS.TU_INTN_MBK 
BEFORE UPDATE OF S ON INT_ACCN
-- может быть включен либо этот, либо TU_INTN
-- для Межбанковских кредитов-депозитов не накапливает погрешность
-- а если накапливаем то ни тот ни другой
FOR EACH ROW
 WHEN (
new.tt in ('%MB','%00','%02')
      ) BEGIN
   :NEW.S := 0;
END;
/
ALTER TRIGGER BARS.TU_INTN_MBK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_INTN_MBK.sql =========*** End ***
PROMPT ===================================================================================== 
