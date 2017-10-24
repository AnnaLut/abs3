

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_REZERV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_REZERV ***

  CREATE OR REPLACE PROCEDURE BARS.CP_REZERV (idu_ INT, dat_ DATE, mode_ INT
         DEFAULT 0)
IS
/*

 DESCRIPTION :   Процедура расчета резерва ЦБ
 COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
 VERSION     : 22.11.2005
 COMMENT     : критерий формирования резерва
               1. cp_pf.pf=3 (портфель до погашения)
               2. cp_pf.pf=1 (торговый портфель) и cp_vr.vr <> 0 (не по справедливой стоимости)
*/
   acc_           INT;
   dat31_         DATE;
   my_            CHAR (6);
   kibor_         NUMBER         := 0;                        -- ставка КІВОР
   procsr_        NUMBER         := 0;
   nom_           NUMBER;
   -- средняя ствка кредитования для расчета
   dni_           NUMBER;      -- количество дней нахождения кучки в портфеле
   np1_           NUMBER         := 5;
   -- количество периодов учета прибыли контрагента (ср.доход)
   np2_           NUMBER         := 7; -- количество периодов дисконтирования
   sd_            NUMBER         := 0;           -- средний доход контрагента
   lastdate_      DATE;                             -- предыдущая дата купона
   pv_            NUMBER;                                   -- период выплаты
   osd_           NUMBER;                           -- оценочная сумма дохода
   dsd_           NUMBER;                    -- дисконтированная сумма дохода
   dsdv_          NUMBER;              -- дисконтированная сумма дохода всего
   osdn_          NUMBER;                         -- сумма погашения номинала
   dsdn_          NUMBER;      -- дисконтированная сумма погашенного номинала
   dsdvn_         NUMBER;            -- дисконтированная сумма номинала всего
   dn_            NUMBER;
   bd_            NUMBER;                   -- базовое количество дней в году
   ps_            NUMBER;                               -- приведенная ставка
   userid_        NUMBER;
   ob_            NUMBER;
   rn_            NUMBER;
   rownumber_     NUMBER;
   accz_          NUMBER;
   nlsz_          NUMBER;
   acczf_         NUMBER;
   nlszf_         NUMBER;
   rnk1_          NUMBER;
   r1_            NUMBER;
   nms_           VARCHAR2 (38);
   nls_           VARCHAR2 (15);
   dat2_          DATE;
   vdat_          DATE;
   okpoa_         VARCHAR2 (14);
   okpob_         VARCHAR2 (14);
   vob_           NUMBER;
   fxz_           VARCHAR2 (3)   := 'FXZ';
   nazn_          VARCHAR2 (160);
   dk_            NUMBER;
   pruch_         NUMBER;
   n02_           NUMBER         := 0;
   r02_           NUMBER         := 0;
   d02_           NUMBER         := 0;
   p02_           NUMBER         := 0;
   s02_           NUMBER         := 0;
   n03_           NUMBER         := 0;
   r03_           NUMBER         := 0;
   d03_           NUMBER         := 0;
   p03_           NUMBER         := 0;
   s03_           NUMBER         := 0;
   n06_           NUMBER         := 0;
   r06_           NUMBER         := 0;
   d06_           NUMBER         := 0;
   p06_           NUMBER         := 0;
   s06_           NUMBER         := 0;
   n07_           NUMBER         := 0;
   r07_           NUMBER         := 0;
   d07_           NUMBER         := 0;
   p07_           NUMBER         := 0;
   s07_           NUMBER         := 0;
   n04_           NUMBER         := 0;
   r04_           NUMBER         := 0;
   d04_           NUMBER         := 0;
   p04_           NUMBER         := 0;
   s04_           NUMBER         := 0;
   n05_           NUMBER         := 0;
   r05_           NUMBER         := 0;
   d05_           NUMBER         := 0;
   p05_           NUMBER         := 0;
   s05_           NUMBER         := 0;
   n08_           NUMBER         := 0;
   r08_           NUMBER         := 0;
   d08_           NUMBER         := 0;
   p08_           NUMBER         := 0;
   s08_           NUMBER         := 0;
   n12_           NUMBER         := 0;
   r12_           NUMBER         := 0;
   d12_           NUMBER         := 0;
   p12_           NUMBER         := 0;
   s12_           NUMBER         := 0;
   g02_           NUMBER         := 0;
   g03_           NUMBER         := 0;
   g06_           NUMBER         := 0;
   g07_           NUMBER         := 0;
   g04_           NUMBER         := 0;
   g05_           NUMBER         := 0;
   g08_           NUMBER         := 0;
   g09_           NUMBER         := 0;
   g10_           NUMBER         := 0;
   g11_           NUMBER         := 0;
   g12_           NUMBER         := 0;
   g14_           NUMBER         := 0;
   g15_           NUMBER         := 0;
   g16_           NUMBER         := 0;
   g17_           NUMBER;                    -- сформ резерв на отчетную дату
   g18_           NUMBER;
   --g19_           NUMBER        ;
   sr_            NUMBER;
   ref_           NUMBER;
   version_       NUMBER         := 2;
   nextdate_      DATE;
   datn_          DATE;
   monthsdays_    number;
   monthsdaysall_    number;
   ern   CONSTANT POSITIVE       := 208;
   err            EXCEPTION;
   erm            VARCHAR2 (80);

   PROCEDURE to_log (id_ NUMBER, txt_ VARCHAR2, val_ VARCHAR2)
   IS
   BEGIN
      rownumber_ := rownumber_ + 1;

      INSERT INTO cp_rez_log
                  (userid, ID, rownumber, txt, val
                  )
           VALUES (userid_, id_, rownumber_, txt_, val_
                  );

      COMMIT;
   END;
BEGIN
   rownumber_ := 0;
   dat31_ := LAST_DAY (ADD_MONTHS (dat_, -1));
   my_ := TO_CHAR (dat_, 'mmyyyy');

   -- код тек. пользователя
   BEGIN
      SELECT ID
        INTO userid_
        FROM staff
       WHERE UPPER (logname) = USER;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         userid_ := 1;
   END;

   DELETE FROM cp_rez_log
         WHERE userid = userid_;

   IF mode_ = 0
   THEN
      DELETE FROM cp_tmp_rez;

      FOR k IN (SELECT
                       --DISTINCT
                       c.REF, SUBSTR (a.nls, 1, 4) nbs, k.ID, k.cp_id,
                       k.datp, k.cena, k.kv, k.dox, k.amort, k.rnk, k.ir,
                       k.NAME, k.basey, v.pf, c.ryn, v.emi, v.vidd,
                       k.period_kup, k.dat_em, NVL (k.ky, 1) ky,
                       NVL (k.dok, k.dat_em) dok, cf.proc, cu.crisk,
                       cu.nmk nmk, pf.NAME pfname, vr.NAME vrname, a.nls,
                       a.acc
                  FROM cp_deal c,
                       cp_kod k,
                       accounts a,
                       oper o,
                       cp_vidd v,
                       customer cu,
                       cp_fin_proc cf,
                       cp_pf pf,
                       cp_vr vr
                 WHERE c.acc = a.acc
                   AND c.REF = o.REF
                   AND o.sos = 5
                   AND c.ID = k.ID
                   AND v.vidd = SUBSTR (a.nls, 1, 4)
                   AND k.tip = 1
                   AND v.tipd = 1
                   AND v.dox = k.dox
                   AND v.emi = k.emi
                   AND k.rnk = cu.rnk
                   AND v.pf = pf.pf
                   AND vr.vr = k.amort
                   AND NVL (cu.crisk, 5) = cf.fin(+))
      LOOP
         IF k.basey = 0
         THEN
            bd_ :=
                 TO_DATE ('3112' || TO_CHAR (dat_, 'yyyy'), 'ddmmyyyy')
               - TO_DATE ('0101' || TO_CHAR (dat_, 'yyyy'), 'ddmmyyyy')
               + 1;
         ELSIF k.basey = 1
         THEN
            bd_ := 365;
         ELSIF k.basey = 2
         THEN
            bd_ := 360;
         ELSE
            bd_ := k.basey;
         END IF;

         -- срок нахождения бумаги в портфеле
         BEGIN
            SELECT dat_ - MIN (s.fdat)
              INTO dni_
              FROM saldoa s, cp_deal d
             WHERE s.acc = d.acc AND d.REF = k.REF AND s.fdat <= dat_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               dni_ := NULL;
         END;

         -- соответствующий ср. процентная ставка
         BEGIN
            SELECT (CASE
                       WHEN dni_ BETWEEN 0 AND 1
                          THEN p.pr1
                       WHEN dni_ BETWEEN 2 AND 7
                          THEN p.pr2
                       WHEN dni_ BETWEEN 8 AND 21
                          THEN p.pr3
                       WHEN dni_ BETWEEN 22 AND 31
                          THEN p.pr4
                       WHEN dni_ BETWEEN 32 AND 92
                          THEN p.pr5
                       WHEN dni_ > 92
                          THEN p.pr6
                       ELSE 0
                    END
                   )
              INTO procsr_
              FROM cp_pr_kiakr p
             WHERE (p.kv, p.dat) = (SELECT   kv, MAX (pp.dat)
                                        FROM cp_pr_kiakr pp
                                       WHERE pp.kv = k.kv AND pp.dat <= dat_
                                    GROUP BY kv);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               procsr_ := 0;
         END;

         to_log (k.ID, 'счет', TO_CHAR (k.nls));
         to_log (k.ID, 'REF', TO_CHAR (k.REF));
         to_log (k.ID, 'ACC', TO_CHAR (k.acc));
         to_log (k.ID, 'наименование', UPPER (k.NAME));
         to_log (k.ID, 'код ЦБ', TO_CHAR (k.ID));
         to_log (k.ID, 'портфель', TO_CHAR (k.pfname));
         to_log (k.ID, 'вид учета ЦБ', TO_CHAR (k.vrname));
         to_log (k.ID, 'отчетная дата', TO_CHAR (dat_));
         to_log (k.ID, 'дата эмиссии', TO_CHAR (k.dat_em));
         to_log (k.ID, 'годовая база (дней)', TO_CHAR (bd_));
         to_log (k.ID, 'годовая ставка купона', TO_CHAR (k.ir));
         to_log (k.ID, 'срок нахождения буиаги в портфеле', TO_CHAR (dni_));
         to_log (k.ID,
                 'средняя процентная ставка исп. в расчете (KIAKR)',
                 TO_CHAR (procsr_)
                );

         -- бал стоим на начало отч периода
         SELECT NVL (SUM (DECODE (s.acc, d.acc, s.ostf - s.dos + s.kos, 0)),
                     0),
                NVL (SUM (DECODE (s.acc, d.accd, s.ostf - s.dos + s.kos, 0)),
                     0
                    ),
                NVL (SUM (DECODE (s.acc, d.accp, s.ostf - s.dos + s.kos, 0)),
                     0
                    ),
                  NVL (SUM (DECODE (s.acc, d.accr, s.ostf - s.dos + s.kos, 0)),
                       0
                      )
                + NVL (SUM (DECODE (s.acc,
                                    d.accr2, s.ostf - s.dos + s.kos,
                                    0
                                   )),
                       0
                      ),
                NVL (SUM (DECODE (s.acc, d.accs, s.ostf - s.dos + s.kos, 0)),
                     0
                    )
           INTO n02_,
                d02_,
                p02_,
                r02_,
                s03_
           FROM saldoa s, cp_deal d, accounts a
          WHERE d.ID = k.ID
            AND a.acc = d.acc
            AND d.REF = k.REF
            AND SUBSTR (a.nls, 1, 4) = k.nbs
            AND s.acc IN (d.acc, d.accd, d.accp, d.accr, d.accs, d.accr2)
            AND (s.acc, s.fdat) = (SELECT   acc, MAX (fdat)
                                       FROM saldoa
                                      WHERE acc = s.acc AND fdat <= dat31_
                                   GROUP BY acc);

         g02_ := - (n02_ + d02_ + p02_ + r02_ + s03_);

         -- бал стоим на конец отч периода
         SELECT NVL (SUM (DECODE (s.acc, d.acc, s.ostf - s.dos + s.kos, 0)),
                     0),
                NVL (SUM (DECODE (s.acc, d.accd, s.ostf - s.dos + s.kos, 0)),
                     0
                    ),
                NVL (SUM (DECODE (s.acc, d.accp, s.ostf - s.dos + s.kos, 0)),
                     0
                    ),
                  NVL (SUM (DECODE (s.acc,
                                    d.accr2, s.ostf - s.dos + s.kos,
                                    0
                                   )),
                       0
                      )
                + NVL (SUM (DECODE (s.acc, d.accr, s.ostf - s.dos + s.kos, 0)),
                       0
                      ),
                NVL (SUM (DECODE (s.acc, d.accs, s.ostf - s.dos + s.kos, 0)),
                     0
                    )
           INTO n12_,
                d12_,
                p12_,
                r12_,
                s12_
           FROM saldoa s, cp_deal d, accounts a
          WHERE d.ID = k.ID
            AND a.acc = d.acc
            AND d.REF = k.REF
            AND SUBSTR (a.nls, 1, 4) = k.nbs
            AND s.acc IN (d.acc, d.accd, d.accp, d.accr, d.accs, d.accr2)
            AND (s.acc, s.fdat) = (SELECT   acc, MAX (fdat)
                                       FROM saldoa
                                      WHERE acc = s.acc AND fdat <= dat_
                                   GROUP BY acc);

         g12_ := - (n12_ + d12_ + p12_ + r12_ + s12_);

         -- факт сформ резерв на отчетную дату (на данный REF)
         BEGIN
            SELECT NVL (SUM (s.ostf - s.dos + s.kos), 0)
              INTO g18_
              FROM accounts a, saldoa s
             WHERE a.acc = s.acc
               AND SUBSTR (a.nls, 1, 4) IN ('1490', '3190', '3290')
               AND a.nbs IS NULL
               AND SUBSTR (a.nls, 6) =
                                      k.ryn || SUBSTR ('00000000' || k.REF,
                                                       -7)
               AND a.kv = k.kv
               AND (s.acc, s.fdat) = (SELECT s.acc, MAX (ss.fdat)
                                        FROM saldoa ss
                                       WHERE ss.acc = s.acc AND fdat <= dat_);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               g18_ := 0;
         END;

         IF g02_ > 0 OR g12_ > 0
         THEN
            -- если были вх или исх остатки бал стоимости
            -- за месяц по разным операциям отдельно
            -- N-номинал, R-купон, D-дисконт, P-премия, S-переоценка
            -- 03-куплено
            -- 04-погашено
            -- 05-продано
            -- 06-списано
            -- 07-переведено в др.портфель
            -- 08-получено в рез.перевода из др.портфеля
            -- 09-изменение курса
            -- 10-амортизация
            -- 11-нач-погаш купона
            n03_ := 0;
            r03_ := 0;
            d03_ := 0;
            p03_ := 0;
            s03_ := 0;
            n06_ := 0;
            r06_ := 0;
            d06_ := 0;
            p06_ := 0;
            s06_ := 0;
            n07_ := 0;
            r07_ := 0;
            d07_ := 0;
            p07_ := 0;
            s07_ := 0;
            n04_ := 0;
            r04_ := 0;
            d04_ := 0;
            p04_ := 0;
            s04_ := 0;
            n05_ := 0;
            r05_ := 0;
            d05_ := 0;
            p05_ := 0;
            s05_ := 0;
            n08_ := 0;
            r08_ := 0;
            d08_ := 0;
            p08_ := 0;
            s08_ := 0;

            FOR c IN (SELECT c.REF, c.acc, c.sumb, NVL (c.n, 0) n,
                             NVL (c.d, 0) d, NVL (c.p, 0) p, NVL (c.r, 0) r,
                             NVL (c.s, 0) s, c.op, SUBSTR (o.nlsa, 1, 4) nbs
                        FROM cp_arch c, oper o
                       WHERE c.REF = o.REF
                         AND c.REF = k.REF
                         AND o.sos = 5
                         AND c.ID = k.ID
                         AND TO_CHAR (c.dat_roz, 'mmyyyy') = my_)
            LOOP
               IF c.op = 1 AND c.nbs = k.nbs
               THEN
                  n03_ := n03_ - c.n;
                  r03_ := r03_ - c.r;
                  d03_ := d03_ + c.d;
                  p03_ := p03_ - c.p;
                  s03_ := s03_ - c.s;
               ELSIF c.op = 6 AND c.nbs = k.nbs
               THEN
                  n06_ := n06_ - c.n;
                  r06_ := r06_ - c.r;
                  d06_ := d06_ + c.d;
                  p06_ := p06_ - c.p;
                  s06_ := s06_ - c.s;
               ELSIF c.op = 3 AND c.nbs = k.nbs
               THEN
                  n07_ := n07_ - c.n;
                  r07_ := r07_ - c.r;
                  d07_ := d07_ + c.d;
                  p07_ := p07_ - c.p;
                  s07_ := s07_ - c.s;
               ELSIF c.op = 2 AND c.nbs = k.nbs AND c.sumb = c.n
               THEN
                  n04_ := n04_ - c.n;
                  r04_ := r04_ - c.r;
                  d04_ := d04_ + c.d;
                  p04_ := p04_ - c.p;
                  s04_ := s04_ - c.s;
               ELSIF c.op = 2 AND c.nbs = k.nbs AND c.sumb <> c.n
               THEN
                  n05_ := n05_ - c.n;
                  r05_ := r05_ - c.r;
                  d05_ := d05_ + c.d;
                  p05_ := p05_ - c.p;
                  s05_ := s05_ - c.s;
               ELSIF c.op = 3 AND c.nbs <> k.nbs
               THEN
                  BEGIN
                     SELECT a.acc
                       INTO acc_
                       FROM cp_deal d, accounts a
                      WHERE d.REF = c.REF
                        AND d.REF = k.REF
                        AND d.acc = a.acc
                        AND SUBSTR (a.nls, 1, 4) = k.nbs;

                     n08_ := n08_ - c.n;
                     r08_ := r08_ - c.r;
                     d08_ := d08_ + c.d;
                     p08_ := p08_ - c.p;
                     s08_ := s08_ - c.s;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        acc_ := NULL;
                  END;
               END IF;
            END LOOP;

            g03_ := - (n03_ + d03_ + p03_ + r03_ + s03_);
            g04_ := - (n04_ + d04_ + p04_ + r04_ + s04_);
            g05_ := - (n05_ + d05_ + p05_ + r05_ + s05_);
            g06_ := - (n06_ + d06_ + p06_ + r06_ + s06_);
            g07_ := - (n07_ + d07_ + p07_ + r07_ + s07_);
            g08_ := - (n08_ + d08_ + p08_ + r08_ + s08_);
            g09_ := - (s12_ - s02_ - s03_ + s04_ + s05_ + s06_ + s07_ - s08_);
            g10_ :=
               - (  p12_
                  - p02_
                  - p03_
                  + p04_
                  + p05_
                  + p06_
                  + p07_
                  - p08_
                  + d12_
                  - d02_
                  - d03_
                  + d04_
                  + d05_
                  + d06_
                  + d07_
                  - d08_
                 );
            g11_ := - (r12_ - r02_ - r03_ + r04_ + r05_ + r06_ + r07_ - r08_);
            to_log (k.ID, 'номинал ЦБ', TO_CHAR (n12_));

            --G15_ - OB
            IF k.pf = 2
            THEN
               -- портфель на инв ???
               g14_ := NULL;
               --g14_ := NULL;
               g15_ := NULL;
               g16_ := NULL;
               g17_ := NULL;
               g18_ := NULL;
            ELSIF k.pf = 4 OR k.amort = 0
            THEN
               --по рыночной стоимости (переоценка)
               g14_ := g12_;
               --g14_ := NULL;
               g15_ := NULL;
               g16_ := NULL;
               g17_ := NULL;
               g18_ := NULL;
            ELSIF k.pf = 3 OR (k.pf = 1 AND k.amort <> 0)
            THEN
               -- по себестоимости (резерв)
               g14_ := 0;
               g15_ := 0;

               -- АКЦИИ
               IF k.dox = 1 AND n12_ <> 0
               THEN
                  -- формула 7.1 - акции часть правая  k*r
                  BEGIN
                     to_log (k.ID, 'Расчет ожидаемого возмещения (АКЦИИ)',
                             '');

--==old=================================================================================
--                      -- здесь возможно необходимо сделать расчет по количеству ЦБ ???
--                      SELECT
--                 --NVL (kapit, 0) * n12_ / kapit0
--                    NVL (kapit, 0)*proc/100
--                        INTO ob_
--                        FROM cp_dt
--                       WHERE rnk = k.rnk
--                         AND kapit0 > 0
--                         AND fdat = (SELECT MAX (fdat)
--                                       FROM cp_dt
--                                      WHERE rnk = k.rnk AND fdat <= dat_);
--==old==================================================================================
                     -- здесь возможно необходимо сделать расчет по количеству ЦБ ???
                     SELECT
                            --NVL (kapit, 0) * n12_ / kapit0
                            NVL (kapit, 0) * proc / 100, proc
                       INTO ob_, pruch_
                       FROM cp_dt
                      WHERE rnk = k.rnk
                        -- ???
                             --AND kapit0 > 0
                        AND fdat = (SELECT MAX (fdat)
                                      FROM cp_dt
                                     WHERE rnk = k.rnk AND fdat <= dat_);
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        ob_ := 0;
                  END;

                  -- часть левая
                  -- средний доход за последние np1_ лет
                  SELECT NVL (SUM (dt) / COUNT (*), 0)
                    INTO sd_
                    FROM cp_dt
                   WHERE rnk = k.rnk
                     AND   TO_NUMBER (TO_CHAR (fdat, 'yyyy'))
                         - TO_NUMBER (TO_CHAR (dat_, 'yyyy')) <= np1_;

                  to_log (k.ID,
                          'ср доход за ' || TO_CHAR (np1_) || ' лет ',
                          TO_CHAR (sd_)
                         );
                  to_log (k.ID, '', '');

                  -- дисконтированый доход за np2_ лет
                  FOR d IN 1 .. np2_
                  LOOP
                     g15_ := g15_ + sd_ / POWER (1 + kibor_ / 100, d);
                     to_log (k.ID, 'период выплаты', TO_CHAR (d));
                     to_log (k.ID,
                             'дисконт сумма.дохода',
                             TO_CHAR (sd_ / POWER (1 + kibor_ / 100, d))
                            );
                  END LOOP;

                  to_log (k.ID, '', '');
                  to_log (k.ID, 'ВСЕГО диск.сум.дохода', TO_CHAR (g15_));
                  to_log (k.ID, 'часть в капит. эмит.', TO_CHAR (ABS (ob_)));
                  g15_ := LEAST (ABS (g15_), ABS (ob_));
               -- ДОЛГОВЫЕ ЦБ
               ELSIF k.dox <> 1 AND n12_ <> 0
               THEN
                  to_log (k.ID, '', '');
                  to_log (k.ID,
                          'Расчет ожидаемого возмещения (ОБЛИГАЦИИ)',
                          ''
                         );
                  dsdv_ := 0;
                  dsdvn_ := 0;
                  ps_ := k.ir * k.period_kup / bd_;
                  rn_ := 0;
                  to_log (k.ID,
                          'приведенная к купонному периоду ставка',
                          TO_CHAR (ps_)
                         );

                  IF k.pf = 1
                  THEN
                     ps_ := procsr_;
                     to_log (k.ID,
                             'используемая в расчете ставка доходности',
                             'KIAKR=' || TO_CHAR (ps_)
                            );
                  ELSE
                     to_log (k.ID,
                             'используемая в расчете ставка доходности',
                             'приведенная' || TO_CHAR (ps_)
                            );
                  END IF;

                  to_log (k.ID, '', '');
                  to_log (k.ID, 'расчет дисконта купона и номинала', '');
                  nom_ := n12_;

                  -- версия расчета исходя из графика купонных платежей
                  IF version_ = 1
                  THEN
                     FOR h IN (SELECT   *
                                   FROM cp_kupon_hist
                                  WHERE ID = k.ID AND dat > dat_
                               ORDER BY dat)
                     LOOP
                        BEGIN
                           SELECT MAX (dat)
                             INTO lastdate_
                             FROM cp_kupon_hist
                            WHERE ID = h.ID AND dat < h.dat;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              lastdate_ := k.dat_em;
                        END;



                        -- погашение купона
                        pv_ := (h.dat - dat_) / k.period_kup;
                        osd_ :=
                           ABS (n12_) * h.proc * 0.01 * (h.dat - lastdate_)
                           / bd_;
                        dsd_ := osd_ / POWER (1 + ps_ / 100, pv_);
                        dsdv_ := dsdv_ + dsd_;
                        -- погашение номинала, номинал на дату купона

                        -- (считаем, что погашение номинала производится в тот же день)
                        --osdn_ := h.nomdekr;
                        dsdn_ := osdn_ / POWER (1 + ps_ / 100, pv_);
                        dsdvn_ := dsdvn_ + dsdn_;
                        nom_ := nom_ - osdn_;
                        to_log (k.ID, 'дата   выплаты', TO_CHAR (h.dat));
                        to_log (k.ID, 'предыдущая дата', TO_CHAR (lastdate_));
                        to_log (k.ID, 'период выплаты', TO_CHAR (pv_));
                        to_log (k.ID, 'ожидаемый ср.доход', TO_CHAR (osd_));
                        to_log (k.ID, 'дисконт сумма.дохода', TO_CHAR (dsd_));
                        to_log (k.ID, 'погашено номинала', TO_CHAR (osdn_));
                        to_log (k.ID,
                                'дисконт сумма. пог. номинала',
                                TO_CHAR (dsdn_)
                               );
                     END LOOP;
                  ELSIF version_ = 2
                  -- версия исходя из планового начисления купона
                  THEN
                     nextdate_ := LEAST (LAST_DAY (dat_), k.datp-1);
                     lastdate_ := dat_;
                     monthsdaysall_:=0;
                     LOOP
                        monthsdays_:= last_day(nextdate_)-last_day(add_months(nextdate_,-1));
						monthsdaysall_:=monthsdaysall_+(nextdate_ - dat_) / monthsdays_;
						pv_ := ROUND ((nextdate_ - dat_) / monthsdays_, 2);
                        osd_ :=
                             round(ABS (n12_)
                           * k.ir
                           * 0.01
                           * (nextdate_ - lastdate_)
                           / bd_,2);
                        dsd_ := round(osd_ / POWER (1 + ps_ / 100, pv_),0);
                        dsdv_ := dsdv_ + dsd_;
-----------------------------------------------------
                        to_log (k.ID, 'dat1', TO_CHAR (lastdate_));
                        to_log (k.ID, 'dat2', TO_CHAR (nextdate_));
                        --to_log (k.ID, 'pv', TO_CHAR (pv_));
						to_log (k.ID, 'osd', TO_CHAR (osd_));
						to_log (k.ID, 'dsd', TO_CHAR (dsd_));
						to_log (k.ID, 'dsdv', TO_CHAR (dsdv_));
						--to_log (k.ID, 'd', TO_CHAR (monthsdays_));
-----------------------------------------------------
                        lastdate_ := nextdate_;

                        IF nextdate_ >= k.datp-1
                        THEN
                           EXIT;
                        ELSE
                           nextdate_ :=
                              LEAST (LAST_DAY (ADD_MONTHS (nextdate_, 1)),
                                     k.datp-1
                                    );
                        END IF;
                     END LOOP;
                  END IF;

-- old ------------------------------------------------------
                  dn_ :=
                       ABS (n12_)
                     / POWER (1 + ps_ / 100, pv_);


    -- old -------------------------------------------------------
--                   dn_ :=
--                        dsdvn_
--                      +   ABS (nom_)
--                        / POWER (1 + ps_ / 100, (k.datp - dat_) / k.period_kup);

                  -- наличие дисконта
                  IF FALSE
                  THEN
                     to_log (k.ID,
                             'дисконт',
                             'есть (учитывается только дисконт номинала)'
                            );
                     g15_ := dn_;
                  ELSE
                     to_log (k.ID, 'дисконт', 'нет');
                     g15_ := dn_ + dsdv_;
                  END IF;

                  to_log (k.ID, 'номинал', TO_CHAR (ABS (n12_)));
                  to_log (k.ID, 'процент', TO_CHAR (ps_));
                  to_log (k.ID, 'дата погашения',
                          TO_CHAR (k.datp, 'ddmmyyyy'));
                  to_log (k.ID, 'отчетная дата', TO_CHAR (dat_, 'ddmmyyyy'));
                  to_log (k.ID, 'купонный период', TO_CHAR (k.period_kup));
                  to_log (k.ID,
                          'период выплаты',
                          TO_CHAR (round((k.datp - dat_) / k.period_kup,2))
                         );
                  to_log (k.ID, 'ВСЕГО диск.сум.дохода', TO_CHAR (dsdv_));
                  to_log (k.ID, 'дисконт. номинал', TO_CHAR (dn_));
               END IF;

               -- резерв
               g16_ :=
                  ABS (GREATEST (ABS (g12_) - ABS (g15_) * (100 - k.proc)
                                              / 100,
                                 0
                                )
                      );
               g15_ := ABS (g15_);
               -- g18_:=g16_-g19_;
               to_log (k.ID, '', '');
               to_log (k.ID, 'Бал. стоим.', TO_CHAR (g12_));
               to_log (k.ID, 'Ожидаемое возмещение', TO_CHAR (g15_));
               to_log (k.ID, 'Фин. положение контрагента', TO_CHAR (k.crisk));
               to_log (k.ID, 'Коэф.коррект. рын. стоим.', TO_CHAR (k.proc));
               to_log (k.ID, 'Резерв', TO_CHAR (g16_));
               to_log (k.ID, '', '');

               -- вставка
               INSERT INTO cp_tmp_rez
                           (REF, dat, idu, rnk, ID, cp_id, kv,
                            vr, dox, g02, g03, g04, g05, g06,
                            g07, g08, g09, g10, g11, g12,
                            g15, g16, g17, g18, nmk,
                            pf, ryn, emi, vidd
                           )
                    VALUES (k.REF, dat_, idu_, k.rnk, k.ID, k.cp_id, k.kv,
                            k.amort, k.dox, g02_, g03_, g04_, g05_, g06_,
                            g07_, g08_, g09_, g10_, g11_, g12_,
                            NVL (g15_, 0), NVL (g16_, 0), g17_, g18_, k.nmk,
                            k.pf, k.ryn, k.emi, k.vidd
                           );
            END IF;                                      -- g02_ >0 or g12_ >0
         END IF;
      END LOOP;
   ELSIF mode_ = 1
   THEN
      BEGIN
         dat2_ := bankdate;

         -- rnk по умолчанию для ЦБ
         SELECT TO_NUMBER (val)
           INTO rnk1_
           FROM params
          WHERE par = 'RNK_CP';

         -- ОКПО
         BEGIN
            SELECT SUBSTR (val, 1, 14)
              INTO okpoa_
              FROM params
             WHERE par = 'OKPO';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               okpoa_ := '';
         END;

         -- VOB
         IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
         THEN
            vob_ := 96;
         ELSE
            vob_ := 6;
         END IF;

         -- vdat
         vdat_ := dat_;

         FOR cb IN (SELECT   t.cp_id, t.kv, t.pf, t.ryn, t.emi, t.vidd,
                             c.nlsz, az.nbs nbsz, az.nms nmsz, az.acc accz,
                             c.nlszf, azf.nbs nbszf, azf.nms nmszf,
                             azf.acc acczf, az.grp,
                             SUM (NVL (t.g17, t.g16) - t.g18) s
                        FROM cp_tmp_rez t,
                             cp_accc c,
                             accounts az,
                             accounts azf
                       WHERE t.idu = idu_
                         AND t.dat = dat_
                         AND t.pf = c.pf
                         AND t.ryn = c.ryn
                         AND t.emi = c.emi
                         AND t.vidd = c.vidd
                         AND c.nlsz = az.nls
                         AND t.kv = az.kv
                         AND c.nlszf = azf.nls
                         AND t.kv = azf.kv
                         AND azf.kv = '980'
                    GROUP BY t.cp_id,
                             t.kv,
                             t.pf,
                             t.ryn,
                             t.emi,
                             t.vidd,
                             c.nlsz,
                             az.nbs,
                             az.nms,
                             az.acc,
                             c.nlszf,
                             azf.nbs,
                             azf.nms,
                             azf.acc,
                             az.grp
                      HAVING SUM (NVL (t.g17, t.g16) - t.g18) <> 0)
         LOOP
            gl.REF (ref_);

            IF vob_ = 96 AND cb.s > 0
            THEN
               nazn_ := 'Коригуюча проводка по доформуванню резерва';
            ELSIF vob_ = 96 AND cb.s < 0
            THEN
               nazn_ := 'Коригуюча проводка по росформуванню резерва';
            ELSIF vob_ <> 96 AND cb.s > 1
            THEN
               nazn_ := 'Доформування резерву';
            ELSIF vob_ <> 96 AND cb.s < 0
            THEN
               nazn_ := 'Росформування резерву';
            END IF;

            nazn_ := SUBSTR (nazn_ || ' (ЦП ' || cb.cp_id || ')', 1, 160);

            INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat, datd,
                         datp, nam_a, nlsa, mfoa,
                         kv, s, nam_b, nlsb,
                         mfob, kv2, s2, nazn, userid,
                         SIGN, id_a, id_b
                        )
                 VALUES (ref_, fxz_, vob_, ref_, 1, SYSDATE, vdat_, dat2_,
                         dat2_, SUBSTR (cb.nmszf, 1, 38), cb.nlszf, gl.amfo,
                         cb.kv, ABS (cb.s), SUBSTR (cb.nmsz, 1, 38), cb.nlsz,
                         gl.amfo, cb.kv, ABS (cb.s), nazn_, idu_,
                         getautosign, okpoa_, okpoa_
                        );

            FOR k IN (SELECT t.cp_id, t.ID, t.REF, t.kv, t.ryn, c.nlsz,
                             az.nbs nbsz, az.nms nmsz, az.acc accz, c.nlszf,
                             azf.nbs nbszf, azf.nms nmszf, azf.acc acczf,
                             az.grp, az.isp ispz, t.g16, t.g17, t.g18
                        FROM cp_tmp_rez t,
                             cp_accc c,
                             accounts az,
                             accounts azf
                       WHERE t.idu = idu_
                         AND t.dat = dat_
                         AND t.cp_id = cb.cp_id
                         AND t.pf = c.pf
                         AND t.ryn = c.ryn
                         AND t.emi = c.emi
                         AND t.vidd = c.vidd
                         AND t.pf = cb.pf
                         AND t.ryn = cb.ryn
                         AND t.emi = cb.emi
                         AND t.vidd = cb.vidd
                         AND c.nlsz = az.nls
                         AND t.kv = az.kv
                         AND c.nlszf = azf.nls
                         AND t.kv = azf.kv)
            LOOP
               -- Структура хвоста : 1 знак   - рынок
               --                  : 7 знаков - REF
               --                  : 1 знак   - пусто/номер

               -- проверка и открытие счетов

               -- внебалансовый счет фонда (1490,3190,3290)
               nls_ :=
                    k.nbsz || '0' || k.ryn || SUBSTR ('00000000' || k.REF,
                                                      -7);
               nls_ := vkrzn (SUBSTR (f_ourmfo (), 1, 5), nls_);
               op_reg_ex (99,
                          0,
                          0,
                          k.grp,
                          r1_,
                          rnk1_,
                          nls_,
                          k.kv,
                          SUBSTR (k.nmsz, 1, 70),
                          'ODB',
                          k.ispz,
                          accz_,
                          NULL
                         );

               SELECT nls
                 INTO nlsz_
                 FROM accounts
                WHERE acc = accz_;

               UPDATE accounts
                  SET accc = k.accz,
                      seci = 1,
                      pap = 2,
                      pos = 0
                WHERE acc = accz_;

               -- внебалансовый счет фонда (7703)
--                nls_ :=
--                     k.nbszf || '0' || k.ryn || SUBSTR ('00000000' || k.REF,
--                                                        -7);
--                op_reg_ex (99,
--                           0,
--                           0,
--                           k.grp,
--                           r1_,
--                           rnk1_,
--                           nls_,
--                           k.kv,
--                           k.nmszf,
--                           'ODB',
--                           idu_,
--                           acczf_,
--                           NULL
--                          );
--
--                SELECT nls
--                  INTO nlszf_
--                  FROM accounts
--                 WHERE acc = acczf_;
--
--                UPDATE accounts
--                   SET accc = k.acczf,
--                       seci = 1,
--                       pap = 1,
--                       pos = 0
--                 WHERE acc = acczf_;

               -- сумма доформирования
               sr_ := NVL (k.g17, k.g16) - k.g18;

               IF sr_ <> 0
               THEN
                  dk_ := GREATEST (SIGN (sr_), 0);

                  IF vob_ = 96 AND dk_ = 1
                  THEN
                     nazn_ := 'Коригуюча проводка по доформуванню резерва';
                  ELSIF vob_ = 96 AND dk_ = 0
                  THEN
                     nazn_ := 'Коригуюча проводка по росформуванню резерва';
                  ELSIF vob_ <> 96 AND dk_ = 1
                  THEN
                     nazn_ := 'Доформування резерву';
                  ELSIF vob_ <> 96 AND dk_ = 0
                  THEN
                     nazn_ := 'Росформування резерву';
                  END IF;

                  nazn_ := nazn_ || ' (ref=' || TO_CHAR (k.REF) || ')';
                  -- payv
                      -- flg_   SMALLINT DEFAULT NULL,  -- Plan/Fact flg
                         -- ref_   INTEGER,    -- Reference
                         -- dat_   DATE,       -- Value Date
                         -- tt_    CHAR,       -- Transaction code
                         -- dk_    SMALLINT,   -- Debet/Credit
                         -- kv1_   SMALLINT,   -- Currency code 1
                         -- nls1_  VARCHAR2,   -- Account number 1
                         -- sum1_  DECIMAL,    -- Amount 1
                         -- kv2_   SMALLINT,   -- Currency code 2
                         -- nls2_  VARCHAR2,   -- Account number 2
                         -- sum2_  DECIMAL
                  gl.payv (0,
                           ref_,
                           vdat_,
                           fxz_,
                           dk_,
                           k.kv,
                           k.nlszf,
                           ABS (sr_),
                           k.kv,
                           nlsz_,
                           ABS (sr_)
                          );

                  UPDATE opldok
                     SET txt = SUBSTR (nazn_, 1, 70)
                   WHERE REF = ref_ AND (acc = accz_ OR acc = k.acczf);
               END IF;
            END LOOP;
         END LOOP;
      EXCEPTION
         WHEN OTHERS
         THEN
            -- ошибки
            ROLLBACK;
            RAISE;
      END;
   END IF;

   COMMIT;
END cp_rezerv;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_REZERV.sql =========*** End ***
PROMPT ===================================================================================== 
