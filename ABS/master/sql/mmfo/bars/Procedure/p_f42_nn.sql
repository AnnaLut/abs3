

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
% VERSION     :  05/05/2018 (03/05/2018)
%------------------------------------------------------------------------
% 02/03/2017 - для МФО=380388 (Платинум банк) изменил признак PR_BANK
%              со значения "T" (временнаяй адм.) на "Л" (ликвидация)
%              с даты 24.02.2017
% 15/02/2017 - для МФО=380388 (Платинум банк) изменил дату действия
%              временной адм. на 01.10.2017
%              для показателей 073-080 будем вічитать сумму резерва
% 20/01/2017 - из расчета суммы резерва по контрагенту (табл. OTC_C5_PROC)
%              исключаем бал.счет 3570
% 19/12/2016 - из расшифровки убрал 9129 с R013 <> '1'
% 29/11/2016 - убрал обработку поля RNKP (было для холдингов)
% 22/11/2016 - не будем включать контрагентов
%              которые превышают 25% от РК и которые будут включаться в
%              файл #8B (контрагенты для файла #8B классификатор KL_F8B)
% 18/11/2016 - показателя 01, 02 будyт формироваться по группе клиентов
%              (поле LINK_GROUP в табл. D8_CUST_LINK_GROUPS) добавлено
%              условие c.rnk = to_number(d.link_group) для банков нерез.
% 28/09/2016 - показателя 01, 02 будyт формироваться по группе клиентов
%              (поле LINK_GROUP в табл. D8_CUST_LINK_GROUPS)
% 30/08/2016 - показатель 01 будет формироваться по группе клиентов
%              (поле LINK_GROUP в табл. D8_CUST_LINK_GROUPS)
% 12/08/2016 - из показателей 01  и 02 удаляем контрагента 900923
%              (Министерство Финансов Украины)
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
   kodp1_      VARCHAR2 (10);
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
   nnnn00_    NUMBER         := 0;
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
   sum_kor_   number;
   cnt_       number;
   pr_f8b_    number;

   link_code_     d8_cust_link_groups.link_code%type;
   link_codepp_   d8_cust_link_groups.link_code%type;
   link_codep1_   d8_cust_link_groups.link_code%type;
   
   link_name_     d8_cust_link_groups.groupname%type;

   ---Остатки код 01, 02, 03, 04, 06
   CURSOR saldo  IS
   select ddd, rnk, link_code, link_name, prins, znap
   from (select '001' ddd,
                NVL(d.link_group, c.rnk) rnk,
                NVL(d.link_code, '000') link_code,
                NVL(d.groupname, c.nmk) link_name,
                DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1) prins,
                abs(sum(decode(substr(kodp, 1, 1), '1', -1, 1)*znap)) znap
        from otc_c5_proc o
        join customer c
        on (c.rnk = o.rnk)
        left outer join d8_cust_link_groups d       
        on (trim(c.okpo) = trim(d.okpo))
        where o.datf = dat_
        group by NVL(d.link_group, c.rnk), 
                 NVL(d.link_code, '000'), 
                 NVL(d.groupname, c.nmk), 
                 DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1)
        having sum(decode(substr(kodp, 1, 1), '1', -1, 1)*znap)<0)
            union all
    select ddd, rnk, link_code, link_name, prins, sum(znap) znap
    from (
        select a.ddd, a.rnk, a.link_code, a.link_name, a.prins, a.znap
        from (
           SELECT  a.ddd, NVL(d.link_group, c.rnk) rnk,
                   NVL(d.link_code, '000') link_code,
                   NVL(d.groupname, c.nmk) link_name,
                   DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1) prins,
                   NVL(ABS (SUM (a.ost_eqv)), 0) znap
           FROM OTCN_F42_TEMP a
           left outer join specparam p
           on (a.acc = p.acc)
           join CUSTOMER c
           on (a.rnk = c.rnk)
           left outer join d8_cust_link_groups d
           on (trim(c.okpo) = trim(d.okpo))
           WHERE a.ap=a.r012 AND
                 NOT exists (SELECT 1
                             FROM OTCN_F42_TEMP b
                             WHERE  b.ap=b.r012        AND
                                    b.nbs IS NULL      AND
                                    b.ACCC = a.acc )   AND
                 ( ((our_rnk_ = -1 or c.rnk <> our_rnk_) and mfo_ <> 344443) or
                            (c.rnk <> 0 and mfo_ = 344443) ) AND
                 (our_okpo_ = '0' or NVL(ltrim(c.okpo, '0'),'X') <> our_okpo_ or a.ddd='006' and (a.nls like '3%' or a.nls like '4%')) AND
                 (prnk_ IS NULL OR c.rnk = prnk_) and
                 a.ddd='006'
           GROUP BY a.ddd, 
                    NVL(d.link_group, c.rnk), 
                    NVL(d.link_code, '000'),
                    NVL(d.groupname, c.nmk),  
                    DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1)) a
    ) s
    group by  s.ddd, s.rnk, s.link_code, s.link_name, s.prins
    order by ddd, znap desc;
    -------------------------------------------------------------------------
---Остатки  код  "A0"
-- с 13.11.2015 (за 12.11.2015) будет формироваться код A0 б/с 9110
   CURSOR saldoost1 IS
   select b.acc, b.nbs, b.nls, b.kv, b.fdat, b.r013, b.rnk, b.ostq, nvl(c.ddd, '099')
   from (SELECT /*+ PARALLEL(8) */
                a.acc, a.nbs, a.nls, a.kv, a.FDAT, NVL (p.r013, '0') r013,
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
   from (SELECT /*+ PARALLEL(8) */
                a.acc, a.nbs, a.nls, a.kv, a.FDAT,
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
      FROM (SELECT /*+ PARALLEL(8) */
                   s.acc, s.rnk, s.nls, s.kv, s.FDAT, s.nbs,
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

   rgk_ := Rkapital (dat_next_u(dat_, 1), kodf_, userid_, 1); -- зм_на 27.12.2005 - при розрахунку норматив_в використовується нев_дкоригований кап_тал

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
              c.rnk rnk,
              SUM (a.ostq), 0
          FROM (SELECT /*+ PARALLEL(8) */
                       s.acc, s.nls, s.kv, s.FDAT, s.nbs, s.rnk,
                       decode(s.kv, 980, s.ost, s.ostq) ostq,
                       DECODE(SIGN(s.ost), -1, '11', '22') r050
                FROM OTCN_SALDO s
                WHERE s.ost <> 0) a,
                KL_F3_29 k, SPECPARAM p, CUSTOMER c
          WHERE a.rnk = c.rnk
            AND a.nbs = k.r020
            AND k.kf = '42'
            AND k.ddd IN  ('047', '051')
            AND a.acc = p.acc
            AND NVL (p.r013, '0') = k.r012
            AND k.r050 = a.r050
        AND (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp) = prnk_)
          GROUP BY a.acc, a.nls, a.kv, a.FDAT, k.ddd, NVL (p.r013, '0'), c.rnk;
        commit;

        insert into otcn_f42_zalog (ACC, ACCS, ND, NBS, R013, OST)
        SELECT /*+ PARALLEL(8) */
               z.acc, z.accs, z.nd, a.nbs, p.r013,
               gl.p_icurval (a.kv, a.ost, dat_) ost
          FROM cc_accp z, sal a, specparam p
         WHERE z.acc in (select acc from otcn_f42_temp where ap = 0)
           AND z.accs = a.acc
           and a.fdat = dat_
           AND a.acc = p.acc
           AND a.nbs || p.r013 <> '91299'
           and a.nbs not in (select r020 from otcn_fa7_temp)
           and a.ost < 0 ;
       commit;

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
                            c.rnk rnk
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
       FROM (SELECT /*+ PARALLEL(8) use_hash(s a)  */
                    s.acc, s.nls, s.kv, s.FDAT, s.nbs,
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

   commit;

   -- формирование кодов 01, 02, 03, 04
   OPEN saldo;

   LOOP
      FETCH saldo
       INTO ddd_, rnk_, link_code_, link_name_, insider_, se_;

      EXIT WHEN saldo%NOTFOUND;

      comm_ := (case when link_code_ = '000' then '' else link_name_ end);
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

         pr_f8b_ := 0;
         
         if link_code_ <> '000' then
             SELECT COUNT (*)
                INTO pr_f8b_
             FROM KL_F8B
             WHERE nvl(link_group, rnk) = rnk_;
         end if;
         
         if rnk_ = 90092301 then
            pr_f8b_ := 1;
         end if;

         IF se_ <> 0 AND f42_ = 0
         THEN
            if se_ <> 0 then
                nlsp_ := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
                znap_ := TO_CHAR (ABS (se_));
                s_zal_:= 0;

                if rnk_ <> 90092301 then
                   nnnn00_ := nnnn00_ + 1;
                end if;

                -- 22/11/2016 не будем включать контрагентов
                -- которые превышают 25% от РК и которые будут включаться в файл #8B
                -- (контрагенты для файла #8B классификатор KL_F8B)
                -- ниже добавлено условие "and pr_f8b_ = 0"
                IF insider_ <> 1 and ABS (se_) > ROUND (sum_k_ * k1_, 0) and
                   rgk_ >= 0 and s_prizn_=0
                THEN
                   if pr_f8b_ = 0 and link_code_ <> '000' then
                      insert into KL_F8B(DATF, LINK_GROUP, NMK, NNNN, OKPO, RNK)
                      select dat_, rnk_, max(groupname), LPAD (nnnn00_, 4, '0'), max(okpo), rnk_
                      from d8_cust_link_groups
                      where link_group = rnk_ and link_code = link_code_;

                      if sql%rowcount = 0 then
                         insert into KL_F8B(DATF, LINK_GROUP, NMK, NNNN, OKPO, RNK)
                         select dat_, null, nmk, LPAD (nnnn00_, 4, '0'), okpo, rnk
                         from customer
                         where rnk = rnk_;
                      end if;

                      pr_f8b_ := 1;
                   end if;

                   if pr_f8b_ = 0 then
                      nnnn01_ := nnnn01_ + 1;
                      if dat_ < dat_Zm4_ then
                         kodp_ := '01' || LPAD (nnnn01_, 4, '0');
                      else
                         kodp_ := '01' || LPAD (nnnn01_, 4, '0') || '000';
                      end if;

                      INSERT INTO RNBU_TRACE
                                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                                  )
                           VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_, comm_
                                  );

                      -- рассчитаем 47 показатель
                      begin
                         select nvl(sum(to_number(znap)), 0)
                         into p47_
                         from rnbu_trace
                         where kodp like '47%' and
                               rnk in ( select c.rnk
                                        from d8_cust_link_groups d, customer c
                                        where trim(d.okpo) = trim(c.okpo)
                                          and d.link_group = rnk_
                                          and d.link_code = link_code_
                                        union
                                        select c.rnk
                                        from customer c
                                        where trim(c.okpo) not in ( select trim(d.okpo)
                                                                    from d8_cust_link_groups d
                                                                  )
                                          and c.rnk = rnk_
                                      );
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
                               rnk in ( select c.rnk
                                        from d8_cust_link_groups d, customer c
                                        where trim(d.okpo) = trim(c.okpo)
                                          and d.link_group = rnk_
                                          and d.link_code = link_code_
                                        union
                                        select c.rnk
                                        from customer c
                                        where trim(c.okpo) not in ( select trim(d.okpo)
                                                                    from d8_cust_link_groups d
                                                                  )
                                          and c.rnk = rnk_
                                      );
                      exception
                         when no_data_found then
                            p51_ := 0;
                      end;

                      IF p47_ <> 0 OR p51_ <> 0 THEN
                         s_zal_ := p47_ + p51_;

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
                                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm)
                           VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), null, rnk_, link_code_, comm_);
                      END IF;

                      flag_inc_ := TRUE;
                   else
                      flag_inc_ := null;
                   end if;
                ELSE
                   flag_inc_ := FALSE;
                END IF;

                -- поиск максимальной суммы среди тех, которые не удовлетв. условию ABS(se_)>ROUND(sum_k_*0.25,0)
                IF insider_ <> 1 and NOT flag_inc_ AND (ABS (se_) >= sp_ or ABS (se_) >= sp1_) and se_ <> 0
                THEN
                  -- рассчитаем 47 показатель
                  begin
                     select nvl(sum(to_number(znap)), 0)
                      into p47_
                     from rnbu_trace
                     where kodp like '47%' and
                           rnk in ( select c.rnk
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo)
                                      and d.link_group = rnk_
                                      and d.link_code = link_code_
                                    union
                                    select c.rnk
                                    from customer c
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_
                                  );
                           --rnk = rnk_;
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
                           rnk in ( select c.rnk
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo)
                                      and d.link_group = rnk_
                                      and d.link_code = link_code_
                                    union
                                    select c.rnk
                                    from customer c
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_
                                  );
                           --rnk = rnk_;
                  exception
                     when no_data_found then
                        p51_ := 0;
                  end;

                  IF p47_ <> 0 OR p51_ <> 0 THEN
                     s_zal_ := p47_ + p51_;

                     IF s_zal_ > ABS (se_) THEN
                        s_zal_ := ABS (se_);
                     END IF;
                  else
                      s_zal_ := 0;
                  END IF;

                  if s_zal_ <> 0 and ABS (se_) >= sp_ then
                     znapp_ := znap_;
                     nlspp_ := nlsp_;
                     comm_pp_ := comm_;
                     rnkp_  := rnk_;
                     link_codepp_ := link_code_;
                     s_zalp_:= s_zal_;
                     sp_ := ABS (se_);
                  elsif s_zal_ = 0 and ABS (se_) >= sp1_ then
                    -- нет суммы обеспечения
                    -- поиск максимальной суммы среди тех, которые не удовлетв. условию ABS(se_)>ROUND(sum_k_*0.25,0)
                      znapp1_ := znap_;
                      nlspp1_ := nlsp_;
                      comm_pp1_ := comm_;
                      rnkp1_  := rnk_;
                      link_codep1_ := link_code_;
                      sp1_ := ABS (se_);
                  end if;
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
                           rnk in ( select c.rnk
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo)
                                      and d.link_group = rnk_
                                      and d.link_code = link_code_
                                    union
                                    select c.rnk
                                    from customer c
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_
                                  );
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
                           rnk in ( select c.rnk
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo)
                                      and d.link_group = rnk_
                                      and d.link_code = link_code_
                                    union
                                    select c.rnk
                                    from customer c
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_
                                  );
                     exception
                        when no_data_found then
                           p51_ := 0;
                     end;

                     IF p47_ <> 0 OR p51_ <> 0 THEN
                        s_zal_ := p47_ + p51_;

                        IF s_zal_ > ABS (se_) THEN
                           s_zal_ := ABS (se_);
                        END IF;
                     END IF;
                  END IF;

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                              )
                       VALUES (nlsp_, 0, dat_, kodp_, to_char(ABS (se_) - s_zal_), rnk_, rnk_, link_code_, comm_
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
                                 (nls, kv, odate, kodp, znap, rnk, ref, nbuc
                                 )
                          VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_
                                 );
                   END IF;
                END IF;

                IF insider_ = 1
                THEN
                   nlsp_ := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
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
                               (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm )
                   VALUES (nlsp_, 0, dat_, kodp_, to_char(ABS (se_) - s_zal_), rnk_, rnk_, link_code_, comm_);

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
                                     (nls, kv, odate, kodp, znap, rnk, ref, nbuc
                                     )
                              VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_
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
                                     (nls, kv, odate, kodp, znap, rnk, ref, nbuc)
                              VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), rnk_, rnk_, link_code_);
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
                                        (nls, kv, odate, kodp, znap, rnk, ref, nbuc) VALUES
                                        (nlsp_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_);
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
                               c.rnk = rnk_  AND
                               a.ddd=ddd_    AND
                               a.acc=o.acc   AND
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
                                   (nls, kv, odate, kodp, znap, rnk, ref, nbuc )
                               VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_ );
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
                                (nls, kv, odate, kodp, znap, rnk, ref, nbuc )
                            VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_, rnk_, link_code_ );
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
                                (nls, kv, odate, kodp, znap, rnk, ref, nbuc )
                            VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_, rnk_, link_code_ );
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
               END IF;
            end if;
         END IF;
      ELSE
         IF se_ <> 0
         THEN
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
                  nlsu_ := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
                  znap_ := TO_CHAR (abs(se_));

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk, ref, nbuc
                              )
                       VALUES (nlsu_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_
                              );

                  spp_72 := se_;
               END IF;

               IF ABS (se_) < ROUND (sum_SK_ * 0.15, 0) AND ABS (se_) >= spp_72
               THEN
                  znapu_72 := TO_CHAR (abs(se_));
                  nlsu_72 := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
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
                     (nls, kv, odate, kodp, znap, rnk, ref
                     )
              VALUES (nlsi_, 0, dat_, kodpi_, znapi_, rnki_, rnki_
                     );

         IF Dat_ >= to_date('31012014','ddmmyyyy') and s_zali_ >= 0
         THEN
            kodpi_ := '94' || LPAD (TO_CHAR (nnnn1_ + 1), 4, '0');

            INSERT INTO RNBU_TRACE
                     (nls, kv, odate, kodp, znap, rnk, ref
                     )
              VALUES (nlsi_, 0, dat_, kodpi_, to_char(s_zali_), rnki_, rnki_
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
                  (nls, kv, odate, kodp, znap, rnk, ref
                  )
           VALUES (nlsi1_, 0, dat_, kodpi_, znapi1_, rnki1_, rnki1_
                  );

         kodpi_ := '94' || LPAD (TO_CHAR (nnnn1_ + 2), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, ref
                  )
           VALUES (nlsi1_, 0, dat_, kodpi_, '0', rnki1_, rnki1_
                  );
      END IF;
   END IF;

   IF TO_NUMBER (znapp_) > 0
   THEN
      kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0');

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                  )
           VALUES (nlspp_, 0, dat_, kodpp_, znapp_, rnkp_, rnkp_, link_codepp_, comm_pp_
                  );
                  
    --- 03.11.2008 - по замечанию Петрокомерца не нужно формировать показатель 05 для максимального заемщика,
    --- который меньше 25%

      IF s_zalp_ >= 0 THEN
         kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                  )
           VALUES (nlspp_, 0, dat_, kodpp_, to_char(s_zalp_), null, rnkp_, link_codepp_, comm_pp_
                  );
      END IF;

   END IF;

   --- 25.06.2011 - по замечанию Петрокомерца формируем показатель 01 для максимального заемщика,
   --- который меньше 25% и нет обеспечения
   IF TO_NUMBER (znapp1_) > 0
   THEN
      kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0');

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                  )
           VALUES (nlspp1_, 0, dat_, kodpp_, znapp1_, rnkp1_, rnkp1_, link_codep1_, comm_pp1_
                  );

         kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                  )
           VALUES (nlspp1_, 0, dat_, kodpp_, '0', null, rnkp1_, link_codep1_, comm_pp1_
                  );
   END IF;

   IF TO_NUMBER (znapu_72) > 0
   THEN
      kodpp_ := '720001';

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, ref
                  )
           VALUES (nlsu_72, 0, dat_, kodpp_, znapu_72, rnku_72, rnku_72
                  );
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
                            (nls, kv, odate, kodp, znap, rnk, ref, acc
                            )
                     VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, rnk_, acc_
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

          comm_ := '';
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
             elsif mfo_ = 380388 and dat_ <= to_date('01102017','ddmmyyyy')
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

          if mfo_ = 380388 and Dat_ >= to_date('24022017','ddmmyyyy')
          then
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

                select NVL(sum(znap), 0)
                   into sum_proc_
                from otc_c5_proc
                where datf = dat_
                  and kodp like '2159%'
                  and acc = acc_ ;

                comm_ := comm_ || ' PROC = '||  to_char(sum_proc_) ;

                if dat_ < dat_Zm4_ then
                   kodp_ := SUBSTR (ddd_, 2, 2) || '0000';
                else
                   kodp_ := SUBSTR (ddd_, 2, 2) || '0000' || '000';
                end if;
                znap_ := TO_CHAR (ABS (se_ + sum_proc_));

                INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk, ref, acc, comm
                            )
                     VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, rnk_, acc_, comm_
                            );
             END IF;
          end if;
       END LOOP;

       CLOSE saldoost7;

      -- формирование кодов 870000, 880000, 890000, 900000, 910000
      if dat_ >=to_date('01072012','ddmmyyyy') then
         pul_dat(to_char(Dat_,'dd-mm-yyyy'), '');

         -- проверка на наличие VIEW CP_V_ZAL_ACC
         if f_obj_exists('BARS', 'CP_V_ZAL_ACC', 'VIEW') = 1 then

            EXECUTE IMMEDIATE 'delete from otcn_f42_cp';

            sql_ :=
                'insert into otcn_f42_cp (fdat, acc, nls, kv, sum_zal, dat_zal, rnk, kodp) '
              ||'select c.fdat, a.acc, a.nls, a.kv, nvl(c.sum_zal, 0), c.dat_zal, a.rnk, null '
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
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, ref, acc)
                         VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.rnk, k.rnk, k.acc);
                      end if;

                      if ( (substr(k.nls,1,4) in ('1412','1413','1414',
                                               '1422','1423','1424')) or
                           (substr(k.nls,1,4) in ('1415','1416','1417','1426','1427') and r013_ in ('3','9'))
                         )
                         and s240_ <= '5'
                         and k.kodp is null
                      then
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, ref, acc)
                         VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.rnk, k.rnk, k.acc);
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
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, ref, acc)
                         VALUES (k.nls, k.kv, dat_, kodp_, znap_, k.rnk, k.rnk, k.acc);
                      end if;

                      if k.kodp is not null then
                         insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, ref, acc)
                         VALUES (k.nls, k.kv, dat_, k.kodp, znap_, k.rnk, k.rnk, k.acc);
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
    delete from rnbu_trace
    where (kodp like '01%' or kodp like '02%' or kodp like '61%')
      and rnk = 90092301;

    nnnn01_ := 0;
    rnk_ := 0;
    ddd_ := '00';

    for k in (select kodp, rnk, trim(comm) comm
              from rnbu_trace
              where substr(kodp,1,2) not in ('R1', 'R2')
              order by substr(kodp,1,2), to_number(znap) DESC, rnk )
    loop
        -- в поле COMM (комментарий) заполняем название клиента
        update rnbu_trace 
        set comm = substr((case when nvl(nbuc, '000') = '000' 
                                then (select c.nmk 
                                      from customer c
                                      where c.rnk = k.rnk)||' '
                                else ''
                           end) || k.comm,1,255)
        where rnk = k.rnk and kodp = k.kodp;

        if ddd_ = '00' OR ddd_ <> substr(k.kodp,1,2) OR rnk_ = 0 OR rnk_ <> k.rnk
        then
           if substr(k.kodp,1,2) = '01' then
              nnnn01_ := nnnn01_ + 1;
              
              if Dat_ < dat_Zm4_ then
                 update rnbu_trace set
                    kodp = substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn01_), 4, '0')
                 where rnk = k.rnk and kodp = k.kodp;
              else
                 update rnbu_trace set
                    kodp = substr(k.kodp,1,2) || LPAD (TO_CHAR (nnnn01_), 4, '0') || '000'
                 where rnk = k.rnk and kodp = k.kodp;
              end if;
           else
              if substr(k.kodp,3,4) <> '0000' then
                 BEGIN
                    select to_number(substr(kodp,3,4)) into nnnn1_
                    from rnbu_trace
                    where rnk = k.rnk and
                    substr(kodp,1,2) in ('01','03') and
                    substr(kodp,1,2) <> substr(k.kodp,1,2) and
                    rownum = 1 ;
                    
                    if type_ <> 0 then
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
                       kodp = substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn1_), 4, '0') || '000'
                    where rnk = k.rnk and kodp = k.kodp;
                 end if;
              end if;
           end if;

           rnk_ := k.rnk;
           ddd_ := substr(k.kodp,1,2);
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

       if Dat_ <=to_date('03012013','ddmmyyyy') then
          INSERT INTO TMP_NBU (kodf, datf, kodp, znap)
          SELECT kodf_, dat_, kodp, SUM (znap)
          FROM RNBU_TRACE
          GROUP BY kodf_, dat_, kodp;
       else
          INSERT INTO TMP_NBU (kodf, datf, kodp, znap)
          SELECT kodf_, dat_, kodp, SUM (znap)
          FROM RNBU_TRACE
          where substr(kodp,1,2) not in ('47','50','51','54','58','61','63','82','83','84','11') and
             not (mfou_ = 300465 and mfou_ <> mfo_ and kodp like '05%' and znap = '0')
          GROUP BY kodf_, dat_, kodp;
       end if;
    END IF;

   if mfou_ not in (300120, 300465) then
      otc_del_arch(kodf_, dat_, 0);
      OTC_SAVE_ARCH(kodf_, dat_, 0);
   end if;

   -- детальная расшифровка показателей 01 и 02 в разрезе лицевых счетов
   -- остатки по счетам и резерв
   insert into rnbu_trace (odate, nls, kv, kodp, znap, rnk, nbuc, nd, ref, acc, comm)
    select /*+ leading(o) */
         dat_ odate, o.nls, o.kv, b.kodp,
         decode(substr(o.kodp,1,1),'1', -1, 1) * o.znap znap,
         o.rnk, nvl(d.link_code, '000'), o.nd, b.group_num ref, o.acc, 
         (case when (substr(o.kodp,2,4) like '___9' or
                     substr(o.kodp,2,4) in ('1890','2890','3590','3690','3692')) and
                     substr(o.kodp,1,1) = '2'
                then '(резерв чи SNA з файлу #C5) '
               else '(залишок з файлу #C5) '
          end) || substr(o.kodp,2,4) ||
          ' / R011=' || substr(o.kodp,6,1) ||
          ' / R013=' || substr(o.kodp,7,1) ||
          ' / S245=' || substr(o.kodp,16,1) comm
    from otc_c5_proc o
    join customer c
    on (o.rnk = c.rnk)
    left outer join d8_cust_link_groups d
    on (trim(c.okpo) = trim(d.okpo))
    join (select distinct k.rnk, k.nbuc link_code,
                        (case when k.kodp like '01%' then 'R1'
                             when k.kodp like '02%' then 'R2'
                             else 'R4'
                        end)||substr(k.kodp,3) kodp,
                        k.ref group_num
        from rnbu_trace k
        where (kodp like '01%' or kodp like '02%' or kodp like '04%')
        order by substr(kodp,3,4), rnk, k.nbuc) b
    on (NVL(d.link_group, c.rnk) = b.rnk and
        NVL(d.link_code, '000') = b.link_code)
    where o.datf = dat_;

   delete  from rnbu_trace where kodp like '01%' or kodp like '02%' or kodp like '04%';

   update rnbu_trace
   set kodp = replace(kodp, 'R', '0')
   where kodp like 'R1%' or kodp like 'R2%' or kodp like 'R4%';

   logger.info ('P_F42_NN: End ');
   commit;
END;
/
show err;

PROMPT *** Create  grants  P_F42_NN ***
grant EXECUTE                                                                on P_F42_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F42_NN        to RPBN002;
grant EXECUTE                                                                on P_F42_NN        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F42_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
/