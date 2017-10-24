

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_BLK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_BLK ***

  CREATE OR REPLACE TRIGGER BARS.TU_BLK 
AFTER UPDATE
ON BARS.ARC_RRP
FOR EACH ROW
 WHEN (NOT ( OLD.blk IS NULL AND NEW.blk=0)) DECLARE
/******************************************************************************
 Протоколирование Блокировки/Разблокировки документов СЕП
******************************************************************************/
BEGIN

bars_audit.info('Блокування/Розблокування документу REC='||:NEW.rec||', BLK:'||:OLD.blk||'->'||:NEW.blk);

END TU_ARC_RRP_BLK;
/
ALTER TRIGGER BARS.TU_BLK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_BLK.sql =========*** End *** ====
PROMPT ===================================================================================== 
