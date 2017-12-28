

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PEREKGOD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PEREKGOD ***

  CREATE OR REPLACE PROCEDURE BARS.PEREKGOD (mode_ NUMBER)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% DESCRIPTION : ѕроцедура перекрыти€ 6,7 классов на 5040
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1998.  All Rights Reserved.
% VERSION     : 18.01.2011 (28.12.2006)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 18.01.2011  некоторые косметические изменени€
% 28.12.2006  дл€ формировани€ проводок перекрыти€ убрал условие
              OSTC=OSTB (фактический остаток=плановому остатку)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   ref_       INT;
   ntemp1_    NUMBER;
   ostf_      NUMBER (24);
   nam_a_     VARCHAR2 (38);
   nam_b_     VARCHAR2 (38);
   nam1_      VARCHAR2 (70);
   nam2_      VARCHAR2 (70);
   nlsd_      VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nls5040_   VARCHAR2 (15);
   okpo_a_    VARCHAR2 (14);
   okpo_b_    VARCHAR2 (14);
   id_        NUMBER;
   nazn_      VARCHAR2 (160);
   okpo1_     VARCHAR2 (14);
   okpo2_     VARCHAR2 (14);
   datv_      DATE;
   tt_        CHAR (3);
   errmes_    CHAR (100);
   vob_       NUMBER (38);

BEGIN
------ инициализаци€ переменных ------------------
   nam_a_ := '';
   nam_b_ := '';
   nazn_ := '«акритт€ року';
--- операци€ перекрыти€
   tt_ := 'ZG2';
--- дата валютировани€
   datv_ := bankdate;

--------------------------------------------------
--- DELETE FROM TMP_6_7;
--- COMMIT;
   SELECT 1
     INTO ntemp1_
   FROM tts
   WHERE tt = tt_;

   --SELECT ID
   --  INTO id_
   --FROM staff
   --WHERE UPPER (logname) = USER;
   id_ := user_id;

   IF f_ourmfo() != 300465 THEN
   -- блок дл€ разрыва св€зей налоговых счетов
      DECLARE
      val_   params.val%TYPE;

      BEGIN
         SELECT val
            INTO val_
         FROM params
         WHERE par = 'ZG2005';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
         INSERT INTO params
                     (par, val,
                      comm
                     )
              VALUES ('ZG2005', '1',
                      'флаг наполнени€ таблицы-св€зок налоговых счетов'
                     );

         DELETE FROM nal_zg;

         INSERT INTO nal_zg
            SELECT DISTINCT a.acc, a.accc
                       FROM accounts a, accounts b, nal_dec8 n
                      WHERE a.accc = b.acc
                        AND b.nls = DECODE (f_ourmfo, 300465, n.nls, n.nls8)
                        AND a.kv = 980
                        AND b.kv = 980;

         FOR z IN (SELECT acc
                     FROM nal_zg)
         LOOP
            UPDATE accounts
               SET accc = NULL
             WHERE acc = z.acc;
         END LOOP;

         COMMIT;
      END;
   END IF;

   IF ntemp1_ = 1
   THEN
      --- вид оборотов из настроек операции
      BEGIN
         SELECT vob
           INTO vob_
         FROM tts_vob
         WHERE tt = tt_;
      EXCEPTION
         WHEN OTHERS
         THEN
            vob_ := 6;
      END;

      FOR k IN (SELECT p.nlsa nlsa, p.nlsb nlsb, p.nazn nazn,
                       SUBSTR (a.nms, 1, 38) nmsa, c.okpo okpo,
                       NVL ((s.ostf - s.dos + s.kos), 0) ost
                FROM perek6_7 p,
                     accounts a,
                     saldoa s,
                     customer c
                 WHERE p.nlsa IS NOT NULL
                   AND p.nlsb IS NOT NULL
                   AND p.nlsa = a.nls
--                   AND a.ostc = a.ostb      -- 28.12.2006
                   AND a.kv = 980
                   AND a.rnk = c.rnk
                   AND s.acc = a.acc
                   AND s.ostf - s.dos + s.kos <> 0
                   AND s.fdat = (SELECT MAX (sa.fdat)
                                 FROM saldoa sa
                                 WHERE a.acc = sa.acc AND sa.fdat <= datv_))
      LOOP
         ostf_ := k.ost;
         nazn_ := NVL (k.nazn, nazn_);

         IF NVL (nls5040_, ' ') <> k.nlsb
         THEN
            BEGIN
               SELECT a.nls, SUBSTR (a.nms, 1, 38), c.okpo
                 INTO nls5040_, nam_b_, okpo_b_
               FROM accounts a, customer c
               WHERE a.nls = k.nlsb
                 AND a.kv = 980
                 AND a.rnk = c.rnk;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  INSERT INTO tmp_6_7
                              (nlsa, nlsb, s,
                               err
                              )
                       VALUES ('', 'ERROR', '',
                                  'ќшибка. ќтсутствует счет перекрыти€ (980)'
                               || k.nlsb
                              );
            END;
         END IF;

         IF ostf_ > 0
         THEN
            nlsd_ := k.nlsa;
            nlsk_ := k.nlsb;
            nam1_ := k.nmsa;
            nam2_ := nam_b_;
            okpo1_ := k.okpo;
            okpo2_ := okpo_b_;
         ELSE
            nlsd_ := k.nlsb;
            nlsk_ := k.nlsa;
            nam1_ := nam_b_;
            nam2_ := k.nmsa;
            okpo2_ := k.okpo;
            okpo1_ := okpo_b_;
         END IF;

--- проводка по перекрытию счета
         SAVEPOINT sp;

         IF ABS (ostf_) > 0
         THEN
            BEGIN
               NULL;
               gl.REF (ref_);
               /*
               INSERT INTO oper
                           (REF, tt, vob, nd, dk, pdat, vdat,
                            datd, datp, nam_a, nlsa, mfoa,
                            id_a, nam_b, nlsb, mfob, id_b, kv,
                            s, kv2, s2, nazn, userid,
                            SIGN
                           )
                    VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, datv_,
                            bankdate, bankdate, nam1_, nlsd_, gl.amfo,
                            okpo1_, nam2_, nlsk_, gl.amfo, okpo2_, 980,
                            ABS (k.ost), 980, ABS (k.ost), nazn_, id_,
                            HEXTORAW ('4155544F5452414E53414354494F4E')
                           );
               */
			   gl.in_doc3(ref_=> ref_  , 
                    tt_  =>tt_, 
                    vob_=> vob_, 
                    nd_ => ref_, 
                    pdat_=> SYSDATE, 
                    vdat_=> datv_,
                    dk_ => 1   , 
                    kv_  =>980, 
                    s_  => ABS (k.ost), 
                    kv2_=> 980, 
                    s2_  => ABS (k.ost), 
                    sk_  => null, 
                    data_=> bankdate, 
                    datp_=> bankdate,
                    nam_a_=> nam1_, 
                    nlsa_=> nlsd_,
                    mfoa_=> gl.amfo, 
                    nam_b_=> nam2_, 
                    nlsb_=> nlsk_, 
                    mfob_=> gl.amfo,
                    nazn_ => nazn_,
                    d_rec_=> null,
                    id_a_=> okpo1_, 
                    id_b_=> okpo2_, 
                    id_o_ => null, 
                    sign_=> HEXTORAW ('4155544F5452414E53414354494F4E'), 
                    sos_=>1, 
                    prty_=>null, 
                    uid_=>id_) ;
			   
               paytt (0,
                      ref_,
                      bankdate,
                      tt_,
                      1,
                      980,
                      nlsd_,
                      ABS (k.ost),
                      980,
                      nlsk_,
                      ABS (k.ost)
                     );
            EXCEPTION
               WHEN OTHERS
               THEN
                  BEGIN
                     ROLLBACK TO sp;
                     errmes_ := SUBSTR (SQLERRM, 1, 100);

                     INSERT INTO tmp_6_7
                                 (REF, nlsa, nlsb, s, err
                                 )
                          VALUES (ref_, nlsd_, nlsk_, ostf_, errmes_
                                 );

                     GOTO FINAL;
                  END;
            END;
         END IF;

         <<final>>
         NULL;
      END LOOP;
   ELSE
      INSERT INTO tmp_6_7
                  (nlsa, nlsb, s,
                   err
                  )
           VALUES ('', 'ERROR', '',
                   'ќшибка. ќтсутствует операци€ автоперекрыти€ ZG2'
                  );
   END IF;
END perekgod;
/
show err;

PROMPT *** Create  grants  PEREKGOD ***
grant EXECUTE                                                                on PEREKGOD        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PEREKGOD        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PEREKGOD.sql =========*** End *** 
PROMPT ===================================================================================== 
