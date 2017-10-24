

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F42_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F42_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F42_NN (dat_ DATE, type_ NUMBER DEFAULT 0,
                                      prnk_ NUMBER DEFAULT NULL,
                                      pmode_ number default 0)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Процедура формирование файла #42 для КБ
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :  13/11/2015 (12/11/2015)
%------------------------------------------------------------------------
% 12/11/2015 - c 12.11.2015 будут формироваться новые коды
%              A00000000, A10000000, A20000000
%              не будут формироваться коды 580000000,61NNNNVVV,630000000
% 16/09/2015 - для включения счетов 1415,1416,1417 в коды 870000000 и
%              880000000 изменены значения R013 (біло 3,5 сейчас 3,9)
% 11/08/2015 - вместо VIEW CP_V_ZAL_ACC_1 будем использовать CP_V_ZAL_ACC
%              (по согласованию с Ковчаком Д.И.)
%              изменен перечень бал.счетов для показателей 870000000,
%              880000000
% 02/07/2015 - вместо VIEW CP_V_ZAL_ACC будем использовать CP_V_ZAL_ACC_1
% 15/06/2015 - с 15.06.2015 (на 16.06.2015) закрыты показатели
%              03NNNN000,41NNNN000,42NNNN000,43NNNN000,62NNNN000,
%              65NNNN000,66NNNN000,94NNNN000,96NNNN000
% 27/04/2015 - с 24.04.2015 (на 27.04.2015) новые показатели и
%              новая структура
% 26/02/2015 - для показателя 42 вычитаем сумму залога и дополнительно
%              формируем показатель 66 для инвалюты (инсайдеры)
% 25/02/2015 - для показателя 41 вычитаем сумму залога и дополнительно
%              формируем показатель 65 для инвалюты
% 01/07/2014 - для показників 03NNNN, 04NNNN (інсайдери) не виконуємо
%              коригування залишку по контрагенту
%              se_ := se_ - s01_ - s02_ - s03_ - s04_ - s05_
%              (беремо значення se_ без віднімання)
% 05/05/2014 - для ГОУ из формирования показателя 01NNNN исключаем
%              клиентов которые внесены в кл-р KL_F8B (ОКПО для #8B)
%              RNK=907973 "НАК Навтогаз" (ОКПО=20077720)
%              RNK=905608 "ТРИ О" (ОКПО=23167814)
% 30/04/2014 - для ГОУ из формирования показателя 01NNNN исключаем
%              клиента RNK=905608 "ТРИ О" (ОКПО=23167814)
% 23/04/2014 - в поле COMM таблицы RNBU_TRACE будет формироваться
%              название клиента
% 25/02/2014 - изменил блок включения всех клиентов для МФО=344443
%              в т.ч. клиентов которые имеют RNK банка
% 13.02.2014 - для банка Демарк добавил формирование показателя 870000
%              как предложили из банка
% 11.02.2014 - заменил виражение ltrim(c.okpo, '0') на
%              NVL(ltrim(c.okpo, '0'),'X')
%              т.к. не включались контрагенты у которых OKPO='000000000'
% 06.02.2014 - для MFOU 300120, 300465 не вызываются процедуры
%              OTC_DEL_ARCH, OTC_SAVE_ARCH
% 05.02.2014 - для банка Петрокоммерц із  показників 02,04 не віднімаємо
%              суму забеспечення
% 04.02.2014 - змінено формування показника 42 (віднімаємо забеспечення)
%              а також віднімаємо забеспечення із показників 02, 04
% 01.02.2014 - змінено формування показника 03NNNN (добавлено ще 2 мах.
%              які < 5% від СК) а також добавлено формування показника
%              94NNNN
% 29/01/2014 - зі звітної дати 31/01/2014 (станом на 01/02/2014) закрито
%              показники 850000, 860000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   dat_Zm_    DATE := TO_DATE('21122005','ddmmyyyy'); -- вступають в дiю змiни згiдно телеграми НБУ №24-622/212 вiд 30.11.2005
   dat_Zm1_   DATE := TO_DATE('01042006','ddmmyyyy'); -- формуються новi показники 61NNNN, 62NNNN, 630000
   dat_Zm2_   DATE := TO_DATE('19112009','ddmmyyyy'); -- формується новий показник 71NNNN
   dat_Zm3_   DATE := TO_DATE('19072010','ddmmyyyy'); -- формується новий показник 82NNNN
   dat_Zm4_   DATE := TO_DATE('24042015','ddmmyyyy'); -- формуються нові показники
                                                      -- 98NNNNVVV, 99NNNNVVV і нова
                                                      -- структура показника
   dat_Zm5_   DATE := TO_DATE('15062015','ddmmyyyy'); -- не будуть формуватися показники 03NNNN000
                                                      --  41NNNN000,42NNNN000,43NNNN000,62NNNN000,
                                                      --  65NNNN000,66NNNN000,94NNNN000,96NNNN000
   dat_Zm6_   DATE := TO_DATE('12112015','ddmmyyyy'); -- формуються нові показники
                                                      -- A00000000, A10000000, A20000000

   pr_bank    VARCHAR2 (1);
   k041_      VARCHAR2 (1);
   k042_      VARCHAR2 (1);
   kodf_      VARCHAR2 (2):= '42';
   kf1_       VARCHAR2 (2):= '01';
   nls_       VARCHAR2 (15);
   nlsp_      VARCHAR2 (15);
   nlsi_      VARCHAR2 (15);
   nlsi1_     VARCHAR2 (15);
   nlspp_     VARCHAR2 (15);
   comm_pp_   VARCHAR2 (255);
   nlspp1_    VARCHAR2 (15);
   comm_pp1_  VARCHAR2 (255);
   nlsu_      VARCHAR2 (15);
   nlsu_72    VARCHAR2 (15);
   data_      DATE;
   dat1_      DATE;
   ddd_       VARCHAR2 (3);
   r012_      VARCHAR2 (1);
   r013_      VARCHAR2 (1);
   r050_      VARCHAR2 (2);
   kv_        SMALLINT;
   kvp_       SMALLINT;
   se_        DECIMAL (24);
   se54_      DECIMAL (24);
   sp_        DECIMAL (24)   := 0;
   sp1_       DECIMAL (24)   := 0;
   spp_       DECIMAL (24)   := 0;
   spp_72     DECIMAL (24)   := 0;
   si_        DECIMAL (24)   := 0;
   si1_       DECIMAL (24)   := 0;
   s02_       DECIMAL (24)   := 0;
   s03_       DECIMAL (24)   := 0;
   s04_       DECIMAL (24)   := 0;
   s05_       DECIMAL (24)   := 0;
   ek2_       DECIMAL (24)   := 0;
   ek3d_      DECIMAL (24);
   ek3k_      DECIMAL (24);
   ek4_       DECIMAL (24)   := 0;

   sum_k_     DECIMAL (24); -- сума регулятивного капiталу
   sum_k_19   DECIMAL (24); -- сума регулятивного капiталу до 19.07.2010
   sum_SK_    DECIMAL (24); -- сума статутного капiталу

   kodp_      VARCHAR2 (10);
   kodpp_     VARCHAR2 (10);
   kodpp1_    VARCHAR2 (10);
   kodpi_     VARCHAR2 (10);
   znap_      VARCHAR2 (30);
   znapp_     DECIMAL (24)   := 0;
   znapp1_    DECIMAL (24)   := 0;
   znapi_     DECIMAL (24)   := 0;
   znapi1_    DECIMAL (24)   := 0;
   znapu_     DECIMAL (24)   := 0;
   znapu_72   DECIMAL (24)   := 0;
   mfo_       NUMBER;
   mfou_      NUMBER;
   rnk_       NUMBER;
   nmk_       Varchar2(70);
   rnka_      NUMBER;
   rnk1_      NUMBER;
   rnk2_      NUMBER;
   nnnn_      NUMBER         := 0;
   nnn1_      NUMBER         := 0;
   nnn2_      NUMBER         := 0;
   nnnn1_     NUMBER         := 0;
   nnnn2_     NUMBER         := 0;
   nnnn41_    NUMBER         := 0;
   nnnn42_    NUMBER         := 0;
   nnnn54_    NUMBER         := 0;
   nnnn01_    NUMBER         := 0;
   f42_       NUMBER;
   insider_   SMALLINT;
   userid_    NUMBER;
   pdat_      DATE;
   pacc_      NUMBER;
   ksum_      NUMBER         := 0;
   sql_       VARCHAR2 (3000);
   flag_      NUMBER;
   k1_        NUMBER;
   k2_        NUMBER;
   k3_        NUMBER;
   sz_        NUMBER;
   acc_       NUMBER;
   accs_      NUMBER;
   sk_        NUMBER;
   kk_        NUMBER;
   nbs_       VARCHAR2 (5);
   s080_      VARCHAR2 (20);
   pr_        NUMBER;
   our_okpo_  varchar2(10);
   our_rnk_   NUMBER;
   flag_inc_  BOOLEAN := FALSE;
   s_zal_     NUMBER;
   s_zalp_    NUMBER := 0;
   s_zali_    NUMBER := 0;
   prizn_     NUMBER;
   s_prizn_   NUMBER;
   fmt_       VARCHAR2(30):='999G999G999G990D99';
   p57_       NUMBER;
   p47_       NUMBER:=0;
   p71_       NUMBER:=0;
   ostc_      NUMBER:=0;
   p51_       NUMBER:=0;
   rnki_      NUMBER;
   rnki1_     NUMBER;
   rnku_      NUMBER;
   rnku_72    NUMBER;
   rnkp_      NUMBER;
   rnkp1_     NUMBER;
   vNKA_      NUMBER;
   sz_all_    number;
   sk_all_    number;
   sz0_       number;
   sz1_       number;
   rez_1      number;
   fl_tp_1    number;
   fl_tp_2    number;
   fl_tp_3    number;
   fl_tp_4    number;
   fl_tp_5    number;
   fl_tp_6    number;
   fl_tp_7    number;
   rgk_       number;
   s180_      Varchar2(1);
   s240_      Varchar2(1);
   p240r_     Varchar2(1);
   vost_      number;
   poisk_     Varchar2(1000);
   sql_acc_   clob;
   ret_       number;
   comm_      Varchar2(200);
   sum_proc_  number;
   cnt_       number;

   ---Остатки код 01, 02, 03, 04, 06
   CURSOR saldo  IS
    select ddd, rnk, prins, znap, tp_1, tp_2, tp_3, tp_4, tp_5, tp_6, tp_7,
        nvl((select -1*sum(znap) from otc_c5_proc where datf = dat_ and rnk = s.rnk), 0) sum_proc
    from (
        select ddd, rnk, prins, znap, tp_1, tp_2, tp_3, tp_4, tp_5, tp_6, tp_7,
            znap - tp_1 - tp_2 - tp_3 - tp_4 + rez_1 sum_kor
        from (
           SELECT  a.ddd, DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
                   DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1) prins,
                   ABS (SUM (a.ost_eqv)) znap,
                   ABS (NVL (sum((case when a.r020 IN ('1502') and NVL (p.r013, '0') NOT IN ('1', '2', '9') or
                                            a.r020 IN ('1524') and NVL (p.r013, '0') NOT IN ('1', '3')
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_1,
                   ABS (NVL (sum((case when a.r020 IN ('3003', '3005', '3007', '3010', '3011', '3015') AND NVL (p.r013, '0' ) NOT IN ('9') or
                                            a.r020 IN ('3006', '3106') AND NVL (p.r013, '0' ) NOT IN ('1') or
                                            a.r020 IN ('3012', '3014') AND NVL (p.r013, '0' ) NOT IN ('7', '9') or
                                            a.r020 IN ('3013') AND NVL (p.r013, '0') NOT IN ('5','6','9','A','B','C') or
                                            a.r020 IN ('3103', '3105', '3107') AND NVL (p.r013, '0') NOT IN ('1', '9')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_2,
                   ABS (NVL (sum((case when a.r020 = '3212' AND NVL (p.r013, '0') not in ('2', '3')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_3,
                   ABS (NVL (sum((case when a.r020 = '3540' and NVL (p.r013, '0') not in ('6')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_4,
                   ABS (NVL (sum((case when a.ost_eqv <> 0 and a.r020 = '3540' and NVL (p.r013, '0') in ('4', '5')
                                    then decode(mfo_, 300120, a.ost_eqv, f_ret_exceeding_3540(a.acc, dat_))
                                    else 0
                                  end)),0)) tp_5,
                   ABS (NVL (sum((case when a.r020 IN ('9500') and NVL (p.r013, '0') = 3
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_6,
                   ABS (NVL (sum((case when a.r020 IN ('9129') and NVL (p.r013, '0') NOT IN ('0', '1')
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_7
           FROM OTCN_F42_TEMP a, CUSTOMER c, specparam p
           WHERE a.ap=a.r012 AND
                 NOT exists (SELECT 1
                             FROM OTCN_F42_TEMP b
                             WHERE  b.ap=b.r012        AND
                                    b.nbs IS NULL      AND
                                    b.ACCC = a.acc ) AND
                 a.rnk=c.rnk      AND
                 ( ((our_rnk_ = -1 or c.rnk <> our_rnk_) and mfo_ <> 344443) or
                            (c.rnk <> 0 and mfo_ = 344443) ) AND
                 (our_okpo_ = '0' or NVL(ltrim(c.okpo, '0'),'X') <> our_okpo_ or a.ddd='006' and (nls like '3%' or nls like '4%')) AND
                 (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_) and
                 a.acc = p.acc(+)
           GROUP BY a.ddd, DECODE (c.rnkp, NULL, c.rnk, c.rnkp),
                    DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1)
           union all
           SELECT  a.ddd, a.accc rnk,
                   DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1) prins,
                   ABS (SUM (a.ost_eqv)) znap,
                   ABS (NVL (sum((case when a.r020 IN ('1502') and NVL (p.r013, '0') NOT IN ('1', '2', '9') or
                                            a.r020 IN ('1524') and NVL (p.r013, '0') NOT IN ('1', '3')
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_1,
                   ABS (NVL (sum((case when a.r020 IN ('3003', '3005', '3007', '3010', '3011', '3015') AND NVL (p.r013, '0' ) NOT IN ('9') or
                                            a.r020 IN ('3006', '3106') AND NVL (p.r013, '0' ) NOT IN ('1') or
                                            a.r020 IN ('3012', '3014') AND NVL (p.r013, '0' ) NOT IN ('7', '9') or
                                            a.r020 IN ('3013') AND NVL (p.r013, '0') NOT IN ('5','6','9','A','B','C') or
                                            a.r020 IN ('3103', '3105', '3107') AND NVL (p.r013, '0') NOT IN ('1', '9')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_2,
                   ABS (NVL (sum((case when a.r020 = '3212' AND NVL (p.r013, '0') not in ('2', '3')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_3,
                   ABS (NVL (sum((case when a.r020 = '3540' and NVL (p.r013, '0') not in ('6')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_4,
                   ABS (NVL (sum((case when a.ost_eqv <> 0 and a.r020 = '3540' and NVL (p.r013, '0') in ('4', '5')
                                    then decode(mfo_, 300120, a.ost_eqv, f_ret_exceeding_3540(a.acc, dat_))
                                    else 0
                                  end)),0)) tp_5,
                   ABS (NVL (sum((case when a.r020 IN ('9500') and NVL (p.r013, '0') = 3
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_6,
                   ABS (NVL (sum((case when a.r020 IN ('9129') and NVL (p.r013, '0') NOT IN ('0', '1')
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_7
           FROM OTCN_F42_TEMP a, CUSTOMER c, specparam p
           where a.acc is null and
             a.accc=c.rnk AND
             ( ((our_rnk_ = -1 or c.rnk <> our_rnk_) and mfo_ <> 344443) or
                            (c.rnk <> 0 and mfo_ = 344443) ) AND
             (our_okpo_ = '0' or NVL(ltrim(c.okpo, '0'),'X') <> our_okpo_ or a.ddd='006' and (nls like '3%' or nls like '4%')) AND
             (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_) and
             a.acc = p.acc(+)
           group by a.ddd, a.accc,
                    DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1))) s
    order by ddd, sum_kor desc;
    -------------------------------------------------------------------------
---Остатки  код  "A0"
-- с 13.11.2015 (за 12.11.2015) будет формироваться код A0 б/с 9110
   CURSOR saldoost1 IS
   select b.acc, b.nbs, b.nls, b.kv, b.fdat, b.r013, b.rnk, b.ostq, nvl(c.ddd, '099')
   from (SELECT a.acc, a.nbs, a.nls, a.kv, a.FDAT, NVL (p.r013, '0') r013,
                 DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
                 (case when a.ostq < 0 then '11' else '22' end) r050,
                 sum(decode(a.kv, 980, a.ost, a.ostq)) ostq
          FROM OTCN_SALDO a, CUSTOMER c, SPECPARAM p
          WHERE a.ost <> 0
            and a.rnk=c.rnk
            AND a.acc = p.acc(+)
            AND (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_)
          GROUP BY a.acc, a.nbs, a.nls, a.kv, a.FDAT, NVL (p.r013, '0'),
                   DECODE (c.rnkp, NULL, c.rnk, c.rnkp),
                   (case when a.ostq < 0 then '11' else '22' end)) b
   left outer join
   (SELECT ddd, r020, r012, r050
    FROM KL_F3_29
    WHERE kf = '42'
      AND ddd IN ('0A0')) c
    on (b.nbs = c.r020 and
        b.r050 = c.r050);

---------------------------------------------------------------------------
---Остатки  коды  "73","74","75","76","77","78","79","80","81"
   CURSOR saldoost7 IS
   select b.acc, b.nls, b.kv, b.fdat, b.r013, b.s240, b.rnk,
          nvl(d.k042, '9') k042, b.ostq, nvl(c.ddd, '099'),
          nvl(e.mfo, '000000'), nvl(e.reestr, 'X')
   from (SELECT a.acc, a.nbs, a.nls, a.kv, a.FDAT,
                NVL (p.r013, '0') r013, NVL(p.s240, '1') s240,
                DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
                NVL(lpad(to_char(c.country),3,'0'),'804') k040,
                sum(decode(a.kv, 980, a.ost, a.ostq)) ostq
          FROM OTCN_SALDO a, CUSTOMER c, SPECPARAM p
          WHERE a.ost <> 0
            and a.rnk=c.rnk
            AND a.acc = p.acc(+)
            AND (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_)
          GROUP BY a.acc, a.nbs, a.nls, a.kv, a.FDAT, NVL (p.r013, '0'), NVL(p.s240, '1'),
                   DECODE (c.rnkp, NULL, c.rnk, c.rnkp),
                   NVL(lpad(to_char(c.country),3,'0'),'804')) b
   left outer join
       (SELECT ddd, r020
        FROM KL_F3_29
        WHERE kf = '42'
          AND ddd IN ('073', '076')) c
    on (b.nbs = c.r020)
    left outer join
        (select k040, k042
         from kl_k040) d
    on (b.k040 = d.k040)
    left outer join
        (select a.rnk, a.mfo, b.reestr
         from custbank a, rcukru b
         where a.mfo=b.mfo) e
    on (b.rnk = e.rnk);

---------------------------------------------------------------------------
---Остатки  коды  "47-51"
   CURSOR saldoost3 IS
        SELECT ACC, NLS, KV, FDAT, DDD, R012, ACCC, OST_EQV
        from OTCN_F42_TEMP
        where ap=0;

---------------------------------------------------------------------------
---Остатки  коды  "82", "83", "84"
   CURSOR saldoost8 IS
       SELECT a.acc, a.nls, a.kv, a.FDAT, NVL (p.r013, '0'), NVL(p.s180, '1'),
             DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
             SUM ((case when a.kv = 980 then ost else gl.p_icurval(a.kv, a.ost, dat_zm3_) end))
      FROM (SELECT s.acc, s.rnk, s.nls, s.kv, s.FDAT, s.nbs,
                s.ost, (case when kv = 980 then s.ost else s.ostq end) ostq
            FROM OTCN_SALDO s
            WHERE s.ost <> 0) a, CUSTOMER c, SPECPARAM p
      WHERE a.rnk=c.rnk
        AND a.acc = p.acc(+)
      GROUP BY a.acc, a.nls, a.kv, a.FDAT,
               NVL (p.r013, '0'), NVL(p.s180,'1'),
               DECODE (c.rnkp, NULL, c.rnk, c.rnkp);

    PROCEDURE p_ins(p_kod_ VARCHAR2, p_val_ NUMBER) IS
        pragma     AUTONOMOUS_TRANSACTION;
    BEGIN
       IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
           INSERT INTO OTCN_LOG (kodf, userid, txt)
           VALUES(kodf_,userid_,p_kod_||TO_CHAR(p_val_/100, fmt_));
           commit;
       END IF;
    END;
---------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
--   dbms_profiler.start_profiler('File 42 (new v6) - 04.11.2013');
   commit;

   select count(*)
   into cnt_
   from otc_c5_proc
   where datf = dat_;

   if cnt_ = 0 then
      raise_application_error(-20001, 'Файл #C5 за '||to_char(dat_, 'dd/mm/yyyy')||
      ' ще не сформовано! Сформуйте #C5, а потім ще раз запустіть формування #42!');
   end if;

   execute immediate('alter session set nls_numeric_characters=''.,''');

   userid_ := user_id;

   logger.info ('P_F42_NN: Begin ');

   EXECUTE IMMEDIATE 'DELETE FROM otcn_f42_history WHERE fdat = :dat_ ' using dat_;

   EXECUTE IMMEDIATE 'truncate table RNBU_TRACE';

   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';
   EXECUTE IMMEDIATE 'truncate table otcn_f42_zalog';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_fa7_temp';
-------------------------------------------------------------------
-- свой МФО
   mfo_ := F_Ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM BANKS
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   INSERT INTO otcn_fa7_temp
      SELECT r020
        FROM kl_r020
       WHERE trim(prem) = 'КБ'
         AND LOWER (txt) LIKE '%прострочені нарах%доход%'
         AND t020 = '1';

   -- тип банку (0 - універсальний, 1 - спеціалізований ощадний)
   flag_ := F_Get_Params ('NORM_TPB', 0);

   -- відсоток негативно класифікованих активів у відповідній групі активів
   IF flag_ > 0 THEN
         vNKA_ := F_Get_Params ('NOR_NKA', 0);
   ELSE  -- для універсального банку не має значення
         vNKA_ := 0;
   END IF;

   --ознака вiдповiдностi банку пп. 2.5-2.7 глави 2 роздiлу VI Iнструкцiї про порядок регулювання дiяльностi банкiв України
   -- а саме - можливiсть виникнення заборгованостi, що перевищує 25% регулятивного капiталу
   s_prizn_:= F_Get_Params ('NORM_OP', 0);

   IF flag_ = 0
   THEN
      k1_ := 0.25; -- для нормативу Н7
      k2_ := 0.05; -- для нормативу Н9
      k3_ := 0; -- для нормативу Н10
   ELSE
      IF vNKA_ = 0 THEN
         k1_ := 0.05;
         k2_ := 0.02;
         k3_ := 0;
      ELSE
         k3_ := 0;
         k2_ := 0.02;

         -- для нормативу Н9
         CASE
            WHEN vNKA_ <= 10 THEN
               k1_ := 0.2;

               -- для нормативу Н10
               CASE
                  WHEN vNKA_ <= 7 THEN k3_ := 0.2;
                  WHEN vNKA_ <= 10 THEN k3_ := 0.1;
               ELSE
                  k3_ := 0;
               END CASE;

            WHEN vNKA_ <= 20 THEN k1_ := 0.15;
            WHEN vNKA_ <= 30 THEN k1_ := 0.1;
         ELSE
            k1_ := 0.5;
         END CASE;

      END IF;
   END IF;

   our_rnk_ := F_Get_Params ('OUR_RNK', -1);
   our_okpo_ := nvl(to_char(F_Get_Params ('OKPO', 0)), '0');

---Сума регулятивного капiталу банку (вiдкореговано згiдно телеграми НБУ)
--- дiє з 01.10.2004 прибуток поточного року 5999 коригується (зменшується)
--- на суму [(Нд+Пнд+Снд)-Рпс]*0.2.    Все вираховується в функцii.
--- якщо сума рег.капiталу < 0 , то береться сума=1000000000 (10 млн.)
--- формувати файл #42 тiльки пiсля формування файлу #01

   rgk_ := Rkapital (dat_, kodf_, userid_, 1); -- зм_на 27.12.2005 - при розрахунку норматив_в використовується нев_дкоригований кап_тал

   if rgk_ <= 0 then
      sum_k_ := 100;
      s_prizn_ := 1; -- щоб не формувався показник 41
   else
      sum_k_ := rgk_;
   end if;

   IF dat_ >= dat_Zm_ THEN    -- з 21.12.2005
      -- статутний капiтал
      BEGIN
         SELECT SUM(ost)
         INTO   sum_SK_
         FROM   sal
         WHERE  fdat=Dat_ AND
                nbs IN ('5000','5001', '5002');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sum_SK_:=0 ;
      END ;

      IF NVL(sum_SK_, 0) = 0 THEN
         sum_sk_:= NVL(Trim(F_Get_Params ('NORM_SK', 0)), 0);
      END IF;

      IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
         p_ins(' -------------------------------- Формування #42 файлу  --------------------------------- ', NULL);

         p_ins('Тип банку -  '|| (CASE flag_ WHEN 0 THEN  'універсальний' ELSE 'ощадний' END), NULL);

         IF vNKA_ > 0 THEN
             p_ins('Відсоток негативно-класифікованих активів: '||TO_CHAR(vNKA_), NULL);
         END IF;

         p_ins(' --------------------------------- НОРМАТИВИ --------------------------------- ',NULL);

         p_ins('Регулятивний капiтал (РК1): ', sum_k_);

         p_ins('Показник 01 та 41 ('||TO_CHAR(k1_*100)||'% від РК1): ',sum_k_ * k1_);

         p_ins('Показник 02 (10% від РК1): ',sum_k_ * 0.1);

         p_ins('Показник 42 ('||TO_CHAR(k2_*100)||'% від РК1): ',sum_k_ * k2_);

         p_ins('Показник 06  (15% від РК1): ',sum_k_ * 0.15);

         IF flag_>0 THEN
           p_ins('Показник 61 (20% від РК1): ',sum_k_ * 0.2);
         END IF;

         p_ins(' ----------------------------------------------------------------------------------------- ',NULL);

         p_ins('Статутний капiтал: ', sum_SK_);

         p_ins('Показник 03 ('||TO_CHAR(k2_*100)||'% від статутного капiталу): ',sum_SK_ * k2_);

         IF k3_ <> 0 THEN
            p_ins('Показник 63 ('||TO_CHAR(k3_*100)||'% від статутного капiталу): ',sum_SK_ * k3_);
         END IF;

         p_ins('Показник 72  (15% в_д статутного капiталу): ',sum_SK_ * 0.15);

      END IF;
   ELSE
      sum_SK_:= sum_k_ ;
   END IF;

-- останн_й робочий день зв_тного пер_оду
   SELECT MAX (FDAT)
      INTO pdat_
   FROM FDAT
   WHERE FDAT <= dat_;

---------------------------------------------------------------------------
   if pmode_ = 0 and s_prizn_ = 0 then
       sql_acc_ := 'SELECT r020 FROM KL_F3_29 WHERE kf = ''42'' AND ddd IN (''047'', ''051'') ';

       ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

       insert into otcn_f42_temp (ACC, NLS, KV, FDAT, DDD, R012, ACCC, OST_EQV, ap)
       SELECT a.acc, a.nls, a.kv, a.FDAT, k.ddd, NVL (p.r013, '0'),
              DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
              SUM (a.ostq), 0
          FROM (SELECT s.acc, s.nls, s.kv, s.FDAT, s.nbs, s.rnk,
                       decode(s.kv, 980, s.ost, s.ostq) ostq,
                       DECODE(SIGN(s.ost), -1, '11', '22') r050
                FROM OTCN_SALDO s
                WHERE s.ost <> 0) a,
                KL_F3_29 k, SPECPARAM p, CUSTOMER c
          WHERE a.rnk=c.rnk
            AND a.nbs = k.r020
            AND k.kf = '42'
            AND k.ddd IN  ('047', '051')
            AND a.acc = p.acc
            AND NVL (p.r013, '0') = k.r012
            AND k.r050 = a.r050
        AND (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_)
          GROUP BY a.acc, a.nls, a.kv, a.FDAT, k.ddd, NVL (p.r013, '0'),
                   DECODE (c.rnkp, NULL, c.rnk, c.rnkp);

        insert into otcn_f42_zalog (ACC, ACCS, ND, NBS, R013, OST)
        SELECT z.acc, z.accs, z.nd, a.nbs, p.r013,
               gl.p_icurval (a.kv, a.ost, dat_) ost
          FROM cc_accp z, sal a, specparam p
         WHERE z.acc in (select acc from otcn_f42_temp where ap = 0)
           AND z.accs = a.acc
           and a.fdat=dat_
           AND a.acc = p.acc
           AND a.nbs || p.r013 <> '91299'
           and a.nbs not in (select r020 from otcn_fa7_temp)
           and a.ost<0;

       ---- формирование кодов 47-51
       OPEN saldoost3;

       LOOP
          FETCH saldoost3
           INTO acc_, nls_, kv_, data_, ddd_, r013_, rnk_, se_;
          EXIT WHEN saldoost3%NOTFOUND;

          IF r013_ = '0'
          THEN
             ddd_ := '098'; -- для контроля
          END IF;

          IF ddd_ IN ('047', '051') THEN
             -- сумма задолженности, кот. покрывает данный залог
             sk_ := 0;
             sz_ := 0;
             se_ := abs(se_);

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
             For k in (select z.ACC, z.ACCS, z.ND, z.NBS, z.R013, z.OST,
                            DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk
                       from OTCN_F42_ZALOG z, cust_acc ca, customer c
                       WHERE z.ACC = acc_ and
                             z.accs = ca.acc and
                             ca.rnk = c.rnk)
             loop
                 ostc_:=0;

                 -- вычисляем процент залога на данный актив
                 if abs(k.ost) < abs(sk_all_) then -- не один актив
                    sz1_ := round(abs(k.ost / sk_all_) * se_, 0);
                 else
                    sz1_ :=  se_;
                 end if;

                -- Для Петрокоммерца не корректируем сумму задолженности на сумму дисконта/премии
                -- письмо от Самсон Ю. (01/10/2007)
                 if mfou_ NOT IN (300120) THEN  -- 300120 NOT IN (mfo_, mfou_)
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

                          if dat_ < dat_Zm4_ then
                             kodp_ := SUBSTR (ddd_, 2, 2) || '0000';
                          else
                             kodp_ := SUBSTR (ddd_, 2, 2) || '0000' || '000';
                          end if;

                          znap_ := TO_CHAR (sz0_);

                          INSERT INTO RNBU_TRACE(nls, kv, odate, kodp, znap, rnk, acc)
                          VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, acc_);
                       end if;
                    end if;
                 end if;
             end loop;
          END IF;
       END LOOP;

       CLOSE saldoost3;
   end if;

   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';

   sql_acc_ := 'SELECT r020 FROM KL_F3_29 WHERE kf = ''42'' AND ddd IN (''001'', ''006'') ';

   ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

   if prnk_ IS NULL then
      INSERT INTO OTCN_F42_TEMP(ACC, KV, FDAT, NBS, NLS, OST_NOM, OST_EQV,
                                 AP, R012, DDD, R020, ACCC, ZAL, RNK)
       SELECT a.acc, a.kv, a.FDAT, a.nbs, a.nls,
              a.ost_nom, a.ost_eqv,
              DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012,
              a.ddd, a.r020, a.accc, 0, a.rnk
       FROM (SELECT s.acc, s.nls, s.kv, s.FDAT, s.nbs,
                    s.ost ost_nom, decode(s.kv, 980, s.ost, s.ostq) ost_eqv, a.accc,
                    s.rnk, k.r012, k.ddd, k.r020
             FROM OTCN_SALDO s, otcn_acc a, KL_F3_29 k, customer r
             WHERE s.acc = a.acc
               and k.kf='42'
               and k.ddd IN ('001', '006')
               and a.nls LIKE k.r020||'%'
               and (a.nbs is null or substr(a.nls,1,4)=a.nbs )
               and a.rnk = r.rnk ) a
        where a.ost_nom<>0;
   else
      INSERT INTO OTCN_F42_TEMP(ACC, KV, FDAT, NBS, NLS, OST_NOM, OST_EQV,
                                 AP, R012, DDD, R020, ACCC, ZAL, RNK)
       SELECT a.acc, a.kv, a.FDAT, a.nbs, a.nls,
              a.ost_nom, a.ost_eqv,
              DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012,
              a.ddd, a.r020, a.accc, 0, a.rnk
       FROM (SELECT s.acc, s.nls, s.kv, s.FDAT, s.nbs,
                    s.ost ost_nom, decode(s.kv, 980, s.ost, s.ostq) ost_eqv, a.accc,
                    s.rnk, k.r012, k.ddd, k.r020
             FROM OTCN_SALDO s, otcn_acc a, KL_F3_29 k, customer r
             WHERE s.acc = a.acc
               and k.kf='42'
               and k.ddd IN ('001', '006')
               and s.nls LIKE k.r020||'%'
               and (s.nbs is null or substr(s.nls,1,4)=s.nbs )
               and a.rnk = r.rnk
               and DECODE (r.rnkp, NULL, r.rnk, r.rnkp)=prnk_) a
        where a.ost_nom<>0;
   end if;

   -- формирование кодов 01, 02, 03, 04
   OPEN saldo;

   LOOP
      FETCH saldo
       INTO ddd_, rnk_, insider_, se_, fl_tp_1, fl_tp_2, fl_tp_3, fl_tp_4, fl_tp_5, fl_tp_6, fl_tp_7, sum_proc_ ;

      EXIT WHEN saldo%NOTFOUND;

      comm_ := '';
      s_zal_ := 0;

      s02_ := 0;
      s03_ := 0;
      s04_ := 0;
      s05_ := 0;
      p71_ := 0;

      IF ddd_ = '001'
      THEN
         f42_ := 0;

         SELECT COUNT (*)
            INTO f42_
         FROM KL_F3_29
         WHERE txt IS NOT NULL AND
           kf = kodf_ AND
           txt = TO_CHAR (rnk_);

         IF se_ <> 0 AND f42_ = 0
         THEN
            se_ := se_ - fl_tp_7;  -- вираховуэмо 9129 (9)

            --- Максимальная сумма кредитов на одного заемщика (код 01)
            --- вычитаем излишние суммы (параметр R013 только определенные значения)
            if fl_tp_1 > 0 then
               s02_ := fl_tp_1;
            end if;

            if fl_tp_2 > 0 then
               s03_ := fl_tp_2;
            end if;

            --- вычитаем излишние суммы (параметр R013 только определенные значения)
            if fl_tp_3 > 0 then
               s04_ := fl_tp_3;
            end if;

            --- вычитаем излишние суммы (параметр R013 только определенные значения) 3540 R013 in (4,5,6)'
            if fl_tp_4 > 0 then
               s05_ := fl_tp_4;
            end if;

            if fl_tp_5 > 0 then
               if mfo_ = 300120 then
                  fl_tp_5 := f_ret_exceeding_3540_by_rnk(rnk_, dat_);
               end if;

               s05_ := s05_ - fl_tp_5;
            end if;

            -- 01.07.2014 для інсайдерів не виконуємо коригування сумі залишку
            -- зауваження ГОУ
            IF insider_ <> 1
            THEN
               se_ := se_ - s02_ - s03_ - s04_ - s05_;
            end if;

            --- вычитаем излишние суммы (параметр R013 только определенные значения) по 9500
            if fl_tp_6 > 0 then
               se_ := se_ - fl_tp_6;
            end if;

            --- резервы нужно отнимать только по определенному набору параметров R013
            if sum_proc_ <> 0 then
               se_ := se_ + sum_proc_;

               if se_ < 0 then
                  se_ := 0;
               end if;
            end if;

            nlsp_ := 'RNK =' || TO_CHAR (rnk_);
            comm_ := comm_ || ' PROC = '||  to_char(sum_proc_) ;
            znap_ := TO_CHAR (ABS (se_));
            s_zal_:= 0;

            IF insider_ <> 1 and ABS (se_) > ROUND (sum_k_ * k1_, 0) and rgk_ >= 0 and s_prizn_=0
            THEN
              nnnn01_ := nnnn01_ + 1;
              if dat_ < dat_Zm4_ then
                 kodp_ := '01' || LPAD (nnnn01_, 4, '0');
              else
                 kodp_ := '01' || LPAD (nnnn01_, 4, '0') || '000';
              end if;

              INSERT INTO RNBU_TRACE
                          (nls, kv, odate, kodp, znap, rnk, comm
                          )
                   VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_, comm_
                          );

              -- рассчитываем 61 показатель с 01.04.2006
              -- (Сукуп.заборг.за операцўями з контрагент.NNNN,що >20%РК до набуття статусу СОБ з Н/Кл.А <=10%)
              IF flag_>0 AND dat_>=dat_Zm1_ AND vNKA_<=10 AND ABS(se_)>ROUND(sum_k_*0.2, 0) THEN
                 if dat_ < dat_Zm4_ then
                    kodp_ := '61' || LPAD (nnnn01_, 4, '0');
                 else
                    kodp_ := '61' || LPAD (nnnn01_, 4, '0') || '000';
                 end if;

                 INSERT INTO RNBU_TRACE
                             (nls, kv, odate, kodp, znap, rnk) VALUES
                             (nlsp_, 0, dat_, kodp_, znap_, rnk_);
              END IF;

              -- рассчитаем 47 показатель
              begin
                 select nvl(sum(to_number(znap)), 0)
                 into p47_
                 from rnbu_trace
                 where kodp like '47%' and
                       rnk = rnk_;
              exception
                 when no_data_found then
                    p47_ := 0;
              end;

              -- рассчитаем 51 показатель
              begin
                 select nvl(sum(to_number(znap)), 0)
                 into p51_
                 from rnbu_trace
                 where kodp like '51%' and
                       rnk = rnk_;
              exception
                 when no_data_found then
                    p51_ := 0;
              end;

              IF p47_<>0 OR p51_ <> 0 THEN
                 s_zal_:= p47_ + p51_;

                 IF s_zal_ > ABS (se_) THEN
                    s_zal_ := ABS (se_);
                 END IF;
              END IF;

              IF s_zal_ <> 0 THEN
                 if dat_ < dat_Zm4_ then
                    kodp_ := '05' || LPAD (nnnn01_, 4, '0');
                 else
                    kodp_ := '05' || LPAD (nnnn01_, 4, '0') || '000';
                 end if;
                 INSERT INTO RNBU_TRACE
                          (nls, kv, odate, kodp, znap, rnk)
                   VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), rnk_);
              END IF;

              if dat_ > dat_Zm2_ then
                 SELECT ABS (NVL (SUM (s.ost_eqv), 0))
                    INTO p71_
                 FROM OTCN_F42_TEMP s, CUSTOMER c, SPECPARAM p,
                      KL_F3_29 k
                 WHERE s.rnk = c.rnk
                   AND s.acc = p.acc(+)
                   AND NVL (c.rnkp, c.rnk) = rnk_
                   AND s.nbs=k.r020
                   AND k.kf='42'
                   AND k.ddd='071'
                   AND p.r013=k.r012 ;

                 -- показник 71
                 ksum_ := ROUND (sum_k_ * k1_, 0);  --ROUND (sum_k_ * 0.2, 0)

                 IF ABS(p71_) > ksum_ and rgk_ >= 0
                 THEN
                    insert into otcn_log (kodf, userid, txt)
                    values (kodf_, userid_, 'показник 71 rnk = '||
                       to_char(rnk_)||'  p71 = '||to_char(p71_-ksum_));

                    if dat_ < dat_Zm4_ then
                       kodp_ := '71' || LPAD (nnnn01_, 4, '0');
                    else
                       kodp_ := '71' || LPAD (nnnn01_, 4, '0') || '000';
                    end if;
                    INSERT INTO RNBU_TRACE
                      (nls, kv, odate, kodp, znap, rnk)
                    VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (p71_-ksum_), rnk_);
                 END IF;

              end if;

              flag_inc_ := TRUE;
            ELSE
              flag_inc_ := FALSE;
            END IF;

            -- поиск максимальной суммы среди тех, которые не удовлетв. условию ABS(se_)>ROUND(sum_k_*0.25,0)
            IF insider_ <> 1 and NOT flag_inc_ AND ABS (se_) >= sp_
            THEN
              -- рассчитаем 47 показатель
              begin
                 select nvl(sum(to_number(znap)), 0)
                  into p47_
                 from rnbu_trace
                 where kodp like '47%' and
                       rnk = rnk_;
              exception
                when no_data_found then
                     p47_ := 0;
              end;

              -- рассчитаем 51 показатель
              begin
                 select nvl(sum(to_number(znap)), 0)
                 into p51_
                 from rnbu_trace
                 where kodp like '51%' and
                       rnk = rnk_;
              exception
                 when no_data_found then
                    p51_ := 0;
              end;

              IF p47_<>0 OR p51_ <> 0 THEN
                 s_zal_:= p47_ + p51_;

                 IF s_zal_ > ABS (se_) THEN
                    s_zal_ := ABS (se_);
                 END IF;
              END IF;

              if s_zal_ <> 0 then
                 znapp_ := znap_;
                 nlspp_ := nlsp_;
                 comm_pp_ := comm_;
                 rnkp_  := rnk_;
                 s_zalp_:= s_zal_;
                 sp_ := ABS (se_);
              end if;
            END IF;

            -- нет суммы обеспечения
            -- поиск максимальной суммы среди тех, которые не удовлетв. условию ABS(se_)>ROUND(sum_k_*0.25,0)
            IF insider_ <> 1 and NOT flag_inc_ AND ABS (se_) >= sp1_
            THEN
              -- рассчитаем 47 показатель
               begin
                  select nvl(sum(to_number(znap)), 0)
                   into p47_
                  from rnbu_trace
                  where kodp like '47%' and
                        rnk = rnk_;
               exception
                  when no_data_found then
                     p47_ := 0;
               end;

              -- рассчитаем 51 показатель
               begin
                 select nvl(sum(to_number(znap)), 0)
                 into p51_
                 from rnbu_trace
                 where kodp like '51%' and
                       rnk = rnk_;
               exception
                 when no_data_found then
                    p51_ := 0;
               end;

               IF p47_+p51_ = 0 THEN
                  znapp1_ := znap_;
                  nlspp1_ := nlsp_;
                  comm_pp1_ := comm_;
                  rnkp1_  := rnk_;
                  sp1_ := ABS (se_);
               END IF;
            END IF;

            IF ABS (se_) > ROUND (sum_k_ * 0.1, 0)
            THEN
              IF type_ = 0
              THEN
                 kodp_ := '020000';
              ELSE
                 nnn1_ := nnn1_ + 1;
                 kodp_ := '02' || LPAD (nnn1_, 4, '0');
              END IF;

              if dat_ >= dat_Zm4_ then
                 kodp_ := kodp_ || '000';
              end if;

              IF mfo_ = 300120 then
                 s_zal_ := 0;
              ELSE
                 -- рассчитаем 47 показатель
                 begin
                    select nvl(sum(to_number(znap)), 0)
                    into p47_
                    from rnbu_trace
                    where kodp like '47%' and
                          rnk = rnk_;
                 exception
                    when no_data_found then
                       p47_ := 0;
                 end;

                 -- рассчитаем 51 показатель
                 begin
                    select nvl(sum(to_number(znap)), 0)
                    into p51_
                    from rnbu_trace
                    where kodp like '51%' and
                          rnk = rnk_;
                 exception
                    when no_data_found then
                       p51_ := 0;
                 end;

                 IF p47_<>0 OR p51_ <> 0 THEN
                    s_zal_:= p47_ + p51_;

                    IF s_zal_ > ABS (se_) THEN
                       s_zal_ := ABS (se_);
                    END IF;
                 END IF;
              END IF;

              INSERT INTO RNBU_TRACE
                          (nls, kv, odate, kodp, znap, rnk, comm
                          )
                   VALUES (nlsp_, 0, dat_, kodp_, to_char(ABS (se_) - s_zal_), rnk_, comm_
                          );
            END IF;

            -- показник 41
            ksum_ := ROUND (sum_k_ * k1_, 0);

            -- показник 41 формуємо лише тод_, коли заг. сума заборгованост_ та сума гарант_й б_льша 25% в_д РК
            -- на 16.06.2015 показник не формується
            IF Dat_ < dat_Zm5_
            THEN
               IF ABS (se_) - s_zal_ > ksum_ AND s_prizn_=0  --ABS (se_) - ABS(p47_) > ksum_ AND s_prizn_=0
               THEN
                 nnnn41_ := nnnn41_ + 1;
                 if dat_ < dat_Zm4_ then
                    kodp_ := '41' || LPAD (nnnn41_, 4, '0');
                 else
                    kodp_ := '41' || LPAD (nnnn41_, 4, '0') || '000';
                 end if;

                 znap_ := TO_CHAR (ABS (se_) - s_zal_ - ksum_);

                 INSERT INTO RNBU_TRACE
                             (nls, kv, odate, kodp, znap, rnk
                             )
                      VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                             );
               END IF;
            END IF;

            IF insider_ = 1
            THEN
               nlsp_ := 'RNK =' || TO_CHAR (rnk_);
               znap_ := TO_CHAR (ABS (se_));
               s_zal_ :=0;

               IF type_ = 0
               THEN
                  kodp_ := '040000';
               ELSE
                  nnn2_ := nnn2_ + 1;
                  kodp_ := '04' || LPAD (nnn2_, 4, '0');
               END IF;

               if dat_ >= dat_Zm4_ then
                  kodp_ := kodp_ || '000';
               end if;

               IF mfo_ = 300120 then
                  s_zal_ := 0;
               ELSE
                  -- рассчитаем 47 показатель
                  begin
                     select nvl(sum(to_number(znap)), 0)
                        into p47_
                     from rnbu_trace
                     where kodp like '47%' and
                           rnk = rnk_;
                  exception
                     when no_data_found then
                        p47_ := 0;
                  end;

                  -- рассчитаем 51 показатель
                  begin
                     select nvl(sum(to_number(znap)), 0)
                        into p51_
                     from rnbu_trace
                     where kodp like '51%' and
                           rnk = rnk_;
                  exception
                     when no_data_found then
                        p51_ := 0;
                  end;

                  IF p47_<>0 OR p51_ <> 0 THEN
                     s_zal_:= p47_ + p51_;

                     IF s_zal_ > ABS (se_) THEN
                        s_zal_ := ABS (se_);
                     END IF;
                  END IF;
               END IF;

               insert into otcn_f42_history(FDAT, RNK, SUM, USERID)
               values (dat_, rnk_, ABS (se_) - s_zal_, userid_);

               INSERT INTO RNBU_TRACE
                           (nls, kv, odate, kodp, znap, rnk, comm )
               VALUES (nlsp_, 0, dat_, kodp_, to_char(ABS (se_) - s_zal_), rnk_, comm_);

               -- з 21.12.2005 перевищення 5% Статутного капiталу банку
               IF ((dat_ >= dat_Zm_ AND ABS (se_) > ROUND (sum_SK_ * k2_, 0)) OR
                   (dat_ < dat_Zm_ AND ABS (se_) > ROUND (sum_k_ * k2_, 0)))
                   and rgk_ >= 0
               THEN
                  nnnn1_ := nnnn1_ + 1;

                  -- на 16.06.2015 показник не формується
                  IF Dat_ < dat_Zm5_
                  THEN
                     if dat_ < dat_Zm4_ then
                        kodp_ := '03' || LPAD (nnnn1_, 4, '0');
                     else
                        kodp_ := '03' || LPAD (nnnn1_, 4, '0') || '000';
                     end if;

                     INSERT INTO RNBU_TRACE
                                 (nls, kv, odate, kodp, znap, rnk
                                 )
                          VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                                 );
                  END IF;
                  -- формирование показателя 94NNNN
                  IF Dat_ >= to_date('31012014','ddmmyyyy') then

                     -- рассчитаем 47 показатель
                     begin
                        select nvl(sum(to_number(znap)), 0)
                           into p47_
                        from rnbu_trace
                        where kodp like '47%' and
                              rnk = rnk_;
                     exception
                        when no_data_found then
                           p47_ := 0;
                     end;

                     -- рассчитаем 51 показатель
                     begin
                        select nvl(sum(to_number(znap)), 0)
                           into p51_
                        from rnbu_trace
                        where kodp like '51%' and
                              rnk = rnk_;
                     exception
                        when no_data_found then
                           p51_ := 0;
                     end;

                     IF p47_<>0 OR p51_ <> 0 THEN
                        s_zal_:= p47_ + p51_;

                        IF s_zal_ > ABS (se_) THEN
                           s_zal_ := ABS (se_);
                        END IF;
                     END IF;

                     IF s_zal_ <> 0 AND Dat_ < dat_Zm5_ THEN
                        if dat_ < dat_Zm4_ then
                           kodp_ := '94' || LPAD (nnnn1_, 4, '0');
                        else
                           kodp_ := '94' || LPAD (nnnn1_, 4, '0') || '000';
                        end if;
                        INSERT INTO RNBU_TRACE
                                 (nls, kv, odate, kodp, znap, rnk)
                          VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), rnk_);
                     END IF;
                  END IF;

                  -- рассчитываем 62 показатель с 01.04.2006
                  -- на 16.06.2015 показник не формується
                  IF Dat_ < dat_Zm5_
                  THEN

                     IF flag_>0 AND dat_>=dat_Zm1_ AND ABS(se_)>ROUND(sum_sk_* k2_, 0) THEN
                        if dat_ < dat_Zm4_ then
                           kodp_ := '62' || LPAD (nnnn1_, 4, '0');
                        else
                           kodp_ := '62' || LPAD (nnnn1_, 4, '0') || '000';
                        end if;

                        INSERT INTO RNBU_TRACE
                                    (nls, kv, odate, kodp, znap, rnk) VALUES
                                    (nlsp_, 0, dat_, kodp_, znap_, rnk_);
                     END IF;
                  END IF;

                  --si_ := ABS (se_);

                  IF dat_ >= dat_Zm_ THEN
                     BEGIN
                        SELECT  ABS (SUM (a.ost_eqv))
                           INTO se54_
                     FROM OTCN_F42_TEMP a, CUSTOMER c, OTCN_F42_PR o  --CUST_ACC ca,
                     WHERE a.ap=a.r012 AND
                           NOT EXISTS (SELECT 1
                                       FROM OTCN_F42_TEMP b
                                       WHERE  b.ap=b.r012        AND
                                              b.nbs IS NULL      AND
                                              b.ACCC = a.acc AND
                                              b.nls LIKE '3%') AND
                           a.rnk = c.rnk AND
                           DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=rnk_ AND
                           a.ddd=ddd_ AND
                           a.acc=o.acc AND
                           o.F42P54=1;
                     EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                        se54_ := 0;
                     END;

                     IF ABS (NVL(se54_, 0)) > ROUND (sum_SK_ * k2_, 0) -- з 21.12.2005 перевищення 5% Статутного капiталу банку
                     THEN
                        nnnn54_ := nnnn1_;
                        IF Dat_ < dat_Zm1_ OR flag_ = 0 THEN
                           kodp_ := '54' || LPAD (nnnn54_, 4, '0');
                        ELSE
                           -- с 01.04.2006
                           kodp_ := '62' || LPAD (nnnn54_, 4, '0');
                        END IF;

                        -- на 16.06.2015 показник не формується
                        IF Dat_ < dat_Zm5_
                        THEN

                           if dat_ >= dat_Zm4_ then
                              kodp_ := kodp_ || '000';
                           end if;

                           INSERT INTO RNBU_TRACE
                               (nls, kv, odate, kodp, znap, rnk )
                           VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_ );
                        END IF;

                        -- добавлено с 18.01.2006
                        IF Dat_ < dat_Zm1_ OR flag_ = 0  THEN
                           kodp_ := '570000';
                        ELSE
                           -- с 01.04.2006
                           kodp_ := '630000';
                        END IF;
                        if dat_ >= dat_Zm4_ then
                           kodp_ := kodp_ || '000';
                        end if;

                        p57_  :=ABS (NVL(se54_, 0)) - ROUND (sum_SK_ * k2_, 0) ;

                        INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk )
                        VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_ );
                     END IF;

                     -- с 01.04.2006 перевищення 10% або 20% Статутного капiталу банку
                     -- залежно вiд обсягу негативно-класифiкованих активiв
                     IF flag_>0 AND k3_ > 0 AND ABS (NVL(se54_, 0)) > ROUND (sum_SK_ * k3_, 0)
                     THEN
                        -- с 01.04.2006
                        if dat_ < dat_Zm4_ then
                           kodp_ := '630000';
                        else
                           kodp_ := '630000' || '000';
                        end if;

                        p57_  :=ABS (NVL(se54_, 0)) - ROUND (sum_SK_ * k3_, 0) ;

                        INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk )
                        VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_ );
                     END IF;
                  END IF;

                 flag_inc_ := TRUE;
               ELSE
                 flag_inc_ := FALSE;
               END IF;

               -- поиск максимальной суммы среди тех, которые не удовлетв. условию ABS(se_)>ROUND(sum_k_*0.25,0)
               IF insider_ = 1 and NOT flag_inc_ AND ABS (se_) >= si_
               THEN
                 -- рассчитаем 47 показатель
                 begin
                    select nvl(sum(to_number(znap)), 0)
                     into p47_
                    from rnbu_trace
                    where kodp like '47%' and
                          rnk = rnk_;
                 exception
                   when no_data_found then
                        p47_ := 0;
                 end;

                 -- рассчитаем 51 показатель
                 begin
                    select nvl(sum(to_number(znap)), 0)
                    into p51_
                    from rnbu_trace
                    where kodp like '51%' and
                          rnk = rnk_;
                 exception
                    when no_data_found then
                       p51_ := 0;
                 end;

                 IF p47_<>0 OR p51_ <> 0 THEN
                    s_zal_:= p47_ + p51_;

                    IF s_zal_ > ABS (se_) THEN
                       s_zal_ := ABS (se_);
                    END IF;
                 END IF;

                 if s_zal_ <> 0 then
                    rnki_     := rnk_;
                    znapi_ := znap_;
                    nlsi_ := nlsp_;
                    s_zali_:= s_zal_;
                    si_ := ABS (se_);
                 end if;
               END IF;

               -- нет суммы обеспечения
               -- поиск максимальной суммы среди тех, которые не удовлетв. условию ABS(se_)>ROUND(sum_k_*0.25,0)
               IF insider_ = 1 and NOT flag_inc_ AND ABS (se_) >= si1_
               THEN
                  -- рассчитаем 47 показатель
                  begin
                     select nvl(sum(to_number(znap)), 0)
                      into p47_
                     from rnbu_trace
                     where kodp like '47%' and
                           rnk = rnk_;
                  exception
                     when no_data_found then
                        p47_ := 0;
                  end;

                  -- рассчитаем 51 показатель
                  begin
                    select nvl(sum(to_number(znap)), 0)
                    into p51_
                    from rnbu_trace
                    where kodp like '51%' and
                          rnk = rnk_;
                  exception
                    when no_data_found then
                       p51_ := 0;
                  end;

                  IF p47_+p51_ = 0 THEN
                     znapi1_ := znap_;
                     nlsi1_ := nlsp_;
                     rnki1_  := rnk_;
                     si1_ := ABS (se_);
                  END IF;
               END IF;

               -- показник 42
               ksum_ := ROUND (sum_SK_ * k2_, 0);

               -- на 16.06.2015 показник не формується
               IF Dat_ < dat_Zm5_
               THEN

                  IF ABS (se_) - s_zal_ > ksum_ and rgk_ >= 0
                  THEN
                     nnnn42_ := nnnn42_ + 1;
                     if dat_ < dat_Zm4_ then
                        kodp_ := '42' || LPAD (nnnn42_, 4, '0');
                     else
                        kodp_ := '42' || LPAD (nnnn42_, 4, '0') || '000';
                     end if;
                     znap_ := TO_CHAR (ABS (se_) - s_zal_ - ksum_);

                     INSERT INTO RNBU_TRACE
                                 (nls, kv, odate, kodp, znap, rnk
                                 )
                          VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                                 );
                  END IF;
               END IF;
            END IF;
         END IF;
      ELSE
         IF se_ <> 0
         THEN
            --- Максимальная сумма, что инвестируется на покупку акций (код 06)
            IF Dat_ < to_date('31032012','ddmmyyyy')
            THEN

               IF ABS (se_) > ROUND (sum_k_ * 0.15, 0) and rgk_ >= 0
               THEN
                  nnnn2_ := nnnn2_ + 1;
                  if dat_ < dat_Zm4_ then
                     kodp_ := '06' || LPAD (nnnn2_, 4, '0');
                  else
                     kodp_ := '06' || LPAD (nnnn2_, 4, '0') || '000';
                  end if;
                  nlsu_ := 'RNK =' || TO_CHAR (rnk_);
                  znap_ := TO_CHAR (abs(se_));

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk
                              )
                       VALUES (nlsu_, 0, dat_, kodp_, znap_, rnk_
                              );

                  spp_ := se_;
               END IF;

               IF ABS (se_) < ROUND (sum_k_ * 0.15, 0) AND ABS (se_) >= spp_
               THEN
                  znapu_ := TO_CHAR (abs(se_));
                  nlsu_ := 'RNK =' || TO_CHAR (rnk_);
                  rnku_ := rnk_;
                  spp_ := se_;
               END IF;
            END IF;

            --- Максимальная сумма, что инвестируется на покупку акций (код 72)
            IF Dat_ > to_date('31032012','ddmmyyyy')
            THEN

               IF ABS (se_) > ROUND (sum_SK_ * 0.15, 0) --and rgk_ >= 0
               THEN
                  if substr(kodp_,1,2) <> '06' then
                     nnnn2_ := nnnn2_ + 1;
                  end if;
                  if dat_ < dat_Zm4_ then
                     kodp_ := '72' || LPAD (nnnn2_, 4, '0');
                  else
                     kodp_ := '72' || LPAD (nnnn2_, 4, '0') || '000';
                  end if;
                  nlsu_ := 'RNK =' || TO_CHAR (rnk_);
                  znap_ := TO_CHAR (abs(se_));

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk
                              )
                       VALUES (nlsu_, 0, dat_, kodp_, znap_, rnk_
                              );

                  spp_72 := se_;
               END IF;

               IF ABS (se_) < ROUND (sum_SK_ * 0.15, 0) AND ABS (se_) >= spp_72
               THEN
                  znapu_72 := TO_CHAR (abs(se_));
                  nlsu_72 := 'RNK =' || TO_CHAR (rnk_);
                  rnku_72 := rnk_;
                  spp_72 := se_;
               END IF;
            END IF;
         END IF;
      END IF;
   END LOOP;

   CLOSE saldo;
--------------------------------------------------------------------------
   --- 30.01.2014 - формируем показатель 03 для максимального заемщика,
   --- который меньше 5% и есть обеспечения
   IF TO_NUMBER (znapi_) > 0
   THEN
      -- на 16.06.2015 показник не формується
      IF Dat_ < dat_Zm5_
      THEN

         kodpi_ := '03' || LPAD (TO_CHAR (nnnn1_ + 1), 4, '0');

         INSERT INTO RNBU_TRACE
                     (nls, kv, odate, kodp, znap, rnk
                     )
              VALUES (nlsi_, 0, dat_, kodpi_, znapi_, rnki_
                     );

         IF Dat_ >= to_date('31012014','ddmmyyyy') and s_zali_ >= 0
         THEN
            kodpi_ := '94' || LPAD (TO_CHAR (nnnn1_ + 1), 4, '0');

            INSERT INTO RNBU_TRACE
                     (nls, kv, odate, kodp, znap, rnk
                     )
              VALUES (nlsi_, 0, dat_, kodpi_, to_char(s_zali_), rnki_
                     );
         END IF;
      END IF;

   END IF;

   --- 30.01.2014 - формируем показатель 03 для максимального заемщика,
   --- который меньше 5% и нет обеспечения
   IF TO_NUMBER (znapi1_) > 0
   THEN

      -- на 16.06.2015 показник не формується
      IF Dat_ < dat_Zm5_
      THEN

         kodpi_ := '03' || LPAD (TO_CHAR (nnnn1_ + 2), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlsi1_, 0, dat_, kodpi_, znapi1_, rnki1_
                  );

         kodpi_ := '94' || LPAD (TO_CHAR (nnnn1_ + 2), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlsi1_, 0, dat_, kodpi_, '0', rnki1_
                  );
      END IF;
   END IF;

   IF TO_NUMBER (znapp_) > 0
   THEN
      kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0');

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, comm
                  )
           VALUES (nlspp_, 0, dat_, kodpp_, znapp_, rnkp_, comm_pp_
                  );
    --- 03.11.2008 - по замечанию Петрокомерца не нужно формировать показатель 05 для максимального заемщика,
    --- который меньше 25%

      IF s_zalp_ >= 0 THEN
         kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlspp_, 0, dat_, kodpp_, to_char(s_zalp_), rnkp_
                  );
      END IF;

   END IF;

   --- 25.06.2011 - по замечанию Петрокомерца формируем показатель 01 для максимального заемщика,
   --- который меньше 25% и нет обеспечения
   IF TO_NUMBER (znapp1_) > 0
   THEN
      kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0');

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, comm
                  )
           VALUES (nlspp1_, 0, dat_, kodpp_, znapp1_, rnkp1_, comm_pp1_
                  );

         kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlspp1_, 0, dat_, kodpp_, '0', rnkp1_
                  );
   END IF;

   IF TO_NUMBER (znapu_) > 0
   THEN
      kodpp_ := '060001';

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlsu_, 0, dat_, kodpp_, znapu_, rnku_
                  );
   END IF;

   IF TO_NUMBER (znapu_72) > 0
   THEN
      kodpp_ := '720001';

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlsu_72, 0, dat_, kodpp_, znapu_72, rnku_72
                  );
   END IF;

   -- показатель 65 как показатель 41 только при изменении курса валют
   -- на 16.06.2015 показник не формується
   IF Dat_ < dat_Zm5_
   THEN

      for k in ( select r.* from rnbu_trace r
                 where r.kodp like '41%'
                   and exists ( select 1 from otcn_saldo o
                                where o.rnk = r.rnk
                                  and o.kv <> 980
                              )
               )

         loop

            INSERT INTO RNBU_TRACE
                        (nls, kv, odate, kodp, znap, rnk
                        )
                 VALUES (k.nls, k.kv, dat_, '65'||substr(k.kodp,3,4), k.znap, k.rnk
                        );

      end loop;
   END IF;

   -- показатель 66 как показатель 42 только при изменении курса валют (інсайдери)
   -- на 16.06.2015 показник не формується
   IF Dat_ < dat_Zm5_
   THEN

      for k in ( select r.* from rnbu_trace r
                 where r.kodp like '42%'
                   and exists ( select 1 from otcn_saldo o
                                where o.rnk = r.rnk
                                  and o.kv <> 980
                              )
               )

         loop

            INSERT INTO RNBU_TRACE
                        (nls, kv, odate, kodp, znap, rnk
                        )
                 VALUES (k.nls, k.kv, dat_, '66'||substr(k.kodp,3,4), k.znap, k.rnk
                        );

      end loop;
   END IF;
   ---------------------------------------------------------------------------
   if pmode_ = 0 then
       --------------------------------------------------------------------------
       ---- с 13.11.2015 (за 12.11.2015) будет формироваться показатель A00000000
       ---- б/с 9110
       if dat_ >= dat_Zm6_
       then
          sql_acc_ := 'SELECT r020 FROM KL_F3_29 WHERE kf = ''42'' AND ddd IN (''0A0'') ';

          ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

          OPEN saldoost1;

          LOOP
             FETCH saldoost1
              INTO acc_, nbs_, nls_, kv_, data_, r013_, rnk_, se_, ddd_;

             EXIT WHEN saldoost1%NOTFOUND;

             IF se_ <> 0
             THEN
                kodp_ := SUBSTR (ddd_, 2, 2) || '0000' || '000';
                znap_ := TO_CHAR (ABS (se_));

                INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk, acc
                            )
                     VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, acc_
                            );
             END IF;
          END LOOP;

          CLOSE saldoost1;

       end if;
       --------------------------------------------------------------------------
       ---- формирование кодов 73,74,75,76,77,78,79,80,81
       sql_acc_ := 'SELECT r020 FROM KL_F3_29 WHERE kf = ''42'' AND ddd IN (''073'', ''076'') ';

       ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

       OPEN saldoost7;
       LOOP
          FETCH saldoost7
           INTO acc_, nls_, kv_, data_, r013_, s240_, rnk_, k042_, se_, ddd_, mfo_, pr_bank;

          EXIT WHEN saldoost7%NOTFOUND;

          pr_bank := 'X';

          if mfo_ in (320003,300089,322603,321712,325569,337933,380623,
                       351878,380388,307112,351760,380247,307220,351599)
          then
             if mfo_ = 320003 and dat_ <= to_date('12082011','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 300089 and dat_ <= to_date('01032010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 322603 and dat_ <= to_date('15032010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 321712 and dat_ <= to_date('16092010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 325569 and dat_ <= to_date('16042010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 337933 and dat_ <= to_date('16072010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 380623 and dat_ <= to_date('19072010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 351878 and dat_ <= to_date('10092010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 380388 and dat_ <= to_date('01102010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ = 307112 and dat_ <= to_date('15042010','ddmmyyyy')
             then
                pr_bank := 'Т';
             elsif mfo_ in (351760,380247,307220,351599) and dat_ <= to_date('23102012','ddmmyyyy') -- ПАБ АКБ "БАЗИС" м. Харкiв
             then
                pr_bank := 'Т';
             else
                pr_bank := 'X';
             end if;
          end if;

          if mfou_ = 380764 and rnk_ in (1048437, 1048278, 1048281) then
             pr_bank := 'Л';
          end if;

          if pr_bank in ('Т','Л') or k042_='1' then
             p240r_ := fs240 (dat_, acc_);

             if ddd_ = '073' and pr_bank = 'Л' then
                ddd_ := '073';
             end if;

             if ddd_ = '073' and pr_bank = 'Т' then
                ddd_ := '074';
             end if;

             if ddd_ = '073' and k042_ = '1' then
                ddd_ := '075';
             end if;

             if ddd_ = '073' and p240r_ not in ('1','2','3','4','5') then
                ddd_ := '079';
             end if;

             if ddd_ = '074' and p240r_ not in ('1','2','3','4','5') then
                ddd_ := '080';
             end if;

             if ddd_ = '075' and p240r_ not in ('1','2','3','4','5') then
                ddd_ := '081';
             end if;

             if ddd_ = '076' and pr_bank = 'Л' then
                ddd_ := '076';
             end if;

             if ddd_ = '076' and pr_bank = 'Т' then
                ddd_ := '077';
             end if;

             if ddd_ = '076' and k042_ = '1' then
                ddd_ := '078';
             end if;

             IF se_ <> 0
             THEN
                if dat_ < dat_Zm4_ then
                   kodp_ := SUBSTR (ddd_, 2, 2) || '0000';
                else
                   kodp_ := SUBSTR (ddd_, 2, 2) || '0000' || '000';
                end if;
                znap_ := TO_CHAR (ABS (se_));

                INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk, acc
                            )
                     VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, acc_
                            );
             END IF;
          end if;
       END LOOP;

       CLOSE saldoost7;

      if dat_ < to_date('30092013','ddmmyyyy') then
         -----------------------------------------------------------------------
         -- зм_на 27.12.2005 - при розрахунку норматив_в використовується нев_дкоригований кап_тал
         sum_k_19 := NVL(Trim(F_Get_Params ('PK_1907', 0)), 0);

         p_ins(' ----------------------------------------------------------------------------------------- ',NULL);

         p_ins('Сума PK на дату 19072010: ', sum_k_19);
         p_ins('Сума PK на поточну дату: ', rgk_);


         if sum_k_19 <= 12000000000 then
           ---- формирование кодов 82,83,84
            sql_acc_ := 'SELECT r020 FROM KL_F3_29 WHERE kf = ''42'' AND ddd IN (''082'') ';

            ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

            OPEN saldoost8;
            LOOP
              FETCH saldoost8
               INTO acc_, nls_, kv_, data_, r013_, s180_, rnk_, se_;

              EXIT WHEN saldoost8%NOTFOUND;

              nbs_ := substr(nls_,1,4);

              IF (nbs_ like '262%' and se_ <> 0 and r013_='1') or
                 (nbs_ like '263%' and se_ <> 0) or
                 (nbs_ like '332%' and se_ <> 0 and r013_ in ('2','5')) or
                 ((nbs_ like '333%' or nbs_ like '334%') and se_ <> 0 and r013_='5')
              THEN

                 IF se_ <> 0
                 THEN
                    if dat_ < dat_Zm4_ then
                       kodp_ := '820000';
                    else
                       kodp_ := '820000' || '000';
                    end if;
                    znap_ := TO_CHAR (se_);

                    INSERT INTO RNBU_TRACE
                                (nls, kv, odate, kodp, znap, rnk, acc
                                )
                         VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, acc_
                                );
                 END IF;
                 -- пополнение вкладов
                 BEGIN
                    select NVL(SUM(a.kos),0)
                       into se_
                    from rnbu_history a
                    where a.nls=nls_
                      and a.kv=kv_
                      and a.odate between to_date('20072010','ddmmyyyy') and Dat_;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    se_ := 0;
                 END;

                 IF se_ <> 0
                 THEN
                    if dat_ < dat_Zm4_ then
                       kodp_ := '830000';
                    else
                       kodp_ := '830000' || '000';
                    end if;
                    znap_ := TO_CHAR (se_);

                    INSERT INTO RNBU_TRACE
                                (nls, kv, odate, kodp, znap, rnk, acc
                                )
                         VALUES (nls_, kv_, dat_, kodp_, znap_, rnk_, acc_
                                );
                 END IF;

                 IF substr(nbs_,1,1) <> '8' then
                    vost_ := 0;

                    BEGIN
                        case
                            when nbs_ in ('1610', '1612', '1615') then
                                poisk_ := '1618%';
                            when nbs_ in ('2546') then
                                poisk_ := '2548%';
                            when nbs_ in ('2610', '2615') then
                                poisk_ := '2618%';
                            when nbs_ in ('2620') then
                                poisk_ := '2628%';
                            when nbs_ in ('2630', '2635') then
                                poisk_ := '2638%';
                            else
                                poisk_ := null;
                                vost_ := 0;
                        end case;

                        if poisk_ is not null then
                            SELECT NVL (SUM (Gl.P_Icurval (kv, s * 100, FDAT)), 0)
                                INTO vost_
                            FROM provodki
                            WHERE FDAT between to_date('20072010','ddmmyyyy') and Dat_
                               AND nlsd LIKE poisk_
                               and acck = acc_;
                        end if;
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            vost_ := 0;
                    END;

                    if vost_ <> 0 then
                       if dat_ < dat_Zm4_ then
                          kodp_ := '840000';
                       else
                          kodp_ := '840000' || '000';
                       end if;
                       znap_ := TO_CHAR (vost_);

                       INSERT INTO RNBU_TRACE(nls, kv, odate, kodp, znap, rnk, acc)
                       VALUES (nls_, kv_, dat_, kodp_, znap_, rnk_, acc_);
                    end if;
                 end if;
              end if;
            END LOOP;

           CLOSE saldoost8;
         end if;
      end if;

      -- формирование кодов 870000, 880000, 890000, 900000, 910000
      if dat_ >=to_date('01072012','ddmmyyyy') then

         pul_dat(to_char(Dat_,'dd-mm-yyyy'), '');

         --EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_f42_cp';

         -- проверка на наличие VIEW CP_V_ZAL_ACC
         if f_obj_exists('BARS', 'CP_V_ZAL_ACC', 'VIEW') = 1 then

            EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_f42_cp';

            sql_ :=
                'insert into otcn_f42_cp (fdat, acc, nls, kv, sum_zal, dat_zal, rnk, kodp) '
              ||'select c.fdat, a.acc, a.nls, a.kv, c.sum_zal, c.dat_zal, a.rnk, null '
              ||'from accounts a, cp_v_zal_acc c '
              ||'where a.acc = c.acc '
              ||'  and c.fdat = :dat_ '
              ||'  and substr(a.nls,1,4) like ''14__%''' ;

            EXECUTE IMMEDIATE sql_ USING dat_;


            for k in (select *
                      from otcn_f42_cp
                      where fdat = dat_
                        and substr(nls,4,1)<>'8'
                      )
                loop

                   begin
                      select r013, s240
                         into r013_, s240_
                      from specparam
                      where acc=k.acc;
                   exception when no_data_found then
                      r013_ := '0';
                      s240_ := '0';
                   end;

                   s240_ := FS240(dat_, k.acc);

                   if dat_ < dat_Zm4_ then
                      kodp_ := '870000';
                   else
                      kodp_ := '870000' || '000';
                   end if;

                   znap_ := to_char(0 - gl.p_icurval(k.kv, k.sum_zal, dat_));

                   if znap_ <> 0
                   then
                      if ((substr(k.nls,1,4) in ('1410','1420',
                                                 '1430','1435','1436','1437',
                                                 '1440','1446','1447')) or
                          (substr(k.nls,1,4) in ('1415','1416','1417','1426','1427') and r013_ not in ('3','9'))) and
                          k.kodp is null
                      then
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
                         VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.rnk, k.acc);
                      end if;

                      if ( (substr(k.nls,1,4) in ('1412','1413','1414',
                                               '1422','1423','1424')) or
                           (substr(k.nls,1,4) in ('1415','1416','1417','1426','1427') and r013_ in ('3','9'))
                         )
                         and s240_ <= '5'
                         and k.kodp is null
                      then
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
                         VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.rnk, k.acc);
                      end if;

                      if dat_ < dat_Zm4_ then
                         kodp_ := '880000';
                      else
                         kodp_ := '880000' || '000';
                      end if;

                      if ((substr(k.nls,1,4) in ('1412','1413','1414',
                                                 '1422','1423','1424',
                                                 '1430','1440','1435','1436',
                                                 '1437','1446','1447')) or
                          (substr(k.nls,1,4) in ('1415','1416','1417','1425','1426','1427') and r013_ in ('3','9'))) and
                          k.kodp is null and s240_ > '5' and s240_ <= 'B'
                      then
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
                         VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.rnk, k.acc);
                      end if;

                      if k.kodp is not null then
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
                         VALUES (k.nls, k.kv, dat_, k.kodp, znap_, k.rnk, k.acc);
                      end if;
                   end if;

                end loop;

         end if;

      end if;

      -----------------------------------------------------------------------
   end if;

   ------------------------------------------------------------------------------
    -- для ОПЕРУ СБ удаляем из кода 01 клиента НАК Нафтогаз ОКПО=20077720
    --              удаляем из кода 01 клиента ТРИ О        ОКПО=23167814
    if mfo_ = 300465 then
       delete from rnbu_trace
        where (kodp like '01%' or kodp like '61%')
          and rnk in ( select rnk from customer
                       where trim(okpo) in (select trim(okpo) from kl_f8b where trim(okpo) is not null)
                     );
    end if;

    nnnn01_ := 0;
    rnk_ := 0;
    ddd_ := '00';

    for k in (select kodp, rnk, trim(comm) comm
              from rnbu_trace
              order by substr(kodp,1,2), to_number(znap) DESC, rnk )

    loop

        -- в поле COMM (комментарий) заполняем название клиента
        update rnbu_trace set comm = substr( (select c.nmk from customer c
                                     where c.rnk = k.rnk) ||' '|| k.comm,1,255)
        where rnk = k.rnk and kodp = k.kodp;

        if ddd_='00' OR ddd_<>substr(k.kodp,1,2) OR rnk_=0 OR rnk_<>k.rnk then

           if substr(k.kodp,1,2)='01' then
              nnnn01_ := nnnn01_+1;
              if Dat_ < dat_Zm4_ then
                 update rnbu_trace set
                    kodp=substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn01_), 4, '0')
                 where rnk=k.rnk and kodp=k.kodp;
              else
                 update rnbu_trace set
                    kodp=substr(k.kodp,1,2) || LPAD (TO_CHAR (nnnn01_), 4, '0') || '000'
                 where rnk=k.rnk and kodp=k.kodp;
              end if;
           else
              if substr(k.kodp,3,4)<>'0000' then

                 BEGIN
                    select to_number(substr(kodp,3,4)) into nnnn1_
                    from rnbu_trace
                    where rnk=k.rnk and
                    substr(kodp,1,2) in ('01','03') and
                    substr(kodp,1,2)<>substr(k.kodp,1,2) and
                    rownum=1 ;
                    if type_<>0 then
                       nnnn01_ := nnnn01_+1;
                       nnnn1_ := nnnn01_;
                    end if;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    nnnn01_ := nnnn01_+1;
                    nnnn1_ := nnnn01_;
                 END;
                 if Dat_ < dat_Zm4_ then
                    update rnbu_trace set
                       kodp=substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn1_), 4, '0')
                    where rnk=k.rnk and kodp=k.kodp;
                 else
                    update rnbu_trace set
                       kodp=substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn1_), 4, '0') || '000'
                    where rnk=k.rnk and kodp=k.kodp;
                 end if;
              end if;
           end if;

           rnk_:=k.rnk;
           ddd_:=substr(k.kodp,1,2);
        end if;
    end loop;

    -- c 12.11.2015 формирование новых кодов A10000000, A20000000
    if dat_ >= dat_Zm6_
    then

       for k in ( select r1.nls, r1.kv, decode(substr(r2.kodp,1,2),'02','A1','A2') ddd,
                         r1.kodp, r1.znap, r1.acc, r1.rnk
                  from rnbu_trace r1, rnbu_trace r2
                  where r1.rnk = r2.rnk
                    and substr(r1.kodp,1,2) in ('47','51')
                    and substr(r2.kodp,1,2) in ('02','04')
                )

          loop

             kodp_ := k.ddd || '0000' || '000';
             insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
                VALUES (k.nls, k.kv, dat_, kodp_, k.znap, k.rnk, k.acc);

      end loop;

    end if;

    IF type_ = 0
    THEN
      DELETE FROM TMP_NBU
            WHERE kodf = kodf_ AND datf = dat_;

       if  Dat_ <=to_date('03012013','ddmmyyyy') then
          INSERT INTO TMP_NBU (kodf, datf, kodp, znap)
          SELECT kodf_, dat_, kodp, SUM (znap)
          FROM RNBU_TRACE
          GROUP BY kodf_, dat_, kodp;
       else
          INSERT INTO TMP_NBU (kodf, datf, kodp, znap)
          SELECT kodf_, dat_, kodp, SUM (znap)
          FROM RNBU_TRACE
          where substr(kodp,1,2) not in ('47','50','51','54','58','61','63','82','83','84') and
             not (mfou_ = 300465 and mfou_ <> mfo_ and kodp like '05%' and znap = '0')
          GROUP BY kodf_, dat_, kodp;
       end if;
    END IF;

   if mfou_ not in (300120, 300465) then
      otc_del_arch(kodf_, dat_, 0);
      OTC_SAVE_ARCH(kodf_, dat_, 0);
   end if;

   logger.info ('P_F42_NN: End ');
   commit;

--  dbms_profiler.flush_data;
--  dbms_profiler.stop_profiler;
END;
/
show err;

PROMPT *** Create  grants  P_F42_NN ***
grant EXECUTE                                                                on P_F42_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F42_NN        to RPBN002;
grant EXECUTE                                                                on P_F42_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F42_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
