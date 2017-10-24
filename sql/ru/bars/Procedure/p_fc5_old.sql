

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FC5_OLD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FC5_OLD ***

  CREATE OR REPLACE PROCEDURE BARS.P_FC5_OLD (dat_ DATE, pnd_ NUMBER DEFAULT NULL)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #С5 для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION      :11/01/2013 (09/01/2013 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  11/01/2013 - виправила перебіжки иіж 1590 та 1592
%  03/01/2013 - зміни структури показника
%  15.11.2012 - для разницы округлений по 2400 в поле NBUC формируем код
%               территории если PR_TOBO>0 иначе код МФО или территории из
%               классификатора KL_F00....
%  27.07.2012 - не враховувалась сума довілного резерву по 232 групі(980)
%  21.07.2012 - доопрацювання
%  18.07.2012 - 1) переведення на f_pop_otcn
%               2) доопрацювання блоку розбивки R013 для 2400 (коди 2 та 9)
%  17.04.2012 - для определения параметра r013 по бал.счетам 2610,2611,2615,
%               2616,2617,2630,2635,2636,2637,2651,2652,2653,2656 проверяем
%               поле MDATE как файле #A7 (замечание Петрокоммерца)
%  20.03.2012 -  в поле коментарий добавил код TOBO и наименование счета
%  17.02.2012 - добавил функцию TRIM для поля PREM кл-ров KL_R020, KOD_R020
%  17.10.2011 - выполняем разбивку по сч. начисл. %% если остаток активный
%  30.03.2011 - для МФО=333368 будем выполнять разбивку по R013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      Varchar2(2) := 'C5';
   sheme_     Varchar2(1) := 'G';
   acc_       NUMBER;
   nbs_       VARCHAR2 (4);
   nbs1_      VARCHAR2 (4);
   nls_       VARCHAR2 (15);
   daos_      DATE;
   dat_r_     DATE;
   data_      DATE;
   mdate_     DATE;
   kv_        SMALLINT;
   sn_        DECIMAL (24);
   se_        DECIMAL (24);
   se1_       DECIMAL (24);
   dk_        CHAR (1);
   kodp_      VARCHAR2 (20);
   znap_      VARCHAR2 (30);
   r013_      VARCHAR2 (1);
   fa7d_      NUMBER;
   id_        NUMBER;
   s080_      NUMBER;
   s080_r_    NUMBER;
   sum_rez_   NUMBER;
   sum_24_    NUMBER;
   acc_24_    NUMBER;
   nls_24_    VARCHAR2 (15);
   userid_    NUMBER;
   rnk_       NUMBER;
   isp_       NUMBER;
   fa7p_      NUMBER;
   comm_      rnbu_trace.comm%TYPE;
   comm1_     rnbu_trace.comm%TYPE;
   tobo_      accounts.tobo%TYPE;
   nms_       accounts.nms%TYPE;
   mfo_       NUMBER;
   mfou_      NUMBER;
   dos_       NUMBER;
   dose_      NUMBER;
   rezid_     NUMBER;
   nd_        NUMBER;
   nd1_        NUMBER;
   nd2_        NUMBER;
   nd3_        NUMBER;
   nd4_        NUMBER;

   -- ДО 30 ДНЕЙ
   o_r013_1   VARCHAR2 (1);
   o_se_1     DECIMAL (24);
   o_comm_1   rnbu_trace.comm%TYPE;
   -- ПОСЛЕ 30 ДНЕЙ
   o_r013_2   VARCHAR2 (1);
   o_se_2     DECIMAL (24);
   o_comm_2   rnbu_trace.comm%TYPE;
   tips_      VARCHAR2 (3);
   f7ad_      NUMBER;

   caldt_ID_   NUMBER;

   typ_       NUMBER;
   nbuc1_     VARCHAR2 (20);
   nbuc_      VARCHAR2 (20);

   CURSOR basel
   IS
      SELECT   kodp, nbuc, SUM (znap)
      FROM rnbu_trace
      GROUP BY kodp, nbuc
      having SUM (znap)<> 0;


   TYPE ref_type_curs IS REF CURSOR;

   saldo        ref_type_curs;
   cursor_sql   varchar2(2000);

   datz_        date := Dat_Next_U(dat_, 1);
   sql_acc_     clob;
   ret_         number;
   in_acc_      varchar2(255);

   r012_        specparam.r012%type;
   s580_        specparam.s580%type;
   s580a_       specparam.s580%type;

   dat_zmin1    date := TO_DATE('20022008', 'ddmmyyyy');
   dat_zmin2    date := to_date('03012013', 'ddmmyyyy');

   -- балансовые счета дисконта
   nbsdiscont_     VARCHAR2 (2000)
      := '2016,2026,2036,2066,2076,2086,2106,2116,2126,2136,2206,2216,2226,2236,';
   -- балансовые счета премии
   nbspremiy_      VARCHAR2 (2000)
      := '2065,2075,2085,2105,2115,2125,2135,2205,2215,2235,';
   nbsrezerv_     VARCHAR2 (2000)
      := '1492,1493,1590,1592,2400,2401,3190,3191,3291,3599,';

   discont_ number := 0;
   premiy_  number := 0;

   datr_    date;
   sum_     number;
   sumc_    number := 0;
   srez_    number := 0;
   srezp_   number := 0;
   sakt_    number := 0;

   type     t_otcn_log is table of number index by pls_integer;
   table_otcn_log3_ t_otcn_log;

   cnt_     number;
   TP_SND   BOOLEAN := false;

BEGIN
-------------------------------------------------------------------
   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_fa7_temp';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ1';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ2';

   EXECUTE IMMEDIATE 'truncate table otcn_f42_zalog'
   ;
   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';

   EXECUTE IMMEDIATE 'truncate table OTC_REF_AKT';

-------------------------------------------------------------------
    -- свой МФО
   mfo_ := f_ourmfo ();

   -- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   if 300465 in (mfo_, mfou_) then
      sheme_ := 'C';
   end if;

-------------------------------------------------------------------
   INSERT INTO otcn_fa7_temp
      SELECT r020
        FROM kl_r020
       WHERE trim(prem) = 'КБ'
         AND (LOWER (txt) LIKE '%нарах%доход%'
              OR LOWER (txt) LIKE '%нарах%витр%'
             )
         AND r020 IN (SELECT k.r020
                        FROM kod_r020 k
                       WHERE trim(k.prem) = 'КБ' AND k.a010 = 'C5')
         AND t020 = '1';

-------------------------------------------------------------------
-- код пользователя, данные по расчету резерву которого использовались
-- при формировании фонда
-- если фонд не формировался = код текущего пользователя
   BEGIN
      SELECT MAX (dat)
        INTO dat_r_
        FROM rez_protocol
       WHERE dat <= dat_;

      IF ABS (MONTHS_BETWEEN (dat_, dat_r_)) > 1.5
      THEN
         dat_r_ := dat_;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         dat_r_ := dat_;
   END;

   -- определение кода области для выбранного файла и схемы
   P_Proc_Set (kodf_, sheme_, nbuc1_, typ_);

   SELECT count(*)
   INTO rezid_
   FROM rez_protocol
   WHERE dat = dat_r_;

   if rezid_ = 0 then
      rezid_ := NULL;
   end if;

   p_upd_r012;

   if pnd_ is null then
      sql_acc_ := ' SELECT *
                    FROM ACCOUNTS a
                    where nbs IN (
                            SELECT r020
                              FROM kod_r020
                             WHERE a010 = ''C5''
                               AND trim(prem) = ''КБ''
                               AND d_open between TO_DATE (''01011997'', ''ddmmyyyy'') and
                                   to_date('''||to_char(datz_,'ddmmyyyy')||''',''ddmmyyyy'')
                               and (d_close is null or
                                    d_close > to_date('''||to_char(datz_,'ddmmyyyy')||''',''ddmmyyyy''))) ';
   else
      sql_acc_ := ' SELECT *
                    FROM ACCOUNTS a
                    where (acc in (select acc from nd_acc where nd = '||to_char(pnd_)|| ' ) or nbs like ''9500%'') and
                          nbs IN (
                            SELECT r020
                              FROM kod_r020
                             WHERE a010 = ''C5''
                               AND trim(prem) = ''КБ''
                               AND d_open between TO_DATE (''01011997'', ''ddmmyyyy'') and
                                   to_date('''||to_char(datz_,'ddmmyyyy')||''',''ddmmyyyy'')
                               and (d_close is null or
                                    d_close > to_date('''||to_char(datz_,'ddmmyyyy')||''',''ddmmyyyy''))) ';
   end if;

   ret_ := BARS.F_POP_OTCN( dat_, 1, sql_acc_, null, 0, 1);

   cursor_sql := 'select a.*, n.nd nd1, b.nd nd2, w.nd nd3, o.nd nd4, nvl(nvl(nvl(n.nd, b.nd), o.nd), w.nd) nd
                    from (SELECT   a.acc, a.nls, a.kv, a.daos, :dat_, a.nbs, NVL (cc.r013, ''0''),
                                            NVL (cc.s080, ''1''), decode(a.kv, 980, s.ost, s.ostq) ostq, a.rnk,
                                            a.isp, a.mdate, a.tip, a.tobo, a.nms, nvl(cc.r012, ''0''), nvl(cc.s580, ''9'')
                                          FROM otcn_saldo s, otcn_acc a, specparam cc
                                         WHERE  s.ost <> 0 and
                                                s.acc = a.acc and
                                                a.acc = cc.acc(+) and
                                                s.nbs not in (''1590'',''1592'',''2400'',''2401'')) a
                         left outer join (select n.acc, max(n.nd) nd
                                          from nd_acc n, cc_deal e
                                          WHERE e.sdate <= :Dat_
                                            AND e.nd = n.nd
                                          group by n.acc ) n
                         on (a.acc = n.acc)
                         left outer join bpk_acc b
                         on (a.acc in (b.ACC_PK, b.ACC_OVR, b.ACC_3570, b.ACC_2208, b.ACC_2207, b.ACC_3579, b.ACC_2209, b.ACC_9129))
                         left outer join (select acc, nd from acc_over where sos<>1) o
                         on (a.acc = o.acc)
                         left outer join w4_acc w
                         on (a.acc in (w.ACC_PK, w.ACC_OVR, w.ACC_9129, w.ACC_3570, w.ACC_2208, w.ACC_2627, w.ACC_2207, w.ACC_3579,
                            w.ACC_2209, w.ACC_2625X, w.ACC_2627X, w.ACC_2625D, w.ACC_2203))
                  ORDER BY 6, 3, 2 ';

   OPEN saldo FOR cursor_sql USING dat_, dat_;

   LOOP
      FETCH saldo
       INTO acc_, nls_, kv_, daos_, data_, nbs_, r013_, s080_, se_, rnk_,
            isp_, mdate_, tips_, tobo_, nms_, r012_, s580_, nd1_, nd2_, nd3_, nd4_, nd_;

      EXIT WHEN saldo%NOTFOUND;

      IF typ_ > 0 THEN
         nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      if instr(nbsdiscont_, nbs_) > 0 or instr(nbspremiy_, nbs_) > 0 then
         r012_ := 'D';
      end if;

      -- зауваження ПКБ
      if nbs_ = '2620' and se_ > 0 then
         r012_ := (case when r013_ = '1' then '2' else '6' end);
      end if;

      -- зауваження ПКБ
      if nbs_ in ('2630', '2635') and se_ > 0 then
         r012_ := '2';
      end if;

      -- Демарк
      if nbs_ = '9500' and r013_ = '0' then
         r013_ := '9';
      end if;

      if dat_>=to_date('01112008','ddmmyyyy') and nbs_ in ('1518','1528') then
         BEGIN
            select a.nbs
               into nbs1_
            from accounts a, int_accn i
            where i.acra=acc_
              and i.acc=a.acc
              and i.ID=0
              and a.daos=daos_
              and ROWNUM=1;

            if nbs_ = '1518' and nbs1_ in ('1510','1512') and
               r013_ not in ('5','7') then
               r013_ := '5';
            end if;

            if nbs_ = '1518' and nbs1_ not in ('1510','1512') and
               r013_ not in ('6','8') then
               r013_ := '6';
            end if;

            if nbs_ = '1528' and nbs1_ = '1521' and
               r013_ not in ('5','7') then
               r013_ := '5';
            end if;

            if nbs_ = '1528' and nbs1_ <> '1521' and
               r013_ not in ('6','8') then
               r013_ := '6';
            end if;

         EXCEPTION WHEN NO_DATA_FOUND THEN
           NULL;
         END;

      end if;

      comm_ := substr(nms_,1,38) || '  R013_old=' || r013_;

      if nbs_ in ('2610','2611','2615','2616','2617','2630','2635','2636',
                  '2637','2651','2652','2653','2656') and
         (r013_ is null OR r013_='0' OR r013_ not in ('1','9') or mdate_ is not null)
      then
         if mdate_ is null OR mdate_ > Dat_ then
            r013_ := '9';
         end if;

         if mdate_ is not null AND mdate_ <= Dat_ then
            r013_ := '1';
         end if;
      end if;

      comm_ := substr(comm_ || ' R013_new=' || r013_, 1, 200);

      IF mfo_=325815 AND TRIM (tips_) = 'NLD'
      THEN
         SELECT COUNT (*)
            INTO fa7d_
         FROM accounts
         WHERE accc = acc_;
      END IF;

      -- для Львова Укоопспилки консолидированные счета депозитов
      IF mfo_=325815 AND TRIM (tips_) = 'NLD' AND fa7d_ > 0
      THEN
         FOR k IN (SELECT a.acc acc, a.nls nls, a.kv kv, s.dapp fdat,
                          s.nbs nbs, s.tip tip,
                          NVL (p.r013, '0') r013,
                          s.mdate mdate, a.ost ost,
                          ca.rnk rnk, s.isp isp
                   FROM sal a,
                        accounts s,
                        specparam p,
                        cust_acc ca
                   WHERE s.accc = acc_

                 AND a.acc = s.acc
                     AND ca.acc = s.acc
                     AND a.fdat = dat_
                     AND a.acc = p.acc(+)
                     AND a.ost <> 0)
         LOOP
            comm1_ :='';

            BEGIN
               SELECT a.deposit_id, a.dat_end
                  INTO  nd_, mdate_
               FROM dpt_deposit a
               WHERE a.acc = k.acc
                 AND a.deposit_id IN (SELECT MAX (deposit_id)
                                      FROM dpt_deposit
                                      WHERE acc = k.acc);


            EXCEPTION
                      WHEN NO_DATA_FOUND THEN
               null;
            END;

            if mdate_ is null OR mdate_ > Dat_ then
               r013_ := '9';
            end if;

            if mdate_ is not null AND mdate_ <= Dat_ then
               r013_ := '1';
            end if;

            IF k.kv <> 980
            THEN
               se1_ := gl.p_icurval (k.kv, k.ost, dat_);
            ELSE
               se1_ := k.ost;
            END IF;

            if se1_ != 0 then

               comm1_ := 'R013=' || r013_;

               dk_ := iif_n (se1_, 0, '1', '2', '2');

               IF dat_ > dat_zmin2
               THEN
                  kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0') || r012_ || s580_;
               ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                  kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0');
               ELSE
                  kodp_ := dk_ || nbs_ || r013_;
               END IF;

               znap_ := TO_CHAR (ABS (se1_));

               INSERT INTO rnbu_trace
                          (nls, kv, odate, kodp, znap, rnk, isp, comm,
                           nd, acc, mdate, nbuc, tobo
                          )
                   VALUES (k.nls, k.kv, data_, kodp_, znap_, k.rnk, k.isp, comm1_,
                           nd_, k.acc, mdate_, nbuc_, tobo_
                          );

               se_ := se_ - se1_;
            END IF;

         END LOOP;
      END IF;

      ------------------------------------------------------------------------
      dk_ := iif_n (se_, 0, '1', '2', '2');

      -- Счет начисленных процентов?
      BEGIN
         SELECT 1
           INTO fa7p_
           FROM otcn_fa7_temp
          WHERE r020 = nbs_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            fa7p_ := 0;
      END;

      -- счета начисленных процентов
      -- c 30.03.2011 для МФО=333368 будем выполнять разбивку по R013
      -- для Ровно Укоопспилки не выполняем разбивку
      -- 17.10.2011 выполняем разбивку только для активных остатков
      IF fa7p_ > 0 and se_ < 0 and mfo_ not in (333432)
      THEN
         -- для банка Демарк консолидированный счет 2627 овердрафт
         IF mfou_=353575 AND nbs_ = '2627'  --TRIM (tips_) = 'NLD'
         THEN
            SELECT COUNT (*)
               INTO fa7d_
            FROM accounts
            WHERE accc = acc_;
         END IF;

         -- для банка Демарк консолидированные счета нач. %% овердрафтов 2627
         IF mfou_ = 353575 AND nbs_ = '2627' AND fa7d_ >= 0
         THEN
            FOR k IN (SELECT a.acc acc, a.nls nls, a.kv kv, s.dapp fdat,
                             s.nbs nbs, s.tip tip,
                             NVL (p.r013, '0') r013,
                             s.mdate mdate, a.ost ost,
                             s.rnk rnk, s.isp isp
                      FROM sal a,
                           accounts s,
                           specparam p
                      WHERE s.nbs = '8026'
                        AND a.acc = s.acc
                        AND a.fdat = dat_
                        AND a.acc = p.acc(+)
                        AND a.ost <> 0)
            LOOP

               comm1_ :='';

               IF k.kv <> 980
               THEN
                  se1_ := gl.p_icurval (k.kv, k.ost, dat_);
               ELSE
                  se1_ := k.ost;
               END IF;

               if se1_ != 0 then
                  comm1_ := 'R013=' || r013_;

                  dk_ := iif_n (se1_, 0, '1', '2', '2');

                  p_analiz_r013 (mfo_,
                                 mfou_,
                                 dat_,
                                 k.acc,
                                 k.nbs,
                                 k.kv,
                                 k.r013,
                                 se1_,
                                 nd_,
                                 --------
                                 o_r013_1,
                                 o_se_1,
                                 o_comm_1,
                                 --------
                                 o_r013_2,
                                 o_se_2,
                                 o_comm_2
                                );

                  -- до 30 дней
                  IF o_se_1 <> 0
                  THEN
                     IF dat_ > dat_zmin2
                     THEN
                        kodp_ := dk_ || nbs_ || o_r013_1 || LPAD (kv_, 3, '0') || r012_ || s580_;
                     ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                        kodp_ := dk_ || nbs_ || o_r013_1 || LPAD (kv_, 3, '0');
                     ELSE
                        kodp_ := dk_ || nbs_ || o_r013_1;
                     END IF;

                     IF typ_ > 0 THEN
                        nbuc_ := NVL (F_Codobl_Tobo (k.acc, typ_), nbuc1_);
                     ELSE
                        nbuc_ := nbuc1_;
                     END IF;

                     znap_ := TO_CHAR (ABS (o_se_1));

                     INSERT INTO rnbu_trace
                               (nls, kv, odate, kodp, znap, rnk, isp,
                                comm, nd, acc, mdate, nbuc, tobo
                               )
                        VALUES (k.nls, k.kv, data_, kodp_, znap_, k.rnk, k.isp,
                                substr(comm_ || o_comm_1,1,200), nd_, k.acc, k.mdate, nbuc_, tobo_
                               );
                  END IF;

                  -- свыше 30 дней
                  IF o_se_2 <> 0
                  THEN
                     IF dat_ > dat_zmin2
                     THEN
                        kodp_ := dk_ || nbs_ || o_r013_2 || LPAD (kv_, 3, '0') || r012_ || s580_;
                     ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                        kodp_ := dk_ || nbs_ || o_r013_2 || LPAD (kv_, 3, '0');
                     ELSE
                        kodp_ := dk_ || nbs_ || o_r013_2;
                     END IF;

                     IF typ_ > 0 THEN
                        nbuc_ := NVL (F_Codobl_Tobo (k.acc, typ_), nbuc1_);
                     ELSE
                        nbuc_ := nbuc1_;
                     END IF;

                     znap_ := TO_CHAR (ABS (o_se_2));

                     INSERT INTO rnbu_trace
                               (nls, kv, odate, kodp, znap, rnk, isp,
                                comm, nd, acc, mdate, nbuc, tobo
                               )
                        VALUES (k.nls, k.kv, data_, kodp_, znap_, k.rnk, k.isp,
                                substr(comm_ || o_comm_2,1,200), nd_, k.acc, k.mdate, nbuc_, tobo_
                               );
                  END IF;
               END IF;

            END LOOP;
               se_ := 0;
         END IF;

         if se_ <> 0 then

            IF typ_ > 0 THEN
               nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;

            p_analiz_r013 (mfo_,
                           mfou_,
                           dat_,
                           acc_,
                           nbs_,
                           kv_,
                           r013_,
                           se_,
                           nd_,
                           --------
                           o_r013_1,
                           o_se_1,
                           o_comm_1,
                           --------
                           o_r013_2,
                           o_se_2,
                           o_comm_2
                          );

            -- до 30 дней
            IF o_se_1 <> 0
            THEN
               IF dat_ > dat_zmin2
               THEN
                  kodp_ := dk_ || nbs_ || o_r013_1 || LPAD (kv_, 3, '0') || r012_ || s580_;
               ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                  kodp_ := dk_ || nbs_ || o_r013_1 || LPAD (kv_, 3, '0');
               ELSE
                  kodp_ := dk_ || nbs_ || o_r013_1;
               END IF;

               znap_ := TO_CHAR (ABS (o_se_1));

               INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, rnk, isp,
                            comm, nd, acc, mdate, nbuc, tobo
                           )
                    VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, isp_,
                            substr(comm_ || o_comm_1,1,200), nd_, acc_, mdate_, nbuc_, tobo_
                           );
            END IF;

            -- свыше 30 дней
            IF o_se_2 <> 0
            THEN
               IF dat_ > dat_zmin2
               THEN
                  kodp_ := dk_ || nbs_ || o_r013_2 || LPAD (kv_, 3, '0') || r012_ || s580_;
               ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                  kodp_ := dk_ || nbs_ || o_r013_2 || LPAD (kv_, 3, '0');
               ELSE
                  kodp_ := dk_ || nbs_ || o_r013_2;
               END IF;

               znap_ := TO_CHAR (ABS (o_se_2));

               INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, rnk, isp,
                            comm, nd, acc, mdate, nbuc, tobo
                           )
                    VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, isp_,
                            substr(comm_ || o_comm_2,1,200), nd_, acc_, mdate_, nbuc_, tobo_
                           );
            END IF;
         END IF;
      ELSE
         IF se_ <> 0
         THEN
            dk_ := iif_n (se_, 0, '1', '2', '2');

            IF dat_ > dat_zmin2
            THEN
               kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0') || r012_ || s580_;
            ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
               kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0');
            ELSE
               kodp_ := dk_ || nbs_ || r013_;
            END IF;

            znap_ := TO_CHAR (ABS (se_));

            INSERT INTO rnbu_trace
                        (nls, kv, odate, kodp, znap, rnk, isp, comm,
                         nd, acc, mdate, nbuc, tobo
                        )
                 VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, isp_, substr(comm_,1,200),
                         nd_, acc_, mdate_, nbuc_, tobo_
                        );
         END IF;
      END IF;

      if instr(nbsdiscont_, nbs_) > 0 or instr(nbspremiy_, nbs_) > 0 then
        r012_ := 'D';

        insert into OTCN_FA7_REZ2(ND, ACC, PR, SUM)
        values(nd1_, acc_, (case when instr(nbsdiscont_, nbs_) > 0 then 1 else 2 end), se_);
      end if;
   END LOOP;

   CLOSE saldo;

   declare
     sk_        number := 0;
     sz_        number := 0;
     sz0_       number := 0;
     sz1_       number := 0;
     sk_all_    number := 0;
     ostc_      number := 0;
     s02_       number := 0;
     s04_       number := 0;
   begin
       insert into otcn_f42_zalog(ACC, ACCS, ND, NBS, R013, OST)
       SELECT z.acc, z.accs, z.nd, a.nbs, nvl(p.r013, '0'),
               gl.p_icurval (a.kv, a.ost, dat_) ost
          FROM cc_accp z, sal a, specparam p
         WHERE z.acc in (select acc from rnbu_trace where substr(kodp,2,5) in ('90101','90151','90301','90311','90361','95001'))
           AND z.accs = a.acc
           and a.fdat=dat_
           AND a.acc = p.acc
           AND a.nbs || p.r013 <> '91299'
           and a.ost<0;

       -- сумма задолженности, кот. покрывает данный залог
       for p in (select * from rnbu_trace where substr(kodp,2,5) in ('90101','90151','90301','90311','90361','95001','95003'))
       loop
          acc_ := p.acc;
          rnk_ := p.rnk;
          sk_ := 0;
          sz_ := 0;
          sz0_ := 0;
          se_ := to_number(p.znap);

         -- сумма активов, которые обеспечивает данный залог (т.е. к которым он ""привязан")
          begin
            select sum(OST)
               into sk_all_
            from otcn_f42_zalog
            where acc=acc_;
          exception
                   WHEN NO_DATA_FOUND THEN
            sk_all_ := 0;
          end;

         -- выбираеи все активы, к которым "привязан" данный залог
          For k in (select z.ACC, z.ACCS, z.ND, z.NBS, z.R013, z.OST, c.rnk
                   from OTCN_F42_ZALOG z, cust_acc ca, customer c
                   WHERE z.ACC = acc_ and
                         z.accs = ca.acc and
                         ca.rnk = c.rnk)
          loop
             ostc_:=0;
             nd_ := k.nd;

             -- вычисляем процент залога на данный актив
             if abs(k.ost) < abs(sk_all_) then -- не один актив
                sz1_ := round(abs(k.ost / sk_all_) * se_, 0);
             else
                sz1_ :=  se_;
             end if;

            -- Для Петрокоммерца не корректируем сумму задолженности на сумму дисконта/премии
            -- письмо от Самсон Ю. (01/10/2007)
             if mfou_ NOT IN (300120, 353575) THEN  -- 300120 NOT IN (mfo_, mfou_)
                -- определяем остаток счетов дисконта или премии
                BEGIN
                   select SUM(NVL(Gl.P_Icurval( s.KV, s.ost, dat_ ) ,0))
                      INTO s04_
                   from sal s
                   where s.fdat=dat_
                     AND s.acc in (select d.acc
                                   from nd_acc d, accounts s
                                   where d.acc<>acc_ and
                                         d.nd = k.nd and
                                         d.acc=s.acc and
                                         s.rnk=rnk_  and
                                         substr(s.nbs,4,1) in ('5','6','9')
                                         and substr(s.nbs,1,3)=substr(k.nbs,1,3));
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   s04_ := 0;
                END;

                ostc_ := abs(k.ost + NVL(s04_,0));
             else
                ostc_ := abs(k.ost);
             end if;

             -- депозиты, которые выступают залогами, привязаны к другим РНК
             if k.rnk <> rnk_ then
                rnk_ := k.rnk;
             end if;

             -- не включаем, т.к. дважды уменьшаются активы на эту сумму (еще в С5) - ПЕТРОКОММЕРЦ
             if nls_ like '9010%' and k.nbs='9023' and k.r013='1' then
                null;
             else
                BEGIN
                    select nvl(SUM(ost_eqv),0)
                    INTO s02_
                    from otcn_f42_temp
                    where accc=k.accs
                      AND ap=1;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    s02_ := 0;
                END;

                if s02_ < ostc_ then
                   if s02_ + sz1_ >= ostc_ then
                      sz0_ := ostc_ - s02_;
                   else
                      sz0_ := sz1_;
                   end if;

                   if sz0_ <> 0 then
                      sz_ := sz_ + sz0_;
                      sk_ := sk_ + abs(ostc_);

                      insert into otcn_f42_temp(ACC, ACCC, OST_EQV, ap, kv)
                      values(acc_, k.accs, sz0_, 1, kv_);

                      begin
                        select s580
                        into s580a_
                        from OTC_RISK_S580
                        where r020 = k.nbs and
                            t020 = '1' and
                            r013 = k.r013;
                      exception
                        when no_data_found then
                            s580a_ := '9';
                      end;

                      insert into OTC_REF_AKT(ACC, KODP, OSTQ, ACC_A, NBS_A, T020_A, R013_A, S580_A, OSTQ_A)
                      values(acc_, p.kodp, sz_, k.accs, k.nbs, '1', k.r013, s580a_, sk_);
                   end if;
                end if;
             end if;
          end loop;

          sz0_ := se_ - sz_;

          if sz0_ > 0 then
             update rnbu_trace
             set znap = to_char(to_number(znap) - sz0_),
                 comm = comm || ' + розбивка по активу (1)',
                 nd = nd_
             where recid = p.recid;

             kodp_ := SUBSTR (p.kodp, 1, 5) || '9' || SUBSTR (p.kodp, 7) ;
             znap_ := TO_CHAR (sz0_);

             INSERT INTO RNBU_TRACE(nls, kv, odate, kodp, znap, rnk, acc, comm, nbuc, isp, tobo, nd)
             VALUES (p.nls, p.kv, p.odate, kodp_, znap_, rnk_, acc_,
                'Перевищення над залишком по активу (2)', p.nbuc, p.isp, p.tobo, nd_);
          end if;
      end loop;
   end;
--
   -- дата розрахунку резерв_в
   select  nvl(max(dat), dat_)
   into datr_
   from rez_protocol
   where dat between add_months(trunc(dat_, 'mm'),-1) and dat_;

   if datr_ >= to_date('10012013', 'ddmmyyyy') then
      datr_ := to_date('30112012', 'ddmmyyyy');
   end if;

   for k in (select kv, count(*) co
              from sal
              where fdat = dat_ and
                    nls like '2401%' and
               NVL(Ost,0) <> 0
              group by kv )
   loop
      table_otcn_log3_(k.kv):=k.co;
   end loop;

   for k in (select acc, nls, kv, rnk, s080, szq, isp, mdate, tobo, nbs, kodp, sump, suma,
                    cnt, rnum, decode(suma, 0, 1, sump / suma) koef, r013, rz, discont, prem, nd
             from (
                 select t.acc, t.nls, t.kv, t.rnk, t.s080,
                        nvl(gl.p_icurval(t.kv, (case when t.sz1 is not null and t.sz1>=0 then t.sz1 else t.sz end), dat_), 0) szq,
                        a.isp, a.mdate, a.tobo, a.nbs,
                        nvl(s.kodp, '00000000000') kodp, nvl(s.sump, 0) sump,
                        nvl((sum(s.sump) over (partition by s.acc)), 0) suma,
                        nvl((count(*) over (partition by s.acc)), 0) cnt,
                        DENSE_RANK() over (partition by s.acc order by r013) rnum,
                        s.r013, t.rz, nvl(t.discont,0) discont, nvl(t.prem,0) prem, t.nd
                 from tmp_rez_risk t,
                      (select acc, kodp, substr(kodp, 6, 1) R013, sum(to_number(znap)) sump
                       from rnbu_trace
                       where substr(kodp,1,5) not in ('21600', '22600', '22605', '22620', '22625', '22650', '22655')
                       group by acc, kodp, substr(kodp, 6, 1)) s,
                       accounts a
                  where t.dat = datr_ and
                      t.id in (select userid
                               from rez_protocol
                               where dat = datr_) and
                      t.acc = s.acc and
                      t.acc = a.acc and
                      a.nbs in (select r020
                                from kod_r020 k
                                WHERE trim(k.prem) = 'КБ' AND k.a010 = 'C5' and
                                      (d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
                                      and (d_close is null or d_close > datz_))
                                      and r020 not in ('9020', '9100', '9129')
                                      and substr(r020,1,3) not in ('351','354','355', '357')
                                )
                        )
            where szq <> 0 or discont <> 0 or prem <> 0
            order by acc)
   loop

      IF typ_ > 0 THEN
         nbuc_ := NVL (F_Codobl_Tobo (k.acc, typ_), nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      if substr(k.nls,1,1) like '1%' then
         if substr(k.nls,1,4) like '150%' and substr(k.nls,1,4) <> '1502' then
             nbs_ := '1592';

             if substr(k.nls,1,4) = '1500' then
                 if k.s080 = '1' then
                    r013_ := '1';
                 else
                    r013_ := '2';
                 end if;
             else
                r013_ := '4';
             end if;
         else
             nbs_ := '1590';

             if substr(k.nls,4,1) not in ('8','9') then
                 if k.s080 = '1' then
                    r013_ := '4';
                 else
                    r013_ := '1';
                 end if;
             else
                if substr(k.nls,1,5) in ('15083','15185','15187','15285','15287') then
                    r013_ := '5';
                else
                    r013_ := '6';
                end if;
             end if;
         end if;
      elsif substr(k.nls,1,3) in ('357') then
         nbs_ := '3599';

         if k.r013 = '3' then
            r013_ := '4';
         else
            r013_ := '5';
         end if;
      elsif substr(k.nls,1,3) in ('351','354','355') then
         nbs_ := '3590';
         r013_ := '0';
      elsif substr(k.nls,1,1) not in ('1', '3')
           and substr(k.nls,1,4) not in ('9020', '9100', '9129')
           and table_otcn_log3_.count()>0 and table_otcn_log3_.exists(k.kv)
           and substr(k.nls,4,1) not in ('8','9')
           and substr(k.nls,1,4) not in ('2607','2627')
           and k.s080= '1'
      then
         nbs_ := '2401';
         r013_ := '6';
      elsif substr(k.nls,1,1) not in ('1', '3')
         and substr(k.nls,1,4) not in ('9020', '9100', '9129')
      then
         nbs_ := '2400';

         if substr(k.nls,4,1) not in ('8','9') then
             if k.s080 = '1' then
                r013_ := '6';
             else
                r013_ := '7';
             end if;
         else
--            if substr(k.nls,5,1) = '3' then
--                r013_ := '4';
--            else
--                r013_ := '5';
--            end if;
--
            r013_ := '5';
         end if;
      elsif substr(k.nls,1,4) in ('9020', '9100', '9129')  then
         nbs_ := '3690';

         if k.s080 = '1' then
            r013_ := '1';
         else
            r013_ := '2';
         end if;
      else
         nbs_ := '0000';
         r013_ := '0';
      end if;

      select count(*) into cnt_ from otcn_fa7_temp where r020 = k.nbs;

      -- ознака рахунку нарахованих відсотків
      TP_SND := (case when cnt_ > 0 or
                           substr(k.nls, 1,1) in ('1','2','3') and substr(k.nls, 4,1) in ('8', '9')
                      then true else false end);

      if k.szq <>0 then
          if TP_SND then
             -- для рахунків нарахованих %, де є розбивка по R013
             kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||'B'||substr(k.kodp, 11, 1);

             srez_ := k.szq;

             sum_ := round(srez_ * k.koef);

             if k.rnum = 1 then
                sumc_ := sum_;
             else
                sumc_ := sumc_ + sum_;
             end if;

             if k.cnt = k.rnum and sumc_ <> srez_ then
                sum_ := sum_ + (srez_ - sumc_);
             end if;

             znap_ := to_char(sum_);
             comm_ := SUBSTR (' резерв під проценти відносимо до R012 = B ' , 1, 200);
          else
             kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||'A'||substr(k.kodp, 11, 1);

             if k.rnum = 1 then
                 if k.discont <> 0 then
                    discont_ := nvl(rez1.ca_fq_discont (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
                 else
                    discont_ := 0;
                 end if;

                 if k.prem <> 0 then
                    premiy_ := nvl(rez1.ca_fq_prem  (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
                 else
                    premiy_ := 0;
                 end if;

                 sakt_ := k.suma  - discont_ + premiy_;
                 srez_ := (case when k.szq <= sakt_ then k.szq else sakt_ end);
                 srezp_ := (case when k.szq <= sakt_ then 0 else k.szq - srez_ end);
             end if;

             if k.cnt = 1 then
                znap_ := to_char(srez_);
                comm_ := SUBSTR (' резерв під осн. борг відносимо до R012 = А ' , 1, 200);
             else
                sum_ := round(srez_ * k.koef);

                if k.rnum = 1 then
                   sumc_ := sum_;
                else
                   sumc_ := sumc_ + sum_;
                end if;

                if k.cnt = k.rnum and sumc_ <> srez_ then
                   sum_ := sum_ + (srez_ - sumc_);
                end if;

                znap_ := to_char(sum_);

                comm_ := SUBSTR (' резерв під осн. борг відносимо до R012 = А ' , 1, 200);
             end if;
          end if;

          if znap_ <> '0' then
             if not TP_SND and discont_ <> 0 or premiy_ <> 0 then
                se_ := nvl(abs(fostq(k.acc, dat_)), 0); -- залишок по кредиту

                insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
                values(k.nd, k.acc, k.nls, k.kv, kodp_, k.sump, se_, discont_, premiy_);
             end if;

             INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm, nd, nbuc, tobo
                          )
              VALUES (s_rnbu_record.NEXTVAL, userid_,
                     k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate,
                     comm_, k.nd, nbuc_, k.tobo);
          end if;

          if srezp_ <> 0 and not TP_SND and k.cnt = k.rnum then
             kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||'B'||substr(k.kodp, 11, 1);

             znap_ := srezp_;
             comm_ := SUBSTR (' перевищення резерву над осн. боргом до R012 = B ' , 1, 200);

             INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm, nd, nbuc, tobo
                          )
             VALUES (s_rnbu_record.NEXTVAL, userid_,
                     k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate,
                     comm_, k.nd, nbuc_, k.tobo);
          end if;
      else
         kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||'B'||substr(k.kodp, 11, 1);

         if k.rnum = 1 then
            if k.discont <> 0 then
               discont_ := nvl(rez1.ca_fq_discont (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
            else
               discont_ := 0;
            end if;

            if k.prem <> 0 then
               premiy_ := nvl(rez1.ca_fq_prem  (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
            else
               premiy_ := 0;
            end if;
         end if;

         if discont_ <> 0 or premiy_ <> 0 then
            se_ := nvl(abs(fostq(k.acc, dat_)), 0);

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, k.kodp, k.sump, se_, discont_, premiy_);
         end if;
      end if;
   end loop;

   for k in (select acc, nbs, nls, kv, rnk, s080, szq, isp, mdate, tobo, r031, r030, r013, rez, discont, prem, nd
             from (
                 select t.acc, t.nls, t.kv, t.rnk, t.s080,
                        gl.p_icurval(t.kv, (case when t.sz1 is not null and t.sz1>=0 then t.sz1 else t.sz end), dat_) szq,
                        a.isp, a.mdate, a.tobo, a.nbs,
                        r031, lpad(l.r030, 3, '0') r030,
                        s.r013, t.rz rez, nvl(t.discont,0) discont, nvl(t.prem,0) prem, t.nd
                 from tmp_rez_risk t, accounts a, specparam s, customer c, kl_r030 l
                  where t.dat = datr_ and
                      t.id in (select userid
                               from rez_protocol
                               where dat = datr_) and
                      t.acc not in (select acc
                                    from rnbu_trace
                                    where substr(kodp,1,5) not in ('21600', '22600', '22605', '22620', '22625', '22650', '22655')) and
                      t.acc = a.acc and
                      t.acc = s.acc(+) and
                      a.kv = TO_NUMBER (l.r030) and
                      a.nbs not in ('9020', '9100', '9129') and
                      substr(a.nbs,1,3) not in ('351','354','355', '357') and
                      a.rnk = c.rnk
                        )
            where szq <> 0 or discont <> 0 or prem <> 0
            order by acc)
   loop
      IF typ_ > 0 THEN
         nbuc_ := NVL (F_Codobl_Tobo (k.acc, typ_), nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      if substr(k.nls, 4, 1) in ('7', '9') then
         sakt_ := abs(k.szq);
      else
         sakt_ := nvl(fostq(k.acc, dat_), 0);

         sakt_ := (case when sakt_ < 0 then abs(sakt_) else 0 end);

         if sakt_ <> 0 then
             if k.discont <> 0 then
                discont_ := nvl(rez1.ca_fq_discont (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
             else
                discont_ := 0;
             end if;

             if k.prem <> 0 then
                premiy_ := nvl(rez1.ca_fq_prem  (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
             else
                premiy_ := 0;
             end if;

             sakt_ := sakt_  - discont_ + premiy_;
         end if;
      end if;

      srez_ := (case when k.szq <= sakt_ then k.szq else sakt_ end);
      srezp_ := (case when k.szq <= sakt_ then 0 else k.szq - srez_ end);

      if substr(k.nls,1,1) like '1%' then
         if substr(k.nls,1,4) like '150%' and substr(k.nls,1,4) <> '1502' then
             nbs_ := '1592';

             if substr(k.nls,1,4) = '1500' then
                 if k.s080 = '1' then
                    r013_ := '1';
                 else
                    r013_ := '2';
                 end if;
             else
                r013_ := '4';
             end if;
         else
             nbs_ := '1590';

             if substr(k.nls,4,1) not in ('8','9') then
                 if k.s080 = '1' then
                    r013_ := '4';
                 else
                    r013_ := '1';
                 end if;
             else
                if substr(k.nls,1,5) in ('15083','15185','15187','15285','15287') then
                    r013_ := '5';
                else
                    r013_ := '6';
                end if;
             end if;
         end if;
      elsif substr(k.nls,1,3) in ('357') then
         nbs_ := '3599';

         if k.r013 = '3' then
            r013_ := '4';
         else
            r013_ := '5';
         end if;
      elsif substr(k.nls,1,3) in ('351','354','355') then
         nbs_ := '3590';
         r013_ := '0';
      elsif substr(k.nls,1,1) not in ('1', '3')
           and substr(k.nls,1,4) not in ('9020', '9100', '9129')
           and table_otcn_log3_.count()>0 and table_otcn_log3_.exists(k.kv)
           and substr(k.nls,4,1) not in ('8','9')
           and substr(k.nls,1,4) not in ('2607','2627')
           and k.s080= '1'
      then
         nbs_ := '2401';
         r013_ := '6';
      elsif substr(k.nls,1,1) not in ('1', '3')
         and substr(k.nls,1,4) not in ('9020', '9100', '9129')
      then
         nbs_ := '2400';

         if substr(k.nls,4,1) not in ('8','9') then
             if k.s080 = '1' then
                r013_ := '6';
             else
                r013_ := '7';
             end if;
         else
--            if substr(k.nls,5,1) = '3' then
--                r013_ := '4';
--            else
--                r013_ := '5';
--            end if;
--
            r013_ := '5';
         end if;
      elsif substr(k.nls,1,4) in ('9020', '9100', '9129')  then
         nbs_ := '3690';

         if k.s080 = '1' then
            r013_ := '1';
         else
            r013_ := '2';
         end if;
      else
         nbs_ := '0000';
         r013_ := '0';
      end if;

      select count(*) into cnt_ from otcn_fa7_temp where r020 = k.nbs;

      -- ознака рахунку нарахованих відсотків
      TP_SND := (case when cnt_ > 0 or
                           substr(k.nls, 1,1) in ('1','2','3') and substr(k.nls, 4,1) in ('8', '9')
                      then true else false end);

      if k.szq <> 0 then
          if TP_SND then
             -- прострочені відсотки
             if sakt_ = 0 then
                comm_ := SUBSTR (' резерв під погашені проценти (залишок = 0) відносимо до R012 = B ' , 1, 200);
             else
                comm_ := SUBSTR (' резерв під прострочені проценти відносимо до R012 = B ' , 1, 200);
             end if;

             kodp_ := '2'||nbs_||r013_||k.r030||'B'||'9';

             znap_ := to_char(k.szq);
          else
             if substr(k.nls, 4, 1)  = '7' then
                kodp_ := '2'||nbs_||r013_||k.r030||'B'||'9';
                znap_ := to_char(k.szq);

                comm_ := SUBSTR (' резерв під прострочку по осн. борг відносимо до R012 = B ' , 1, 200);
             else
                kodp_ := '2'||nbs_||r013_||k.r030||'A'||'9';
                znap_ := to_char(srez_);

                comm_ := SUBSTR (' резерв під осн. борг відносимо до R012 = А ' , 1, 200);
             end if;

             if k.discont <> 0 then
                discont_ := nvl(rez1.ca_fq_discont (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
             else
                discont_ := 0;
             end if;

             if k.prem <> 0 then
                premiy_ := nvl(rez1.ca_fq_prem  (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
             else
                premiy_ := 0;
             end if;

             if discont_ <> 0 or premiy_ <> 0 then
                se_ := nvl(abs(fostq(k.acc, dat_)), 0); -- залишок по кредиту

                insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
                values(k.nd, k.acc, k.nls, k.kv, kodp_, se_, se_, discont_, premiy_);
             end if;
          end if;

          if znap_ <> '0' then
              INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm, nd, nbuc, tobo
                          )
              VALUES (s_rnbu_record.NEXTVAL, userid_,
                     k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate,
                     comm_, k.nd, nbuc_, k.tobo);
          end if;

          if srezp_ <> 0 and not TP_SND then
             kodp_ := '2'||nbs_||r013_||k.r030||'B'||'9';
             znap_ := srezp_;

             if sakt_ = 0 then
                comm_ := SUBSTR (' резерв по осн. боргом, у якого залишок = 0, відносимо до R012 = B ' , 1, 200);
             else
                comm_ := SUBSTR (' перевищення резерву над осн. боргом до R012 = B ' , 1, 200);
             end if;

             INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm, nd, nbuc, tobo
                          )
             VALUES (s_rnbu_record.NEXTVAL, userid_,
                     k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate,
                     comm_, k.nd, nbuc_, k.tobo);
          end if;
      else
         kodp_ := '2'||nbs_||r013_||k.r030||'B'||'9';

         if k.discont <> 0 then
            discont_ := nvl(rez1.ca_fq_discont (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
         else
            discont_ := 0;
         end if;

         if k.prem <> 0 then
            premiy_ := nvl(rez1.ca_fq_prem  (acc_=>k.acc, dat_ => dat_, mode_ => 1, p_nd => k.nd), 0);
         else
            premiy_ := 0;
         end if;

         if discont_ <> 0 or premiy_ <> 0 then
            se_ := nvl(abs(fostq(k.acc, dat_)), 0);

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, kodp_, se_, se_, discont_, premiy_);
         end if;
      end if;
   end loop;

  update rnbu_trace r
   set kodp = substr(kodp, 1, 9) || 'C' || substr(kodp, 11)
   where r.acc in (select acc
                   from OTCN_FA7_REZ2)
     and r.kodp like '%D_'
     and not exists (select 1
                     from OTCN_FA7_REZ1 p
                     where p.nd = r.nd and
                           substr(p.nls,1,3) = substr(r.nls,1,3) and
                           p.kv = r.kv and
                           substr(p.nls,4,1) = '7' and
                           to_number(p.znap) <> 0);

   declare
       over_    number := 0;
       rizn_    number := 0;
   begin
       -- розбиваємо дисконти/премії на коди C та D в залежності від активу
       for k in (select s.*,
                    s.znap sumdp_k,
                    s.suma / s.suma_all koef,
                    nvl((count(*) over (partition by s.acc, s.nd, s.kv)), 0) cnt,
                    row_number() over (partition by s.acc, s.nd, s.kv order by s.acca, s.kodp) rnum
                 from (
                    select a.tp, a.nd, a.acc, a.nls, a.kv, a.kodp, a.znap, a.comm,
                        a.rnk, a.mdate, a.isp, a.nbuc,
                        substr(a.kodp,10,1) r012,
                        b.ACC acca, b.NLS nlsa,
                        decode(a.tp, 1, b.SUMD, b.SUMP) sumdp,
                        (case when substr(b.nls,4,1) = '7'
                              then 'D' else 'C'
                        end) r012_a,
                        b.suma, b.sumk,
                        nvl((sum(b.suma) over (partition by a.acc, a.nd, a.kv)), 0) suma_all
                    from
                        (-- дисконти
                         select 1 tp, nd, acc, nls, kv, rnk, mdate, isp, nbuc, kodp, znap, comm
                         from rnbu_trace
                         where acc in (select acc
                                       from OTCN_FA7_REZ2
                                       where pr = 1)
                        union
                        -- премії
                        select 2 tp, nd, acc, nls, kv, rnk, mdate, isp, nbuc, kodp, znap, comm
                         from rnbu_trace
                         where acc in (select acc
                                       from OTCN_FA7_REZ2
                                       where pr = 2)
                                       ) a
                    join
                        (select ND, ACC, NLS, KV, KODP,
                            to_number(ZNAP) suma,
                            SUMA sumk, SUMD, SUMP
                         from OTCN_FA7_REZ1
                         where suma <> 0) b
                     on (a.nd = b.nd and
                         substr(a.nls,1,3) = substr(b.nls,1,3) and
                         a.kv = b.kv)) s)
       loop
          if k.rnum = 1 then
             if k.znap > k.suma_all then
                over_ :=  k.znap - k.suma_all;
             else
                over_ := 0;
             end if;
          end if;

          k.sumdp_k := round((k.znap - over_) * k.koef);

          if k.rnum = 1 then
             sumc_ := k.sumdp_k;
          else
             sumc_ := sumc_ + k.sumdp_k;
          end if;

          if k.rnum = k.cnt then
             rizn_ := to_number(k.znap) - sumc_;
          end if;

          kodp_ := substr(k.kodp, 1, 9) ||k.r012_a||'9';

          if k.rnum = 1 then
             znap_ := to_char(k.sumdp_k);
             comm_ := substr(k.comm || ' заміна по рахунку '||k.nlsa||'('||to_char(k.kv)||')',1,255);

             update rnbu_trace
             set kodp = kodp_,
                 znap = znap_,
                 comm = comm_
             where acc = k.acc and
                nd = k.nd and
                kodp =k.kodp;

             if over_ <> 0 then
                 kodp_ := substr(k.kodp, 1, 9) ||'D'||'9';

                 znap_ := to_char(over_);
                 comm_ := substr(k.comm || ' перевищення дисконту (> ніж залишок по рахунку '||k.nlsa||'('||to_char(k.kv)||') )',1,255);

                 insert into rnbu_trace(recid, userid, nls, kv, odate, kodp,
                           znap, acc,rnk, isp, mdate, comm, nd, nbuc)
                 values(s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate, comm_, k.nd, k.nbuc);
             end if;
          else
             if k.rnum = k.cnt then
                znap_ := to_char(k.sumdp_k + rizn_);
             else
                znap_ := to_char(k.sumdp_k);
             end if;

             comm_ := substr(k.comm || ' розбивка дисконту на частини по рахунку '||k.nlsa||'('||to_char(k.kv)||')',1,255);

             insert into rnbu_trace(recid, userid, nls, kv, odate, kodp,
                       znap, acc,rnk, isp, mdate, comm, nd, nbuc)
             values(s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv, data_, kodp_,
                 znap_, k.acc, k.rnk, k.isp, k.mdate, comm_, k.nd, k.nbuc);
          end if;
       end loop;
   end;

   if datr_ <> dat_ and mfo_ <> 300465 and mfou_ <> 353575 then
       -- учитываем счета резервов, которые были открыты после формирования резервов (при миграции)
       declare
            kodpn_  varchar2(20);
            znapn_  varchar2(20);
       begin
           for k in (SELECT s.acc, s.nls, s.kv, s.nbs, s.rnk, k.r031, nvl(p.r013, '0') r013,
                            2 - NVL(MOD(c.CODCAGENT, 2),1) k030, s.odate, a.tobo, a.isp, a.mdate,
                            decode(s.kv, 980, s.ost, s.ostq) ostq, lpad(k.r030, 3, '0') r030
                     FROM   otcn_saldo s, otcn_acc a, kl_r030 k, customer c, specparam p
                     WHERE  s.ost <> 0 and
                            s.nbs in ('2400', '2401') and
                            s.kv = TO_NUMBER (k.r030) and
                            s.rnk = c.rnk and
                            s.acc = p.acc(+) and
                            s.acc = a.acc and
                            (daos > datr_ and
                             not exists (select 1
                                        from saldoa
                                        where acc = s.acc and
                                              fdat  < datr_ + 10 and
                                              kos <> 0))
                     )
           loop
              kodp_ := '2'||k.nbs||k.r013||k.r030||'B'||'9';
              znap_ := to_char(abs(k.ostq));

              comm_ := 'Суми по рахуках резерву, яких не було на '||to_char(datr_, 'ddmmyyyy');

              IF typ_ > 0 THEN
                 nbuc_ := NVL (F_Codobl_Tobo (k.acc, typ_), nbuc1_);
              ELSE
                 nbuc_ := nbuc1_;
              END IF;

              INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm,
                           nbuc, tobo
                          )
               VALUES (s_rnbu_record.NEXTVAL, userid_,
                       k.nls, k.kv, k.odate, kodp_,
                       znap_, k.acc, k.rnk, k.isp, k.mdate,
                       SUBSTR (k.tobo || '  ' || comm_, 1, 200),
                       nbuc_, k.tobo
                      );
           end loop;
       end;

       if mfou_ <> 353575 then
           -- учитываем гашения безнадежной задолженности за счет резерв или  другие уменьшения резерва
           declare
                kodpn_  varchar2(20);
                znapn_  varchar2(20);
                rid_    number;
           begin
               for k in (select o.acc, o.nls, o.kv,
                                gl.p_icurval(o.kv, o.s, dat_) sq,
                                a.nbs, k.r031, p.r013,
                                2 - NVL(MOD(c.CODCAGENT, 2),1) k030,
                                (case when typ_ > 0
                                        THEN NVL (F_Codobl_Tobo (o.acc, typ_), nbuc1_)
                                        ELSE nbuc1_
                                 END) nbuc, lpad(k.r030, 3, '0') r030, z.acc acca
                         from opl o, accounts a, kl_r030 k, customer c, specparam p, opldok z, accounts x
                         where o.ref in (select ref
                                         from oper r
                                         where (r.dk=0 and r.nlsb like '240%' or
                                                r.dk=1 and r.nlsa like '240%') and
                                            r.vdat > datr_ and
                                            r.sos = 5  ) and
                               o.nls like '240%' and
                               o.acc = a.acc and
                               a.kv = TO_NUMBER (k.r030) and
                               a.rnk = c.rnk and
                               o.acc = p.acc(+)  and
                               o.ref = z.ref and
                               o.stmt = z.stmt and
                               o.dk <> z.dk and
                               z.acc = x.acc and
                               x.nls not like '7%'
                         )
               loop
                   begin
                       select RECID, znap
                       into rid_, znapn_
                       from rnbu_trace r
                       where r.kodp like '2'||k.nbs||'%' and
                            r.acc = k.acca and
                            rownum = 1;

                       bars_audit.info('flag0 = '||to_char(rid_));
                   exception
                       when no_data_found then
                           begin
                               select RECID, znap
                                   into rid_, znapn_
                                   from rnbu_trace r
                                   where r.kodp like '2'||k.nbs||k.r013||k.r030||'B'||'_' and
                                         to_number(r.znap) >= k.sq and
                                         r.nbuc = k.nbuc and
                                         rownum = 1;

                               bars_audit.info('flag1 = '||to_char(rid_));
                           exception
                               when no_data_found then
                                   begin
                                       select RECID, znap
                                           into rid_, znapn_
                                           from rnbu_trace r
                                           where r.kodp like '2'||k.nbs||k.r013||k.r030||'A'||'_' and
                                                 to_number(r.znap) >= k.sq and
                                                 r.nbuc = k.nbuc and
                                                 rownum = 1;

                                       bars_audit.info('flag2 = '||to_char(rid_));
                                   exception
                                       when no_data_found then
                                            bars_audit.info('flag3 = '||to_char(rid_));
                                            rid_ := null;
                                   end;
                           end;
                   end;

                   if rid_ is not null then
                       znap_ := to_char(znapn_ - k.sq);

                       update rnbu_trace
                       set znap = znap_,
                           comm = substr(comm || ' + спис-ня заб-ті з рез-ву '||to_char(k.sq), 1, 200)
                       where recid = rid_;

                       bars_audit.info('upd OK '||to_char(sql%rowcount));
                   end if;
               end loop;
           end;
       end if;
   end if;

---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = 'C5' AND datf = dat_;

---------------------------------------------------
   OPEN basel;

   LOOP
      FETCH basel
       INTO kodp_, nbuc_, znap_;

      EXIT WHEN basel%NOTFOUND;

      INSERT INTO tmp_nbu
                  (kodf, datf, kodp, znap, nbuc
                  )
           VALUES ('C5', dat_, kodp_, znap_, nbuc_
                  );
   END LOOP;

   CLOSE basel;
----------------------------------------
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FC5_OLD.sql =========*** End ***
PROMPT ===================================================================================== 
