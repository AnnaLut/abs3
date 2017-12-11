CREATE OR REPLACE PROCEDURE BARS.p_fc5 (dat_ DATE, pnd_ NUMBER DEFAULT NULL)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #С5 для КБ (универсальная)
% COPYRIGHT : Copyright UNITY-BARS Limited, 1999. All Rights Reserved.
%
% VERSION : v.17.009 08.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 параметры: Dat_ - отчетная дата

 Структура показателя D BBBB P VVV Щ Й Q WWW

 1 D 1/2 (остаток ДТ/КТ)
 2 BBBB R020 балансовый счет
 6 P распределение в разрезе R013
 7 VVV R030 код валюты
 10 Щ распределение в разрезе R012
 11 Й S580 распределение по группе риска
 12 Q R017 код индексации финансовых инструментов
 13 WWW R030 код валюты индексации

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 28.07.2017 отдельное определение r012 для счетов 1592
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
 разбивка по параметру R012 на 'A' и "B'
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
 kodf_ Varchar2(2) := 'C5';
 sheme_ Varchar2(1) := 'G';
 acc_ NUMBER;
 nbs_ VARCHAR2 (4);
 nbs1_ VARCHAR2 (4);
 nls_ VARCHAR2 (15);
 daos_ DATE;
 datp_ DATE;
 data_ DATE;
 mdate_ DATE;
 kv_ SMALLINT;
 sn_ DECIMAL (24);
 se_ DECIMAL (24);
 se1_ DECIMAL (24);
 dk_ CHAR (1);
 kodp_ VARCHAR2 (20);
 znap_ VARCHAR2 (30);
 r013_ VARCHAR2 (1);
 r013_30 NUMBER;
 fa7d_ NUMBER;
 id_ NUMBER;
 s080_ NUMBER;
 s080_r_ NUMBER;
 sum_rez_ NUMBER;
 sum_24_ NUMBER;
 acc_24_ NUMBER;
 nls_24_ VARCHAR2 (15);
 userid_ NUMBER;
 rnk_ NUMBER;
 isp_ NUMBER;
 fa7p_ NUMBER;
 comm_ rnbu_trace.comm%TYPE;
 comm1_ rnbu_trace.comm%TYPE;
 tobo_ accounts.tobo%TYPE;
 nms_ accounts.nms%TYPE;
 mfo_ NUMBER;
 mfou_ NUMBER;
 dos_ NUMBER;
 dose_ NUMBER;
 nd_ NUMBER;
 nd1_ NUMBER;
 nd2_ NUMBER;
 nd3_ NUMBER;
 nd4_ NUMBER;
 -- Макаренко И.В.
 CurrDate DATE;
 Checkdate DATE;

 -- ДО 30 ДНЕЙ
 o_r013_1 VARCHAR2 (1);
 o_se_1 DECIMAL (24);
 o_comm_1 rnbu_trace.comm%TYPE;
 -- ПОСЛЕ 30 ДНЕЙ
 o_r013_2 VARCHAR2 (1);
 o_se_2 DECIMAL (24);
 o_comm_2 rnbu_trace.comm%TYPE;
 tips_ VARCHAR2 (3);
 f7ad_ NUMBER;

 caldt_ID_ NUMBER;

 typ_ NUMBER;
 nbuc1_ VARCHAR2 (20);
 nbuc_ VARCHAR2 (20);
 t020_ VARCHAR2 (1);

 TYPE ref_type_curs IS REF CURSOR;

 saldo ref_type_curs;
 cursor_sql varchar2(20000);

 type rec_type is record
 (acc_ number,
 nls_ varchar2(15),
 kv_ integer,
 daos_ date,
 data_ date,
 nbs_ char(4),
 r013_ varchar2(1),
 s080_ varchar2(1),
 se_ number,
 sn_ number,
 rnk_ number,
 isp_ accounts.isp%TYPE,
 mdate_ date,
 tips_ accounts.tip%TYPE,
 tobo_ accounts.tobo%TYPE,
 nms_ accounts.nms%TYPE,
 r012_ varchar2(1),
 s580_ varchar2(1),
 t020_ varchar2(1),
 nd1_ number,
 nd2_ number,
 nd3_ number,
 nd4_ number,
 nd_ number,
 s580r_ varchar2(1),
 fa7p_ number,
 freq_ number);

 TYPE rec_t IS TABLE OF rec_type;
 l_rec_t rec_t := rec_t();

 TYPE rnbu_trace_t IS TABLE OF rnbu_trace%rowtype;
 l_rnbu_trace rnbu_trace_t := rnbu_trace_t();

 TYPE t_otcn IS TABLE OF NUMBER(1) INDEX BY VARCHAR2(4);
 table_R013 t_otcn;

 datz_ date := Dat_Next_U(dat_, 1);
 sql_acc_ clob;
 ret_ number;
 in_acc_ varchar2(255);

 r012_ specparam.r012%type;
 s580_ specparam.s580%type;
 s580a_ specparam.s580%type;
 s580r_ specparam.s580%type;
 r017_ varchar2(1); --segment Q
 segm_WWW varchar2(3);

 dat_zmin1 date := to_date('20022008', 'ddmmyyyy');
 dat_zmin2 date := to_date('03012013', 'ddmmyyyy');
 dat_zmin3 date := to_date('01092016', 'ddmmyyyy');

 -- балансовые счета дисконта
 nbsdiscont_ VARCHAR2 (2000)
 := '2016,2026,2036,2066,2076,2086,2106,2116,2126,2136,2206,2216,2226,2236,';
 -- балансовые счета премии
 nbspremiy_ VARCHAR2 (2000)
 := '2065,2075,2085,2105,2115,2125,2135,2205,2215,2235,';
 nbsrezerv_ VARCHAR2 (2000)
 := '1492,1493,1590,1592,2400,2401,3190,3191,3291,3599,';

 discont_ number := 0;
 premiy_ number := 0;

 datr_ date;
 datb_ date;
 sum_ number;
 sumc_ number := 0;
 srez_ number := 0;
 srezp_ number := 0;
 sakt_ number := 0;
 r030_ varchar2(3);
 nbs_r013_ varchar2(5);

 cnt_ number;
 TP_SND BOOLEAN := false;
 pr_accc number;
 dati_ integer := null;
 freq_ number;
 fl_cp_ number:=0;

 CURSOR saldo_cp
 IS
 SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, a.tip,
 nvl(trim(p.r013), '0'), a.mdate, a.ost, a.rnk, a.isp,
 a.tobo, nvl(p.r012, '0'), lpad(l.r030, 3, '0'), NVL(p.s580,'9')
 FROM (SELECT s.acc, s.nls, s.kv, s.mdate, aa.fdat, s.nbs, s.tip,
 aa.dos, aa.kos, s.rnk, s.isp, s.pap, s.daos,
 aa.ost, s.dapp, s.tobo
 FROM otcn_saldo aa, otcn_acc s
 WHERE aa.acc = s.acc and
 (nvl(aa.nbs, substr(aa.nls,1,4)) in ('1490','1491','1492','1493') or
 fl_cp_ = 0 and nvl(aa.nbs, substr(aa.nls,1,4)) in ('3190','3290'))
 ) a,
 kl_r030 l,
 specparam p
 WHERE a.ost <> 0
 AND a.kv = TO_NUMBER (l.r030)
 AND a.acc = p.acc(+);

function f_get_r012_for_1508( p_acc in number )
 return varchar2
is
 l_r011 varchar2(1);
begin

 begin
 select nvl(trim(r011),'1') into l_r011
 from specparam
 where acc =p_acc;

 exception
 when no_data_found then l_r011 :='1';
 end;

 if l_r011 ='1' then
 return 'K';
 else
 return 'L';
 end if;

end;

 procedure P_Set_S580_Def(r020_ in varchar2, r013_ in varchar2) is
 invk_ varchar2(1);
 begin
 if r020_ = '9500' then
 if r013_ in ('1', '3') then
 s580_ := '5';
 end if;

 if r013_ = '9' then
 s580_ := '9';
 end if;
 end if;

 if r020_ in ('3570','3578') then
 if r013_ in ('3','4') then s580_ :='5'; end if;
 if r013_ in ('5','6') then s580_ :='1'; end if;
 end if;

 if mfou_ = 353575 and r020_ in ('1518', '1520', '1521') or
 mfou_ <> 353575 and r020_ in ('1500','1502','1508','1509',
 '1510','1512','1513','1515','1516','1517','1518','1519',
 '1520','1521','1523','1524','1525','1526','1528')
 then
 begin
 select nvl(trim(VALUE), '2')
 into invk_
 from customerw
 where rnk = rnk_ and
 tag = 'INVCL';
 exception
 when no_data_found then
 invk_:= null;
 end;
 else
 invk_:= null;
 end if;

 invk_:= nvl(invk_, '2');

 s580_ := (case
 when r020_||invk_ in ('15003','15083','15103','15123') then '1'
 when r020_||invk_ in ('15001','15081','15101','15121') then '3'
 when r020_||invk_ in ('15002','15082','15102','15122') then '4'
 ---
 when r020_||r013_ in ('15023') then '1'
 when r020_||r013_ in ('15021','15022','15029') and invk_ ='3' then '1'
 when r020_||r013_ in ('15021') and invk_ in ('1','2') then '4'
 when r020_||r013_ in ('15022','15029') and invk_ in ('1','2') then '5'
 ---
 when r020_||invk_ in ('15133') then '1'
 when r020_||invk_ in ('15131','15132') then '5'
 ---
 when r020_||r013_ in ('15185','15186','15187','15188') and invk_ ='3' then '1'
 when r020_||r013_ in ('15185','15187') and invk_ ='1' then '3'
 when r020_||r013_ in ('15186','15188') and invk_ ='2' then '5'
 when r020_||invk_ in ('15182') then '5'
 when r020_ in ('1509','1519') then '5'
 ---
 when r020_||r013_ in ('15151','15154','15161','15164') and invk_ ='3' then '1'
 when r020_||r013_ in ('15151','15154','15161','15164') and invk_ ='1' then '3'
 when r020_||r013_ in ('15151','15154','15161','15164') and invk_ ='2' then '4'
 when r020_||r013_ in ('15152','15162') and invk_ ='3' then '1'
 when r020_||r013_ in ('15152','15162') and invk_ in ('1','2') then '5'
 ---
 when r020_||invk_ in ('15203', '15213', '15223','15233') then '1'
 when r020_||invk_ in ('15201', '15202', '15221', '15222') then '5'
 when r020_||invk_ in ('15211', '15231') then '3'
 when r020_||invk_ in ('15212') then '4'
 when r020_||invk_ in ('15232') then '5'
 ---
 when r020_||r013_||invk_ in ('152433') then '1'
 when r020_||r013_||invk_ in ('152411', '152412') then '5'
 ---
 when r020_||invk_ in ('15253') and r013_ in ('1','2','3','4','5','7') then '1'
 when r020_||invk_ in ('15251') and r013_ in ('1','4') then '3'
 when r020_||invk_ in ('15251') and r013_ in ('2','3','5','7') then '5'
 when r020_||r013_ in ('15254') then '4'
 when r020_||r013_ in ('15251','15252','15253','15255','15257') and invk_ = '2' then '5'
 ---
 when r020_||invk_ in ('15263') and r013_ in ('1','2','3','4','5','7') then '1'
 when r020_||invk_ in ('15261') and r013_ in ('1','4') then '3'
 when r020_||invk_ in ('15261') and r013_ in ('2','3','5','7') then '5'
 when r020_||r013_ in ('15264') then '4'
 when r020_||r013_ in ('15261','15262','15263','15265','15267') and invk_ = '2' then '5'
 ---
 when r020_||invk_ in ('15283') then '1'
 when r020_||invk_ in ('15281') then '3'
 when r020_||r013_ in ('15285','15287') then '4'
 when r020_||r013_ in ('15286','15288') and invk_ = '2' then '5'
 else
 s580_
 end);
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

 EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
 logger.info ('BARS.P_FC5: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));

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
 AND ( LOWER (txt) LIKE '%нарах%доход%'
 OR LOWER (txt) LIKE '%нарах%витр%' )
 and not lower(txt) like '%прострочен%'
 AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
 and (d_close is null or
 d_close >= datz_);

 -- определение кода области для выбранного файла и схемы
 P_Proc_Set (kodf_, sheme_, nbuc1_, typ_);

 -------------------------------------------------------------------

 if dat_ between to_date('10012013', 'ddmmyyyy') and to_date('30012013', 'ddmmyyyy') then
 datr_ := to_date('01012013', 'ddmmyyyy');
 datp_ := to_date('15012013', 'ddmmyyyy');
 else
 -- дата розрахунку резерв_в
 select max(dat)
 into datb_
 from rez_protocol
 where dat_bank is not null and
 dat_bank <= dat_ and
 dat <= dat_ ;

 if datb_ is null then
 if dat_ between to_date('31012013', 'ddmmyyyy') and to_date('10022013', 'ddmmyyyy') then
 datr_ := to_date('01012013', 'ddmmyyyy');
 datp_ := to_date('15012013', 'ddmmyyyy');
 else
 datr_ := add_months(last_day(dat_)+1,-1);
 end if;

 datp_ := dat_;
 else
 datr_ := last_day(datb_) + 1;
 end if;
 end if;

 select max(dat_bank)
 into datp_
 from rez_protocol
 where dat = datb_ and
 dat <= dat_;

 if datp_ is null and dat_ between to_date('31012013', 'ddmmyyyy') and to_date('10022013', 'ddmmyyyy') then
 datp_ := to_date('15012013', 'ddmmyyyy');
 else
 datp_ := datp_ + 1;
 end if;

 insert /*+ append */
 into TMP_KOD_R020
 SELECT r020
 FROM kod_r020
 WHERE a010 = 'C5'
 AND trim(prem) = 'КБ'
 AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
 and (d_close is null or
 d_close > datz_);

-- действующие R013 в рабочую таблицу

 for k in ( select distinct r020 pok
 from kl_r013
 where trim(prem)='КБ'
 and ( d_close is null
 or d_close >= datz_) )
 loop
 table_r013(k.pok) := 1;
 end loop;
-------------------------------------------------------------------

 if pnd_ is null then
 sql_acc_ := ' SELECT /*+PARALLEL(a, 8)*/ *
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

 p_upd_r012('C5', mfou_);

   cursor_sql := 'select a.*, n.nd nd1, null nd2, null nd3, null nd4, n.nd nd,
                         nvl(r.s580, ''0'') s580r, decode(t.r020, null, 0, 1) fa7p, i.freq
                    from (SELECT   /*+ use_hash(s) full(a) full(s) */
                                   a.acc, a.nls, a.kv, a.daos, :dat_, a.nbs,
                                   NVL (cc.r013, ''0'') r013, NVL (cc.s080, ''1'') s080,
                                   decode(a.kv, 980, s.ost, s.ostq) ostq, s.ost, a.rnk,
                                   a.isp, a.mdate, a.tip, a.tobo, a.nms,
                                   nvl(cc.r012, ''0'') r012, nvl(cc.s580, ''9'') s580,
                                   decode(sign(s.ost),-1,''1'', ''2'') t020
                          FROM otcn_saldo s, otcn_acc a, specparam cc
                          WHERE s.ost <> 0 and
                                s.acc = a.acc and
                                s.acc = cc.acc(+) and
                                nvl(s.nbs, substr(s.nls,1,4)) not in (''1490'',''1491'',''1492'',''1493'',
                                            ''1590'',''1592'',''1890'',''2400'',''2401'',''2890'',''3190'',''3290'',
                                            ''3590'',''3599'',''3690'')
                         ) a
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
                         left outer join (select R020, T020, R013, max(S580) s580
                                          from otc_risk_s580
                                          where s580 <> ''R''
                                          group by R020, T020, R013
                                          ) r
                         on (a.nbs = r.r020 and
                             (a.t020 = r.t020 or r.t020 = ''3'') and
                             (a.r013 = r.r013 or r.r013 = ''0'')
                             )
                         left outer join otcn_fa7_temp t
                         on (a.nls like t.r020 || ''%'')
                  ORDER BY 6, 3, 2 ';

   OPEN saldo FOR cursor_sql USING dat_, dat_;
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
          r012_     := l_rec_t(i).r012_;
          s580_     := l_rec_t(i).s580_;
          t020_     := l_rec_t(i).t020_;
          nd1_      := l_rec_t(i).nd1_;
          nd2_      := l_rec_t(i).nd2_;
          nd3_      := l_rec_t(i).nd3_;
          nd4_      := l_rec_t(i).nd4_;
          nd_       := l_rec_t(i).nd_;
          s580r_    := l_rec_t(i).s580r_;
          fa7p_     := l_rec_t(i).fa7p_;
          freq_     := l_rec_t(i).freq_;

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

          if s580r_ <> '0' then
             s580_ := s580r_;
          end if;

          IF     mfou_ IN (300205, 300465)
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

              if instr(nbsdiscont_, nbs_) > 0 or instr(nbspremiy_, nbs_) > 0 then
                 r012_ := 'D';
              end if;

              if tips_ = 'SNA' then
                 r012_ := '4';
              end if;

              -- зауваження ПКБ
              if nbs_ = '2620' and se_ > 0 then
                 r012_ := (case when r013_ = '1' then '2' else '6' end);
              end if;

              -- зауваження ПКБ
              if nbs_ in ('2630', '2635') and se_ > 0 then
                 r012_ := '2';
              end if;

              if nbs_ in ('1890', '2890', '3590', '3599') and se_ > 0 then
                 r012_ := 'B';
              end if;

              comm_ := substr(nms_,1,38) || '  R013_old=' || r013_;

              -- Демарк
              if nbs_ = '9500' and r013_ = '0' then
                 r013_ := '9';
              end if;

              if dat_>=to_date('01112008','ddmmyyyy') and
                 nbs_ in ('1518','1528') and
                 nvl(trim(r013_),'0') = '0'
              then
                 declare
                    dapp_ date;
                 BEGIN
                     select max(fdat)
                    into dapp_
                    from saldoa
                    where acc = acc_ and
                          fdat <= dat_ and
                          dos <>0;

                    select a.nbs
                       into nbs1_
                    from accounts a, int_accn i
                    where i.acra=acc_
                      and i.acc=a.acc
                      and i.ID=0
                      and nvl(i.ACR_DAT, i.apl_DAT) >= dapp_
                      and i.ACR_DAT = (select min(ACR_DAT)
                                       from int_accn
                                       where acra=acc_ and
                                             nvl(ACR_DAT, apl_DAT) >= dapp_);

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
                 SELECT COUNT ( *)
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


                       IF dat_ >= dat_zmin3 then

                          p_set_s580_def(nbs_, r013_);
                          kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0') || r012_|| s580_||r017_||segm_WWW;

                       ELSIF dat_ > dat_zmin2  then

                          p_set_s580_def(nbs_, r013_);
                          kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0') || r012_ || s580_;

                       ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                          kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0');
                       ELSE
                          kodp_ := dk_ || nbs_ || r013_;
                       END IF;

                       znap_ := TO_CHAR (ABS (se1_));

                       p_add_rec(s_rnbu_record.nextval, userid_, k.nls, k.kv, data_, kodp_, znap_,
                                 k.rnk, k.isp, comm1_, nd_, k.acc, mdate_, nbuc_, tobo_);

                       se_ := se_ - se1_;
                    END IF;
                  END LOOP;
              END IF;

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
                 not (nbs_ in ('1408', '1418', '1428') and nvl(r013_, '0') = '1') and
                 not (mfo_ = 300465 and rnk_ = 907973 and nbs_ in ('1418', '3118')) and
                 nbs_ <> '2628'
              THEN
                 if se_ <> 0 then

                    IF typ_ > 0 THEN
                       nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
                    ELSE
                       nbuc_ := nbuc1_;
                    END IF;

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
                       IF dat_ >= dat_zmin3 then

                          p_set_s580_def(nbs_, o_r013_1);
                          kodp_ := dk_ || nbs_ || o_r013_1 || LPAD (kv_, 3, '0') || r012_|| s580_||r017_||segm_WWW;

                       ELSIF dat_  > dat_zmin2  THEN

                          p_set_s580_def(nbs_, o_r013_1);
                          kodp_ := dk_ || nbs_ || o_r013_1 || LPAD (kv_, 3, '0') || r012_ || s580_;

                       ELSIF dat_ > dat_zmin1   THEN
                          kodp_ := dk_ || nbs_ || o_r013_1 || LPAD (kv_, 3, '0');
                       ELSE
                          kodp_ := dk_ || nbs_ || o_r013_1;
                       END IF;

                       znap_ := TO_CHAR (ABS (o_se_1));

                       p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_,
                                    substr(comm_ || o_comm_1,1,200), nd_, acc_, mdate_, nbuc_, tobo_);
                    END IF;

                    -- свыше 30 дней
                    IF o_se_2 <> 0
                    THEN
                       IF dat_ >= dat_zmin3  then

                          p_set_s580_def(nbs_, o_r013_2);
                          kodp_ := dk_ || nbs_ || o_r013_2 || LPAD (kv_, 3, '0') || r012_|| s580_||r017_||segm_WWW;

                       ELSIF dat_ > dat_zmin2  THEN

                          p_set_s580_def(nbs_, o_r013_2);
                          kodp_ := dk_ || nbs_ || o_r013_2 || LPAD (kv_, 3, '0') || r012_ || s580_;

                       ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                          kodp_ := dk_ || nbs_ || o_r013_2 || LPAD (kv_, 3, '0');
                       ELSE
                          kodp_ := dk_ || nbs_ || o_r013_2;
                       END IF;

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

                    IF dat_ >= dat_zmin3  then

                       p_set_s580_def(nbs_, r013_);
                       kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0') || r012_|| s580_||r017_||segm_WWW;

                    ELSIF dat_ > dat_zmin2  THEN

                       p_set_s580_def(nbs_, r013_);
                       kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0') || r012_ || s580_;

                    ELSIF dat_ between dat_zmin1 and dat_zmin2 THEN
                       kodp_ := dk_ || nbs_ || r013_ || LPAD (kv_, 3, '0');
                    ELSE
                       kodp_ := dk_ || nbs_ || r013_;
                    END IF;

                    znap_ := TO_CHAR (ABS (se_));

                    p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp_, znap_, rnk_, isp_, substr(comm_,1,200),
                                 nd_, acc_, mdate_, nbuc_, tobo_);
                 END IF;
              END IF;

              if instr(nbsdiscont_, nbs_) > 0 or
                 instr(nbspremiy_, nbs_) > 0  or
                 tips_ = 'SNA'
              then
                 if tips_ = 'SNA' then
                    r012_ := '4';
                 else
                    r012_ := 'D';
                 end if;

                 insert into OTCN_FA7_REZ2(ND, ACC, PR, SUM)
                 values(nd1_, acc_, (case when instr(nbsdiscont_, nbs_) > 0 then 1
                                        when instr(nbspremiy_, nbs_) > 0 then 2
                                        else 3 end), se_);
              end if;
          end if;
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
         WHERE z.acc in (select acc from rnbu_trace where substr(kodp,2,5) in ('90101','90151','90301','90311','90361','95001'))
           AND z.accs = a.acc
           and a.fdat=dat_
           AND a.acc = p.acc
           AND a.nbs || p.r013 <> '91299'
           and a.nbs not in (select r020 from otcn_fa7_temp)
           and a.ost<0;

       -- сумма задолженности, кот. покрывает данный залог
       for p in (select * from rnbu_trace where substr(kodp,2,5) in ('90101','90151','90301','90311','90361','95001'))
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

            -- Для Петрокоммерца не корректируем сумму задолженности на сумму дисконта/премии
            -- письмо от Самсон Ю. (01/10/2007)
             if mfou_ NOT IN (300120) THEN
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
                        select max(nvl(s580, '0'))
                        into s580a_
                        from OTC_RISK_S580
                        where r020 = k.nbs and
                            t020 in ('1', '3') and
                            (r013 = k.r013 or r013 = '0') and
                            s580 <> 'R';
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
                s580a_ := '9';
             end if;

             if substr(p.kodp, 2, 5) = '95001' then
                s580a_ := '5';
             end if;

             update rnbu_trace
             set znap = to_char(to_number(znap) - sz0_),
                 comm = comm || ' + розбивка по активу (1)',
                 nd = nd_,
                 kodp = substr(kodp,1,10)|| s580a_||substr(kodp,12)
             where recid = p.recid;

             if substr(p.kodp, 2, 5) = '95001' then
                s580a_ := '9';
             end if;

             kodp_ := SUBSTR(p.kodp, 1,5) || '9' || SUBSTR(p.kodp, 7,4) || s580a_||substr(p.kodp,12);
             znap_ := TO_CHAR (sz0_);

             INSERT INTO RNBU_TRACE(recid, userid, nls, kv, odate, kodp, znap, rnk, acc, comm, nbuc, isp, tobo, nd)
             VALUES (s_rnbu_record.nextval, userid_, p.nls, p.kv, p.odate, kodp_, znap_, rnk_, acc_,
                'Перевищення над залишком по активу (2)', p.nbuc, p.isp, p.tobo, nd_);
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
                 select /*+index(t PK_NBU23REZ_ID) */
                        t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                        nvl(gl.p_icurval(t.kv, t.sz, dat_), 0) szq,
                        nvl(gl.p_icurval(t.kv, t.rez_30, dat_), 0) szq_30,
                        a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                        nvl(s.kodp, '00000000000') kodp, nvl(s.sump, 0) sump,
                        nvl((sum(s.sump) over (partition by s.acc)), 0) suma,
                        nvl((count(*) over (partition by s.acc)), 0) cnt,
                        DENSE_RANK() over (partition by s.acc order by s.r013) rnum,
                        s.r013, t.rz,
                        nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                        nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                        t.nd, t.id,
                        a.ob22, c.custtype, t.accr, t.accr_30, a.tip
                 from v_tmp_rez_risk_c5 t,
                      (select acc, kodp, substr(kodp, 6, 1) R013, sum(to_number(znap)) sump
                       from rnbu_trace
                       where substr(kodp,1,5) not in ('21600', '22600', '22605', '22620', '22625', '22650', '22655',
                                                      '11419','11429','11519','11529',
                                                      '12039','12069','12089',
                                                      '12109','12119','12129','12139',
                                                      '12209','12239' )
                       group by acc, kodp, substr(kodp, 6, 1)) s,
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

--      IF typ_ > 0 THEN
--         nbuc_ := NVL (F_Codobl_Tobo (k.acc, typ_), nbuc1_);
--      ELSE
--         nbuc_ := nbuc1_;
--      END IF;

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

--      s580a_ := (case when nbs_||r013_ in ('15904','15921','24006','24016') then '9' else s580a_ end);

      select count(*) into cnt_ from otcn_fa7_temp where r020 = k.nbs;

      -- ознака рахунку нарахованих відсотків
      TP_SND := (case when substr(k.nls, 1,1) in ('1','2','3') and
                           ( substr(k.nls, 4,1) = '9' or
                             (substr(k.nls,1,4) in ('2607','2627','2657') and k.tip = 'SNA') or
                             (substr(k.nls,4,1) = '8' and k.tip = 'SNA')
                           )  and
                           substr(k.nls,1,4) not in ('1818','1819','2809','3519','3559')
                      then true else false end);

      if k.szq <>0 then
          if TP_SND then
             r012_ := 'B';
             if nbs_='1592'  and  k.nls like '1508%'  then
                r012_ :=f_get_r012_for_1508(k.acc);
             end if;

             -- для рахунків нарахованих %, де немає розбивки по R013
             kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||r012_||s580a_||substr(k.kodp,12);
             comm_ := SUBSTR (' резерв під прострочені відсотки відносимо до R012='||r012_||' sumc='||to_char(sumc_) , 1,200);

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
             if substr(k.nls,1,4) in ( '1517','1527','2037','2067','2087',
                                       '2107','2117','2127','2137',
                                       '2207','2237' )
             then
                 r012_ := 'B';
             end if;
             if nbs_='1592' and  k.nls like '1500%'  then  r012_:='I';  end if;
             if nbs_='1592' and  k.nls like '1502%'  then  r012_:='J';  end if;
             if nbs_='1592' and  k.nls like '1508%'  then
                r012_ :=f_get_r012_for_1508(k.acc);
             end if;

             kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||r012_||s580a_||substr(k.kodp,12);

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
                comm_ := SUBSTR (' резерв під борг відносимо до R012='||r012_||'(1)' , 1,200);
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

                comm_ := SUBSTR (' резерв під борг відносимо до R012='||r012_||'(2)' , 1,200);
             end if;
          end if;

          if znap_ <> '0' then
             if (discont_ <> 0 or premiy_ <> 0) then
                se_ := nvl(abs(fostq_new(k.acc, dat_, dati_)), 0); -- залишок по кредиту

                insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
                values(k.nd, k.acc, k.nls, k.kv, kodp_, k.sump, se_, k.discont_row, premiy_);
             end if;

             if nbs_ = '3690' then
                kodp_ := substr(kodp_, 1, 9) || '0' || substr(kodp_, 11);
                znap_ := to_char(k.szq);
                comm_ := '';
                srezp_ := 0;
             end if;

             INSERT INTO rnbu_trace
                      ( recid, userid, nls, kv, odate,
                        kodp, znap, acc, rnk, isp, mdate,
                        comm, nd, nbuc, tobo )
               VALUES ( s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv,
                        data_, kodp_, znap_, k.acc, k.rnk, k.isp, k.mdate,
                        comm_, k.nd, nbuc_, k.tobo );
          end if;

          if srezp_ <> 0 and not TP_SND and k.cnt = k.rnum then

-- превышение резерва при наличии только одной строки проц.счета
             if k.cnt =1 and k.nls like '3118%' then

                if r013_30 = 1 then
--   rez_30 нужно показать с R013=B,R012=B
--        оставшийся нераспределенный резерв:  R013=r013_,R012=B
                   nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr_30);
                   sum_ := least ( k.szq_30, srezp_ );

                   kodp_ := '2'||nbs_||substr(nbs_r013_, 5,1)||substr(k.kodp, 7,3)||'B'||s580a_||substr(k.kodp,12);

                   znap_ := sum_;

                      INSERT INTO rnbu_trace
                               ( recid, userid, nls, kv, odate,
                                 kodp, znap, acc, rnk, isp, mdate,
                                 comm, nd, nbuc, tobo )
                        VALUES ( s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv,
                                 data_, kodp_, znap_, k.acc, k.rnk, k.isp, k.mdate,
                                 comm_, k.nd, nbuc_, k.tobo );

                   srezp_ := srezp_ - sum_;
                else
--   (rez_-rez_30) нужно показать с R013=A,R012=B
--        оствшийся нераспределенный резерв с R013=r013_,R012=B
                   nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);
                   sum_ := least ( k.szq-k.szq_30, srezp_ );

                   kodp_ := '2'||nbs_||substr(nbs_r013_, 5,1)||substr(k.kodp, 7,3)||'B'||s580a_||substr(k.kodp,12);

                   znap_ := sum_;

                      insert into rnbu_trace
                               ( recid, userid,
                                 nls, kv, odate, kodp,
                                 znap, acc, rnk, isp, mdate,
                                 comm, nd, nbuc, tobo )
                        values ( s_rnbu_record.NEXTVAL, userid_,
                                 k.nls, k.kv, data_, kodp_,
                                 znap_, k.acc, k.rnk, k.isp, k.mdate,
                                 comm_, k.nd, nbuc_, k.tobo );

                   srezp_ := srezp_ - sum_;
                end if;
             end if;

             if srezp_ <> 0  then
                r012_ :='B';
                if nbs_='1592' and  k.nls like '1500%'  then  r012_:='I';  end if;
                if nbs_='1592' and  k.nls like '1502%'  then  r012_:='J';  end if;
                if nbs_='1592' and  k.nls like '1508%'  then
                    r012_ :=f_get_r012_for_1508(k.acc);
                end if;

                kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7,3)||r012_||s580a_||substr(k.kodp,12);

                znap_ := srezp_;
                comm_ := SUBSTR(' перевищення резерву над осн. боргом до R012='||r012_, 1,200);

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
         kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7,3)||'B'||s580a_||substr(k.kodp,12);

         if k.rnum = 1 then
              discont_ := k.discont;
              premiy_ := k.prem;
         end if;

         if discont_ <> 0 or premiy_ <> 0 then
            se_ := nvl(abs(fostq_new(k.acc, dat_, dati_)), 0);

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, k.kodp, k.sump, se_, k.discont_row, premiy_);
         end if;
      end if;
   end loop;

   for k in (select acc, nbs, nls, kv, rnk, s080, szq, isp, mdate, tobo, r031, r030,
                    r013, s580, rez, discont, prem, nd, id, ob22, custtype, accr, tip
               from ( select /*+index(t PK_NBU23REZ_ID) */
                             t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                             gl.p_icurval(t.kv, t.sz - t.rez_30, dat_) szq,
                             a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                             r031, decode(lpad(l.r030, 3, '0'), '974', '933', lpad(l.r030, 3, '0')) r030,
                             nvl(s.r013, '0') r013, t.rz rez,
                             nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                             nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                             t.nd, t.id, nvl(s.s580, '0') s580, a.ob22, c.custtype, t.accr, a.tip
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
                      select /*+index(t PK_NBU23REZ_ID) */
                             t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                             gl.p_icurval(t.kv, t.rez_30, dat_) szq,
                             a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                             r031, decode(lpad(l.r030, 3, '0'), '974', '933', lpad(l.r030, 3, '0')) r030,
                             nvl(s.r013, '0') r013, t.rz rez,
                             nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                             nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                             t.nd, t.id, nvl(s.s580, '0') s580, a.ob22, c.custtype, t.accr_30 accr, a.tip
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
                      union
--   добавлены счета просроченных процентов
--   в этом блоке они разбиваются аналогично #A7 (по эквиваленту на две части)
                      select /*+index(t PK_NBU23REZ_ID) */
                             t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                             gl.p_icurval(t.kv, t.sz - t.rez_30, dat_) szq,
                             a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                             r031, decode(lpad(l.r030, 3, '0'), '974', '933', lpad(l.r030, 3, '0')) r030,
                             nvl(s.r013, '0') r013, t.rz rez,
                             nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                             nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                             t.nd, t.id, nvl(s.s580, '0') s580, a.ob22, c.custtype, t.accr, a.tip
                        from v_tmp_rez_risk_c5 t,
                             accounts a, specparam s, customer c, kl_r030 l
                       where t.dat = datr_
                         and (    t.nls like '1419%'  or  t.nls like '1429%'
                              or  t.nls like '1519%'  or  t.nls like '1529%'
                              or  t.nls like '2039%'  or  t.nls like '2069%'
                              or  t.nls like '2089%'  or  t.nls like '2109%'
                              or  t.nls like '2119%'  or  t.nls like '2129%'
                              or  t.nls like '2139%'  or  t.nls like '2209%'
                              or  t.nls like '2239%' )
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
                      select /*+index(t PK_NBU23REZ_ID) */
                             t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                             gl.p_icurval(t.kv, t.rez_30, dat_) szq,
                             a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                             r031, decode(lpad(l.r030, 3, '0'), '974', '933', lpad(l.r030, 3, '0')) r030,
                             nvl(s.r013, '0') r013, t.rz rez,
                             nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                             nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                             t.nd, t.id, nvl(s.s580, '0') s580, a.ob22, c.custtype, t.accr_30 accr, a.tip
                        from v_tmp_rez_risk_c5 t,
                             accounts a, specparam s, customer c, kl_r030 l
                       where t.dat = datr_
                         and (    t.nls like '1419%'  or  t.nls like '1429%'
                              or  t.nls like '1519%'  or  t.nls like '1529%'
                              or  t.nls like '2039%'  or  t.nls like '2069%'
                              or  t.nls like '2089%'  or  t.nls like '2109%'
                              or  t.nls like '2119%'  or  t.nls like '2129%'
                              or  t.nls like '2139%'  or  t.nls like '2209%'
                              or  t.nls like '2239%' )
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

--      IF typ_ > 0 THEN
--         nbuc_ := NVL (F_Codobl_Tobo (k.acc, typ_), nbuc1_);
--      ELSE
--         nbuc_ := nbuc1_;
--      END IF;

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

      if k.s580 <> '0' then
         s580a_ := k.s580;
      else
          begin
             select max(S580)
             into s580a_
             from otc_risk_s580
             where s580 <> 'R' and
                   R020 = k.nbs and
                   T020 in ('1', '3') and
                   (r013 = k.r013 or r013 = '0');
          exception
            when no_data_found then
                s580a_ := '0';
          end;

          if s580a_ = '0' then
             s580_ := null;

             p_set_s580_def(substr(k.nls, 1, 4), k.r013);

             if s580_ is not null then
                s580a_ := s580_;
             else
                s580a_ := '9';
             end if;
          end if;
      end if;

--      s580a_ := (case when nbs_||r013_ in ('15904','15921','24006','24016') then '9' else s580a_ end);

 --  сегмент Q + сегмент WWW : умолчания
          r017_ := '3';
          segm_WWW := LPAD (k.kv, 3,'0');

      select count( * ) into cnt_ from otcn_fa7_temp where r020 = k.nbs;

      -- ознака рахунку нарахованих відсотків
      TP_SND := (case when substr(k.nls, 1,1) in ('1','2','3') and
                           ( substr(k.nls, 4,1) = '9' or
                             (substr(k.nls,1,4) in ('2607','2627','2657') and k.tip = 'SNA') or
                             (substr(k.nls,4,1) = '8' and k.tip = 'SNA')
                           ) and
                           substr(k.nls,1,4) not in ('1818','1819','2809','3519','3559')
                      then true else false end);

      if k.szq <> 0 then
          if TP_SND then

             r012_:='B';
             if nbs_='1592' and k.nls like '1508%'  then
                r012_ :=f_get_r012_for_1508(k.acc);
             end if;

             -- прострочені відсотки
             if sakt_ = 0 then
                comm_ := SUBSTR (' резерв під погашені проценти (залишок = 0) відносимо до R012='||r012_, 1,200);
             else
                comm_ := SUBSTR (' резерв під прострочені проценти відносимо до R012='||r012_, 1,200);
             end if;

             kodp_ := '2'||nbs_||r013_||k.r030||r012_||s580a_||r017_||segm_WWW;

             znap_ := to_char(k.szq);
          else
             if substr(k.nls, 4, 1)  = '7' and
                substr(k.nls, 1, 4) not in ('2607','2627','2657')
             then
                kodp_ := '2'||nbs_||r013_||k.r030||'B'||s580a_||r017_||segm_WWW;
                znap_ := to_char(k.szq);

                comm_ := SUBSTR (' резерв під прострочку по осн. борг відносимо до R012 = B ' , 1, 200);
             else

                r012_:='A';
                if nbs_='1592' and  k.nls like '1500%'  then  r012_:='I';  end if;
                if nbs_='1592' and  k.nls like '1502%'  then  r012_:='J';  end if;
                if nbs_='1592' and  k.nls like '1508%'  then
                   r012_ :=f_get_r012_for_1508(k.acc);
                end if;

                kodp_ := '2'||nbs_||r013_||k.r030||r012_||s580a_||r017_||segm_WWW;
                znap_ := to_char(srez_);

                comm_ := SUBSTR (' резерв під осн. борг відносимо до R012='||r012_||' R013R='||r013_, 1, 200);
             end if;

             discont_ := k.discont;
             premiy_ := k.prem;

             if discont_ <> 0 or premiy_ <> 0 then
                se_ := nvl(abs(fostq_new(k.acc, dat_, dati_)), 0); -- залишок по кредиту

                insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
                values(k.nd, k.acc, k.nls, k.kv, kodp_, se_, se_, discont_, premiy_);
             end if;
          end if;

          if znap_ <> '0' then
              if nbs_ = '3690' then
                 kodp_ := substr(kodp_, 1, 9) || '0' || substr(kodp_, 11);
                 znap_ := to_char(k.szq);
                 comm_ := '';
                 srezp_ := 0;
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

          if srezp_ <> 0 and not TP_SND then

             r012_ :='B';
             if nbs_='1592' and  k.nls like '1500%'  then  r012_:='I';  end if;
             if nbs_='1592' and  k.nls like '1502%'  then  r012_:='J';  end if;
             if nbs_='1592' and  k.nls like '1508%'  then
                r012_ :=f_get_r012_for_1508(k.acc);
             end if;

             kodp_ := '2'||nbs_||r013_||k.r030||r012_||s580a_||r017_||segm_WWW;
             znap_ := srezp_;

             if sakt_ = 0 then
                comm_ := SUBSTR (' резерв за осн.боргом, у якого залишок = 0, відносимо до R012='||r012_, 1, 200);
             else
                comm_ := SUBSTR (' перевищення резерву над осн. боргом до R012='||r012_||' R013R='||r013_ , 1, 200);
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
         r012_ := 'B';
         if nbs_='1592' and  k.nls like '1500%'  then  r012_:='I';  end if;
         if nbs_='1592' and  k.nls like '1502%'  then  r012_:='J';  end if;
         if nbs_='1592' and  k.nls like '1508%'  then
            r012_ :=f_get_r012_for_1508(k.acc);
         end if;

         kodp_ := '2'||nbs_||r013_||k.r030||r012_||s580a_||r017_||segm_WWW;

         discont_ := k.discont;
         premiy_ := k.prem;

         if discont_ <> 0 or premiy_ <> 0 then
            se_ := nvl(abs(fostq_new(k.acc, dat_, dati_)), 0);

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, kodp_, se_, se_, discont_, premiy_);
         end if;
      end if;
   end loop;

   update rnbu_trace r
   set kodp = substr(kodp, 1, 9) || 'C' || substr(kodp, 11),
       comm = comm || ' C-D-1'
   where r.acc in (select acc
                   from OTCN_FA7_REZ2
                   where pr <> 3)
     and r.kodp like '%D_____'
     and not exists (select 1
                     from OTCN_FA7_REZ1 p
                     where p.nd = r.nd and
                           substr(p.nls,1,3) = substr(r.nls,1,3) and
                           p.kv = r.kv and
                           substr(p.nls,4,1) in ('7', '9') and
                           to_number(p.znap) <> 0)
     and exists (select 1
                     from OTCN_FA7_REZ1 p
                     where p.nd = r.nd and
                           substr(p.nls,1,3) = substr(r.nls,1,3) and
                           p.kv = r.kv and
                           substr(p.nls,4,1) not in ('7', '9') and
                           to_number(p.znap) <> 0);

  update rnbu_trace r
   set kodp = substr(kodp, 1, 9) || 'C' || substr(kodp, 11),
       comm = comm || ' C-D-1'
   where r.kodp like '2___6%D_____'
     and r.acc not in (select acc
                       from nbu23_rez
                       where fdat = datr_);

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
                        (case when substr(b.nls,4,1) = '7' or
                                   substr(b.kodp,11,1) = 'B'
                              then 'D' else 'C'
                        end) r012_a, b.s580_a,
                        b.suma, b.sumk, b.r013_a,
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
                        (select a.ND, a.ACC, a.NLS, a.KV, a.KODP,
                            substr(a.kodp, 11, 1) s580_a,
                            to_number(a.ZNAP) suma,
                            a.SUMA sumk, a.SUMD, a.SUMP, nvl(s.r013,'0') r013_a
                         from OTCN_FA7_REZ1 a, specparam s
                         where a.suma <> 0 and
                            substr(a.nls, 4, 1) not in ('7', '8', '9') and
                            a.acc = s.acc(+)) b
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
             sumc_ := k.sumdp_k + over_;
          else
             sumc_ := sumc_ + k.sumdp_k;
          end if;

          if k.rnum = k.cnt then
             rizn_ := to_number(k.znap) - sumc_;
          end if;

          if k.s580_a not in ('0', '9') then
             s580a_ := k.s580_a;
          else
              begin
                 select max(S580)
                 into s580a_
                 from otc_risk_s580
                 where s580 <> 'R' and
                       R020 = substr(k.nlsa,1,4) and
                       T020 in ('1', '3') and
                       (r013 = k.r013_a or r013 = '0');
              exception
                when no_data_found then
                    s580a_ := '0';
              end;

              if s580a_ = '0' then
                 s580_ := null;

                 p_set_s580_def(substr(k.nlsa, 1, 4), k.r013_a);

                 if s580_ is not null then
                    s580a_ := s580_;
                 else
                    s580a_ := '9';
                 end if;
              end if;
          end if;

          kodp_ := substr(k.kodp, 1, 9) ||
            (case when substr(k.nlsa,4,1) in ('7', '9') then 'D' else k.r012_a end)||s580a_||substr(k.kodp,12);

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
                 kodp_ := substr(k.kodp, 1, 9) ||'D'||s580a_||substr(k.kodp,12);

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

   select count( * )
   into fl_cp_
   from rnbu_trace
   where kodp like '23190%' or
         kodp like '23290%';

   OPEN saldo_cp;

   LOOP
      FETCH saldo_cp
       INTO acc_, nls_, kv_, data_, nbs_, tips_,
            r013_, mdate_, sn_, rnk_, isp_, tobo_, r012_, r030_, s580_;
      EXIT WHEN saldo_cp%NOTFOUND;

      IF typ_ > 0 THEN
         nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      r013_ := NVL (TRIM (r013_), '0');

      if nvl(trim(r012_),'0') = '0' then
         r012_ := 'B';
      end if;

 --  сегмент Q + сегмент WWW : умолчания
          r017_ := '3';
          segm_WWW := LPAD (kv_, 3,'0');

     IF kv_ <> 980 THEN
         se_ := gl.p_icurval (kv_, sn_, dat_);
      ELSE
         se_ := sn_;
      END IF;

      dk_ := iif_n (se_, 0, '1', '2', '2');

      kodp_ := dk_ || nbs_ || r013_ || r030_ || r012_ || s580_||r017_||segm_WWW;

      znap_ := to_char(abs(se_));

      INSERT INTO rnbu_trace
                  (recid, userid, nls, kv, odate, kodp,
                   znap, acc, rnk, isp, mdate,
                   comm, nbuc, tobo
                  )
           VALUES (s_rnbu_record.NEXTVAL, userid_,
                   nls_, kv_, data_, kodp_,
                   znap_, acc_, rnk_, isp_, mdate_,
                   null, nbuc_, tobo_
                  );
   end loop;

   close saldo_cp;

--------------------------------------------------
-- списання за рахунок резерву
   declare
      recid_    number;
      granica_  number := 100;
      mask_     varchar2(100);
   begin
      for k in (select fdat, ref, acc, nls, kv, sq, nbs, acca, nlsa,
                       sum(sq) over (partition by acc) sum_all
                from (select /*+ ordered index(o, IDX_OPLDOK_KF_FDAT_ACC)  */
                             o.fdat, o.ref, o.acc, a.nls, a.kv,
                             decode(o.dk, 0, -1, 1) * gl.p_icurval(a.kv, o.s, dat_) sq,
                             a.nbs, z.acc acca, x.nls nlsa
                      from accounts a, opldok o, opldok z, accounts x, oper p
                      where o.fdat = any (select fdat from fdat where fdat between datp_ and dat_) and
                        o.acc = a.acc and
                        (a.nls like '159%' or
                         a.nls like '189%' or
                         a.nls like '240%' or
                         a.nls like '289%' or
                         --a.nls like '319%' or
                         a.nls like '329%' or
                         a.nls like '359%' or
                         a.nls like '369%')
                        and o.tt not like 'AR%'
                        and o.ref = z.ref
                        and o.fdat = z.fdat
                        and o.stmt = z.stmt
                        and o.dk <> z.dk
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
                      if k.nlsa like '7%' then
                         begin
                             if k.nls like '3590%' then
                                mask_ := '355%';
                             else
                                mask_ := null;
                             end if;

                             if mask_ is not null then
                                 select r.recid, r.kodp, r.znap
                                 into recid_, kodp_, znap_
                                 from opl o, rnbu_trace r
                                 where o.fdat = k.fdat and
                                       o.nls like mask_ and
                                       o.kv = k.kv and
                                       o.sq = abs(k.sq) and
                                       o.acc = r.acc and
                                       rownum = 1;
                             else
                                recid_ := null;
                             end if;
                         exception
                             when no_data_found then
                                recid_ := null;
                         end;
                      else
                         recid_ := null;
                      end if;
               end;

               if recid_ is not null then
                  INSERT INTO rnbu_trace
                              (recid, userid, nls, kv, odate, kodp,
                               znap, acc, rnk, isp, mdate, ref,
                               comm, nbuc, tobo
                              )
                   select s_rnbu_record.NEXTVAL recid,
                          userid, nls, kv, odate, kodp,
                          to_char(k.sq), acc,
                          rnk, isp, mdate, k.ref,
                          'Списання за рахунок резерву РЕФ = '||to_char(k.ref) comm,
                          nbuc, tobo
                   from rnbu_trace
                   where recid = recid_;
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
                                          '2400','2401','2890','3190','3290','3590','3599','3690',
                                          '9010','9015','9030','9031','9036','9500')
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
                            min((case when substr(kodp, 10, 1) = 'B' then '1' else '2' end)||
                                 substr(kodp, 6, 1)||substr(kodp, 10, 1)) R013_s580,
                            min((case when substr(kodp, 10, 1) = 'A' then '1' else '2' end)||
                                 substr(kodp, 6, 1)||substr(kodp, 10, 1)) R013_s580_A
                        from rnbu_trace r, customer c
                        where substr(r.kodp, 2, 4) in ('1410','1412','1415','1416','1417','1418',
                                      '1490','1491','1492','1493','1590','1592','1890',
                                      '2400','2401','2890','3190','3290','3590','3599','3690',
                                      '9010','9015','9030','9031','9036','9500')
                          and r.rnk = c.rnk
                        group by r.nbuc, substr(r.kodp, 1, 1), 2-MOD(c.codcagent,2),substr(r.kodp, 2, 4), r.kv) b
                    on (a.nbuc = b.nbuc and a.t020 = b.t020 and a.rez = b.rez and a.nbs = b.nbs and a.kv = b.kv)
                where abs(nvl(a.ostq, 0) - nvl(b.ostq, 0)) between 1 and granica_
                order by 1, 2 )
       loop
          begin
             if k.nbs not in ('2400','2401') then
                begin
                   select r.recid
                   into recid_
                   from rnbu_trace r, customer c
                   where r.nbuc = k.nbuc and
                         r.kodp like k.t020||k.nbs||'_'||lpad(k.kv, 3, '0')||'B%' and
                         substr(kodp, 6, 1)||substr(kodp, 10, 1) = substr(k.R013_s580,2,2) and
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
                                 r.kodp like k.t020||k.nbs||'_'||lpad(k.kv, 3, '0')||'A%' and
                                 substr(kodp, 6, 1)||substr(kodp, 10, 1) = substr(k.R013_s580_A,2,2) and
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
                                         r.kodp like k.t020||k.nbs||'_'||lpad(k.kv, 3, '0')||'%' and
                                         substr(kodp, 6, 1)||substr(kodp, 10, 1) = substr(k.R013_s580,2,2) and
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
             else
                begin
                   select r.recid
                   into recid_
                   from rnbu_trace r, customer c
                   where r.nbuc = k.nbuc and
                         r.kodp like k.t020||k.nbs||'4'||lpad(k.kv, 3, '0')||'B%' and
                         substr(kodp, 6, 1)||substr(kodp, 10, 1) = substr(k.R013_s580,2,2) and
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
                                 substr(kodp, 6, 1)||substr(kodp, 10, 1) = substr(k.R013_s580,2,2) and
                                 r.kodp like k.t020||k.nbs||'5'||lpad(k.kv, 3, '0')||'B%' and
                                (sign(k.rizn) = -1 and to_number(r.znap) >= abs(k.rizn) or
                                 sign(k.rizn) = 1 and to_number(r.znap) > 0) and
                                 r.rnk = c.rnk and
                                 2-MOD(c.codcagent,2) = k.rez and
                                rownum = 1;
                       exception
                            when no_data_found then
                               select r.recid
                               into recid_
                               from rnbu_trace r, customer c
                               where r.nbuc = k.nbuc and
                                     r.kodp like k.t020||k.nbs||'_'||lpad(k.kv, 3, '0')||'_%' and
                                     substr(kodp, 6, 1)||substr(kodp, 10, 1) = substr(k.R013_s580_A,2,2) and
                                    (sign(k.rizn) = -1 and to_number(r.znap) >= abs(k.rizn) or
                                     sign(k.rizn) = 1 and to_number(r.znap) > 0) and
                                     r.rnk = c.rnk and
                                     2-MOD(c.codcagent,2) = k.rez and
                                    rownum = 1;
                       end;
                end;
             end if;
          exception
             when no_data_found then
                  recid_ := null;
          end;

          if recid_ is not null then
              update rnbu_trace
              set znap = to_char(to_number(znap) + k.rizn),
                comm = substr(comm || ' + вирів-ня з балансом на '||to_char(k.rizn), 1, 200)
              where recid = recid_;
          end if;
       end loop;
   end;

--------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = 'C5' AND datf = dat_;

---------------------------------------------------
   INSERT INTO tmp_nbu(kodf, datf, kodp, znap, nbuc)
   SELECT 'C5', dat_, kodp, SUM (znap), nbuc
   FROM rnbu_trace
   GROUP BY kodp, nbuc
   having SUM (znap)<> 0;

   DELETE FROM OTC_C5_PROC WHERE datf = dat_;

   INSERT INTO otc_c5_proc
            ( datf, rnk, nd, acc, nls, kv, kodp, znap )
     SELECT dat_ datf,
            r.rnk,
            r.nd,
            r.acc,
            r.nls,
            r.kv,
            r.kodp,
            DECODE (SUBSTR (r.kodp, 1, 1), '1', -1, 1) * r.znap znap
       FROM rnbu_trace r
      WHERE SUBSTR (r.kodp, 2, 5) IN
                   (SELECT r020 || s240
                      FROM kl_f3_29
                     WHERE kf = '42' AND ddd IN ('101', '201')) and
            not (substr(kodp, 1, 6) in ('215901', '215904', '235903') and
                 substr(kodp,10,1) in ('F', 'H'));

    delete from OTC_C5_PROC c
    WHERE datf = dat_
          AND KODP LIKE '23690%'
          AND acc in (SELECT ACC
                      FROM RNBU_TRACE
                      WHERE KODP LIKE '191299%');

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

   logger.info ('P_FC5: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END;
/