

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SHTARIF_HISTORY.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SHTARIF_HISTORY ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SHTARIF_HISTORY 
 /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
--Date:26/09/2011
--Comments: Синхронизация таблиц_ базових тариф_в з таблицею _стор_ї (противоположность процедури P_SYNC_TARIF)
*/
  after insert or update  ON BARS.SH_TARIF for each row
begin
 UPDATE tarif_history
         SET tar = :new.tar,
             pr = :new.pr,
             smin = :new.smin,
             smax = :new.smax,
             nbs_ob22 = :new.nbs_ob22
       WHERE ids = :new.ids AND kod = :new.kod;

      IF SQL%ROWCOUNT = 0
      THEN
         INSERT INTO tarif_history (IDS,
                               KOD,
                               TAR,
                               PR,
                               SMIN,
                               SMAX,
                               NBS_OB22,
                               DAT_OPEN)
              VALUES (:new.IDS,
                      :new.KOD,
                      :new.TAR,
                      :new.PR,
                      :new.SMIN,
                      :new.SMAX,
                      :new.NBS_OB22,
                      trunc(sysdate));
          end if;
            LOGGER.INFO('TIU_SHTARIF_HISTORY:'||'Оновлено таблицю тариф_в, код пакету='||:new.IDS||','||
                            'код тарифу='||:new.KOD||','||
                            'тариф='|| :new.TAR||','||
                            '% в_д суми='||:new.PR||','||
                            'Мин значення='||:new.SMIN||','||
                            'макс. значення='||:new.SMAX||','||
                            'nbs_ob22=' ||:new.NBS_OB22||','||
                            'дата '||trunc(sysdate));
end;
/
ALTER TRIGGER BARS.TIU_SHTARIF_HISTORY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SHTARIF_HISTORY.sql =========***
PROMPT ===================================================================================== 
