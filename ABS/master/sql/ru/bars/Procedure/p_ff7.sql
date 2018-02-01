CREATE OR REPLACE PROCEDURE BARS.p_ff7 (Dat_ DATE, p_sheme_ varchar2 default 'G',
    typf_ number default 0, isf8_ number default 0)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования файла #F7 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
%
% VERSION      :  v.18.001     29.01.2018    (12/09/2017)
%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
23.01.2018 новый сегмент в показателе для #F8
               -расширена рабочая таблица otc_ff7_history_acc
10/03/2017 для карточных счетов овердрафтов 2605 наполняем табл.
           OTCN_F71_TEMP из W4_ACC (не включались 2605 в файл)
01/02/2017 не удаляем счета овердрафтов которые пассивные и которые есть
           в ACC_OVER
24/01/2017 в блок овердрафтов добавлены счета 2605/2625 по табл.w4_acc
20/12/2016 не включаем счета оверов если есть OSTQ_KD > 0 а остаток 
           в течении месяца не был активным
28/09/2016 для бал.счетов 2607,2627 номер договора будет заполняться из 
           из портфеля оверов из основного счета 
19/09/2016 изменил блок обработки изменения поля ND 
           для бал.счетов 2607,2627 в OTC_FF7_HISTORY_ACC 
           (будем выбирать из предыдущей отчетной даты этой же таблицы
            если данный счет отсутствует в INT_ACCN)
12/08/2016 для бал.счетов 2607,2627 поле ND в OTC_FF7_HISTORY_ACC будем
           из предыдущей отчетной даты этой же таблицы
           если данный счет отсутствует в INT_ACCN
10/08/2016 для счетов овердрафтов при заполнении кода "CC" остаток по
           счету может быть и пассивный
09/06/2016 для выборки из OPLDOK(ов) добавил условие по полю FDAT
02/06/2016 для счетов 1502 будем включать если есть Дт или Кт оборот
23/01/2014 для ГОУ (300465) убрал блок для изменения кодов 13,15 на 12,14
           для бал.счетов 1 класса
24/09/2013 доопрацювання по рахунку 3548
10/09/2013 для удаления счетов 9 класса из OTC_FF7_HISTORY_ACC добавил
           условие FDAT <= dat_
12/08/2013 из OTC_FF7_HISTORY_ACC удаляем отдельно счета 9 класса
           (кредиты никогда они не выдавались) и все осатальные
           счета по которым выдача была после отчетной даты
09/08/2013 для отрицательных сумм погашения оведрафтов (KOSQ < 0)
           изменяем данное поле  на ABS(OSTQ) - ABS(KOSQ)

принцип формирования показателей:

    03 - количество кредитных договоров на отчётную дату.
            Договора, у которых есть остаток на отчётную дату хотя бы на одном из счетов основной задолженности, дисконта, премии, процентов, 9129.

    07 - количество новых кредитных договоров.
           Дата открытия договора (если договора нет - счета) принадлежит отчетному периоду

    08 - количество закрытых кредитных договоров.
           Договора, у которых остатки по основной задолженности, дисконт, премия, проценты, 9129 обнулились.

    12 - изменения в объёме задолженности - выдача по новым кредитным договорам
            Из файла #03 (таблица rnbu_history) Дт-оборот (для овердрафтов - остаток)  по договорам указанным в dd=07.

    13 - изменения в объёме задолженности - выдача в рамках действующих кредитных договоров
           Из файла #03 (таблица rnbu_history) Дт-оборот (для овердрафтов - остаток)  по договорам к-е есть в показателе 03
           и нет в 07 и 08

    14 - изменения в объёме задолженности - закрытие кредитных договоров
            Кт-оборот по основной задолженности (с учетом переноса на просрочку) по договорам указанным в dd=08.

    15 - изменения в объёме задолженности - погашение в рамках действующих кредитных договоров
            Кт-оборот по основной задолженности (с учетом переноса на просрочку) по договорам к-е есть в показателе 03
           и нет в 07 и 08

    18 - изменения в объёме задолженности - другое
            Обороты на протяжении отчётного периода по счетам процентов, дисконта, премии. - сумма (Дт - Кт)
            Эти счет определяются из табл. kl_f3_29 поле S260 = 1

Особенности:

    1. Номер договора к которому относится счет определяется следующим образом -
       - референс из портфеля кредитов (юр, физ, МБК, овердрафтов)
       - если договора в портфеле нет - номер берется из параметра "Номер договору (ф.71)" по счету
       - если параметр не заполнен, каждый счет считается отдельным договором

    2.    Договора, которые были оформлены и погашены на протяжении отчётного периода, показывается по кодам dd:
        -    07 - как оформление нового договора;
        -    08 - как закрытие договора;
        -    12 - как выдача по новым кредитным договорам;
        -    14 - как закрытие кредитных договоров.

    3. По овердрафтам исключаются те счета, по которым в течении отчетного месяца не было активных остатков.

    4. Для овердрафтов считаем КТ-обороты (погашение) исходя из
        - входящего остатка за месяц (исходящий остаток за предыдущую дату),
        - исходящего остатока за текущий месяц
        - Выдачи за текущий месяц (из файла #03)
        т.о.
         1. Вх >= 0  Исх = 0  -  Погаш = Выдача
         2. Вх >= 0  Исх < 0  -  Погаш = Выдача - abs(Исх)
         3. Вх < 0  Исх = 0  -  Погаш = Выдача + abs(Вх)
         4. Вх < 0  Исх < 0  -  Погаш = Выдача + abs(Вх) - abs(Исх)

    5. Овердрафтами считаются договора которые есть в портфеле овердрафтов (табл. ACC_OVER или ACC_OVER_ARCHIVE)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='F7';
acc_     Number;
dk_      Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
dd_      Varchar2(2);
mdate_   Date;
data_    Date;
kv_      SMALLINT;
se_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
kodp_    Varchar2(16);
znap_    Varchar2(30);
cc_      Varchar(3);
userid_  Number;
sql_acc_ varchar2(2000):='';
ret_     number;
rnk_     number;
codcagent_ number;

nd_     number;
sdate_  date;
wdate_  date;
sos_    number;
comm_   varchar2(200);
datp_   date;
datb_   date;
mfo_    number;
mfou_   number;
default_   number;
is_upb     number := 0;
kosq_   number;

typ_     number;
nbuc_    varchar2(12);
nbuc1_   varchar2(12);

sheme_   varchar2(1) := p_sheme_;
dat_kl_  date := add_months(trunc(dat_, 'mm'), 1);
dat_spr_ date := last_day(dat_)+1;

BEGIN
commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
logger.info ('P_FF7: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;

if isf8_=0 then
    EXECUTE IMMEDIATE 'delete from RNBU_TRACE';
end if;

EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';
EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';
-------------------------------------------------------------------
mfo_ := f_ourmfo;

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

if 300465 in (mfo_, mfou_) then
   sheme_ := 'C';
end if;

-- определение начальных параметров (код области или МФО или подразделение)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);
nbuc_ := nbuc1_;

--Кроме ГОУ Сбербанка.
if 300465 not in  (mfo_) then
    sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''F7'' and r020 not like ''1%'' ';
else
    sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''F7'' ';
end if;

is_upb := 1;

if 300120 in (mfo_, mfou_) then
   default_ := 1; -- для s260='00', устанавливаем по-умолчанию s260='06'
else
   default_ := 0;
end if;

default_ := 0; --Петрокомерц отказался

datb_ := trunc(dat_, 'mm'); -- дата начала месяца

select max(fdat) -- прошлая отчетная дата
into datp_
from fdat
where fdat<datb_ and fdat NOT IN (SELECT holiday FROM holiday);

if dat_ = to_date('31012013','ddmmyyyy') then
   datp_ := to_date('29122012','ddmmyyyy');
end if;

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);                 -- внутри вызывается f_pop_otcn_snp

delete from otc_ff7_history_acc where datf=dat_ ;

--не овердрафты и не МБК для всех банков кроме ГОУ Сбербанка
--для ГОУ Сбербанка выбираются ВСЕ СЧЕТА
insert into otc_ff7_history_acc(DATF, ACC, ACCC, NBS, SGN, NLS, KV, NMS, DAOS, DAZS, OST,
       OSTQ, DOSQ, KOSQ, ND, NKD, SDATE, WDATE, SOS, RNK, STAFF, TOBO, s260, k110, s031
       ,tip, ostq_kd, r011, r_dos, cc_id, s245)
select distinct 
       dat_, tt.ACC, tt.ACCC, tt.NBS, tt.SGN, tt.NLS, tt.KV, tt.NMS, tt.DAOS, tt.DAZS, tt.OST,
       tt.OSTQ, tt.DOSQ, tt.KOSQ, tt.ND, tt.NKD, tt.SDATE, tt.WDATE, tt.SOS, tt.RNK, tt.u_id, tt.TOBO, tt.s260, tt.ved, tt.s031
       ,tt.tip, tt.ostq_kd, tt.r011,
      --Для оверов r.ost, для остальных - r.dos
       nvl(rr.r_dos, 0) --суммы выдачи
       ,tt.cc_id, '1'
from (
select /*+ leading(s) hash(s) full(o) */
       s.acc, o.isp accc, substr(o.nls,1,4) nbs, decode(sign(s.ost-s.dos96+s.kos96),-1,'1',1,'2','0') sgn,
       o.nls, o.kv, o.nms, o.daos, o.dazs, s.ost-s.dos96+s.kos96 ost,
       decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96) ostq,
       decode(o.kv, 980, s.dos+s.dos96-s.dos96p, gl.p_icurval (o.kv, s.dos+s.dos96-s.dos96p, dat_)) dosq,
       decode(o.kv, 980, s.kos+s.kos96-s.kos96p, gl.p_icurval (o.kv, s.kos+s.kos96-s.kos96p, dat_)) kosq,
       nvl(to_char(c.nd), decode(trim(p.nkd), null,'-'||to_char(s.acc), '№'||trim(p.nkd))) nd,
       null nkd, -- якщо немає ND, то підставляємо ACC
       c.sdate, c.wdate, c.sos, s.rnk, user_id u_id, o.tobo,
       f_get_s260(c.nd, s.acc, p.s260, s.rnk, o.nbs,default_) s260,
       z.ved, p.s031, nvl(c.tip, o.tip) tip, nvl(trim(p.r011), '0') r011,
       --в сумму по договору включаем остатки с учетом знака по таблице kl_f3_29
       --например для 2625 только активные остатки
       sum(decode(decode(sign(decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96)),-1,'1','2'),n.r012,
           decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96), 0))
           over(partition by nvl(to_char(c.nd), decode(trim(p.nkd), null,'-'||to_char(s.acc), '№'||trim(p.nkd))), s.rnk) ostq_kd,
       --сумма Дт оборотов по договору
       sum(s.dos+s.dos96) over(partition by nvl(to_char(c.nd), decode(trim(p.nkd), null,'-'||to_char(s.acc), '№'||trim(p.nkd))), s.rnk) dos_kd,
       --сумма Кт оборотов по договору
       sum(s.kos+s.kos96) over(partition by nvl(to_char(c.nd), decode(trim(p.nkd), null,'-'||to_char(s.acc), '№'||trim(p.nkd))), s.rnk) kos_kd,
       n.r012  , n.s240, c.cc_id, o.dapp
from OTCN_SALDO s, OTCN_ACC o,
   (select a.acc,
           -- Для ГОУ Сбербанка ND проставляем NULL -
           --номер договора будет браться со счета
           a.nd ,
           b.sdate, b.wdate, b.sos, 0 ost_9129, b.cc_id, a.tip
    from
         (select n.acc, max(n.nd) nd, decode(C.VIDD, 10, 'LVR', null) tip
             from nd_acc n, cc_deal c
             where n.nd=c.nd and c.sdate <= dat_  and 
                   c.vidd <> 110 
             group by n.acc, decode(C.VIDD, 10, 'LVR', null)
         ) a
         join cc_deal b on a.nd=b.nd
         --для кредитных линий в ситуации если все остатки и обороты по счетам нулевые, но есть лимит 9129
   ) c,
      specparam p, customer z, kl_f3_29 n
where s.acc = o.acc and
     not (substr(o.nls,1,4) in ('1508') and nvl(trim(p.r011),'1') !='6') and
     s.acc=c.acc(+) and
     s.acc=p.acc(+) and
     s.rnk=z.rnk and
     o.nls like n.r020 || '%' and
     n.kf='F7'
     and s.acc not in (select vv.acc_pk from w4_acc vv)
     and s.acc not in (select vc.acco from acc_over vc)
     and nvl(o.dazs, to_date('01014999','ddmmyyyy')) >= trunc(dat_,'mm')
    --было сделано для ГОУ Сбербанка - не уитывать счета 9603 для юр лиц
    and not (o.nls like '9603%' and z.custtype = 2)
) tt
left join (select r.acc, sum(decode(r.kv, 980,
                       decode(instr('1600,2600,2605,2620,2625,2650,2655,8025,',substr(r.nls,1,4)||','), 0 ,r.dos, decode(r.dos+r.kos,0,r.ost,0)),
                       decode(instr('1600,2600,2605,2620,2625,2650,2655,8025,',substr(r.nls,1,4)||','), 0 ,
                               gl.p_icurval(r.kv, (gl.p_ncurval(r.kv,r.dos,r.odate)), dat_),
                               gl.p_icurval(r.kv, (gl.p_ncurval(r.kv,decode(r.dos+r.kos,0,r.ost,0),r.odate)), dat_))
                    )) r_dos
from rnbu_history r, kl_f3_29 k
where r.odate between trunc(dat_,'mm') and dat_ and 
      trim(r.d020) != '03' and
      k.kf = 'F7' and
      r.nls like k.r020||'%'
group by r.acc) rr
on (tt.acc = rr.acc)
where (tt.nbs not in ('9129', '9020') and
       (tt.ostq_kd <> 0 or tt.dos_kd <> 0 or tt.kos_kd <> 0) and --есть остатки или обороты по какому-то из счетов договора
        not(tt.ost = 0 and tt.dosq = 0 and tt.kosq = 0 and nvl(tt.s240,'0') = '1')  -- не отображать счета %, диск/премии с нулевыми остатками и оборотами
         )
      or (mfou_ in (300465) and 
          tt.nbs in ('9020','9129') and 
          tt.ostq_kd = tt.ost and 
          tt.nms not like '%2625%' and 
          tt.dapp is not null and tt.dapp not in (tt.sdate, tt.daos)); -- перевірка чи видавався вже овердрафт 

logger.info ('P_FF7: etap 1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

execute immediate 'truncate table OTCN_F71_TEMP';

insert into OTCN_F71_TEMP
(
  RNK      , -- acc_pk
  ACC      , -- acc_pk
  P120     , -- acc_9129
  P125     , -- acc_2067
  P130     , -- acc_2069 
  P150     , -- acc_ovr
  P111     , -- dat_begin
  TP       , -- sos 
  P112     , -- dat_end  
  ND       , -- nd
  P110     , -- lim
  ISP      , -- lim_hist
  P113     , -- to_date('01014999','ddmmyyyy') deldate
  P090       -- substr(vv.card_code,1,30) NDOC 
)
select vv.acc_pk, vv.acc_pk, null, null, null, vv.acc_ovr,                                              
       vv.dat_begin, null,                                   
       vv.dat_end, vv.nd, 0,                                 
       null,                                               
       to_date('01014999','ddmmyyyy'),                      
       substr(vv.card_code,1,30)                               
from w4_acc vv, accounts a                                          
where vv.acc_pk = a.acc                                             
  and a.nbs = '2605';                                                

-- овердрафты
insert into otc_ff7_history_acc(DATF, ACC, ACCC, NBS, SGN, NLS, KV, NMS, DAOS, DAZS, OST,
       OSTQ, DOSQ, KOSQ, ND, NKD, SDATE, WDATE, SOS, RNK, STAFF, TOBO, s260, k110, s031
       ,tip, ostq_kd, r_dos, cc_id, r011, s245)
select *
from (
with sel_over as (select value acc, sdate, sos, wdate, nd, lim, lim_hist, deldate, ndoc
                    from (   
   select v.acco, v.acc_9129, v.acc_2067,v.acc_2069, datd sdate, v.sos, datd2 wdate  , v.nd,
                                         decode(a.nbs,'8021',a.lim,0) lim --У Демарка лимит овердрафта живет в поле accounts.lim
                                          ,  null lim_hist, to_date('01014999','ddmmyyyy') deldate, v.NDOC
                                  from acc_over v   , accounts a, accounts a1
                                  where datd <= dat_ and a.acc = v.acc
                                        and v.datd is not null 
                                        and a1.acc = v.acco and a1.nbs <> '2203'
                                        and v.nd not in (select nd from cc_deal where vidd in (10, 110))
                                    union all
                                  select vv.acco, vv.acc_9129, vv.acc_2067,vv.acc_2069, datd sdate, vv.sos, datd2 wdate, vv.nd ,
                                         decode(a.nbs,'8021',a.lim,0) lim
                                         , null lim_hist, nvl(vv.deldate,to_date('01014999','ddmmyyyy') ) deldate, vv.NDOC
                                  from acc_over_archive vv   , accounts a, accounts a1
                                  where vv.datd <= dat_ and vv.deldate >= trunc(dat_,'mm')  and a.acc = vv.acc
                                        and a1.acc = vv.acco and a1.nbs <> '2203'
                                        and vv.acco not in (select acco from acc_over)
                                        and vv.nd not in (select nd from cc_deal where vidd in (10, 110))
                                    union all
                                  select vv.acc acco, null acc_9129, null acc_2067, null acc_2069, 
                                         vv.p111 sdate, vv.tp sos,
                                         vv.p112 wdate, vv.nd, p110 lim, 
                                         vv.isp lim_hist, p113 deldate, substr(vv.p090,1,30) NDOC
                                  from otcn_f71_temp vv) UNPIVOT (VALUE
                                                                    FOR colname
                                                                    IN  (acc_9129,
                                                                        acc_2067,
                                                                        acc_2069,
                                                                        acco))      )
select dat_ fdat,
       tt.acc, tt.accc,tt.nbs, decode(sign(tt.ost),1,'2',-1, '1','0') sgn,
       tt.nls, tt.kv, tt.nms, tt.daos, tt.dazs,
       tt.ost,tt.ostq, tt.dosq, 
       decode(sign(nvl(tt.h_ostq,0)), -1,-- Вх < 0
                                decode(sign(nvl(tt.ostq,0)), -1, --Исх < 0
                                       sum( nvl(decode(instr('1600,2600,2605,2620,2625,2650,2655,8025,',tt.nbs||','), 0 ,r.dos, decode(r.dos+r.kos,0,r.ost,0)),0))
                                       + abs(nvl(tt.h_ostq,0)) - abs(nvl(tt.ostq,0)),--4. Вх < 0  Исх < 0  -  Погаш = Выдача + abs(Вх) - abs(Исх)
                                      -- 0,--Исх = 0
                                       sum(nvl(decode(instr('1600,2600,2605,2620,2625,2650,2655,8025,',tt.nbs||','), 0 ,r.dos, decode(r.dos+r.kos,0,r.ost,0)),0))
                                       + abs(nvl(tt.h_ostq,0))  --3. Вх < 0  Исх = 0  -  Погаш = Выдача + abs(Вх)
                                      ),
                                --Вх >= 0
                                decode(sign(nvl(tt.ostq,0)), -1, --Исх < 0
                                       sum( nvl(decode(instr('1600,2600,2605,2620,2625,2650,2655,8025,',tt.nbs||','), 0 ,r.dos, decode(r.dos+r.kos,0,r.ost,0)),0))
                                       - abs(nvl(tt.ostq,0)), --2. Вх >= 0  Исх < 0  -  Погаш = Выдача - abs(Исх)
                                      -- 0,--Исх = 0
                                       sum( nvl(decode(instr('1600,2600,2605,2620,2625,2650,2655,8025,',tt.nbs||','), 0 ,r.dos, decode(r.dos+r.kos,0,r.ost,0)),0))  -- 1. Вх >= 0  Исх = 0  -  Погаш = Выдача
                                      )
             ) kosq,
       tt.nd, tt.nkd,
       tt.sdate, tt.wdate, tt.sos, tt.rnk, tt.u_id, tt.tobo,
       tt.s260, tt.ved, tt.s031 ,tt.tip, 
       --в случае если счет привязан к нескольким договорам
       --остаток по договору определяем для договора с максимальным номером
       -- для остальных договоров = 0
       decode(nvl('-'||to_char(max_nd), tt.nd), tt.nd, tt.ostq_kd , 0) ostq_kd
       , sum( nvl(decode(instr('1600,2600,2605,2620,2625,2650,2655,8025,',tt.nbs||','), 0 ,r.dos, decode(r.dos+r.kos, 0, r.ost, 0)),0))  r_dos
       ,tt.ndoc, tt.r011, '1'
from (
select t.*,
       sum(decode(decode(sign(t.ostq),-1,'1','2'), r012, abs(t.ostq), 0))
       over(partition by t.nd, t.rnk) ostq_kd -- к общей сумме по договору прибавляем лимит овердрафта по счету 8021 (для Демарка)
       ,hi.ostq  h_ostq
from(
select  /*+ leading(c) full(o) */
       s.acc, o.isp accc, substr(o.nls,1,4) nbs, decode(sign(s.ost-s.dos96+s.kos96),-1,'1','2') sgn,
       o.nls, o.kv, o.nms, o.daos, o.dazs,
       decode(n.r012, 2, s.ost-s.dos96+s.kos96,least(0, s.ost-s.dos96+s.kos96)) ost,
       decode(n.r012, 2, decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96),
                           least(0, decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96))) ostq,
       decode(o.kv, 980, s.dos+s.dos96-s.dos96p, gl.p_icurval (o.kv, s.dos+s.dos96-s.dos96p, dat_)) dosq,
       decode(o.kv, 980, s.kos+s.kos96-s.kos96p, gl.p_icurval (o.kv, s.kos+s.kos96-s.kos96p, dat_)) kosq,
       '-'||to_char(c.nd) nd,
       null nkd, -- якщо немає ND, то підставляємо ACC
       max(c.nd) over(partition by s.acc) max_nd,
       c.sdate, c.wdate, c.sos, s.rnk, user_id u_id, o.tobo,
       f_get_s260(null, s.acc, p.s260, s.rnk, o.nbs,default_) s260,
       z.ved, p.s031
       ,'OVR' tip
       ,c.deldate, n.r012, c.ndoc, nvl(trim(p.r011), '0') r011
from sel_over c, OTCN_SALDO s, OTCN_ACC o, 
      specparam p, customer z,
       kl_f3_29 n
where ((s.ost-s.dos96+s.kos96) <> 0 or s.dos+s.dos96-s.dos96p <> 0 or s.kos+s.kos96-s.kos96p <> 0 ) and
      s.acc = o.acc and
      s.acc = c.acc and
      s.acc=p.acc(+) and
      s.rnk=z.rnk and
      s.nls like n.r020 || '%' and
      n.kf='F7' and
      (decode(n.r012, 2, decode(sign(s.ost-s.dos96+s.kos96),-1,'1','2'), 1 ) = n.r012 or (s.ost-s.dos96+s.kos96) = 0 )
      and nvl(o.dazs, to_date('01014999','ddmmyyyy')) >= trunc(dat_,'mm')
)t
--обращаемся к otc_ff7_history_acc чтобы найти входящий остаток на начало отчетного месяца
-- 10.12.2010 OAB добавил условие t.nd = hi.nd т.к. для овердрафтов используется один и тотже счет а № дог. разные
left join otc_ff7_history_acc hi 
on (t.acc = hi.acc and t.nd = hi.nd and hi.datf = datp_)
group by   t.acc, t.accc,t.nbs, t.sgn,
       t.nls, t.kv, t.nms, t.daos, t.dazs,
       t.ost,t.ostq, t.dosq, t.kosq,t.nd, t.nkd,
       t.sdate, t.wdate, t.sos, t.rnk, t.tobo,
       t.s260, t.ved, t.s031 ,t.tip,  t.u_id ,hi.ostq ,t.deldate, t.r012, t.ndoc, t.r011, max_nd
) tt
left join  (select '-'||ttt.nd nd, rr.acc, sum(rr.dos) dos, sum(rr.kos) kos, sum(rr.ost) ost
            from rnbu_history rr, sel_over ttt 
            where trim(rr.d020) != '03' and
            ttt.acc = rr.acc and
            rr.odate between greatest(trunc(dat_,'mm'),nvl(ttt.sdate,trunc(dat_,'mm'))) and least(dat_,nvl(ttt.wdate,dat_) )
            group by '-'||ttt.nd, rr.acc) r
on (tt.acc = r.acc and
    tt.nd = r.nd)   --вместо tt.date было tt.deldate-1
where tt.nbs not in ('9129', '9020')
group by   tt.acc, tt.accc,tt.nbs, tt.sgn,
       tt.nls, tt.kv, tt.nms, tt.daos, tt.dazs,
       tt.ost,tt.ostq, tt.dosq, tt.kosq,tt.nd, tt.nkd,
       tt.sdate, tt.wdate, tt.sos, tt.rnk, tt.tobo,
       tt.s260, tt.ved, tt.s031 ,tt.tip, tt.ostq_kd,
       tt.u_id ,tt.h_ostq ,tt.deldate, tt.ndoc, tt.r011, max_nd)
;
--для правильної кількості договорів (показник 20)
insert into otc_ff7_history_acc(
       DATF, ACC, ACCC, NBS,
       SGN, NLS, KV, NMS, DAOS, DAZS, OST, OSTQ, ND, NKD,
       SDATE, WDATE, SOS, RNK, STAFF, TOBO, s260, k110, s031, 
       OSTQ_KD, R_DOS, TPA, S080, tip, r011, s245)
select dat_, o.acc, o.accc, substr(o.nls,1,4),
       '0',  o.nls, o.kv, o.nms, o.daos, o.dazs, 0 ost,0 ostq,
       nvl(c.nd, -o.acc) nd, (case when c.nd is null then trim(p.nkd) else null end), -- якщо немає ND, то підставляємо ACC
       c.sdate, c.wdate, c.sos, o.rnk, userid_, o.tobo,
       f_get_s260(c.nd, o.acc, p.s260, o.rnk, o.nbs, default_) s260,
       z.ved, p.s031, 0, 0, k.tpa, nvl(p.s080,0), o.tip, nvl(trim(p.r011), '0'), '1'
from   OTCN_ACC          o,
       (select a.acc, a.nd, b.sdate, b.wdate, b.sos
        from   (select n.acc, max(n.nd) nd
                from   nd_acc n, cc_deal c
                where  n.nd=c.nd and
                       c.sdate <= dat_ and
                       c.VIDD not in (10, 26) -- убираем бронирование средств
                group by n.acc) a, cc_deal b
        where a.nd=b.nd) c,
       specparam         p,
       customer          z,
       accounts a,
       (select r020, max(decode(trim(s240), null, '1', '2')) tpa from kl_f3_29 where kf='F7' group by r020) k
where  o.acc=c.acc(+)             and
       o.acc=p.acc(+)             and
       o.rnk=z.rnk and
       o.acc not in (select acc from otc_ff7_history_acc where datf=dat_) and
       nvl(o.dazs, dat_+1) > dat_ and
       o.nbs = k.r020 and 
       k.tpa in (1, 3, 4) and  
       o.acc=a.acc and
       a.dapp is not null and a.dapp not in (c.sdate, a.daos) and -- перевірка чи видавався вже овердрафт 
       exists (select 1
               from nd_acc n, sal s
               where n.nd=c.nd and
                     n.acc=s.acc and
                     s.fdat=dat_ and
                     s.nls like '9129%' and
                     s.ost<>0);
   
-- вилучаємо ті договора, по яких був рух по ліміту, а по інших рахунках договору - ні                  
delete
from otc_ff7_history_acc o
where o.datf = dat_ and
    o.nls like '9129%' and 
    (o.ostq_kd = o.ost or o.ost = 0) and
    not exists (select 1
                from otc_ff7_history_acc o1, accounts a
                where o1.datf = dat_ and
                      o1.nd = o.nd and
                      o1.acc = a.acc and
                      o1.nls like '2%' and
                      o1.kv = o.kv and
                      (o1.ost <> 0 or 
                       o1.ost = 0 and a.dapp is not null));                     
                     
-- 09.08.2013
-- для отрицательных сумм погашения оведрафтов KOSQ < 0 изменям данное поле
-- ABS(OSTQ) - ABS(KOSQ)
update otc_ff7_history_acc
set kosq = ABS(ostq) - ABS(kosq)
where datf = dat_
 and tip in ('OVR', 'W4B')
 and kosq < 0;

logger.info ('P_FF7: etap 2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update  OTC_FF7_HISTORY_ACC t
set tpa = (select max(decode(trim(s240), null, '1', '2')) from kl_f3_29 where kf='F7' and r020 = t.nbs),
    dazs = (case when dazs = to_date('01032013','ddmmyyyy') and substr(nbs,1,3) = '207'
                    then to_date('01014999','ddmmyyyy')
                 else dazs
            end)
where datf=dat_;

-- виділяємо рахунки, які привязані до кредиту, але по якому немає основного боргу
update  OTC_FF7_HISTORY_ACC a
set tpa = 3
where a.datf=dat_ and
      a.tpa = 2 and
      not exists (select 1
                  from OTC_FF7_HISTORY_ACC b
                  where b.datf=dat_ and
                        b.tpa = 1 and
                        b.rnk = a.rnk and
                        b.nd = a.nd )
      and substr(a.nd,1,1)<>'-';

logger.info ('P_FF7: etap 3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

execute immediate 'truncate table OTCN_F42_TEMP';

insert into OTCN_F42_TEMP
(
  ACC      ,
  KV        ,
  FDAT     ,
  ZAL
)
select /*+ ordered */
    O.ACC, 1, O.DATF,
    GREATEST (O.KOSQ - SUM ((case when ok.sos >= 4 then gl.p_icurval(o.kv,ok.S,dat_) else 0 end)), 0) SQ
from OTC_FF7_HISTORY_ACC O, opldok ok, opldok od, accounts ad
where O.DATF = dat_
  AND NVL (O.KOSQ, 0) <> 0
  AND O.TIP not in ('LVR','OVR','W4B')
  AND O.NBS NOT IN
                     ('1502',
                      '1600',
                      '2600',
                      '2605',
                      '2607',
                      '2620',
                      '2625',
                      '2627',
                      '2650',
                      '2655',
                      '2657',
                      '8025')
  and o.tpa in (1,2,3)
  and ok.FDAT = any (select fdat from fdat where fdat between trunc(dat_, 'mm') and dat_)
  and o.acc = ok.ACC
  and ok.DK = 1
  and od.ref = ok.ref
  and od.dk = 0
  and od.stmt = ok.stmt
  and od.fdat = ok.fdat
  and od.acc = ad.acc
  and (ad.nls like substr(o.nls,1,3)||'%' or
       ok.tt = '024' and o.nls like '207%' and ad.nls like '206%' or
       ok.tt = '024' and o.nls like '207%' and ad.nls like '208%' or
       ok.tt = '024' and o.nls like '206%' and ad.nls like '207%' or
       ok.tt = '024' and o.nls like '208%' and ad.nls like '207%')
group by O.ACC, O.DATF, O.KOSQ;

commit;
logger.info ('P_FF7: etap 4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

merge into otc_ff7_history_acc o
using (select fdat, acc, nvl(zal, 0) zal
       from OTCN_F42_TEMP) a
on (o.acc = a.acc and o.datf = a.fdat)
when matched then update set o.kosq = a.zal
where o.datf = dat_;

logger.info ('P_FF7: etap 5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--от суммы дебетовых оборотов по счетам отнимается сумма дебетовых проводок, которые не являются выдачей
-- по всем счетам кроме овердрафтов
execute immediate 'truncate table OTCN_F42_TEMP';
insert into OTCN_F42_TEMP
(
  ACC      ,
  KV        ,
  FDAT     ,
  ZAL
)
select /*+ ordered */
    O.ACC, 1, O.DATF,
    GREATEST (O.DOSQ - SUM ((case when ok.sos >= 4 then gl.p_icurval(o.kv,ok.S,dat_) else 0 end)), 0) SQ
from OTC_FF7_HISTORY_ACC O, opldok ok, opldok od, accounts ad
where O.DATF = dat_
  AND NVL (O.DOSQ, 0) <> 0
  AND O.tip not in ('LVR', 'OVR','W4B')
  AND O.NBS NOT IN
                     ('1502',
                      '1600',
                      '2600',
                      '2605',
                      '2607',
                      '2620',
                      '2625',
                      '2627',
                      '2650',
                      '2655',
                      '2657',
                      '8025')
  and o.tpa in (1,2,3)
  and ok.FDAT = any (select fdat from fdat where fdat between trunc(dat_, 'mm') and dat_)
  and o.acc = ok.ACC
  and ok.DK = 0
  and od.ref = ok.ref
  and od.dk = 1
  and od.stmt = ok.stmt
  and od.fdat = ok.fdat
  and od.acc = ad.acc
  and (ad.nls like substr(o.nls,1,3)||'%' or
       ok.tt = '024' and o.nls like '206%' and ad.nls like '207%' or
       ok.tt = '024' and o.nls like '208%' and ad.nls like '207%' or
       ok.tt = '024' and o.nls like '207%' and ad.nls like '206%' or
       ok.tt = '024' and o.nls like '207%' and ad.nls like '208%')
group by O.ACC, O.DATF, O.DOSQ;
commit;

logger.info ('P_FF7: etap 6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

merge into otc_ff7_history_acc o
using (select fdat, acc, nvl(zal, 0) zal
       from OTCN_F42_TEMP) a
on (o.acc = a.acc and o.datf = a.fdat)
when matched then update set o.dosq = a.zal
where o.datf = dat_;
commit;

logger.info ('P_FF7: etap 7 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

for k in (select o.datf, o.acc, o.nd, 
                  decode(sign(nvl(o1.ostq,0)), -1,-- Вх < 0
                          decode(sign(nvl(o.ostq,0)), -1, --Исх < 0
                                   ( nvl(o.r_dos,0)) + abs(nvl(o1.ostq,0)) - abs(nvl(o.ostq,0)),--4. Вх < 0  Исх < 0  -  Погаш = Выдача + abs(Вх) - abs(Исх)
                                  -- 0,--Исх = 0
                                   (nvl(o.r_dos,0)) + abs(nvl(o1.ostq,0))  --3. Вх < 0  Исх = 0  -  Погаш = Выдача + abs(Вх)
                                  ),
                            --Вх >= 0
                           decode(sign(nvl(o.ostq,0)), -1, --Исх < 0
                                   ( nvl(o.r_dos,0)) - abs(nvl(o.ostq,0)), --2. Вх >= 0  Исх < 0  -  Погаш = Выдача - abs(Исх)
                                  -- 0,--Исх = 0
                                   ( nvl(o.r_dos,0))  -- 1. Вх >= 0  Исх = 0  -  Погаш = Выдача
                                  )
                         ) kosq
             from (select *
                   from otc_ff7_history_acc o
                   where  o.datf = dat_  and
                          o.tip not in ('OVR', 'W4B', 'PK9') and
                          o.tip not like 'W4%' and
                          o.nbs in ('1600','2600','2605','2620','2625','2650','2655') ) o
             left join (select * from otc_ff7_history_acc where datf = datp_) o1 
             on (o.acc = o1.acc and o.nd = o1.nd) 
             where (nvl(o1.ostq, 0) < 0 or 
                    nvl(o.ostq, 0) < 0  or
                    nvl(o.ostq_kd, 0) < 0 or
                    o.tip = 'LVR')
         )
loop
     update otc_ff7_history_acc
     set kosq = k.kosq
     where datf = k.datf and
        acc = k.acc and
        nd = k.nd;     
end loop;
     
commit;

logger.info ('P_FF7: etap 8 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--удалить А/П счета, с нулевыми остатками на конец месяца,
--у которых  в течении периода небыло остатков с нужным знаком
delete
from otc_ff7_history_acc o
where o.datf = dat_ and
      o.ostq_kd >= 0 and
      o.nbs in (select r020 from kl_r020 where d_close is null and t020 = 3) and --А/П
      --в течении месяца небыло остатков с нужным знаком
      not exists
        (select 1
          from saldoa ss
          where ss.acc = o.acc and
                (o.nbs, decode(sign(ss.ostf-ss.dos+ss.kos),-1,'1','2')) in
                                                            (select n.r020,n.r012
                                                            from kl_f3_29 n
                                                            where n.kf='F7') and
                ss.fdat between trunc(dat_,'mm') and  dat_) and  
      not (tpa = 1 and
           exists ( select 1 from acc_over v 
                   where v.acco = o.acc 
                     and nvl(v.sos, 110) = 110
                     and v.datd <= dat_ )  or tpa = 2) 
;

logger.info ('P_FF7: etap 9 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

  -- удаляем кредиты, по которым есть 9129, но никогда они не выдавались
delete
from otc_ff7_history_acc a
where datf = dat_
  and nls like '9%'
  and ostq = 0
  and ostq_kd < 0
  and not exists (select 1
                  from saldoa
                  where acc = a.acc
                    and ostf-dos+kos<0
                    and fdat <= dat_);

logger.info ('P_FF7: etap 10 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

  -- удаляем кредиты, по которым выдача была после отчетной даты
delete
from otc_ff7_history_acc a
where datf = dat_
  and nls not like '9%'
  and ostq = 0
  and ostq_kd < 0
  and not exists (select 1
                  from saldoa
                  where acc = a.acc
                    and (ostf-dos+kos < 0 or dos+kos <> 0)
                    and fdat <= dat_);

logger.info ('P_FF7: etap 11 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

  -- удаляем возможные овердрафты, которые никогда они не выдавались
delete
from otc_ff7_history_acc a
where a.datf = dat_ and
    a.nbs in ('1600', '2600', '2605', '2620', '2625', '2650', '2655', '8025') and
    a.ostq >= 0 and
    a.ostq_kd < 0 and
    not exists (select 1
                from saldoa s
                where s.acc = a.acc and 
                      s.fdat between a.daos and dat_ and 
                      s.ostf-s.dos+s.kos < 0);

logger.info ('P_FF7: etap 12 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

delete
from otc_ff7_history_acc a
where datf = dat_ and
    nbs = '3548' and
    acc in (SELECT s.ACC
            FROM SPECPARAM s, accounts a
            WHERE NVL (TRIM (s.R011), '0') NOT IN ('1', '2', '3', '4') and
                   s.acc = a.acc and
                   a.nbs = '3548');

 --потому что ...!!!!! счета процентов не ведуться в портфеле овердрафтов ...!!! а только в процентной карточке!!!!
 --из процентной карточки находим счет 2600, а по нему из acc_over находим номер договора
update otc_ff7_history_acc o
 set o.nd = '-'||nvl(( select trim(to_char(nvl(v.nd,vv.nd)))
             from int_accn i, acc_over v, accounts a, acc_over_archive vv
             where i.acra = o.acc
               and i.acc=v.acco(+)
               and i.acc=a.acc
               and i.acc=vv.acco(+)
               and vv.datd(+) <= dat_
               and vv.deldate(+) >= trunc(dat_,'mm')
               and i.id = 0 and a.nbs <> '9129' 
               and rownum = 1
          ),trim(leading '-' from o.nd))
 where nbs in ('2607','2627') and datf = dat_;

update otc_ff7_history_acc o
 set o.nd = '-'||nvl(( select trim(to_char(nvl(v.nd,vv.nd)))
             from  accounts a, acc_over v, acc_over_archive vv
             where a.acc = o.acc 
               and o.acc = v.acco(+)
               and v.datd is not null 
               and v.datd2 is not null  
               and a.acc = vv.acco(+)
               and vv.datd(+) <= dat_
               and vv.deldate(+) >= trunc(dat_,'mm')
               and rownum = 1
          ),trim(leading '№' from o.nd))
 where nbs in ('2600','2620','2625') and datf = dat_;

logger.info ('P_FF7: etap 13 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update otc_ff7_history_acc o
 set ostq_kd = -1 * greatest(nvl(( select max(abs(o1.ostq_kd))
             from otc_ff7_history_acc o1
             where o1.datf = dat_ and o.rnk = o1.rnk and o.nd = o1.nd and o1.ostq_kd<>0
          ),abs(o.ostq_kd)),abs(o.ostq_kd))
 where nbs in ('2607', '2067', '9129') and datf = dat_;

-- (12/08/2016) замена ND для счетов 2607,2627 отсутсвующих в INT_ACCN
BEGIN
   update otc_ff7_history_acc o
   set o.nd = ( select o1.nd
                from otc_ff7_history_acc o1
                where o1.acc=o.acc
                  and o1.nbs in ('2607','2627') 
                  and o1.datf = ( select max(datf)
                                  from otc_ff7_history_acc o2
                                  where o2.acc = o1.acc
                                    and o2.nbs in ('2607','2627')
                                    and o2.datf < dat_)
              )
    where o.nbs in ('2607','2627')
      and datf = dat_
      and not exists (select 1 from int_accn i where i.acra = o.acc);
EXCEPTION WHEN OTHERS THEN
   null;
END;

logger.info ('P_FF7: etap 14 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update otc_ff7_history_acc o
set s031 = f_get_s031(o.acc, dat_, s031, null)  -- substr(o.nd,2))
where o.nbs in ('2600','2607','2625','2627','2650','2657')
  and datf = dat_;

update otc_ff7_history_acc o
set k111 = nvl((select k111 from kl_k110 k where k.k110=o.k110 and d_open <= dat_spr_ and (d_close is null or d_close > dat_spr_)),'00'),
    cc = (select max(trim(f.ddd)) from kl_f3_29 f where f.kf='F7' and f.r020=o.nbs and f.r012=decode(o.sgn, 0 ,f.r012, o.sgn)),
    s032 = f_get_s032(o.acc, dat_, s031),
    s260 = lpad(s260,2,'0')
where datf = dat_;

update otc_ff7_history_acc o
set o.cc = (select max(trim(f.ddd)) from kl_f3_29 f
            where f.kf='F7' and f.r020 = o.nbs
              and f.r012 <> decode(o.sgn, 0 ,f.r012, o.sgn)
            )
where o.datf = dat_ and
      trim(o.cc) is null and
      o.nbs in ('2600','2605','2607','2620','2625','2627','2650','2655','2657');

update otc_ff7_history_acc o
set o.cc = (select max(trim(f.ddd)) from kl_f3_29 f
            where f.kf='F7' and f.r020 = o.nbs
              and f.r012 <> decode(o.sgn, 0 ,f.r012, o.sgn)
            )
where o.datf = dat_ and
      trim(o.cc) is null and o.tip ='SNA';

if  mfou_ = 300465 then
    merge into otc_ff7_history_acc o
    using (select datf, nd, max(s260) s260   --datf, kf, nd, max(s260) s260 
            from otc_ff7_history_acc f
                             where  f.datf = dat_ and
                                    not (f.nd like '-%' or f.nd like'№%')
            group by datf, nd) a   --group by datf, kf, nd) a
    on (o.nd = a.nd and o.datf = a.datf)   -- and o.kf = a.kf)
       when matched then update set o.s260 = a.s260
    where o.datf = dat_ and
          not (o.nd like '-%' or o.nd like'№%');    

    merge into otc_ff7_history_acc o
    using (select datf, acc, nd, f_get_s260_bpk(nd, acc, 1, s260, dat_) s260
           from (select f.datf, v.acc, to_char(max(v.nd)) nd, f.s260
                 from v_otc_bpk_nd_acc v, otc_ff7_history_acc f
                 where v.acc = f.acc and
                       f.datf = dat_ and
                       f.tip not like 'W4%' and
                       (f.nd like '-%' or f.nd like '№%')
                 group by f.datf, v.acc, f.s260)
           ) a
    on (o.acc = a.acc and o.datf = a.datf)
       when matched then update set o.nd = a.nd, o.s260 = a.s260
       where o.datf = dat_ and o.tip not like 'W4%';

    merge into otc_ff7_history_acc o
    using (select datf, acc, nd, f_get_s260_bpk(nd, acc, 1, s260, dat_) s260
           from (select f.datf, v.acc, to_char(max(v.nd)) nd, f.s260
                 from v_otc_w4_nd_acc v, otc_ff7_history_acc f
                 where v.acc = f.acc and
                       f.datf = dat_ and
                       --f.tip like 'W4%' and
                       (f.nd like '-%' or f.nd like '№%')
                 group by f.datf, v.acc, f.s260)
           ) a
    on (o.acc = a.acc and o.datf = a.datf)
       when matched then update set o.nd = a.nd, o.s260 = a.s260
       where o.datf = dat_ and o.tip like 'W4%';
end if;

if mfo_ = 326461 or mfou_ = 300465 then
    update otc_ff7_history_acc o
    set cc =decode(k110, '00000', '31', '21'),
        tpa = 4
    where o.datf = dat_ and
          o.nbs in ('9129');
end if;

--Для ГОУ Сбербанка по договорам БПК -
--если есть счет 2203 то суммы по 2625 и 2203 показываются по счету 2203
--если нет - то по счету 2625
--поэтому по счетам 2625 для которые есть 2203 проставляет СС = 31

--если есть счет 2233 то суммы по 2203 и 2233 показывать по счету 2233
--если нет - то по 2203
--поэтому по счетам 2203 для которые есть 2233 проставляет СС = 38
if 300465 in  (mfo_,mfou_) then
    update OTC_FF7_HISTORY_ACC
    set cc = '31'
    where acc in
    (
    select acc
    from OTC_FF7_HISTORY_ACC o
    where datf = dat_ and nbs in ('2625', '2627') and
    exists (select 1 from OTC_FF7_HISTORY_ACC o1
            where o1.datf = dat_ and o.nd = o1.nd and o1.nbs in ('2203','2202')
           )
    ) and datf = dat_
    ;

    if 300465 in  (mfo_) then
        update OTC_FF7_HISTORY_ACC
        set cc = '38'
        where acc in
        (
        select acc
        from OTC_FF7_HISTORY_ACC o
        where datf = dat_ and nbs in ('2203','2207','2208','2209') and
        exists (select 1 from OTC_FF7_HISTORY_ACC o1
                where o1.datf = dat_ and o.nd = o1.nd and o1.nbs in ('2233','2237')
               )
        ) and datf = dat_
        ;
    end if;
end if;

if dat_ < to_date('30092013','ddmmyyyy') then
    update otc_ff7_history_acc o
    set cc = decode((select r011 from specparam where acc = o.acc),
                     '1', '15', '2', '52','3', '23','4', '34','00')
    where o.datf = dat_ and
          o.nbs = '3548' and
          exists (select 1 from specparam where acc = o.acc and nvl(trim(r011), '0') in ('1','2','3','4')) ;
else
    update otc_ff7_history_acc o
    set cc = decode((select r011 from specparam where acc = o.acc),
                     '1', '11', '2', '51','3', '21','4', '31','00')
    where o.datf = dat_ and
          o.nbs = '3548' and
          exists (select 1 from specparam where acc = o.acc and nvl(trim(r011), '0') in ('1','2','3','4')) ;
end if;
--------- Корректировка S032 по закрытым договорам
for t in
(select max(acc) acc, nd from OTC_FF7_HISTORY_ACC where datf=dat_ and sos=15 and s032 is null group by nd)
loop
      update OTC_FF7_HISTORY_ACC set s032=nvl((select max(s032) from OTC_FF7_HISTORY_ACC where datf=datp_ and nd=t.nd),'9') where nd=t.nd and datf=dat_;
end loop;

logger.info ('P_FF7: etap 15 for datf = '||to_char(dat_, 'dd/mm/yyyy'));                         

update otc_ff7_history_acc o
   set cc ='33'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('3');

update otc_ff7_history_acc o
   set cc ='32'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('2');

update otc_ff7_history_acc o
   set cc ='31'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('1');

-- изменение S080 на новые значения "A" или "M" в соответствии с KL_S080
if dat_ >= to_date('31012017','ddmmyyyy') then
    update otc_ff7_history_acc o
    set o.s080 = (select max(o1.s080) from otc_ff7_history_acc o1 where o1.datf = dat_ and o1.rnk = o.rnk and o1.nd = o.nd and o1.ost <> 0)
    where o.datf = dat_ and
          (NVL(o.s080, '0') = '0' or o.ost = 0);

    update otc_ff7_history_acc o
    set o.s080 = 'A'
    where o.datf = dat_ and
          o.cc = '21' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;

    update otc_ff7_history_acc o
    set o.s080 = 'M'
    where o.datf = dat_ and
          o.cc <> '21' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;
end if;

update otc_ff7_history_acc o
set o.s260 = '08' 
where o.s260='00' 
  and o.cc in ('31', '35')
  and o.datf = dat_;

update otc_ff7_history_acc
   set s245 ='2'
 where tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN','SNA');

logger.info ('P_FF7: etap 16 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--------- Наполнение tmp_file03 и корректировка оборотов в otc_ff7_history_acc
begin
   insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK)
   select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK
    from (
        select decode(a.dk, 0, a.acc, b.acc) accd, a.tt, a.ref, a.kv,
            decode(a.dk, 0, a.nls, d.nls) nlsd, a.s, a.sq, a.fdat,
            c.nazn, decode(a.dk, 1, a.acc, b.acc) acck,
             decode(a.dk, 1, a.nls, d.nls) nlsk
        from (select /*+ leading(h) */
                    o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                    o1.acc, o1.s, o1.sq, a.nls, a.kv
                from otc_ff7_history_acc h, opldok o1, accounts a
                where h.datf=dat_ and
                    o1.fdat between datb_ and dat_ and
                    o1.acc = h.acc and
                    o1.acc = a.acc and
                    o1.sos >= 4) a, opldok b, accounts d, oper c
        where a.ref = b.ref and
            a.stmt = b.stmt and
            a.fdat = b.fdat and
            a.dk <> b.dk and
            b.acc = d.acc and
            a.ref = c.ref and
            c.sos = 5)
      group by ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK;
    commit;

    logger.info ('P_FF7: etap 17 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    for k in
        (SELECT acc, SUM (dos) dos, SUM (kos) kos
         FROM (WITH t
                   AS (SELECT accd, acck, sq
                         FROM tmp_file03
                        WHERE     (    SUBSTR (nlsd, 1, 4) IN ('3600', '2066')
                                   AND SUBSTR (nlsk, 1, 4) IN ('3600', '2066'))
                              AND tt <> '013')
              SELECT accd acc, sq dos, 0 kos
                FROM t
               WHERE EXISTS
                        (SELECT 1
                           FROM otc_ff7_history_acc
                          WHERE datf = dat_ AND acc = accd)
              UNION ALL
              SELECT acck acc, 0 dos, sq kos
                FROM t
               WHERE EXISTS
                        (SELECT 1
                           FROM otc_ff7_history_acc
                          WHERE datf = dat_ AND acc = acck))
         GROUP BY acc)
    loop
       update otc_ff7_history_acc set dosq=dosq-k.dos, kosq=kosq-k.kos where acc=k.acc;
    end loop;

end;

logger.info ('P_FF7: etap 18 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

---------
if isf8_=0 then -- формирование только наполнения otc_ff7_history_acc
    -- блок для формирования показателя 18 для списания сумм по безнадежным кредитам за счет резерва
    for k in (select acck, nlsk, kv, NVL(sum(gl.p_icurval(o.kv, o.s*100, dat_ /*o.fdat*/)), 0) kos
              from provodki_otc o, kl_f3_29 k   --specparam s
              where ( (o.nlsd like '1590%' or 
                               o.nlsd like '15_9%' and 
                              o.fdat > to_date('20171218','yyyymmdd') )
                  OR  (o.nlsd like '2400%' or
                                (   o.nlsd like '20_9%'
                                 or o.nlsd like '21_9%'
                                 or o.nlsd like '22_9%'
                                 or o.nlsd like '26_9%' ) and
                              o.fdat > to_date('20171218','yyyymmdd') )
                    )
                and o.nlsk like k.r020 || '%'
                and k.kf='F7'
                and ((o.fdat between datb_ and Dat_
                     and o.tt not in ('096', 'ZG8', 'ZG9'))
                 or (o.fdat between Dat_+1 and Dat_+28
                     and o.tt in ('096', 'ZG8', 'ZG9')))
              group by acck, nlsk, kv)
    loop
       BEGIN
          update OTC_FF7_HISTORY_ACC
          set kosq = kosq - k.kos
          where datf=dat_
            and acc=k.acck;

          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp)
          select f.nls, nvl(f.kv_dog, f.kv), dat_, '18' || NVL(f.cc,'00') || NVL(f.k111,'00') ||
                          NVL(f.s260,'00') || NVL(f.s032,'0') ||
                          lpad(nvl(f.kv_dog, f.kv),3,'0')||s245,
                         to_char(0-k.kos),  -- погашение
                         (case substr(f.nd,1,1) when '№' then null when '-' then null else f.nd end),
                          f.rnk,
                          nvl(f.nkd, f.nd),
                          decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                          userid_,
                          f.accc
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_
                          and f.acc=k.acck;
       EXCEPTION WHEN OTHERS THEN
          null;
       END;
    end loop;

    -- нові кредитні договори
    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp)
    select *
    from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                             max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                             nvl(nkd, nd) comm,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                             1 cnt,
                             sum(r_dos) ost -- выдача
                             ,min (accc) isp
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_
                              and f.tpa = 1
                              and (f.ostq_kd <> 0 or f.ostq_kd = 0 and f.r_dos <> 0 and f.nd is not null)
                              and daos <> to_date('01012011','ddmmyyyy')
                              and not exists
                                  (select 1
                                  from OTC_FF7_HISTORY_ACC f1
                                  where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and f1.datf=datp_
                                  -- если в прошлом месяце сумма по договору = 0, а в этом <> 0  - договор новый
                                       and (f1.ostq_kd <> 0
                                                or
                                           (f1.nbs in ('2202','2203') and f1.ostq_kd = 0 )
                                                or
                                            f1.ostq_kd = 0 and f1.r_dos <> 0
                                            )
                              )
                        group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                        order by 1)
        select nls, kv, dt, '07'||k1||k2||k3||k4||s245 kodp, cnt  znap, nd, rnk, comm, nbuc, userid_, isp
        from kred
        where nvl(ost,0) <> 0
        union all
        select nls, kv, dt, '12'||k1||k2||k3||k4||s245 kodp, abs(ost) znap, nd, rnk, comm, nbuc, userid_,isp
        from kred
        where nvl(ost,0) <> 0);

    -- закриті кредитні договори
    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp)
    select *
    from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2 ,
                             max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                             max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                             nvl(nkd,nd) comm,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                             1 cnt, sum(ostq) ost
                             ,sum((case when tpa = 4 then 0 else kosq end)) kos
                             ,min (accc)  isp
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_ and
                              f.tpa in (1, 4) and
                              (f.ostq_kd = 0 and
                               (f.dazs is null or f.dazs <> to_date('01014999','ddmmyyyy')) and
                                exists
                                  (select 1
                                   from OTC_FF7_HISTORY_ACC f1
                                   where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and
                                         f1.datf=datp_ and
                                         f1.ostq_kd <> 0)
                                  or
                                f.ostq_kd = 0 and
                                f.r_dos <> 0 and
                                f.nd is not null and
                                exists (select 1
                                        from rnbu_trace
                                        where to_char(nd) = f.nd and
                                              kodp like '07%'))
                        group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, tobo, nvl(nkd,nd), rnk,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                      )
        select nls, kv, dt, '08'||k1||k2||k3||k4||s245 kodp, cnt  znap, nd, rnk, comm, nbuc, userid_,isp
        from kred
        union all
        select nls, kv, dt, '14'||k1||k2||k3||k4||s245 kodp,
               --decode(qnt,0, kos,1,kos, greatest(0, kos-kos1)) znap,--Для столицы : погашение = сумма кредитовых - сумма дебетовых по всем счетам SS
               --если нет счета SS берется кредитовый оборот по счету
               --ести счета SS один, то береться Кт и Дт обороты с учетом переноса на просрочку (по счетам SS SP)
               --ести счетов SS несколько (в Столице) - береться сумма кредитовых - сумма дебетовых по всем счетам SS
              -- decode(qnt,0, kos2,1,kos, greatest(0, kos-kos1)) znap,
              kos znap,
               nd, rnk, comm, nbuc, userid_,isp
        from kred
        where kos<>0);

    -- показник 03 - кількість кредитних договорів на звітну дату (00 - сума по кредитам для перевірки)
    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                             cc||k111||max(f.s260)||max(s032)||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
                            max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                            nvl(nkd,nd) comm,
                            decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                            1 cnt, sum(ostq) ost, sum (r_dos) r_dos
                             ,sum(case substr(nd,1,1) when '№' then (kosq)
                                                      when '-' then (kosq)
                                                      else decode(f.tip,'SS ',(kosq), 'SP ', (-dosq+kosq), 'SL', (-dosq+kosq), 0)
                                  end) kos
                             --Для столицы   если несколько счетов SS
                             ,sum(decode(f.tip,'SS ',1,0)) qnt
                             ,sum(case substr(nd,1,1) when '№' then 0
                                                      when '-' then 0
                                                      else decode(f.tip,'SS ',(dosq), 0)
                                  end) kos1
                             ,min (accc)  isp
                      from OTC_FF7_HISTORY_ACC f
                      where f.datf=dat_
                            and ( f.ostq_kd <> 0 or
                                  (f.ostq_kd = 0 and f.nbs in ('2600','2605','2607',
                                                               '2620','2625','2627',
                                                               '2650','2655','2657'
                                                              )
                                  )
                                )
                            and f.tpa in (1, 3, 4)
                      group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                               decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                      )
        select nls, kv, dt, '03'||kodp, cnt  znap, nd, rnk, comm, nbuc, userid_,isp
        from kred
        union all
        select nls, kv, dt, '00'||kodp, -1*ost znap, nd, rnk, comm, nbuc, userid_,isp
        from kred
        where nls not like '9129%' and nls not like '9020%');

    -- 13, 15 - выдача и погашение по существующим договорам
    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                             cc||k111||max(f.s260)||max(s032)||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
                            max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                            nvl(nkd,nd) comm,
                            decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                            1 cnt, sum(ostq) ost, sum (r_dos) r_dos,
                            sum(dosq) dos, sum(kosq) kos,
                            min (accc)  isp
                      from OTC_FF7_HISTORY_ACC f
                      where f.datf=dat_
                             and f.tpa = 1
                      group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd),
                               nbs, rnk,
                               decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                      )
        select nls, kv, dt, '15'||kodp,
               --decode(qnt,0, kos,1,kos, greatest(0, kos-kos1))  znap, --Для столицы : погашение = сумма кредитовых - сумма дебетовых по всем счетам SS
               --если нет счета SS берется кредитовый оборот по счету
               --ести счета SS один, то береться Кт и Дт обороты с учетом переноса на просрочку (по счетам SS SP)
               --ести счетов SS несколько (в Столице) - береться сумма кредитовых - сумма дебетовых по всем счетам SS
               --decode(qnt,0, kos2,1,kos, greatest(0, kos-kos1)) znap,
               kos znap,
               nd, rnk, comm, nbuc, userid_,isp
        from kred kk
        where kos > 0
              --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
              --and exists (select 1 from rnbu_trace r where  (r.kodp like '03%' or r.kodp like '07%') and r.comm = kk.comm)
              --and not exists (select 1 from rnbu_trace r where (/*r.kodp like '07%' or*/ r.kodp like '08%') and r.comm = kk.comm)
              and exists (select 1 from rnbu_trace r where  (r.kodp like '03%' or r.kodp like '08%') and r.comm = kk.comm)
              and not exists (select 1 from rnbu_trace r where (/*r.kodp like '07%' or*/ r.kodp like '07%') and r.comm = kk.comm)
        union all
        select nls, kv, dt, '13'||kodp,
               r_dos  znap, --выдача (берется по файлу 03)
               nd, rnk, comm, nbuc, userid_,isp
        from kred kk
        where r_dos > 0
              --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
              and exists (select 1 from rnbu_trace r where  (r.kodp like '03%' or r.kodp like '08%') and r.comm = kk.comm)
              and not exists (select 1 from rnbu_trace r where (r.kodp like '07%') and r.comm = kk.comm)
        union all
        select nls, kv, dt, '13'||kodp,
               dos  znap, --выдача (берется по файлу 03)
               nd, rnk, comm, nbuc, userid_,isp
        from kred kk
        where kk.nls like '1502%' and kk.dos > 0 and kk.r_dos = 0
              --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
              and exists (select 1 from rnbu_trace r where  (r.kodp like '03%' or r.kodp like '08%') and r.comm = kk.comm)
              and not exists (select 1 from rnbu_trace r where (r.kodp like '07%') and r.comm = kk.comm)
    );

    --Для Сбербанка
    if nvl(GetGlobalOption('OB22'),0) = 1 or 300465 in (mfou_) or mfou_ not in (300465) then  -- было еще и для Демарка 353575 in (mfo_) then
        --добавляем счета % и дисконта в показатели 12,13,14,15                              -- с 24.12.10 будет для всех
        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
        select *
        from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                             max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                             nvl(nkd,nd) comm,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                             1 cnt,
                             sum(decode(f_acc_type(f.nbs),'SN ',(dosq),'SPN',(dosq), 'DSK', (dosq), 0)) dos
                             ,min (accc)  isp
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_
                          and f.tpa in (2, 3)
                          and not exists
                          (select 1 from OTC_FF7_HISTORY_ACC f1 where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and f1.datf=datp_
                                   and ((f1.ostq_kd <> 0 ) -- если в прошлом месяце сумма по договору = 0, а в этом <> 0  - договор новый
                                         OR (f1.nbs in ('2202','2203') and f1.ostq_kd = 0 ) )

                          )
                        group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                        order by 1)
        select nls, kv, dt, '12'||k1||k2||k3||k4||s245 kodp, dos znap, nd, rnk, comm, nbuc, userid_,isp
        from kred
        where nvl(dos,0) <> 0);

        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
        select *
        from (
            with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                                 max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                                 max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                                 nvl(nkd,nd) comm,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                                 1 cnt,
                                 sum(decode(f_acc_type(f.nbs),'SN ',(dosq), 'SPN',(dosq), 'DSK', (dosq), 0)) dos
                                ,min (accc)  isp
                            from OTC_FF7_HISTORY_ACC f
                            where f.datf=dat_
                                  and f.tpa in (2, 3)
                            group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                     decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) )
                            order by 1)
            select nls, kv, dt, '13'||k1||k2||k3||k4||s245 kodp, dos znap, nd, rnk, comm, nbuc, userid_,isp
            from kred kk
            where nvl(dos,0) <> 0
                  --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
                  and exists (select 1 from rnbu_trace r where  (r.kodp like '03%' or r.kodp like '08%') and r.comm = kk.comm)
                  and not exists (select 1 from rnbu_trace r where (r.kodp like '07%' /*or r.kodp like '08%'*/) and r.comm = kk.comm)
        );

        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
        select *
        from (
            with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                                 max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                                 max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                                 nvl(nkd,nd) comm,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                                 1 cnt,
                                 sum(decode(f_acc_type(f.nbs),'SN ',(kosq), 'SPN', /*(-dosq+kosq)*/ (kosq), 'DSK', (kosq), 0)) kos
                                 ,min (accc)  isp
                            from OTC_FF7_HISTORY_ACC f
                            where f.datf=dat_ and
                              f.ostq_kd = 0
                              and f.tpa in (2, 3)
                              and not exists
                              (select 1 from OTC_FF7_HISTORY_ACC f1 where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and f1.datf=datp_ and f1.ostq_kd = 0)
                             group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                      decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                            order by 1)
            select nls, kv, dt, '14'||k1||k2||k3||k4||s245 kodp, kos znap, nd, rnk, comm, nbuc, userid_,isp
            from kred
            where nvl(kos,0) <> 0
              and exists (select 1 from rnbu_trace r where (r.kodp like '08%') and r.comm = comm));

        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
        select *
        from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                             max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                             nvl(nkd,nd) comm,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                             1 cnt,
                             sum(decode(f_acc_type(f.nbs),'SN ',(kosq), 'SPN', /*(-dosq+kosq)*/ (kosq), 'DSK', (kosq), 0)) kos
                             ,min (accc)  isp
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_
                              and f.tpa in (2, 3)
                        group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                        order by 1)
        select nls, kv, dt, '15'||k1||k2||k3||k4||s245 kodp, abs(kos) znap, nd, rnk, comm, nbuc, userid_,isp
        from kred kk
        where nvl(kos,0) <> 0
              --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
              and exists (select 1 from rnbu_trace r where  (r.kodp like '03%' or r.kodp like '07%') and r.comm = kk.comm)
              and not exists (select 1 from rnbu_trace r where (r.kodp like '08%') and r.comm = kk.comm)
        );

        --Для ГОУ Сбербанка по МБК заменяем показатели 13 и 15 на 12 и 14
    --    if 300465 in (mfo_) then
    --       update rnbu_trace
    --       set kodp = decode(substr(kodp,1,2),'13','12','15','14')||substr(kodp,3)
    --       where substr(kodp,1,2) in ('13','15') and nls like '1%'
    --       ;
    --    end if;

        --Для Cбербанка формируем 18 показатель  для счетов % и дисконта - если нет выдачи/погашения по счетам основного долга
        -- первый вариант формирования показателя 18 был для кодов 13 и 15
        -- и для кода 15 сумма показателя выбиралась с отрицательным значением
        -- результат в некоторых случаях формировался отрицательным
        -- после просьбы Оли (Херсон СБ) показатель 18 формируем только для кода 15
       If nvl(GetGlobalOption('OB22'),0) = 1 or 300465 in (mfou_) then
           update rnbu_trace kk
           set kodp = '18'||substr(kodp,3), znap=decode(substr(kodp,1,2),'12',znap, '13',znap, -znap)  --, znap=decode(substr(kodp,1,2),'13',znap, -znap)
           where --нет выдачи/погашения по счетам основного долга
                 substr(kk.kodp,1,2) in ('12','13','14','15')
              and not exists (select 1 from rnbu_trace r,
                              kl_f3_29 n
                              where substr(r.nls,1,4) = n.r020
                                and r.kv = kk.kv
                                and nvl(n.s240,'0') = '0'
                                and n.kf='F7'
                                and r.comm = kk.comm
                                and substr(r.kodp,1,2) not in ('00','03','07','08','09') )
              --выбираем счета % и дисконта
              and exists(select 1
                         from kl_f3_29 n
                         where substr(kk.nls,1,4) = n.r020
                           and nvl(n.s240,'0') = '1'
                           and n.kf='F7');
       End if;

       if mfou_ not in (300465) then    -- было только для Демарка 353575
          update rnbu_trace kk
          set kodp = '18'||substr(kodp,3), znap=decode(substr(kodp,1,2),'12',znap, '13',znap, -znap)
          where --нет выдачи/погашения по счетам основного долга
              substr(kk.kodp,1,2) in ('12','13','14','15')
              and not exists (select 1 from rnbu_trace r,
                              kl_f3_29 n
                              where substr(r.nls,1,4) = n.r020
                                and r.kv = kk.kv
                                and nvl(n.s240,'0') = '0'
                                and n.kf='F7'
                                and r.comm = kk.comm
                                and substr(r.kodp,1,2) not in ('00','03','07','08','09') )
              --выбираем счета % и дисконта
              and exists(select 1
                         from kl_f3_29 n
                         where substr(kk.nls,1,4) = n.r020
                           and nvl(n.s240,'0') = '1'
                           and n.kf='F7');
       end if;
    else
        --  18 - изменения в объёме задолженности - другое
        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
        select *
        from (
        with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                             max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                              /*'Кількість рахунків - '||to_char(count(*))*/nvl(nkd,nd) comm,
                              decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                              --0 tobo,
                              1 cnt,
                              sum(dosq) dos, sum(kosq) kos
                              ,min (accc)  isp
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_ and f.tpa in (2, 3)
                        group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_))
                        order by 1)
        select nls, kv, dat_, '18'||k1||k2||k3||k4||s245 kodp, dos-kos  znap, nd, rnk, comm, nbuc, userid_ ,isp
        from kred
        where dos-kos<>0);
    end if;

    ---------------------------------------------------------------------------
    if mfo_ = 380764 then
       update rnbu_trace
       set kodp = substr(kodp, 1, 4)||'00'||substr(kodp, 7)
       where substr(kodp, 3,2) in ('31', '32', '33', '34', '35', '38');
    end if;
    -----------------------------------------------------------------------------
    DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
    ---------------------------------------------------
    INSERT INTO tmp_nbu(kodf, datf, kodp, nbuc, znap)
    SELECT kodf_, Dat_, kodp, nbuc, SUM(znap)
    FROM rnbu_trace
    where kodp not like '00%'
    GROUP BY kodp, nbuc;
    ----------------------------------------
    -- Для Укоопспилок не нужно
    if not (322625 in (mfo_, mfou_)) then
        otc_del_arch(kodf_, dat_, 0);
        OTC_SAVE_ARCH(kodf_, dat_, 0);
        commit;
    end if;
end if;

logger.info ('P_FF7: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END;
/

