CREATE OR REPLACE PROCEDURE BARS.P_FC5 (dat_ DATE, pnd_ NUMBER DEFAULT NULL)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #С5 для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     : v.17.025  17/04/2018 (16/04/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата

   Структура показателя     D BBBB Z P VVV Й Q WWW E K

  1    D          1/2  (остаток ДТ/КТ)
  2    BBBB       R020 балансовый счет
  6    Z          распределение в разрезе R011
  7    P          распределение в разрезе R013
  8    VVV        R030 код валюты
 11    Й          S580 распределение по группе риска
 12    Q          R017 код индексации финансовых инструментов
 13    WWW        R030 код валюты индексации
 16    E          S245 код строку погашення
 17    K          K077 код сектору економiки

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 26.12.2017 изменение структуры показателей с отчета за 26.12.2017
 19.12.2017 исключение из основнго скрипта новых счетов резервов
 28.07.2017 отдельное определение r012 для счетов 1592
 28.03.2017 ограничение на количество параллельных процессов
 17.03.2017 снята отдельная разбивка в разрезе S580 для счетов резервов
               (было s580=9 для первой категории качества)
 21.02.2017 расширен список счетов, для которых определяется S580 в P_Set_S580_Def
            исключение задвоения для 3541 (есть основные и дочерние счета)
 31.01.2017 второй блок резервов -оптимизация для счетов просроченных процентов
 21.09.2016 -в ограничения по счетам добавлены 2657
 19.09.2016 -резервы по счетам просроченных процентов обрабатываются
             во втором блоке резервов (как в #A7)
 12.09.2016 -для счетов просрочки по телу r012=B при обработке данных из tmp_rez_risk
 02.09.2016 -для бал.счетов с отсутсвующим либо закрытым r013 в kl_r013
             параметр r013 устанавливается в '0'
 31.08.2016 - изменение структуры показателей с отчета за 01.09.2016
 29.07.2016 - перераспределение R013 при превышении резерва над текущим
              остатком для проц.счетов ЦБ
 21/07/2016 - для счетов резерва параметр R013 будет определяться по
              R013 активов (счета начисленных процентов до 30, больше 30)
 02/07/2016 - для таблиц OPLDOK добавил условие o.fdat = z.fdat
              для уменьшения времени формирования
              для валюты 974 (белоруские рубли) из V_TMP_REZ_RISK_C5
              изменяем на значение 933
 14/06/2016 - для счетов резервов под непросроченные проценты будет
              разбивка по параметру  R012 на 'A' и "B'
 10/06/2016 - для счетов резервов под непросроченные проценты формируем
              параметр R012 = 'A'
 17/05/2016 - ГРЦ Ощадбанка. Макаренко И.В.
              в самом конце процедуры проверка на академическое время вызова процедуры,
              если вызывается после 19:00 (технологи закрывают/открывают день) -
              ничего не писать в архив, если в операционное время - технологи выполняют
              формирование файла - в архив фиксируем запись
 15/10/2014 - для блока "списання за рахунок резерву" добавлено умову
              and x.nls not like '3800%' тому що при перенесенні суми
              з одного рахунку 2400 на інший і потім погашення з іншого
              не включались суми погашення
 20/11/2013 - суттєва аоптимізація
 23/09/2013 - не враховуволось погашення за рахунок резерву на 3599
 11/09/2013 - доопрацювання по r012 для дисконтів
 20/08/2013 - доопрацювання по S580 (додала перевірку інвесттиц. класу для всіх)
 15/08/2013 - виправила помилку по 1528 (зауваження від ПКБ) при роботі з INT_ACCN
 14/08/2013 - з ГОУ надійшло зауваження, що не виконується розбивка по R013
              для рахунків 1408, 1418, 1428
 13/08/2013 - виключила рахунок 2924 3 формування показників по резерву (ГОУ)
 22/07/2013 - для курсора SALDO_CP добавив параметр S580 iз SPECPARAM
              (зауваження ГОУ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      Varchar2(2) := 'C5';
   sheme_     Varchar2(1) := 'G';
   acc_       NUMBER;
   nbs_       VARCHAR2 (4);
   nbs1_      VARCHAR2 (4);
   nls_       VARCHAR2 (15);
   daos_      DATE;
   datp_      DATE;
   data_      DATE;
   mdate_     DATE;
   kv_        SMALLINT;
   sn_        DECIMAL (24);
   se_        DECIMAL (24);
   se1_       DECIMAL (24);
   dk_        CHAR (1);
   kodp_      VARCHAR2 (20);
   znap_      VARCHAR2 (30);

   r011_      VARCHAR2 (1);
   r013_      VARCHAR2 (1);
   r013_30    NUMBER;
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
   nd_        NUMBER;
   nd1_       NUMBER;
   nd2_       NUMBER;
   nd3_       NUMBER;
   nd4_       NUMBER;
   -- Макаренко И.В.
   CurrDate   DATE;
   Checkdate  DATE;

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

   caldt_ID_  NUMBER;

   typ_       NUMBER;
   nbuc1_     VARCHAR2 (20);
   nbuc_      VARCHAR2 (20);
   t020_      VARCHAR2 (1);

   dathb_   date;
   dathe_   date;
   s240_    varchar2(1);

   TYPE ref_type_curs IS REF CURSOR;

   saldo        ref_type_curs;
   cursor_sql   varchar2(20000);

   type rec_type is record
        (acc_   number,
         nls_   varchar2(15),
         kv_    integer,
         daos_  date,
         data_  date,
         nbs_   char(4),
         r011_  varchar2(1),
         r013_  varchar2(1),
         s080_  varchar2(1),
         se_    number,
         sn_    number,
         rnk_   number,
         isp_   accounts.isp%TYPE,
         mdate_ date,
         tips_  accounts.tip%TYPE,
         tobo_  accounts.tobo%TYPE,
         nms_   accounts.nms%TYPE,
         r012_  varchar2(1),
         s580_  varchar2(1),
         t020_  varchar2(1),
         s240_  varchar2(1),
         nd1_   number,
         nd2_   number,
         nd3_   number,
         nd4_   number,
         nd_    number,
         fa7p_  number,
         freq_  number,
         k077_  varchar2(1) );

   TYPE rec_t IS TABLE OF rec_type;
   l_rec_t      rec_t := rec_t();

   TYPE rnbu_trace_t IS TABLE OF rnbu_trace%rowtype;
   l_rnbu_trace rnbu_trace_t := rnbu_trace_t();

   TYPE     t_otcn IS TABLE OF NUMBER(1) INDEX BY VARCHAR2(4);
   table_R011    t_otcn;
   table_R013    t_otcn;

   datz_        date := Dat_Next_U(dat_, 1);

   sql_acc_     clob;

   ret_         number;
   in_acc_      varchar2(255);

   r012_        specparam.r012%type;
   s580_        specparam.s580%type;
   s580a_       specparam.s580%type;
   s580r_       specparam.s580%type;
   s245_        varchar2(1);
   k077_        varchar2(1);
   r017_        varchar2(1);          --segment   Q
   segm_WWW     varchar2(3);

   dat_zmin1    date         := to_date('20022008', 'ddmmyyyy');
   dat_zmin2    date         := to_date('03012013', 'ddmmyyyy');
   dat_zmin3    date         := to_date('01092016', 'ddmmyyyy');
   dat_zmin4    date         := to_date('26122017', 'ddmmyyyy');

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
   datb_    date;
   sum_     number;
   sumc_    number := 0;
   srez_    number := 0;
   srezp_   number := 0;
   sakt_    number := 0;
   r030_    varchar2(3);
   nbs_r013_    varchar2(5);

   cnt_     number;
   TP_SND   BOOLEAN := false;
   pr_accc  number;
   dati_    integer := null;
   freq_    number;
   fl_cp_   number:=0;

   sum_zal  number:=0;

   sum_z0   number:=0;
   sum_z1   number:=0;
   sum_z2   number:=0;

   koef_z0   number:=1;
   koef_z1   number:=1;
   koef_z2   number:=1;

   sum_se0   number:=0;
   sum_sel   number:=0;
   sum_se2   number:=0;

   dc_   number;

   dat_beg_ date;
   dat_end_ date;

   datd_    date;

    procedure P_Set_S580_Def(r020_ in varchar2, t020_ in varchar2, r011_ in varchar2, s245_ in varchar2) is
       invk_ varchar2(1);
    begin
       if s580_ = '0' or r020_ in ('2233', '2238', '2625', '3114', '3570') then
           select nvl(max(s580), '9')
           into s580r_
           from nbur_ref_risk_s580
           where r020 = r020_ and
                (t020 = t020_ or t020 = '*') and
                (r011 = r011_ or r011 = '*') and
                (S245 = s245_ or S245 = '*');

           s580_ := s580r_;
       end if;

       if r020_ in ('2066', '2920', '3400', '3408', '3500', '3508', '4410', '9129') and s580_ = '9' then
          s580_ := '5';
       end if;
       
       if r020_ = '9200' and t020_ = '1' then
          s580_ := (case when r013_ in ('3', '8', 'A') then '1'
                         when r013_ in ('4') then '3'
                         when r013_ in ('5', '6') then '4'
                         else '9'
                    end); 
       end if;
       
       if (r020_ in ('9201','9202','9204') or
           r020_ between '9206' and '9208' or
           r020_ between '9350' and '9359') and
           t020_ = '1'
       then
          if r020_ <> '9355' and r013_ = '1' then
              s580_ := '1';
          elsif r013_ = '2' then
              s580_ := '4'; 
          else
              s580_ := '9'; 
          end if;
       end if;
       
       if r020_ = '9300' and t020_ = '1' then
          s580_ := (case when r013_ in ('3') then '1'
                         when r013_ in ('1', '2') then '5'
                         else '9'
                    end); 
       end if;       
       
       if r020_ in ('2602','2622','9030','9031','9036','9500') and
          r020_ || r013_ not in ('26021','26221','90301','90311','90361','95001','95003')   
       then
          s580_ := '9'; 
       end if; 

--       if r020_ in ('1500','1502','1508','1509',
--                    '1510','1512','1513','1515','1516','1517','1518','1519',
--                    '1520','1521','1523','1524','1525','1526','1528')
--       then
--           begin
--             select nvl(trim(VALUE), '2')
--             into invk_
--             from customerw
--             where rnk = rnk_ and
--                   tag = 'INVCL';
--           exception
--                when no_data_found then
--                    invk_:= null;
--           end;
--       else
--           invk_:= null;
--       end if;
--
--       invk_:= nvl(invk_, '2');
    end;

    procedure p_add_rec(p_recid rnbu_trace.recid%type, p_userid rnbu_trace.userid%type, p_nls rnbu_trace.nls%type,
                        p_kv rnbu_trace.kv%type, p_odate rnbu_trace.odate%type, p_kodp rnbu_trace.kodp%type,
                        p_znap rnbu_trace.znap%type, p_rnk rnbu_trace.rnk%type, p_isp rnbu_trace.isp%type,
                        p_comm rnbu_trace.comm%type, p_nd rnbu_trace.nd%type, p_acc rnbu_trace.acc%type,
                        p_mdate rnbu_trace.mdate%type, p_nbuc rnbu_trace.nbuc%type, p_tobo rnbu_trace.tobo%type)
    is
        lr_rnbu_trace rnbu_trace%rowtype;
    begin
       lr_rnbu_trace.RECID := p_recid;
       lr_rnbu_trace.USERID := p_userid;
       lr_rnbu_trace.NLS := p_nls;
       lr_rnbu_trace.KV := p_kv;
       lr_rnbu_trace.ODATE := p_odate;
       lr_rnbu_trace.KODP := p_kodp;
       lr_rnbu_trace.ZNAP := p_znap;
       lr_rnbu_trace.NBUC := p_nbuc;
       lr_rnbu_trace.ISP := p_isp;
       lr_rnbu_trace.RNK := p_rnk;
       lr_rnbu_trace.ACC := p_acc;
       lr_rnbu_trace.REF := null;
       lr_rnbu_trace.COMM := p_comm;
       lr_rnbu_trace.ND := p_nd;
       lr_rnbu_trace.MDATE := p_mdate;
       lr_rnbu_trace.TOBO := p_tobo;

       l_rnbu_trace.Extend;
       l_rnbu_trace(l_rnbu_trace.last) := lr_rnbu_trace;

       if l_rnbu_trace.COUNT >= 10000 then
          FORALL i IN 1 .. l_rnbu_trace.COUNT
               insert /*+ append */ into rnbu_trace values l_rnbu_trace(i);

          l_rnbu_trace.delete;
       end if;
    end;
BEGIN
   commit;

  -- фактическая дата конца декады
   dc_ := TO_NUMBER (LTRIM (TO_CHAR (dat_, 'DD'), '0'));

   FOR i IN 1 .. 3
   LOOP
     IF dc_ BETWEEN 10 * (i - 1) + 1 AND 10 * i + iif (i, 3, 0, 1, 0)
     THEN
       IF i < 3
       THEN
          dat_beg_ := TO_DATE (LPAD (10 * (i - 1) + 1, 2, '0')
                      || TO_CHAR (dat_, 'mmyyyy'),
                      'ddmmyyyy'
                     );
          dat_end_ :=
             TO_DATE (LPAD (10 * i, 2, '0')
                      || TO_CHAR (dat_, 'mmyyyy'),
                      'ddmmyyyy'
                     );
       ELSE
          dat_beg_ := to_date('21'|| TO_CHAR (dat_, 'mmyyyy'), 'ddmmyyyy');
          dat_end_ := LAST_DAY (dat_);
       END IF;

       EXIT;
     END IF;
   END LOOP;

   select max(fdat)
   into dat_end_
   from fdat
   where fdat<=dat_end_;

   if dat_ = dat_end_ then
      datd_ := dat_;
   else
       select max(report_date)
       into datd_
       from NBUR_TMP_A7_S245
       where report_date < dat_beg_;
   end if;

   select count(*)
   into cnt_
   from NBUR_TMP_A7_S245
   where report_date = datd_;

   if cnt_ = 0 then
      p_fa7_nn(datd_);
      commit;
   end if;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_FC5: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_fa7_temp';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ1';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ2';

   EXECUTE IMMEDIATE 'truncate table otcn_f42_zalog';

   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';

   EXECUTE IMMEDIATE 'truncate table OTC_REF_AKT';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_KOD_R020';

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

   INSERT /*+ append */
   INTO otcn_fa7_temp
      SELECT r020
        FROM kl_r020
       WHERE trim(prem) = 'КБ'
         AND (   LOWER (txt) LIKE '%нарах%доход%'
              OR LOWER (txt) LIKE '%нарах%витр%' )
         and not lower(txt) like '%прострочен%'
         and trim(pr) is null
         AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
         and (d_close is null or
              d_close >= datz_);

   -- определение кода области для выбранного файла и схемы
   P_Proc_Set (kodf_, sheme_, nbuc1_, typ_);

-------------------------------------------------------------------
   declare
      cnt_ number;
   begin
       select count(*)
       into cnt_
       from holiday
       where holiday = dat_;

       dathb_ := null;
       dathe_ := null;

       if cnt_ > 0 then
          select max(fdat) + 1
          into dathb_
          from fdat
          where fdat < dat_;

          select min(fdat) - 1
          into dathe_
          from fdat
          where fdat > dat_;
       else
          select max(fdat) + 1
          into dathe_
          from fdat
          where fdat < dat_;

          if dat_ <> dathe_ then
             dathb_ := dathe_;

             select max(holiday)
             into dathe_
             from holiday
             where holiday < dat_;
          else
             dathb_ := null;
             dathe_ := null;
          end if;
       end if;
   end;

   -- дата розрахунку резервiв
   select  max(dat)
   into datb_
   from rez_protocol
   where dat_bank is not null and
         dat_bank <= dat_ and
         dat <= dat_  ;

   if datb_ is null then
      datr_ := add_months(last_day(dat_)+1,-1);
   else
      datr_ := last_day(datb_) + 1;
   end if;

   select max(dat_bank)
   into datp_
   from rez_protocol
   where dat = datb_ and
         dat <= dat_;

   datp_ := datp_ + 1;

   insert /*+ append */
   into TMP_KOD_R020
   SELECT r020
      FROM kod_r020
     WHERE a010 = 'C5'
       AND trim(prem) = 'КБ'
       AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
       and (d_close is null or
            d_close > datz_);

-- действующие R011 в рабочую таблицу

   for k in ( select distinct r020 pok
                from kl_r011
               where trim(prem)='КБ'
                 and d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
                 and (   d_close is null
                      or d_close >= datz_) )
   loop
       table_r011(k.pok) := 1;
   end loop;

-- действующие R013 в рабочую таблицу

   for k in ( select distinct r020 pok
                from kl_r013
               where trim(prem)='КБ'
                 and d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
                 and (   d_close is null
                      or d_close >= datz_) )
   loop
       table_r013(k.pok) := 1;
   end loop;

-------------------------------------------------------------------
   if mfo_ = 300465 then
         pul_dat(to_char(Dat_,'dd-mm-yyyy'), '');

         EXECUTE IMMEDIATE 'delete from otcn_f42_cp';

         sql_acc_ :=
                'insert into otcn_f42_cp (fdat, acc, nls, kv, sum_zal, dat_zal, rnk, kodp) '
              ||'select c.fdat, a.acc, a.nls, a.kv, nvl(c.sum_zal, 0), c.dat_zal, a.rnk, null '
              ||'from accounts a, cp_v_zal_acc c '
              ||'where a.acc = c.acc '
              ||'  and c.fdat = :dat_ '
              ||'  and substr(a.nls,1,4) like ''14__%''' ;

            EXECUTE IMMEDIATE sql_acc_ USING dat_;
   end if;
-------------------------------------------------------------------

   if pnd_ is null then
      sql_acc_ := ' SELECT   *
                    FROM ACCOUNTS a
                    where nvl(nbs, substr(nls,1,4))
                            in (select b.r020 from TMP_KOD_R020 b) ';
   else
      sql_acc_ := ' SELECT *
                    FROM ACCOUNTS a
                    where (acc in (select acc from nd_acc where nd = '||to_char(pnd_)|| ' ) or nbs like ''9500%'') and
                           nvl(nbs, substr(nls,1,4))
                            in (select b.r020 from TMP_KOD_R020 b)) ';
   end if;

   ret_ := F_POP_OTCN( dat_, 1, sql_acc_, null, 0, 1);

   cursor_sql := 'select a.*, n.nd nd1, null nd2, null nd3, null nd4, n.nd nd,
                         decode(t.r020, null, 0, 1) fa7p, i.freq,
                         decode(k.k077,null,decode(substr(a.nbs,1,1),''1'',''1'',''3''),k.k077) k077
                    from (SELECT    /*+ parallel(8) */
                                   a.acc, a.nls, a.kv, a.daos, :dat_, a.nbs,
                                   NVL(trim(cc.r011), ''0'') r011,
                                   NVL(trim(cc.r013), ''0'') r013, NVL (cc.s080, ''1'') s080,
                                   decode(a.kv, 980, s.ost, s.ostq) ostq, s.ost, a.rnk,
                                   a.isp, a.mdate, a.tip, a.tobo, a.nms,
                                   nvl(cc.r012, ''0'') r012, nvl(trim(cc.s580), ''0'') s580,
                                   decode(sign(s.ost),-1,''1'', ''2'') t020,
                                   nvl(trim(cc.s240),''0'') s240
                          FROM otcn_saldo s, otcn_acc a, specparam cc
                          WHERE s.ost <> 0 and
                                s.acc = a.acc and
                                s.acc = cc.acc(+) and
                                a.tip <> ''REZ''
                         ) a
                         join customer c
                             ON (a.rnk = c.rnk)
                         left outer join (select *
                                            from kl_k070
                                           where d_open <= :dat_
                                             and d_close is null or d_close>:dat_
                                         )   k
                             ON (c.ise = k.k070)
                         left outer join (select n.acc, max(n.nd) nd
                                            from nd_acc n, cc_deal e
                                           WHERE e.sdate <= :Dat_
                                             AND e.nd = n.nd
                                           group by n.acc ) n
                         on (a.acc = n.acc)
                         left outer join (SELECT n8.nd, max(i.freq) freq
                                                  FROM accounts a8, nd_acc n8, int_accn i
                                                 WHERE a8.nls LIKE ''8999%''
                                                   AND n8.acc = a8.acc
                                                   AND a8.acc = i.acc
                                                   AND i.ID = 0
                                                group by n8.nd) i
                         on (i.nd = n.nd)
                         left outer join otcn_fa7_temp t
                         on (a.nls like t.r020||''%'' )
                  ORDER BY 6, 3, 2 ';

   OPEN saldo FOR cursor_sql USING dat_, dat_, dat_, dat_;
   LOOP
       FETCH saldo BULK COLLECT INTO l_rec_t LIMIT 10000;
       EXIT WHEN l_rec_t.count = 0;

       for i in 1..l_rec_t.count loop
          acc_      := l_rec_t(i).acc_;
          nls_      := l_rec_t(i).nls_;
          kv_       := l_rec_t(i).kv_;
          daos_     := l_rec_t(i).daos_;
          data_     := l_rec_t(i).data_;
          nbs_      := l_rec_t(i).nbs_;
          r011_     := l_rec_t(i).r011_;
          r013_     := l_rec_t(i).r013_;
          s080_     := l_rec_t(i).s080_;
          se_       := l_rec_t(i).se_;
          sn_       := l_rec_t(i).sn_;
          rnk_      := l_rec_t(i).rnk_;
          isp_      := l_rec_t(i).isp_;
          mdate_    := l_rec_t(i).mdate_;
          tips_     := l_rec_t(i).tips_;
          tobo_     := l_rec_t(i).tobo_;
          nms_      := l_rec_t(i).nms_;
          s580_     := l_rec_t(i).s580_;
          t020_     := l_rec_t(i).t020_;
          s240_     := l_rec_t(i).s240_;
          nd1_      := l_rec_t(i).nd1_;
          nd2_      := l_rec_t(i).nd2_;
          nd3_      := l_rec_t(i).nd3_;
          nd4_      := l_rec_t(i).nd4_;
          nd_       := l_rec_t(i).nd_;
          fa7p_     := l_rec_t(i).fa7p_;
          freq_     := l_rec_t(i).freq_;
          k077_     := l_rec_t(i).k077_;
          comm_ :=' ';

          s245_ :='1';

          if   trim(tips_) in ('SK9','SP','SPN','OFR','KSP','KK9','KPN', 'SNA')
          then
               s245_ :='2';
          elsif nbs_ in ('1200','1203','3500','4400','4409','4410','4419','4430','4431','4500','4509','4530')
          then
              s245_ :='0';
          else
              if s240_ = '0' or mdate_ is not null then
                 s240_ := fs240 (dat_, acc_, null, null, mdate_, s240_);
              end if;

              if s240_ = 'Z' then
                 s245_ :='2';
              end if;
          end if;

          if nls_ like '29%' then
             r011_ := '0';
          end if;

          IF typ_ > 0 THEN
             nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
          ELSE
             nbuc_ := nbuc1_;
          END IF;

          IF kv_ <> 980 and se_ = 0 and sn_ <> 0
          THEN
            se_ := gl.p_icurval (kv_, sn_, dat_);
          END IF;

--  сегмент Q + сегмент WWW : умолчания
          r017_ := '3';
          segm_WWW := LPAD (kv_, 3,'0');

          pr_accc := 0;

          IF     mfou_ = 300465
             AND SUBSTR (nls_, 1, 3) IN
                    ('140', '141', '142', '143', '144', '300', '301', '310',
                     '311', '312', '313', '321', '330', '331','354')
          THEN
             -- добавил для банка ОПЕРУ СБ обработку дочерних счетов по ЦБ
             -- вместо консолидированных
             IF     nbs_ IS NOT NULL
                AND (mfo_ = 300465 and nbs_ NOT IN ('1405', '1415', '1435', '3007', '3015', '3107', '3115','3541') or
                     mfo_ <> 300465)
             THEN
                BEGIN
                   SELECT COUNT ( * )
                     INTO pr_accc
                     FROM sal a, accounts s
                    WHERE a.fdat = dat_
                      AND s.accc = acc_
                      AND s.accc = a.acc
                      AND s.nbs IS NULL;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      pr_accc := 0;
                END;
             END IF;
          END IF;
          
          if not (nbs_ like '150_'
             or  nbs_ like '34__' or  nbs_ like '36__'
             or  nbs_ like '44__' or  nbs_ like '45__'
             or  nbs_ like '9___'
             or  nbs_ in ('2920','3500')) 
          then
              begin
                  select sum(decode(s245, '0', ost, 0)), 
                         sum(decode(s245, '1', ost, 0)), 
                         sum(decode(s245, '2', ost, 0))
                  into sum_z0, sum_z1, sum_z2
                  from NBUR_TMP_A7_S245
                  where report_date = dat_ and
                        acc_id = acc_;  
              exception
                when no_data_found then
                    sum_z0:=0;
                    sum_z1:=0; 
                    sum_z2:=0;
              end;
                  
              koef_z1 := sum_z1 / se_;
              koef_z2 := sum_z2 / se_;
              koef_z0 := sum_z0 / se_;
                    
              if sum_z1 <> 0 then
                 s245_ := '1';
                 koef_z1 := 1;
              elsif sum_z2 <> 0 then
                 s245_ := '2';
                 koef_z2 := 1;
              elsif sum_z0 <> 0 then
                 
                 koef_z0 := 1;
              end if;    
          else 
              s245_ := '0';  
              
              sum_z0:=sn_;
              sum_z1:=0; 
              sum_z2:=0;          
          end if;
          
          if nbs_ not in ('1200','1203','3500','4400','4409','4410','4419','4430','4431','4500','4509','4530') or
             nbs_ is null
          then
              begin
                  if dat_ = datd_ then
                      if tips_ = 'NL8'then
                          select sign(se_)*nvl(sum(decode(s245, '0', ost, 0)), 0),
                                 sign(se_)*nvl(sum(decode(s245, '1', ost, 0)), 0),
                                 sign(se_)*nvl(sum(decode(s245, '2', ost, 0)), 0)
                          into sum_z0, sum_z1, sum_z2
                          from NBUR_TMP_A7_S245
                          where report_date = dat_ and
                                acc_id in (select dep_acc
                                           from V_DPU_REL_ACC_ALL
                                           where gen_acc = acc_);
                      else
                          select sign(se_)*nvl(sum(decode(s245, '0', ost, 0)), 0),
                                 sign(se_)*nvl(sum(decode(s245, '1', ost, 0)), 0),
                                 sign(se_)*nvl(sum(decode(s245, '2', ost, 0)), 0)
                          into sum_z0, sum_z1, sum_z2
                          from NBUR_TMP_A7_S245
                          where report_date = dat_ and
                                acc_id = acc_;
                      end if;
                  else 
                    raise no_data_found;
                  end if;
              exception
                when no_data_found then
                    sum_z0:=(case when s245_ = '0' then se_ else 0 end);
                    sum_z1:=(case when s245_ = '1' then se_ else 0 end);
                    sum_z2:=(case when s245_ = '2' then se_ else 0 end);
              end;

              if sum_z0 + sum_z1 + sum_z2 = 0 then
                 sum_z0:=(case when s245_ = '0' then se_ else 0 end);
                 sum_z1:=(case when s245_ = '1' then se_ else 0 end);
                 sum_z2:=(case when s245_ = '2' then se_ else 0 end);
              end if;

              koef_z1 := sum_z1 / se_;
              koef_z2 := sum_z2 / se_;
              koef_z0 := sum_z0 / se_;

              if sum_z1 <> 0 then
                 s245_ := '1';
                 koef_z1 := 1;
              elsif sum_z2 <> 0 then
                 s245_ := '2';
                 koef_z2 := 1;
              elsif sum_z0 <> 0 then
                 s245_ := '0';
                 koef_z0 := 1;
              end if;
          else
              s245_ := '0';

              sum_z0:=se_;
              sum_z1:=0;
              sum_z2:=0;
          end if;

          IF    (    mfou_ IN (300205, 300465)
                 AND (   (    nbs_ IS NULL
                          AND (mfo_ = 300465 and SUBSTR (nls_, 1, 4) NOT IN
                                 ('1405', '1415', '1435', '3007', '3015', '3107','3115','3541') or
                               mfo_ <> 300465)
                         )
                      OR (pr_accc = 0 AND nbs_ IS NOT NULL)
                     )
                )
             OR mfou_ NOT IN (300205, 300465)
          THEN
              IF nbs_ IS NULL
              THEN
                 nbs_ := SUBSTR (nls_, 1, 4);
              END IF;

              -- Демарк
              if nbs_ = '9500' and r013_ = '0' then
                 r013_ := '9';
              end if;

              comm_ := substr(comm_ || ' R013=' || r013_, 1, 200);

              --   проверка наличия для счета значений R013
              if not table_r013.exists(nbs_)
              then
                 r013_ :='0';
              end if;

              ------------------------------------------------------------------------
              dk_ := iif_n (se_, 0, '1', '2', '2');

              -- счета начисленных процентов
              -- 17.10.2011 выполняем разбивку только для активных остатков
              -- 09/04/2014 для ГОУ Сбербанка исключаем разбивку по 3118 Нафтогаза
              IF fa7p_ > 0 and se_ < 0 and
                 not (mfo_ = 300465 and rnk_ = 907973 and nbs_ in ('1418', '3118')) and
                 not (nbs_ in ('1418', '1428') and nvl(r011_, '0') in ('D')) and
                 not (nbs_ in ('3118') and nvl(r011_, '0') in ('2', 'A')) and
                 nbs_ <> '2628'
              THEN
                 if se_ <> 0 then

                    IF typ_ > 0 THEN
                       nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
                    ELSE
                       nbuc_ := nbuc1_;
                    END IF;

                    p_set_s580_def(nbs_, dk_, r011_, s245_);

                    p_analiz_r013_calc (1,
                                   mfo_,
                                   mfou_,
                                   dat_,
                                   acc_,
                                   tips_,
                                   nbs_,
                                   kv_,
                                   r013_,
                                   se_,
                                   nd_,
                                   freq_,
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
                       kodp_ := dk_ || nbs_ || r011_||o_r013_1 || LPAD (kv_,3,'0') || s580_||r017_||segm_WWW||s245_||k077_;

                       znap_ := TO_CHAR (ABS (o_se_1));

                       p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_,
                                    substr(comm_ || o_comm_1,1,200), nd_, acc_, mdate_, nbuc_, tobo_);
                    END IF;

                    -- свыше 30 дней
                    IF o_se_2 <> 0
                    THEN
                       kodp_ := dk_ || nbs_ || r011_||o_r013_2 || LPAD (kv_,3,'0') || s580_||r017_||segm_WWW||s245_||k077_;
                       znap_ := TO_CHAR (ABS (o_se_2));

                       p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_,
                                    substr(comm_ || o_comm_2,1,200), nd_, acc_, mdate_, nbuc_, tobo_);
                    END IF;
                 END IF;
              ELSE
                 IF nbs_ <> '2628' and se_ <> 0 or
                    nbs_ = '2628' and se_ > 0
                 THEN
                    dk_ := iif_n (se_, 0, '1', '2', '2');

                    --  сегмент Q + сегмент WWW :
                    if    r013_ = '5'
                      and nbs_ in ( '1400', '1405', '1406', '1407',
                                    '1410', '1415', '1416', '1417',
                                    '1420', '1426', '1427', '3040' )
                    then
                         r017_ := '1';
                         segm_WWW := '840';
                    end if;

                    if ((substr(nls_,1,4) in ('1410','1420','1430','1435','1436','1437','1440','1446','1447')) or
                        (substr(nls_,1,4) in ('1415','1416','1417','1426','1427') and r013_ not in ('3','9'))) or
                       ((substr(nls_,1,4) in ('1412','1413','1414','1422','1423','1424')) or
                         (substr(nls_,1,4) in ('1415','1416','1417','1426','1427') and r013_ in ('3','9')))
                         and s245_ <= 'I'
                    then
                        select nvl(sum(sum_zal), 0)
                        into sum_zal
                          from otcn_f42_cp
                          where fdat = dat_
                            and substr(nls,4,1)<>'8'
                            and acc = acc_;
                    else
                        sum_zal := 0;
                    end if;

                    p_set_s580_def(nbs_, dk_, r011_, s245_);

                    if sum_zal <> 0 then
                       kodp_ := dk_ || nbs_ || r011_||r013_ || LPAD (kv_,3,'0') || s580_||r017_||segm_WWW||s245_||k077_;
                       znap_ := TO_CHAR (ABS (se_ - sum_zal));

                       p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_, substr(comm_,1,200),
                                     nd_, acc_, mdate_, nbuc_, tobo_);

                       kodp_ := dk_ || nbs_ || '2' ||r013_ || LPAD (kv_,3,'0') || s580_||r017_||segm_WWW||s245_||k077_;

                       znap_ := TO_CHAR (ABS (sum_zal));

                       p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_, substr(comm_,1,200),
                                     nd_, acc_, mdate_, nbuc_, tobo_);
                    else
                       if sum_z0 <> 0 then
                          kodp_ := dk_ || nbs_ || r011_||r013_ || LPAD (kv_,3,'0') || s580_||r017_||segm_WWW||'0'||k077_;
                          znap_ := TO_CHAR (ABS (sum_z0));

                          p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_, substr(comm_,1,200),
                                         nd_, acc_, mdate_, nbuc_, tobo_);
                       end if;

                       if sum_z1 <> 0 then
                          kodp_ := dk_ || nbs_ || r011_||r013_ || LPAD (kv_,3,'0') || s580_||r017_||segm_WWW||'1'||k077_;
                          znap_ := TO_CHAR (ABS (sum_z1));

                          p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_, substr(comm_,1,200),
                                         nd_, acc_, mdate_, nbuc_, tobo_);
                       end if;

                       if sum_z2 <> 0 then
                          kodp_ := dk_ || nbs_ || r011_||r013_ || LPAD (kv_,3,'0') || s580_||r017_||segm_WWW||'2'||k077_;
                          znap_ := TO_CHAR (ABS (sum_z2));

                          p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_, substr(comm_,1,200),
                                         nd_, acc_, mdate_, nbuc_, tobo_);
                       end if;
                    end if;
                 END IF;
              END IF;
          end if;

          comm_ :='';
       END LOOP;

       l_rec_t.delete;
   END LOOP;

   CLOSE saldo;

   FORALL i IN 1 .. l_rnbu_trace.COUNT
       insert /*+ append */  into rnbu_trace values l_rnbu_trace(i);

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
       SELECT /*+ leading(z) */
               z.acc, z.accs, z.nd, a.nbs, nvl(p.r013, '0'),
               gl.p_icurval (a.kv, a.ost, dat_) ost
          FROM cc_accp z, sal a, specparam p
         WHERE z.acc in (select acc from rnbu_trace where substr(kodp,2,4)||substr(kodp,7,1) in ('26021','26221','90301','90311','90361','95001','95003'))
           AND z.accs = a.acc
           and a.fdat=dat_
           AND a.acc = p.acc
           AND a.nbs || p.r013 <> '91299'
           and a.nbs not in (select r020 from otcn_fa7_temp)
           and a.ost<0;

       -- сумма задолженности, кот. покрывает данный залог
       for p in (select * from rnbu_trace where substr(kodp,2,4)||substr(kodp,7,1) in ('26021','26221','90301','90311','90361','95001','95003'))
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

         -- выбираем все активы, к которым "привязан" данный залог
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

             -- депозиты, которые выступают залогами, привязаны к другим РНК
             if k.rnk <> rnk_ then
                rnk_ := k.rnk;
             end if;

             -- не включаем, т.к. дважды уменьшаются активы на эту сумму (еще в С5) - ПЕТРОКОММЕРЦ
             if nls_ like '9010%' and k.nbs='9023' and k.r013='1' then
                s580a_ := '1';
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
                        select nvl(max(s580), '9')
                        into s580a_
                          from nbur_ref_risk_s580
                          where r020 = k.nbs and
                                (t020 = (case when k.ost<0 then '1' else '2' end) or t020 = '*')  and
                                (r011 = substr(p.kodp,6,1) or r011 = '*') and
                                (S245 = substr(p.kodp,16,1) or S245 = '*');
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
             if nvl(s580a_,'0') = '0' then
                if substr(p.kodp,2,4)||substr(p.kodp,7,1) = '95001' then
                   s580a_ := '5'; 
                else
                   s580a_ := '9';
                end if;
             end if;

             update rnbu_trace
             set znap = to_char(to_number(znap) - sz0_),
                 comm = substr(comm || ' + розбивка по активу (1)',1,200),
                 nd = nd_,
                 kodp = substr(kodp,1,10)|| s580a_||substr(kodp,12)
             where recid = p.recid;

             kodp_ := SUBSTR(p.kodp, 1,6) || '9' || SUBSTR(p.kodp, 8,3) || s580a_||substr(p.kodp,12);
             znap_ := TO_CHAR (sz0_);

             INSERT INTO RNBU_TRACE(recid, userid, nls, kv, odate, kodp, znap, rnk, acc, comm, nbuc, isp, tobo, nd)
             VALUES (s_rnbu_record.nextval, userid_, p.nls, p.kv, p.odate, kodp_, znap_, rnk_, acc_,
                'Перевищення над залишком по активу (2)', p.nbuc, p.isp, p.tobo, nd_);
          else
             if sk_all_ = 0 then -- немає відповідного активу
                 update rnbu_trace
                 set comm = substr(comm || ' + заміна по активу (2)',1,200),
                     nd = nd_,
                     kodp = substr(kodp,1,10) || '9' || substr(kodp,12)
                 where recid = p.recid;
             else -- забезпечення не перекриває актив
                 for k in (select substr(r.kodp,11,1) s580a, sum(T.OST_EQV) ost,
                                  nvl((count(*) over (partition by substr(r.kodp,11,1))), 0) cnt,
                                  DENSE_RANK() over (partition by substr(r.kodp,11,1) order by substr(r.kodp,11,1)) rnum
                           from otcn_f42_temp t, rnbu_trace r
                           where t.acc = p.acc and
                                 t.accc = r.acc  
                          group by substr(r.kodp,11,1))
                 loop
                    if k.cnt = 1 or k.rnum = 1 then
                       update rnbu_trace
                       set znap = to_char(k.ost),
                           comm = substr(comm || ' + розбивка по активу (3)',1,200),
                           nd = nd_,
                           kodp = substr(kodp,1,10)|| k.s580a ||substr(kodp,12)
                       where recid = p.recid;
                    else
                       INSERT INTO RNBU_TRACE(recid, userid, nls, kv, odate, kodp, znap, rnk, acc, comm, nbuc, isp, tobo, nd)
                       VALUES (s_rnbu_record.nextval, userid_, p.nls, p.kv, p.odate, 
                            substr(p.kodp,1,10)|| k.s580a ||substr(p.kodp,12), to_char(k.ost), rnk_, acc_,
                        'Розбивка по активу (4)', p.nbuc, p.isp, p.tobo, nd_);
                    end if;
                 end loop;               
             end if;
          end if;
      end loop;
   end;

   insert into TMP_KOD_R020 values ('9001');

   for k in (select acc, nls, kv, rnk, s080, szq, szq_30, isp, mdate, tobo, nbs, kodp, sump, suma,
                    cnt, rnum, decode(suma, 0, 1, sump / suma) koef, r013, rz, discont, prem,
                    round(discont * decode(suma, 0, 1, sump / suma)) discont_row,
                    round(prem * decode(suma, 0, 1, sump / suma)) prem_row,
                    nd, id, ob22, custtype, accr, accr_30, tip
             from (
                 select t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                        nvl(gl.p_icurval(t.kv, t.sz, dat_), 0) szq,
                        nvl(gl.p_icurval(t.kv, t.rez_30, dat_), 0) szq_30,
                        a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                        nvl(s.kodp, '00000000000') kodp, nvl(s.sump, 0) sump,
                        nvl((sum(s.sump) over (partition by s.acc)), 0) suma,
                        nvl((count( * ) over (partition by s.acc)), 0) cnt,
                        DENSE_RANK() over (partition by s.acc order by s.r013) rnum,
                        s.r013, t.rz,
                        nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                        nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                        t.nd, t.id,
                        a.ob22, c.custtype, t.accr, t.accr_30, a.tip
                 from v_tmp_rez_risk_c5 t,
                      (select acc, kodp, substr(kodp,7,1) R013, sum(to_number(znap)) sump
                       from rnbu_trace
                       where substr(kodp,1,5) not in ('21600','22600','22605','22620','22625','22650','22655',
                                                      '11419','11429','11519','11529',
                                                      '12039','12069','12089',
                                                      '12109','12119','12129','12139',
                                                      '12209','12239' )
                       group by acc, kodp, substr(kodp,7,1)) s,
                       accounts a, customer c
                  where t.dat = datr_ and
                      t.id not like 'NLO%' and
                      t.acc = s.acc and
                      t.acc = a.acc and
                      nvl(a.nbs, substr(a.nls, 1,4))
                            in (select r020
                                from  TMP_KOD_R020 k
                                WHERE r020 not in ('2924')
                                      and substr(r020,1,3) not in ('410','420')
                                ) and
                      a.rnk = c.rnk and
                      (mfo_ = 300465 and nvl(t.dat_mi, dat_)<= dat_ or
                       mfo_ <> 300465 and nvl(t.dat_mi, dat_+1) > dat_)
                        )
            where szq <> 0 or discont <> 0 or prem <> 0
            order by acc, rnum)
   loop
      IF typ_ > 0 THEN
         if k.accr is not null and mfo_ = '322669' then
            nbuc_ := NVL (F_Codobl_Tobo_New(k.accr, dat_, typ_), nbuc1_);
         else
            nbuc_ := NVL (F_Codobl_branch (k.tobo, typ_), nbuc1_);
         end if;
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      -- новая функция для определения кода R013=1 до 30-и дней, 2 - более 30
      r013_30 := f_ret_type_r013 ( dat_, k.nbs, k.r013 );

      if k.accr = k.accr_30 or r013_30 = 1
      then
         nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);
      else
         nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr_30);
      end if;

      nbs_ := substr(nbs_r013_, 1, 4);
      r013_ := substr(nbs_r013_, 5, 1);

      s580a_ := substr(k.kodp, 11, 1);
      
      -- тимчасово, поки НБУ не зніме контроль на 3590
      if nbs_ = '3590' and k.nbs not in ('3510', '3511', '3519') then
         s245_ := '2';
      else 
         s245_ := substr(k.kodp, 16, 1); 
      end if;      

      select count( * ) into cnt_ from otcn_fa7_temp where r020 = k.nbs;

      -- ознака рахунку нарахованих відсотків
      TP_SND := (case when substr(k.nls, 1,1) in ('1','2','3') and
                           ( (substr(k.nls,1,4) in ('2607','2627','2657') and k.tip = 'SNA') or
                             (substr(k.nls,4,1) = '8' and k.tip = 'SNA')
                           )  and
                           substr(k.nls,1,4) not in ('1818')
                      then true else false end);

      if k.szq <>0 then
          if TP_SND then
             r012_ :='B';

             -- для рахунків нарахованих %, де немає розбивки по R013
             if nbs_ in ('2609','2629','2659') then
                kodp_ := '2'||nbs_||'0'||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
             else
                kodp_ := '2'||nbs_||substr(k.kodp,6,1)||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
             end if;

             comm_ := SUBSTR (' резерв під прострочені відсотки відносимо до R012='||r012_||' sumc='||to_char(sumc_) , 1, 200);

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
          else
             r012_ := 'A';

             if nbs_ in ('2609','2629','2659') then
                kodp_ := '2'||nbs_||'0'||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
             elsif nbs_ = '3599' and substr(k.nls, 1, 4) in ('3710', '3548') then
                kodp_ := '2'||nbs_||'2'||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
             else
                kodp_ := '2'||nbs_||substr(k.kodp,6,1)||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
             end if;

             if k.rnum = 1 then
                 discont_ := k.discont;
                 premiy_ := k.prem;

                 if k.suma  - discont_ + premiy_ < 0 then
                    sakt_ := k.suma;
                 else
                    sakt_ := k.suma  - discont_ + premiy_;
                 end if;

                 srez_ := (case when k.szq <= sakt_ then k.szq else sakt_ end);
                 srezp_ := (case when k.szq <= sakt_ then 0 else k.szq - srez_ end);
             end if;

             if k.cnt = 1 then
                znap_ := to_char(srez_);
                comm_ := SUBSTR (' резерв під борг відносимо до R012='||r012_||'(1)' , 1, 200);
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

                comm_ := SUBSTR (' резерв під борг відносимо до R012='||r012_||'(2)' , 1, 200);
             end if;
          end if;

          if znap_ <> '0' then
             INSERT INTO rnbu_trace
                      ( recid, userid, nls, kv, odate,
                        kodp, znap, acc, rnk, isp, mdate,
                        comm, nd, nbuc, tobo )
               VALUES ( s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv,
                        data_, kodp_, znap_, k.acc, k.rnk, k.isp, k.mdate,
                        comm_, k.nd, nbuc_, k.tobo );
          end if;

          if srezp_ <> 0 and not TP_SND and k.cnt = k.rnum then

             if srezp_ <> 0  then
                r012_:='B';

                if nbs_ in ('2609','2629','2659') then
                    kodp_ := '2'||nbs_||'0'||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||'2'||substr(k.kodp,17);
                elsif nbs_ = '3599' and substr(k.nls, 1, 4) in ('3710', '3548') then
                    kodp_ := '2'||nbs_||'2'||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||'2'||substr(k.kodp,17);
                else
                    kodp_ := '2'||nbs_||substr(k.kodp,6,1)||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||'2'||substr(k.kodp,17);
                end if;

                znap_ := srezp_;
                comm_ := SUBSTR(' перевищення резерву над осн. боргом до R012='||r012_, 1,100);

                insert into rnbu_trace
                         ( recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc, rnk, isp, mdate,
                           comm, nd, nbuc, tobo )
                  values ( s_rnbu_record.NEXTVAL, userid_,
                           k.nls, k.kv, data_, kodp_,
                           znap_, k.acc, k.rnk, k.isp, k.mdate,
                           comm_, k.nd, nbuc_, k.tobo );
             end if;
          end if;
      else
         if nbs_ in ('2609','2629','2659') then
            kodp_ := '2'||nbs_||'0'||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
         elsif nbs_ = '3599' and substr(k.nls, 1, 4) in ('3710', '3548') then
            kodp_ := '2'||nbs_||'2'||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
         else
            kodp_ := '2'||nbs_||substr(k.kodp,6,1)||r013_||substr(k.kodp,8,3)||s580a_||substr(k.kodp,12,4)||s245_||substr(k.kodp,17);
         end if;

         if k.rnum = 1 then
              discont_ := k.discont;
              premiy_ := k.prem;
         end if;
      end if;
   end loop;

   for k in (select acc, nbs, nls, kv, rnk, s080, szq, isp, mdate, tobo, r031, r030,
                    r011, r013, s580, rez, discont, prem, nd, id, ob22, custtype, accr, tip, s240
               from ( select t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                             gl.p_icurval(t.kv, t.sz - t.rez_30, dat_) szq,
                             a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                             r031, decode(lpad(l.r030, 3, '0'), '974', '933', lpad(l.r030, 3, '0')) r030,
                             nvl(s.r011, '0') r011, nvl(s.r013, '0') r013, t.rz rez,
                             nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                             nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                             t.nd, t.id, nvl(s.s580, '0') s580, a.ob22, c.custtype, t.accr,
                             a.tip, nvl(s.s240, '0') s240
                        from v_tmp_rez_risk_c5 t,
                             accounts a, specparam s, customer c, kl_r030 l
                       where t.dat = datr_
                         and (  not exists (
                                       select 1
                                         from rnbu_trace x
                                        where x.acc = t.acc
                                          and substr(x.kodp,1,5) not in ('21600','22600','22605','22620','22625','22650','22655',
                                                                         '11419','11429','11519','11529','12039',
                                                                         '12069','12089','12109','12119','12129',
                                                                         '12139','12209','12239') )
                             )
                         and t.acc = a.acc
                         and t.acc = s.acc(+)
                         and a.rnk = c.rnk
                         and a.kv = to_number(l.r030)
                         and nvl(a.nbs, substr(a.nls,1,4)) not in ('2924')
                         and substr(nvl(a.nbs, substr(a.nls,1,4)),1,3) not in ('410','420')
                         and (   mfo_ = 300465 and nvl(t.dat_mi, dat_)<= dat_
                              or
                                mfo_ <> 300465 and nvl(t.dat_mi, dat_+1) > dat_ )
                      union
                      select t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                             gl.p_icurval(t.kv, t.rez_30, dat_) szq,
                             a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                             r031, decode(lpad(l.r030, 3, '0'), '974', '933', lpad(l.r030, 3, '0')) r030,
                             nvl(s.r011, '0') r011, nvl(s.r013, '0') r013, t.rz rez,
                             nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                             nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                             t.nd, t.id, nvl(s.s580, '0') s580, a.ob22, c.custtype, t.accr_30 accr,
                             a.tip, nvl(s.s240, '0') s240
                        from v_tmp_rez_risk_c5 t,
                             accounts a, specparam s, customer c, kl_r030 l
                       where t.dat = datr_
                         and ( not exists (
                                      select 1
                                        from rnbu_trace x
                                       where x.acc = t.acc
                                         and substr(x.kodp,1,5) not in ('21600','22600','22605','22620','22625','22650','22655',
                                                                        '11419','11429','11519','11529','12039',
                                                                        '12069','12089','12109','12119','12129',
                                                                        '12139','12209','12239') )
                             )
                         and t.acc = a.acc
                         and t.acc = s.acc(+)
                         and a.rnk = c.rnk
                         and a.kv = to_number(l.r030)
                         and nvl(a.nbs, substr(a.nls,1,4)) not in ('2924')
                         and substr(nvl(a.nbs, substr(a.nls,1,4)),1,3) not in ('410','420')
                         and (   mfo_ = 300465 and nvl(t.dat_mi, dat_)<= dat_
                              or
                                mfo_ <> 300465 and nvl(t.dat_mi, dat_+1) > dat_)
                        )
            where szq <> 0 or discont <> 0 or prem <> 0
            order by acc )
   loop
      IF typ_ > 0 THEN
         if k.accr is not null and mfo_ = '322669' then
            nbuc_ := NVL (F_Codobl_Tobo_New(k.accr, dat_, typ_), nbuc1_);
         else
            nbuc_ := NVL (F_Codobl_branch (k.tobo, typ_), nbuc1_);
         end if;
      ELSE
         nbuc_ := nbuc1_;
      END IF;

--?? как здесь определить просрочку
      if substr(k.nls, 4, 1) in ('7', '9') and
         substr(k.nls, 1, 4) not in ('2607','2627','2657','1819','2809','3519','3559')
      then
         sakt_ := abs(k.szq);
      else
         sakt_ := nvl(fostq_new(k.acc, dat_, dati_), 0);

         sakt_ := (case when sakt_ < 0 then abs(sakt_) else 0 end);

         if sakt_ <> 0 then
             discont_ := k.discont;
             premiy_ := k.prem;

             if sakt_  - discont_ + premiy_ >= 0 then
                sakt_ := sakt_  - discont_ + premiy_;
             end if;
         end if;
      end if;

      srez_ := (case when k.szq <= sakt_ then k.szq else sakt_ end);
      srezp_ := (case when k.szq <= sakt_ then 0 else k.szq - srez_ end);

      nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);

      nbs_ := substr(nbs_r013_, 1, 4);
      r013_ := substr(nbs_r013_, 5, 1);

      select nvl(max(s245), '1')
      into s245_
      from NBUR_TMP_A7_S245
      where report_date = datd_ and
            acc_id = k.acc;
            
      if nbs_ = '3590' and k.nbs not in ('3510', '3511', '3519') then
         s245_ := '2';
      end if;              

      r011_ := k.r011;

--   проверка наличия для счета значений R011
      if not table_r011.exists(nbs_)
      then
          r011_ :='0';
      end if;

      if      nbs_ in ('2029','2039','2079','2209','2219','2229')
      then
            r011_ :='1';
      elsif nbs_ = '3599' and substr(k.nls, 1, 4) in ('3710', '3548') then
            r011_ :='2';
      end if;

      if r011_ ='0' then

         if      nbs_ in ('2239','2249','3599')
         then
               r011_ :='1';
         elsif   nbs_ in ('2019','2089','2119','2139')
         then
               r011_ :='2';
         elsif   nbs_ in ('2069','2109','2129')
         then
               r011_ :='3';
         elsif   nbs_ in ('3692')
         then
               r011_ :='4';
         elsif   nbs_ in ('2890')
         then
               r011_ :='6';
         else
               NULL;
         end if;

      end if;

      if    k.nbs like '1%'
         or k.nbs like '31%'
         or k.nbs like '32%'
         or nbs_ in ('2890','3590')
      then  K077_:='1';
      elsif k.nbs like '20%'
         or k.nbs like '260%'
         or k.nbs like '265%'
         or nbs_ in( '3599', '3690','3692')
      then  K077_:='3';
      elsif k.nbs like '22%' or k.nbs like '262%'
      then  K077_:='5';
      elsif k.nbs like '21%'
      then  k077_ :='2';
      else
            k077_ :='3';
      end if;

      if k.s580 <> '0' then
         s580a_ := k.s580;
      else
        select nvl(max(s580), '9')
        into s580a_
          from nbur_ref_risk_s580
          where r020 = k.nbs and
                (t020 = '1' or t020 = '*') and
                (r011 = r011_ or r011 = '*') and
                (S245 = s245_ or S245 = '*');
      end if;

 --  сегмент Q + сегмент WWW : умолчания
      r017_ := '3';
      segm_WWW := LPAD (k.kv, 3,'0');

      select count( * ) into cnt_ from otcn_fa7_temp where r020 = k.nbs;

      -- ознака рахунку нарахованих відсотків
      TP_SND := (case when substr(k.nls, 1,1) in ('1','2','3') and
                           ( (substr(k.nls,1,4) in ('2607','2627','2657') and k.tip = 'SNA') or
                             (substr(k.nls,4,1) = '8' and k.tip = 'SNA')
                           ) and
                           substr(k.nls,1,4) not in ('1818','1819','2809','3519','3559')
                      then true else false end);

      if k.szq <> 0 then
          if TP_SND then

             r012_:='B';

             kodp_ := '2'||nbs_||r011_||r013_||k.r030||s580a_||r017_||segm_WWW||s245_||k077_;
             znap_ := to_char(k.szq);

          else
--?? как здесь определить просрочку
             if substr(k.nls, 4, 1)  = '7' and
                substr(k.nls, 1, 4) not in ('2607','2627','2657')
             then
                kodp_ := '2'||nbs_||r011_||r013_||k.r030||s580a_||r017_||segm_WWW||s245_||k077_;
                znap_ := to_char(k.szq);

                comm_ := SUBSTR (' резерв під прострочку по осн. борг відносимо до R012=B ' , 1, 200);
             else
                r012_:='A';

                kodp_ := '2'||nbs_||r011_||r013_||k.r030||s580a_||r017_||segm_WWW||s245_||k077_;
                znap_ := to_char(srez_);

                comm_ := SUBSTR (' резерв під осн. борг відносимо до R012='||r012_||' R013R='||r013_, 1,100);
             end if;

             discont_ := k.discont;
             premiy_ := k.prem;

          end if;

          if znap_ <> '0' then
              comm_ := comm_ || '(!)';

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
             r012_ :='B';

             kodp_ := '2'||nbs_||r011_||r013_||k.r030||s580a_||r017_||segm_WWW||'2'||k077_;
             znap_ := srezp_;


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
         r012_ := 'B';

         kodp_ := '2'||nbs_||r011_||r013_||k.r030||s580a_||r017_||segm_WWW||s245_||k077_;

         discont_ := k.discont;
         premiy_ := k.prem;

      end if;
   end loop;

--------------------------------------------------
-- списання за рахунок резерву
   declare
      recid_    number;
      granica_  number := 100;
      mask_     varchar2(100);
      diff_     number;
   begin
      for k in (select fdat, ref, acc, nls, kv, sq, nbs, acca, nlsa, rnka,
                       sum(sq) over (partition by acc) sum_all
                from (select /*+ leading(a) index(o,IDX_OPLDOK_KF_FDAT_ACC)  */
                             o.fdat, o.ref, o.acc, a.nls, a.kv,
                             decode(o.dk, 0, -1, 1) * gl.p_icurval(a.kv, o.s, dat_) sq,
                             a.nbs, z.acc acca, x.nls nlsa, x.rnk rnka
                      from accounts a, opldok o, opldok z, accounts x, oper p
                      where o.fdat = any (select fdat from fdat
                                           where fdat between datb_+1 and dat_
                                             and fdat !=to_date('20171218','yyyymmdd')  ) and
                        o.acc = a.acc
                        and a.tip = 'REZ'
                        and o.tt not like 'AR%'
                        and o.ref = z.ref
                        and o.fdat = z.fdat
                        and o.stmt = z.stmt
                        and o.dk <> z.dk
                        and o.dk = 0
                        and z.acc = x.acc
                        and x.nls not like '7%'
                        and x.nls not like '3800%'
                        and o.ref = p.ref
                        and p.sos in (-2, 5)
                        and p.vdat between datb_ and dat_
                       )
                    )
       loop
           if k.sum_all <> 0 then
               begin
                   select recid, kodp, znap
                   into recid_, kodp_, znap_
                   from rnbu_trace
                   where acc = k.acca and
                         kodp like '2'||substr(k.nls,1,4)||'%' and
                         rownum = 1;
               exception
                  when no_data_found then
                      recid_ := null;
               end;

               if recid_ is not null then

                  diff_ :=0;
                  if abs(k.sq) > znap_ then
                     diff_ := -1 *(abs(k.sq) - znap_);
                     znap_ := -1 *znap_;
                  else
                     znap_ := k.sq;
                  end if;

                  INSERT INTO rnbu_trace
                              (recid, userid, nls, kv, odate, kodp,
                               znap, acc, rnk, isp, mdate, ref,
                               comm, nbuc, tobo
                              )
                   select s_rnbu_record.NEXTVAL recid,
                          userid, nls, kv, odate, kodp,
                          to_char(znap_), acc,
                          rnk, isp, mdate, k.ref,
                          'Списання за рахунок резерву РЕФ = '||to_char(k.ref) comm,
                          nbuc, tobo
                   from rnbu_trace
                   where recid = recid_;

                   if diff_ != 0  then       --списано больше чем остаток, ищем еще счета клиента
                       begin
                           select recid, kodp, znap
                           into recid_, kodp_, znap_
                           from rnbu_trace
                           where rnk =k.rnka and acc != k.acca and
                                 kodp like '2'||substr(k.nls,1,4)||'%' and
                                 rownum = 1;
                       exception
                          when no_data_found then
                              recid_ := null;
                       end;
                       if recid_ is not null then
                              INSERT INTO rnbu_trace
                                        ( recid, userid, nls, kv, odate, kodp,
                                          znap, acc, rnk, isp, mdate, ref,
                                          comm, nbuc, tobo )
                               select s_rnbu_record.NEXTVAL recid,
                                      userid, nls, kv, odate, kodp,
                                      to_char(diff_), acc,
                                      rnk, isp, mdate, k.ref,
                                      'Списання за рахунок резерву РЕФ = '||to_char(k.ref) comm,
                                      nbuc, tobo
                               from rnbu_trace
                               where recid = recid_;
                       end if;

                   end if;
               end if;
           end if;
       end loop;
   end;
--------------------------------------------------
   declare
      recid_    number;
      granica_  number := 1000;
   begin
       for k in (select nvl(a.nbuc, b.nbuc) nbuc, nvl(a.t020, b.t020) t020,
                        nvl(a.nbs, b.nbs) nbs, nvl(a.kv, b.kv) kv,  nvl(a.rez, b.rez) rez,
                        a.ostq ost1, b.ostq ost2, nvl(a.ostq, 0) - nvl(b.ostq, 0) rizn,
                        R013_s580, R013_s580_A
                from (select nbuc, t020, rez, nbs, kv,
                            ostq +
                            (case when nbs not like '9%'
                                    then 0
                                    else f_ret_pereoc(dat_, '01',
                                           t020||'0'||nbs||lpad(kv, 3, '0'), nbuc, typ_)
                            end) ostq
                      from (
                          select nbuc, decode(t020, -1, '1', '2') t020, rez, nbs, kv, abs(ostq) ostq
                          from (
                            select (case when typ_ > 0
                                            THEN NVL (F_Codobl_Tobo (a.acc, typ_), nbuc1_)
                                            else nbuc1_
                                    end) nbuc, 2-MOD(c.codcagent,2) rez,
                                sign(decode(a.kv, 980, a.ost, a.ostq)) t020, a.nbs, a.kv,
                                sum(decode(a.kv, 980, a.ost, a.ostq)) ostq
                            from otcn_saldo a, otcn_acc s, customer c
                            where nvl(a.nbs, substr(a.nls,1,4)) in ('1410','1412','1415','1416','1417','1418',
                                          '1490','1491','1492','1493','1590','1592','1890',
                                          '2890','3190','3290','3590','3599','3690','3692',
                                          '9010','9015','9030','9031','9036','9500',
                                          '1419','1429','1509','1519','1529','2039','2069','2089','2109','2119','2129',
                                          '2609','2629','2659',
                                          '2139','2209','2239','3119','3219')
                              and a.acc = s.acc
                              and a.rnk = c.rnk
                            group by (case when typ_ > 0
                                            THEN NVL (F_Codobl_Tobo (a.acc, typ_), nbuc1_)
                                            else nbuc1_
                                    end), 2-MOD(c.codcagent,2), sign(decode(a.kv, 980, a.ost, a.ostq)), a.nbs, a.kv)
                          where t020 <> 0)) a
                    full outer join
                    (select r.nbuc,
                            substr(r.kodp, 1, 1) t020, 2-MOD(c.codcagent,2) rez,
                            substr(r.kodp, 2, 4) nbs, r.kv,
                            sum(to_number(r.znap)) ostq,
                            min('1'||substr(kodp, 6, 2)) R013_s580,
                            min('1'||substr(kodp, 6, 2)) R013_s580_A
                        from rnbu_trace r, customer c
                        where substr(r.kodp, 2, 4) in ('1410','1412','1415','1416','1417','1418',
                                      '1490','1491','1492','1493','1590','1592','1890',
                                      '2400','2401','2890','3190','3290','3590','3599','3690','3692',
                                      '9010','9015','9030','9031','9036','9500',
                                      '1419','1429','1509','1519','1529','2039','2069','2089','2109','2119','2129',
                                      '2609','2629','2659',
                                      '2139','2209','2239','3119','3219')
                          and r.rnk = c.rnk
                        group by r.nbuc, substr(r.kodp, 1, 1), 2-MOD(c.codcagent,2),substr(r.kodp, 2, 4), r.kv) b
                    on (a.nbuc = b.nbuc and a.t020 = b.t020 and a.rez = b.rez and a.nbs = b.nbs and a.kv = b.kv)
                where abs(nvl(a.ostq, 0) - nvl(b.ostq, 0)) between 1 and granica_
                order by 1, 2 )
       loop
          begin
               select r.recid
               into recid_
               from rnbu_trace r, customer c
               where r.nbuc = k.nbuc and
                     r.kodp like k.t020||k.nbs||'__'||lpad(k.kv,3,'0')||'%' and
                     substr(kodp,16,1) = '2' and
                     substr(kodp,6,2) = substr(k.R013_s580,2,2) and
                    (sign(k.rizn) = -1 and to_number(r.znap) >= abs(k.rizn) or
                     sign(k.rizn) = 1 and to_number(r.znap) > 0) and
                     r.rnk = c.rnk and
                     2-MOD(c.codcagent,2) = k.rez and
                    rownum = 1;
          exception
             when no_data_found then
                 begin
                   select r.recid
                   into recid_
                   from rnbu_trace r, customer c
                   where r.nbuc = k.nbuc and
                         r.kodp like k.t020||k.nbs||'__'||lpad(k.kv,3,'0')||'%' and
                         substr(kodp,6,2) = substr(k.R013_s580,2,2) and
                        (sign(k.rizn) = -1 and to_number(r.znap) >= abs(k.rizn) or
                         sign(k.rizn) = 1 and to_number(r.znap) > 0) and
                         r.rnk = c.rnk and
                         2-MOD(c.codcagent,2) = k.rez and
                        rownum = 1;
                 exception
                    when no_data_found then
                       begin
                           select r.recid
                           into recid_
                           from rnbu_trace r, customer c
                           where r.nbuc = k.nbuc and
                                 r.kodp like k.t020||k.nbs||'__'||lpad(k.kv, 3, '0')||'%' and
                                 substr(kodp, 6, 2) = substr(k.R013_s580_A,2,2) and
                                (sign(k.rizn) = -1 and to_number(r.znap) >= abs(k.rizn) or
                                 sign(k.rizn) = 1 and to_number(r.znap) > 0) and
                                r.rnk = c.rnk and
                                2-MOD(c.codcagent,2) = k.rez and
                                rownum = 1;
                       exception
                            when no_data_found then
                              begin
                                   select r.recid
                                   into recid_
                                   from rnbu_trace r, customer c
                                   where r.nbuc = k.nbuc and
                                         r.kodp like k.t020||k.nbs||'__'||lpad(k.kv, 3, '0')||'%' and
                                         substr(kodp, 6, 2) = substr(k.R013_s580,2,2) and
                                        (sign(k.rizn) = -1 and to_number(r.znap) >= abs(k.rizn) or
                                         sign(k.rizn) = 1 and to_number(r.znap) > 0) and
                                         r.rnk = c.rnk and
                                         2-MOD(c.codcagent,2) = k.rez and
                                         rownum = 1;
                              exception
                                 when no_data_found then
                                   recid_ := null;
                              end;
                       end;
                 end;
          end;

          if recid_ is not null then
             -- вирівнювання по рахунках резерву в бік збільшення
             if k.nbs in ('1090','1190','1419','1429','1509','1519','1529',
                        '1549','1609','1890','2019','2029','2039','2049',
                        '2069','2079','2089','2109','2119','2129','2139',
                        '2149','2209','2219','2229','2239','2249','2309',
                        '2319','2329','2339','2349','2359','2369','2379',
                        '2409','2419','2429','2439','2609','2629','2659',
                        '2890','3119','3219','3569','3590','3599','3690','3692') and
              k.t020 = '2' and 
              k.rizn > 0  
             then 
               insert into rnbu_trace(recid, userid, nls, kv, odate, kodp, znap, nbuc, 
                    isp, rnk, acc, ref, comm, nd, mdate, tobo)
               select s_rnbu_record.nextval, userid, nls, kv, odate, 
                    substr(kodp, 1, 15)||'2'||substr(kodp, 17), 
                    to_char(k.rizn) znap, nbuc, 
                    isp, rnk, acc, ref, 'Вирів-ня з балансом на '||to_char(k.rizn) comm, 
                    nd, mdate, tobo
               from rnbu_trace
               where recid = recid_;
             else
                update rnbu_trace
                set znap = to_char(to_number(znap) + k.rizn),
                    comm = substr(comm || ' + вирів-ня з балансом на '||to_char(k.rizn), 1, 200)
                where recid = recid_;
             end if;
          end if;
       end loop;
   end;

--------------------------------------------------
   if dat_ <to_date('20171226','yyyymmdd')  then
       delete from rnbu_trace
        where substr(kodp, 2,4) not in (select r020 from TMP_KOD_R020 ) ;
   end if;

   --------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = 'C5' AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu(kodf, datf, kodp, znap, nbuc)
   SELECT 'C5', dat_, kodp, SUM (znap), nbuc
   FROM rnbu_trace
   GROUP BY kodp, nbuc
   having SUM (znap)<> 0;

----------------------------------------
    -- Макаренко И.В.(налаштований job о 19:00 по формуванню файлу для розшифровки показників
    -- та вивантаженню в файл і протокол зберігається під BARS, а інші користувачі потім не можуть
    -- його вилучити (такі були вимоги для ГОУ: хто формує, той лише може вилучити)
    -- тому, при такому формуванні не потрібно зберігати протокол в архів
    if mfo_ = 300465 then
       select sysdate into CurrDate from dual;
       select to_date(to_char(trunc(sysdate),'dd/mm/yyyy')||' 19:00:00','dd/mm/yyyy hh24:mi:ss') into Checkdate from dual;

       if CurrDate < Checkdate then
         OTC_DEL_ARCH (kodf_, dat_, 0);
         OTC_SAVE_ARCH(kodf_, dat_, 0);
       end if;
    ELSE
       OTC_DEL_ARCH (kodf_, dat_, 0);
       OTC_SAVE_ARCH(kodf_, dat_, 0);
    end if;
----------------------------------------

   commit;

   DELETE FROM OTC_C5_PROC WHERE datf = dat_;

   INSERT INTO otc_c5_proc
            (datf, rnk, nd, acc, nls, kv, kodp, znap )
    select /*+ parallel(8) */
        dat_, cust_id, nd, acc_id, acc_num, kv, field_code, field_value
    from V_NBUR_#C5_DTL_TMP v, kl_f3_29 k
    where k.kf = '42' and k.ddd = '001' and
        v.seg_02 = k.r020 and
        (v.seg_01 = k.r012 or k.r012 = '3') and
        (
        (v.seg_02 like '___8' or v.seg_02 in ('1607','2607','2627','2657')) and 
        v.seg_02 not in ('1508','3108','3108','3118','3218','3548','3578','3568') and
        v.seg_04 = '2' 
        or
        (v.seg_02 like '___9') and 
        v.seg_02 not in ('1509','1819','2809','3049','3119','3219','3519','3599','3569','9129') and
        v.seg_04 in ('2', '4') 
        or 
        not (substr(v.seg_02,1,3) in ('150','300','301','310','311','321') or 
             v.seg_02 in ('1607','2607','2627','2657','3040', '3692') or 
             v.seg_02 like '___8'  or 
             v.seg_02 like '___9')
        )
    order by seg_02, seg_01, acc_num;
    -----------------------------------------------------

     
   INSERT INTO otc_c5_proc
            (datf, rnk, nd, acc, nls, kv, kodp, znap )
    select /*+ parallel(8) */
        dat_, cust_id, nd, acc_id, acc_num, kv, field_code, field_value
    from V_NBUR_#C5_DTL_TMP v, kl_f3_29 k
    where k.kf = '42' and k.ddd = '001' and
        v.seg_02 = k.r020 and
        (v.seg_01 = k.r012 or k.r012 = '3') and
        (
        v.seg_02 = '1502' and v.seg_03 in ('2', '3', '6') 
        or
        v.seg_02 = '1508' and v.seg_03 in ('2', '3', '6') and v.seg_04 in ('2')
        or
        v.seg_02 = '1509' and v.seg_03 in ('2', '3', '6') and v.seg_04 in ('2', '4')  
        )
    order by seg_02, seg_01, acc_num;
    -----------------------------------------------------

     
   INSERT INTO otc_c5_proc
            (datf, rnk, nd, acc, nls, kv, kodp, znap )
    select /*+ parallel(8) */
        dat_, cust_id, nd, acc_id, acc_num, kv, field_code, field_value
    from V_NBUR_#C5_DTL_TMP v, kl_f3_29 k
    where k.kf = '42' and k.ddd = '001' and
        v.seg_02 = k.r020 and
        (v.seg_01 = k.r012 or k.r012 = '3') and
        (
        v.seg_02 = '3003' and v.seg_03 in ('6') and v.seg_04 in ('9')
        or
        v.seg_02 = '3005' and v.seg_03 in ('B') and v.seg_04 in ('9')
        or
        v.seg_02 = '3007' and v.seg_03 in ('6', 'B') and v.seg_04 in ('9')
        or
        v.seg_02 = '3008' and v.seg_03 in ('6', 'B') and v.seg_04 in ('2')
        or
        v.seg_02 = '3010' and v.seg_03 in ('2') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3011' and v.seg_03 in ('5') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3012' and v.seg_03 in ('8','9') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3013' and v.seg_03 in ('A','B','E','F','J','K') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3014' and v.seg_03 in ('N','O') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3015' and v.seg_03 in ('2','5','8','9','A','B','E','F','J','K','N','O') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3018' and v.seg_03 in ('2','8','A','J','K','N') and v.seg_04 in ('9') and v.seg_09 in ('1') 
        or
        v.seg_02 = '3018' and v.seg_03 in ('5','9','B','E','F','O') and v.seg_04 in ('2')  
        or
        v.seg_02 = '3040' and v.seg_03 in ('2', '4') 
        )
    order by seg_02, seg_01, acc_num;
    -----------------------------------------------------

     
   INSERT INTO otc_c5_proc
            (datf, rnk, nd, acc, nls, kv, kodp, znap )
    select /*+ parallel(8) */
        dat_, cust_id, nd, acc_id, acc_num, kv, field_code, field_value
    from V_NBUR_#C5_DTL_TMP v, kl_f3_29 k
    where k.kf = '42' and k.ddd = '001' and
        v.seg_02 = k.r020 and
        (v.seg_01 = k.r012 or k.r012 = '3') and
        (
        v.seg_02 = '3103' and v.seg_03 in ('2','5') and v.seg_04 in ('9')
        or
        v.seg_02 = '3105' and v.seg_03 in ('6','9') and v.seg_04 in ('9')
        or
        v.seg_02 = '3107' and v.seg_03 in ('2','5','6','9') and v.seg_04 in ('9')
        or
        v.seg_02 = '3108' and v.seg_03 in ('2','5','6','9') and v.seg_04 in ('2')
        or
        v.seg_02 = '3110' and v.seg_03 in ('2') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3111' and v.seg_03 in ('5') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3112' and v.seg_03 in ('6','7') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3113' and v.seg_03 in ('A','B','C','D','E','F') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3114' and v.seg_03 in ('K','L') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3115' and v.seg_03 in ('2','5','6','7','A','B','C','D','E','F','K','L') and v.seg_04 in ('9')  
        or
        v.seg_02 = '3118' and v.seg_03 in ('2','6','A','C','D','K') and v.seg_04 in ('9') and v.seg_09 in ('1') 
        or
        v.seg_02 = '3118' and v.seg_03 in ('5','7','B','E','F','L') and v.seg_04 in ('2')  
        or
        v.seg_02 = '3119' and v.seg_03 in ('2','6','A','C','D','K') and v.seg_04 in ('1') and v.seg_09 in ('1') 
        or
        v.seg_02 = '3119' and v.seg_03 in ('2','6','A','C','D','K') and v.seg_04 in ('4') 
        or
        v.seg_02 = '3119' and v.seg_03 in ('5','7','B','E','F','L') and v.seg_04 in ('2','4')  
        )
    order by seg_02, seg_01, acc_num;
    -----------------------------------------------------

     
   INSERT INTO otc_c5_proc
            (datf, rnk, nd, acc, nls, kv, kodp, znap )
    select /*+ parallel(8) */
        dat_, cust_id, nd, acc_id, acc_num, kv, field_code, field_value
    from V_NBUR_#C5_DTL_TMP v, kl_f3_29 k
    where k.kf = '42' and k.ddd = '001' and
        v.seg_02 = k.r020 and
        (v.seg_01 = k.r012 or k.r012 = '3') and
        (
        v.seg_02 = '3210' and v.seg_03 in ('1') 
        or
        v.seg_02 = '3211' and v.seg_03 in ('2') 
        or
        v.seg_02 = '3212' and v.seg_03 in ('3','4') 
        or
        v.seg_02 = '3213' and v.seg_03 in ('5','6','7','8','9','A') 
        or
        v.seg_02 = '3214' and v.seg_03 in ('B','C') 
        or
        v.seg_02 = '3218' and v.seg_03 in ('1','4','5','7','8','B') and v.seg_04 in ('9') and v.seg_09 in ('1') 
        or
        v.seg_02 = '3218' and v.seg_03 in ('2','3','6','9','A','C') and v.seg_04 in ('2')  
        or
        v.seg_02 = '3219' and v.seg_03 in ('1','4','5','7','8','B') and v.seg_04 in ('1') and v.seg_09 in ('1') 
        or
        v.seg_02 = '3219' and v.seg_03 in ('1','4','5','7','8','B') and v.seg_04 in ('4') 
        or
        v.seg_02 = '3219' and v.seg_03 in ('2','3','6','9','A','C') and v.seg_04 in ('2','4')  
        )
    order by seg_02, seg_01, acc_num;
    -----------------------------------------------------

   INSERT INTO otc_c5_proc
            (datf, rnk, nd, acc, nls, kv, kodp, znap )
    select /*+ parallel(8) */
        dat_, cust_id, nd, acc_id, acc_num, kv, field_code, field_value
    from V_NBUR_#C5_DTL_TMP v, kl_f3_29 k
    where k.kf = '42' and k.ddd = '001' and
        v.seg_02 = k.r020 and
        (v.seg_01 = k.r012 or k.r012 = '3') and
        (
        v.seg_02 = '3599' and v.seg_03 in ('2') and v.seg_04 in ('9') and v.acc_num not like '3570%'
        or
        v.seg_02 = '3578' and v.seg_03 in ('1') and v.seg_04 in ('2') 
        or
        v.seg_02 = '3599' and v.seg_03 in ('1') and v.seg_04 in ('2') and v.acc_num not like '3570%'
        or
        v.seg_02 = '3560' and v.seg_03 in ('1','3') 
        or
        v.seg_02 = '3568' and v.seg_03 in ('1','3') and v.seg_04 in ('2')  
        or
        v.seg_02 = '3569' and v.seg_03 in ('1','3') and v.seg_04 in ('2','4')  
        or
        v.seg_02 = '9129' and v.seg_04 in ('1') 
        or
        v.seg_02 = '3692' and v.acc_num not like '9129%'
        or
        v.seg_02 in ('1819', '2809', '3049', '3519','3548')
        )
    order by seg_02, seg_01, acc_num;
   -----------------------------------------------------

   INSERT INTO otc_c5_proc
            (datf, rnk, nd, acc, nls, kv, kodp, znap )
    select /*+ parallel(8) */
        dat_, cust_id, nd, acc_id, acc_num, kv, field_code, field_value
    from V_NBUR_#C5_DTL_TMP v, kl_f3_29 k, specparam s
    where k.kf = '42' and k.ddd = '001' and
        v.seg_02 = k.r020 and
        (v.seg_01 = k.r012 or k.r012 = '3') and
        v.seg_02 = '3692' and v.acc_num like '9129%' and
        v.acc_id = s.acc and
        nvl(trim(s.r013), '0') = '1'
    order by seg_02, seg_01, acc_num;
    -----------------------------------------------------

    delete 
    FROM OTC_C5_PROC 
    WHERE datf = dat_ and
       substr(kodp,1,1) = '2' and
       substr(kodp,2,4) in ('1090','1190','1419','1429','1509','1519','1529',
                            '1549','1609','1890','2019','2029','2039','2049',
                            '2069','2079','2089','2109','2119','2129','2139',
                            '2149','2209','2219','2229','2239','2249','2309',
                            '2319','2329','2339','2349','2359','2369','2379',
                            '2409','2419','2429','2439','2609','2629','2659',
                            '2890','3119','3219','3569','3590','3599','3690','3692') and
       acc in (select acc from snap_balances where fdat = dat_ and ost=0);   
    
    commit;

   logger.info ('P_FC5: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END;
/