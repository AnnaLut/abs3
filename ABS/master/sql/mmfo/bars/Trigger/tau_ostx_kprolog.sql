

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OSTX_KPROLOG.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OSTX_KPROLOG ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OSTX_KPROLOG 
   AFTER UPDATE OF ostx
   ON accounts
   FOR EACH ROW
     WHEN (    NEW.TIP = 'LIM'
         AND NEW.OSTX IS NOT NULL
         AND OLD.OSTX IS NOT NULL
         AND NEW.OSTX != OLD.OSTX) DECLARE
   l_nd     nd_acc.nd%TYPE;
   l_id     staff.id%TYPE;
   l_fio    staff.fio%TYPE;
   l_npp    cc_prol.npp%TYPE;
   l_txt    cc_prol.txt%TYPE;
   l_type   cc_prol.prol_type%TYPE := 2;                       -- зм≥на л≥м≥ту
BEGIN
   SELECT MAX (n.nd)
     INTO l_nd
     FROM ND_ACC n
    WHERE n.acc = :NEW.ACC;

   IF (l_nd IS NOT NULL)
   THEN
      BEGIN
         SELECT s.id, s.fio
           INTO l_id, l_fio
           FROM STAFF$BASE s
          WHERE s.logname = USER;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_id := NULL;
            l_fio := NULL;
      END;

      l_txt :=
            '«мiни  ƒ: '
         || CASE
               WHEN :NEW.OSTX > :OLD.OSTX THEN '«бiльшенн€'
               ELSE '«меншенн€'
            END
         || ' лiмiту з '
         || TO_CHAR (ABS (:old.ostx / 100), 'FM999G999G999G990D00')
         || ' на '
         || TO_CHAR (ABS (:new.ostx / 100), 'FM999G999G999G990D00')
         || ' (вик.'
         || l_id
         || ' - '
         || l_fio
         || ')';

         UPDATE CC_DEAL
            SET kprolog = NVL (kprolog, 0) + 1
          WHERE nd = l_nd AND sos > 0 AND sos < 15
      RETURNING kprolog
           INTO l_npp;

      IF (l_npp IS NOT NULL)
      THEN
         INSERT INTO cc_prol (ND,
                              FDAT,
                              NPP,
                              acc,
                              TXT,
                              PROL_TYPE)
              VALUES (l_nd,
                      gl.bdate,
                      l_npp,
                      :NEW.acc,
                      l_txt,
                      l_type);
      ELSE
         NULL;
      END IF;
   END IF;
END TAU_OSTX_KPROLOG;



/
ALTER TRIGGER BARS.TAU_OSTX_KPROLOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OSTX_KPROLOG.sql =========*** En
PROMPT ===================================================================================== 
