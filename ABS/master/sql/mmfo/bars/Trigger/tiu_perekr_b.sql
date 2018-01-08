

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_PEREKR_B.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_PEREKR_B ***

  CREATE OR REPLACE TRIGGER BARS.TIU_PEREKR_B 
AFTER INSERT OR UPDATE OF TT, MFOB, NLSB, polu,NAZN,OKPO, IDR, KOEF, VOB, ID,
                          FORMULA, KOD
             OR DELETE
ON BARS.PEREKR_B FOR EACH ROW
declare
  flg  Number(1) := 0;
BEGIN
  IF INSERTING THEN

    INSERT
    INTO   perekr_b_update (ID       ,
                            IDS      ,
                            TT       ,
                            MFOB     ,
                            NLSB     ,
                            polu     ,
                            NAZN     ,
                            OKPO     ,
                            IDR      ,
                            KOEF     ,
                            VOB      ,
                            FORMULA  ,
                            KOD      ,
                            KF      ,
                            FDAT     ,
                            USER_NAME,
                            IDUPD    ,
                            CHACTION)
                    VALUES (:NEW.ID           ,
                            :NEW.ids          ,
                            :NEW.tt           ,
                            :NEW.mfob         ,
                            :NEW.nlsb         ,
                            :NEW.polu         ,
                            :NEW.nazn         ,
                            :NEW.okpo         ,
                            :NEW.idr          ,
                            :NEW.koef         ,
                            :NEW.vob          ,
                            :NEW.formula      ,
                            :NEW.kod          ,
                            :NEW.kf          ,
--                          to_date(To_char(gl.bdate,'dd/mm/yyyy')||' '||
--                                  To_char(sysdate,'hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
                            sysdate           ,
                            user_name         ,
                            S_perekr_b_update.nextval,
                            0);
  ELSIF UPDATING THEN
    flg := 1;
    IF nvl(:OLD.ids,0)    <>nvl(:NEW.ids,0)     OR
       nvl(:OLD.tt,0)     <>nvl(:NEW.tt,0)      OR
       nvl(:OLD.mfob,0)   <>nvl(:NEW.mfob,0)    OR
       nvl(:OLD.nlsb,0)   <>nvl(:NEW.nlsb,0)    OR
       nvl(:OLD.polu,0)   <>nvl(:NEW.polu,0)    OR
       nvl(:OLD.nazn,0)   <>nvl(:NEW.nazn,0)    OR
       nvl(:OLD.okpo,0)   <>nvl(:NEW.okpo,0)    OR
       nvl(:OLD.idr,0)    <>nvl(:NEW.idr,0)     OR
       nvl(:OLD.koef,0)   <>nvl(:NEW.koef,0)    OR
       nvl(:OLD.vob,0)    <>nvl(:NEW.vob,0)     OR
       nvl(:OLD.formula,0)<>nvl(:NEW.formula,0) OR
       nvl(:OLD.kod,0)    <>nvl(:NEW.kod,0) THEN
      INSERT
      INTO   perekr_b_update (ID       ,
                              IDS      ,
                              TT       ,
                              MFOB     ,
                              NLSB     ,
                              polu     ,
                              NAZN     ,
                              OKPO     ,
                              IDR      ,
                              KOEF     ,
                              VOB      ,
                              FORMULA  ,
                              KOD      ,
                              KF       ,
                              FDAT     ,
                              USER_NAME,
                              IDUPD    ,
                              CHACTION)
                      VALUES (:OLD.ID                  ,
                              :OLD.ids                 ,
                              :OLD.tt                  ,
                              :OLD.mfob                ,
                              :OLD.nlsb                ,
                              :OLD.polu                ,
                              :OLD.nazn                ,
                              :OLD.okpo                ,
                              :OLD.idr                 ,
                              :OLD.koef                ,
                              :OLD.vob                 ,
                              :OLD.formula             ,
                              :OLD.kod                 ,
                              :OLD.kf                 ,
--                            to_date(To_char(gl.bdate,'dd/mm/yyyy')||' '||
--                                    To_char(sysdate,'hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
                              sysdate                  ,
                              user_name                ,
                              S_perekr_b_update.nextval,
                              1);
    END IF;
  ELSIF DELETING THEN
    INSERT
    INTO   perekr_b_update (ID       ,
                            IDS      ,
                            TT       ,
                            MFOB     ,
                            NLSB     ,
                            polu     ,
                            NAZN     ,
                            OKPO     ,
                            IDR      ,
                            KOEF     ,
                            VOB      ,
                            FORMULA  ,
                            KOD      ,
                            KF       ,
                            FDAT     ,
                            USER_NAME,
                            IDUPD    ,
                            CHACTION)
                    VALUES (:OLD.ID                  ,
                            :OLD.ids                 ,
                            :OLD.tt                  ,
                            :OLD.mfob                ,
                            :OLD.nlsb                ,
                            :OLD.polu                ,
                            :OLD.nazn                ,
                            :OLD.okpo                ,
                            :OLD.idr                 ,
                            :OLD.koef                ,
                            :OLD.vob                 ,
                            :OLD.formula             ,
                            :OLD.kod                 ,
                            :OLD.kf                 ,
--                          to_date(To_char(gl.bdate,'dd/mm/yyyy')||' '||
--                                  To_char(sysdate,'hh24:mi:ss'),'dd/mm/yyyy hh24:mi:ss'),
                            sysdate                  ,
                            user_name                ,
                            S_perekr_b_update.nextval,
                            2);
  END IF;
  IF flg=1 THEN
    bars_audit.write_message(bars_audit.INFO_MSG,bankdate,'Сделаны изменения в схеме '||:new.ids);
  END IF;
END tiu_perekr_b;
/
ALTER TRIGGER BARS.TIU_PEREKR_B ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_PEREKR_B.sql =========*** End **
PROMPT ===================================================================================== 
