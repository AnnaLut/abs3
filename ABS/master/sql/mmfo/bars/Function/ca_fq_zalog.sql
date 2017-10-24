
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/ca_fq_zalog.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CA_FQ_ZALOG ( ACC_ INT, DAT_ DATE )  RETURN NUMBER  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Функция расчета обеспечения
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 10/08/2010 (22.04.2010, 01.04.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
               sheme_ - схема формирования
               prnk_ - РНК контрагента
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
10/08/2010 - включаем счет 9031 в формирование суммы обеспечения по кредиту
22.04.2010 - исключаем сумму дисконта из рассчета суммы кредита и суммы
             обеспечения т.к. в файле #D8 (@71) должна формироваться общая
             сумма обеспечения (замечание банка Демарк)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
      sk1_           NUMBER;                        -- suma 1 kredita   в экв
      sz_            NUMBER;                        -- suma zaloga all  в экв
      sz1_           NUMBER;                        -- suma 1 zaloga    в экв
      sk_            NUMBER;                        -- suma kredita all в экв
      s080_          CHAR (1);
      r013_          CHAR (5);
      pr_            NUMBER;
      kk_            NUMBER (20, 10);
      ostc_zo_       NUMBER;               --  сумма счета залога с учетом ЗО
      nls_           VARCHAR2 (15);
      kdate_         DATE;
      wdate_         DATE;
      k_             NUMBER          := 1;
      kvk_           NUMBER;                                -- валюта кредита
      discont_       NUMBER          := 0;
      x9_            VARCHAR2 (9);
      del_           NUMBER;
      delq_          NUMBER;
   BEGIN
      sz_ := 0;

      -- сумма 1-го кредита на дату dat_ (с ЗО)
      BEGIN
         SELECT Gl.P_Icurval (a.kv, Rez.ostc96 (a.acc, dat_), dat_),
                NVL (p.s080, '1') s080,
                a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1'), a.kv,
                a.nls
           INTO sk1_,
                s080_,
                r013_, kvk_,
                nls_
           FROM ACCOUNTS a, SPECPARAM p
          WHERE a.acc = p.acc(+) AND a.acc = acc_;

         BEGIN
            SELECT wdate
              INTO wdate_
              FROM CC_ADD
             WHERE nd = (SELECT MAX (nd)
                           FROM ND_ACC
                          WHERE acc = acc_) AND adds = 0;
         EXCEPTION
            WHEN OTHERS
            THEN
               wdate_ := NULL;
         END;

         --discont_ := Rez.ca_fq_discont (acc_, dat_, 1);
         discont_ := 0;  -- 22.04.2010

         -- коррекция на дисконт
         IF SUBSTR (nls_, 1, 4) = '2020'
         THEN
            x9_ := SUBSTR (nls_, 6, 9);

            BEGIN
               SELECT Rez.ostc96 (acc, dat_),
                      Gl.P_Icurval (kv, Rez.ostc96 (acc, dat_), dat_)
                 INTO del_,
                      delq_
                 FROM ACCOUNTS
                WHERE nbs = '2026'
                  AND SUBSTR (nls, 6, 9) = x9_
                  AND kv = kvk_
                  AND (dazs IS NULL OR dazs > dat_);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  del_ := 0;
                  delq_ := 0;
            END;
         ELSE
            del_ := 0;
            delq_ := 0;
         END IF;

         sk1_ := sk1_ + delq_ + discont_;

         IF r013_ = '91299' OR sk1_ > 0
         THEN
            sk1_ := 0;
         END IF;

         IF SUBSTR (r013_, 1, 4) IN ('9100', '9129')
         THEN
            sk1_ := ROUND (0.5 * sk1_);
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      --проверить все договора залога на этот кредит с ЗО
      FOR k IN (SELECT z.acc, a.kv,
                       Rez.ostc96 (a.acc, dat_) Ostc,
                       sz.pawn, c.s031, k.r031
                  FROM CC_ACCP z,
                       ACCOUNTS a,
                       PAWN_ACC sz,
                       CC_PAWN c,
                       KL_R030 k
                 WHERE z.accs = acc_
                   AND z.acc = a.acc
                   AND sz.acc = z.acc
                   AND c.pawn = sz.pawn
                   --and a.nbs <> '9031'
                   AND TO_NUMBER (k.r030) = a.kv)
      LOOP
         ostc_zo_ := Gl.P_Icurval (k.kv, k.Ostc, dat_);
         ------ сумма всех кредитов, имеющих текущий k.NDZ общий дог залога
         -- только отрицательные  п2600 не брать !
         sk_ := 0;
         discont_ := 0;


         FOR k1 IN (SELECT Rez.ostc96 (a.acc, dat_) s, a.kv, a.nls,
                              a.nbs
                           || DECODE (NVL (p.r013, '1'), '9', '9', '1') r013 , a.acc
                      FROM ACCOUNTS a, SPECPARAM p
                     WHERE a.acc IN (SELECT accs
                                       FROM CC_ACCP
                                      WHERE acc = k.acc) AND p.acc(+) = a.acc)
         LOOP
            IF k1.s < 0 AND k1.r013 <> '91299' --and substr(k1.nls,1,4)<>'9031'
            THEN
               -- рассматриваем как кредит
               IF SUBSTR (k1.r013, 1, 4) IN ('9100', '9129')
               THEN
                  sk_ := sk_ + 0.5 * Gl.P_Icurval (k1.kv, k1.s, dat_);
               ELSE
                  sk_ := sk_ + Gl.P_Icurval (k1.kv, k1.s, dat_);
               END IF;


               --discont_ := Rez.ca_fq_discont (k1.acc, dat_, 1);
               discont_ := 0;  -- 22.04.2010

               -- коррекция del_ на дисконт
               IF SUBSTR (k1.nls, 1, 4) = '2020'
               THEN
                  x9_ := SUBSTR (k1.nls, 6, 9);

                  BEGIN
                     SELECT Rez.ostc96 (acc, dat_),
                            Gl.P_Icurval (kv, Rez.ostc96 (acc, dat_), dat_)
                       INTO del_,
                            delq_
                       FROM ACCOUNTS
                      WHERE nbs = '2026'
                        AND SUBSTR (nls, 6, 9) = x9_
                        AND kv = k1.kv
                        AND (dazs IS NULL OR dazs > dat_);
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        del_ := 0;
                        delq_ := 0;
                  END;
               ELSE
                  del_ := 0;
                  delq_ := 0;
               END IF;

               sk_ := LEAST (sk_ + delq_ + discont_, 0);
            END IF;
         END LOOP;

         IF sk_ <> 0
         THEN
		    pr_ := 100;

            IF pr_ <> 0
            THEN
               kk_ := sk1_ / sk_;
               sz1_ := ostc_zo_ * kk_ * pr_ / 100;

               sz_ := sz_ + ROUND (ABS (sz1_));
            END IF;

         END IF;
      END LOOP;

      -- расчет приведенного обеспечения
      IF ABS (sk1_) < ABS (sz_)
      THEN
         k_ := ABS (sk1_ / sz_);
      END IF;

      RETURN ABS (sz_);
   END;
/
 show err;
 
PROMPT *** Create  grants  CA_FQ_ZALOG ***
grant EXECUTE                                                                on CA_FQ_ZALOG     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/ca_fq_zalog.sql =========*** End **
 PROMPT ===================================================================================== 
 