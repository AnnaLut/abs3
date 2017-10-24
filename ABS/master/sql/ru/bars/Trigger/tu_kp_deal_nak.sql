

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_KP_DEAL_NAK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_KP_DEAL_NAK ***

  CREATE OR REPLACE TRIGGER BARS.TU_KP_DEAL_NAK 
BEFORE UPDATE
OF MFOB
  ,NLSB
  ,OKPOB
  ,NAK
  ,NAZN
ON BARS.KP_DEAL 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
 WHEN (
OLD.acc IS NOT NULL
      ) DECLARE
   ids_           INT;
   nms_           VARCHAR2 (38);
   tt_            CHAR (3);
   errk           INT;
   ern   CONSTANT POSITIVE      := 333;
   err            EXCEPTION;
   erm            VARCHAR2 (80);
BEGIN
   --Проверить достаточность параметров
   IF    (    :NEW.grp = 1
          AND (   :NEW.mfob IS NULL
               OR :NEW.nlsb IS NULL
               OR :NEW.nmsb IS NULL
               OR :NEW.okpob IS NULL
               OR :NEW.nazn IS NULL
               OR :NEW.tt IS NULL
               OR :NEW.vob IS NULL
               OR :NEW.sk IS NULL
              )
         )
      OR (:NEW.grp = 0 AND (:NEW.tt IS NULL OR :NEW.vob IS NULL))
   THEN
      erm := 'Не заданы все обязательные параметры для договора № ' || :NEW.nd;
      RAISE err;
   END IF;

----------------------------
   IF :NEW.mfob <> gl.amfo
   THEN
      tt_ := 'PS2';
   ELSE
      tt_ := 'PS1';
   END IF;

   IF :NEW.grp = 1
   THEN
      --появилась группировка - создали и включили схему IDS_

      --узнать код и имя схемы
      SELECT TO_NUMBER (nls), SUBSTR (nms, 1, 38)
        INTO ids_, nms_
        FROM accounts
       WHERE acc = :OLD.acc;

      --S создать-обновить схему
      UPDATE perekr_s
         SET NAME = nms_
       WHERE ids = ids_;

      IF SQL%ROWCOUNT = 0
      THEN
         INSERT INTO perekr_s
                     (ids, NAME
                     )
              VALUES (ids_, nms_
                     );
      END IF;

      --B создать-обновить состав схемы
      IF :NEW.nak = 0
      THEN
         UPDATE perekr_b
            SET tt = tt_,
                mfob = :NEW.mfob,
                nlsb = :NEW.nlsb,
                polu = SUBSTR (:NEW.nmsb, 1, 38),
                nazn = :NEW.nazn,
                kv = gl.baseval,
                okpo = :NEW.okpob,
                koef = 1,
                vob = 6
          WHERE ids = ids_ AND tt LIKE 'PS_';

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO perekr_b
                        (ids, tt, mfob, nlsb, polu,
                         nazn, kv, okpo, koef, vob, idr
                        )
                 VALUES (ids_, tt_, :NEW.mfob, :NEW.nlsb, SUBSTR (:NEW.nmsb, 1, 38),
                         :NEW.nazn, gl.baseval, :NEW.okpob, 1, 6, 1
                        );
         END IF;
      END IF;

      --установить схему для счета
      UPDATE specparam
         SET ids = ids_
       WHERE acc = :OLD.acc;

      IF SQL%ROWCOUNT = 0
      THEN
         INSERT INTO specparam
                     (acc, ids
                     )
              VALUES (:OLD.acc, ids_
                     );
      END IF;
   ELSE
      --Исчезла группировка - выключили схему
      UPDATE specparam
         SET ids = NULL
       WHERE acc = :OLD.acc;

     --
     :NEW.KOMU_FLAG := null;
     :NEW.KOMU_VAL := null;
   END IF;
EXCEPTION
   WHEN err
   THEN
      raise_application_error (- (20000 + ern), '\' || erm, TRUE);
END tu_kp_deal_nak; 
/
ALTER TRIGGER BARS.TU_KP_DEAL_NAK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_KP_DEAL_NAK.sql =========*** End 
PROMPT ===================================================================================== 
