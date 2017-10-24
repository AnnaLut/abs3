

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_A.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SAL_A ***

  CREATE OR REPLACE TRIGGER BARS.TU_SAL_A 
   -- Reflects all payments in archive saldoa table
   -- VER  tu_sal.sql 5.0.0.0 03/14/04
   -- KF      -- для мульти-МФО схемы с полем KF
   AFTER INSERT OR UPDATE OF dapp, ostc, ostq
   ON accounts
DECLARE
   CURSOR c0
   IS
      SELECT pdat, fdat
        FROM saldoa
       WHERE acc = gl.val.a_acc AND fdat >= gl.bDATE
      FOR UPDATE OF
         ostf,
         pdat,
         dos,
         kos,
         trcn;

   CURSOR c1
   IS
          SELECT ostf
            FROM saldoa
           WHERE     acc = gl.val.a_acc
                 AND fdat = (SELECT MIN (fdat)
                               FROM saldoa
                              WHERE fdat > gl.bDATE AND acc = gl.val.a_acc)
      FOR UPDATE OF pdat;

   trcn_   INT;
   pdat_   DATE;
   fdat_   DATE;
   ostp_   DECIMAL (24);
   ostf_   DECIMAL (24);
   dos_    DECIMAL (24);
   kos_    DECIMAL (24);
   erm     VARCHAR2 (80);
BEGIN
   IF gl.fRCVR = 1
   THEN                                           -- Recovery process - no arc
      RETURN;
   END IF;

   gl.fRCVR := 2;

   trcn_ := NULL;

   IF gl.val.b_ost > gl.val.a_ost
   THEN
      dos_ := gl.val.b_ost - gl.val.a_ost;
      kos_ := 0;
   ELSE
      dos_ := 0;
      kos_ := gl.val.a_ost - gl.val.b_ost;
   END IF;


   OPEN c0;

   LOOP
      FETCH c0 INTO pdat_, fdat_;

      EXIT WHEN c0%NOTFOUND;

      IF fdat_ = gl.bDATE
      THEN
         UPDATE saldoa
            SET dos = dos + dos_, kos = kos + kos_, trcn = trcn + 1
          WHERE CURRENT OF c0;

         trcn_ := 1;
      ELSE
         UPDATE saldoa
            SET ostf = ostf - dos_ + kos_
          WHERE CURRENT OF c0;
      END IF;
   END LOOP;

   CLOSE c0;

   IF trcn_ IS NULL
   THEN
      BEGIN                                     -- Get previous history record
         SELECT ostf - dos + kos, fdat
           INTO ostf_, pdat_
           FROM saldoa
          WHERE     acc = gl.val.a_acc
                AND fdat = (SELECT MAX (fdat)
                              FROM saldoa
                             WHERE fdat < gl.bDATE AND acc = gl.val.a_acc);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ostf_ := NULL;
            pdat_ := NULL;
      END;

      OPEN c1;                                    -- Chain next history record

      LOOP
         FETCH c1 INTO ostp_;

         IF c1%NOTFOUND
         THEN                                           -- No history found ->
            IF ostf_ IS NULL
            THEN
               ostf_ := gl.val.b_ost;                           -- use current
            END IF;
         ELSE
            UPDATE saldoa
               SET pdat = gl.bDATE
             WHERE CURRENT OF c1;

            IF ostf_ IS NULL
            THEN
               ostf_ := ostp_ + dos_ - kos_;
            END IF;
         END IF;

         EXIT;
      END LOOP;

      CLOSE c1;

      INSERT INTO saldoa (acc,
                          fdat,
                          pdat,
                          ostf,
                          dos,
                          kos,
                          trcn,
                          kf)
           VALUES (gl.val.a_acc,
                   gl.bDATE,
                   pdat_,
                   ostf_,
                   dos_,
                   kos_,
                   1,
                   gl.aMFO);
   END IF;
END;



/
ALTER TRIGGER BARS.TU_SAL_A ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_A.sql =========*** End *** ==
PROMPT ===================================================================================== 
