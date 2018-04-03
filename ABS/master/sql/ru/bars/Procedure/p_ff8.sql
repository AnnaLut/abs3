 

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FF8.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FF8 ***

CREATE OR REPLACE PROCEDURE BARS.p_ff8 (Dat_ DATE) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DESCRIPTION : Процедура формирования файла #F8 для КБ
COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.

VERSION     :   v.18.002    03.04.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата

   Структура показника    DD CC LL ГГ Ч Т AA VVV L

 1   DD         {04,05,06,...}            код показника
 3   CC         {11,51,21,31,32,33,38,35} код виду кредиту
 5   LL         K111 вид економiчноi дiяльностi
 7   ГГ         S260 код iндивiдуального споживання за цiлями
 9   Ч          S032 код виду забезпечення
10   Т          S080 код категории риска
11   AA         S270 код срока погашения основного долга
13   VVV        R030 код валюти
16   L          S245 узагальнений строк погашення

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
03.04.2018  для 1502 выбирается поле DOSQ вместо R_DOS
23.01.2018  -новый сегмент в показателе: L(S245)
               -расширена рабочая таблица otc_ff8_history_acc
            -для сегмента CC новая разбивка по балансовым
31/08/2017 - в 26 показатель будут включаться договора по которым
             не было движения но есть курсовая разница
             в показатель 20 (кол-во догю) не будут включаться 
             договора для ОСББ особый период (ND=NDI в табл. CC_DEAL) 
13/07/2017 - в 12 показатель не будут включаться договора реструкту-
             ризиранные в предыдущие отчетные периоды
11/07/2017 - для определения значения S080
             исключаем счета дебиторки при отборе из V_TMP_REZ_RISK
             и выбираем S080 не из SPECPARAM а из OTC_FF7_HISTORY_ACC
             за предыдущую банковскую дату
10/03/2017 - убрал мусор
13/02/2017 - для формирования показателей 15,16,18 заменены условие
             для S080  с S080 in ('4','5') на S080 in ('Q','J')
10/02/2017 - для договоров реструктуризации (VIEW CC_V) будем изменять
             параметр S080 (на "A" или "M")
07/02/2016 - для параметра S080 будем использовать поле S080 вместо KAT
10/08/2016 - для счетов овердрафтов при заполнении кода "CC" остаток по
             счету может быть и пассивный
08/08/2016 - для показателя 16 изменил условие на f,r013 is not null
             вместо NVL(f.r013,'0') not in ('0','3') или ('0','1')
01/08/2016 - для показателя 16 добавлені новые условия
             f.cc like '__1' and f.s270='08' (было f.s270='1')
             f.cc like '__3' and f.s370='J'  (было f.s370='J')
09/06/2016 - для выборки из OPLDOK(ов) добавил условие по полю FDAT
03/06/2016 - для 1502 вібираем поле DOSQ вместо R_DOS т.к. выдача не
             формируется в RNBU_HISTORY
12/08/2014 - Доработки согласно заявки BRSMAIN-2645.
             отображение кредитов в разрезе валют по мультивалютным кредитам
             отображение неработающих в отчетном периоде но незакрытых договоров
             из оборотов по договорам убраны обороты между балансовыми счетами 3600 и 2066
             добавлена корректировка S032 по закрытым договорам, исправлены др.ошибки
24/09/2013 - зміни в STRU_F8 по 1508, 1509
06/02/2013 - изменения по KL_K110 (дата открытия и закрытия показателя)
28/01/2013 - доопрацювання по 23 постанові
17/12/2012 - изменения по KL_K110
11/10/2012 - формируем в разрезе кодов территорий
13/06/2012 - виправлення помилки при формуванні показників 12 та 13 (не
             формувався 12 та 13 показник, якщо за звітнsий період було
             введено більше ніж один вид реструктуризації)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  kodf_       varchar2(2):='F8';
  sheme_      varchar2(1);
  acc_        Number;
  dk_         Varchar2(1);
  nbs_        Varchar2(4);
  nls_        Varchar2(15);
  dd_         Varchar2(3);
  mdate_      Date;
  data_       Date;
  kv_         SMALLINT;
  se_         DECIMAL(24);
  Ostn_       DECIMAL(24);
  Ostq_       DECIMAL(24);
  Dos96_      DECIMAL(24);
  Kos96_      DECIMAL(24);
  Dosq96_     DECIMAL(24);
  Kosq96_     DECIMAL(24);
  Doszg_      DECIMAL(24);
  Koszg_      DECIMAL(24);
  Dos96zg_    DECIMAL(24);
  Kos96zg_    DECIMAL(24);
  Dos99zg_    DECIMAL(24);
  Kos99zg_    DECIMAL(24);
  kodp_       Varchar2(16);
  znap_       Varchar2(30);
  cc_         Varchar(3);
  userid_     Number;
  sql_acc_    varchar2(2000):='';
  ret_        number;
  rnk_        number;
  codcagent_  number;

  nd_         number;
  sdate_      date;
  wdate_      date;
  sos_        number;
  comm_       varchar2(200);
  datp_       date;
  datb_       date;
  datr_       date;

  mfo_        number;
  mfou_       number;
  default_    number;

  typ_        number;
  nbuc_       varchar2(12);
  nbuc1_      varchar2(12);
  flag_       number;
  dat_spr_    date := last_day(dat_)+1;
  s080r_      varchar2(1);

BEGIN
logger.info ('P_FF8: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FF8_MIGR_ND';
-------------------------------------------------------------------
sql_acc_ := 'select * from accounts '||
            'where nbs in (select distinct r020 from kl_f3_29 where kf='''||kodf_||''') and '||
            ' acc in (select n.acc from nd_acc n, cck_restr c where n.nd=c.nd and '||
            ' c.fdat<=to_date('''||to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and '||
            ' nvl(c.fdat_end, to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'')) '||
            ' >= to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and pr_no = 1 '||
            ' union all '||
            'select acc from cck_restr_acc c where c.fdat<=to_date('''||
            to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and '||
            ' nvl(c.fdat_end, to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'')) '||
            ' >= to_date('''|| to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'') and pr_no = 1 '||
            ')';

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

if 300120 in (mfo_, mfou_) then
   default_ := 1; -- для s260='00', устанавливаем по-умолчанию s260='06'
else
   default_ := 0;
end if;

default_ := 0; --Петрокомерц отказался

if 300465 in (mfo_, mfou_) then
   sheme_ := 'C';
else
   sheme_ := 'G';
end if;

datb_ := trunc(dat_,'mm'); -- дата начала месяца

select max(fdat) -- прошлая отчетная дата
into datp_
from fdat
where fdat<datb_;

-- дата розрахунку резерву
datr_ := last_day(dat_) + 1;

select count(*)
into flag_
from nbu23_rez
where fdat = datr_;

if flag_ = 0 then
   datr_ := add_months(datr_, -1);
end if;

-- определение начальных параметров (код области или МФО или подразделение)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);
nbuc_ := nbuc1_;

ret_ := f_pop_otcn(Dat_, 2, sql_acc_,null, 0, 1);
-------------------------------------------------------------------
delete from otc_ff8_history_acc where datf=dat_;

insert into otc_ff8_history_acc(
       DATF, ACC, ACCC, NBS,
       SGN,
       NLS, KV, NMS, DAOS, DAZS, OST,
       OSTQ,
       ND, NKD,
       SDATE, WDATE, SOS, RNK, STAFF, TOBO, s260, k110, s031, s080, s270,
       tip, r011, r013, s370, sum_r013_1, s245)
select dat_, s.acc, o.accc, substr(o.nls,1,4),
       decode(sign(s.ost-s.dos96+s.kos96),-1,'1','2'),
       o.nls, o.kv, o.nms, o.daos, o.dazs, s.ost-s.dos96+s.kos96 ost,
       decode(o.kv, 980, s.ost-s.dos96+s.kos96, s.ostq-s.dosq96+s.kosq96) ostq,
       nvl(c.nd, -s.acc) nd, trim(p.nkd), -- якщо немає ND, то підставляємо ACC
       c.sdate, c.wdate, c.sos, s.rnk, userid_, o.tobo,
       f_get_s260(c.nd, s.acc, p.s260, s.rnk, o.nbs, default_) s260,
       z.ved, p.s031, nvl(p.s080,0), p.s270,
       o.tip, nvl(trim(p.r011), '0'), nvl(trim(p.r013), '0'), nvl(trim(p.s370), '0'), 0, '1'
from   OTCN_SALDO        s,
       OTCN_ACC          o,
       (select a.acc, a.nd, b.sdate, b.wdate, b.sos
        from   (select n.acc, max(n.nd) nd
                from   nd_acc n, cc_deal c
                where  n.nd=c.nd and
                       c.sdate <= dat_ and
                       c.VIDD <> 26 -- убираем бронирование средств
                group by n.acc) a, cc_deal b
        where a.nd=b.nd) c,
       specparam         p,
       customer          z
where  (s.ost-s.dos96+s.kos96)<>0 and
       s.acc=o.acc                and
       (substr(o.nls,1,4),decode(sign(s.ost-s.dos96+s.kos96),-1,'1','2')) in
       (select n.r020,n.r012
        from   kl_f3_29 n
        where  n.kf=kodf_)         and
       s.acc=c.acc(+)             and
       s.acc=p.acc(+)             and
       s.rnk=z.rnk;

logger.info ('P_FF8: etap 1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

insert into otc_ff8_history_acc(
       DATF, ACC, ACCC, NBS,
       SGN,
       NLS, KV, NMS, DAOS, DAZS, OST,
       OSTQ,
       ND, NKD,
       SDATE, WDATE, SOS, RNK, STAFF, TOBO, s260, k110, s031, s080, s270,
       tip, r011, r013, s370, sum_r013_1, s245)
select dat_, o.acc, o.accc, substr(o.nls,1,4),
       '0',
       o.nls, o.kv, o.nms, o.daos, o.dazs, 0 ost,0 ostq,
       nvl(c.nd, -o.acc) nd, trim(p.nkd), -- якщо немає ND, то підставляємо ACC
       c.sdate, c.wdate, c.sos, o.rnk, userid_, o.tobo,
       f_get_s260(c.nd, o.acc, p.s260, o.rnk, o.nbs, default_) s260,
       z.ved, p.s031, nvl(p.s080,0), p.s270,
       o.tip, nvl(trim(p.r011), '0'), nvl(trim(p.r013), '0'), nvl(trim(p.s370), '0'), 0, '1'
from   OTCN_ACC          o,
       (select a.acc, a.nd, b.sdate, b.wdate, b.sos
        from   (select n.acc, max(n.nd) nd
                from   nd_acc n, cc_deal c
                where  n.nd=c.nd and
                       --dat_ between c.sdate and c.WDATE and
                       c.sdate <= dat_ and
                       c.VIDD not in (10, 26) -- убираем бронирование средств
                group by n.acc) a, cc_deal b
        where a.nd=b.nd) c,
       specparam         p,
       customer          z
where  substr(o.nls,1,4) in
           (select n.r020
            from   kl_f3_29 n
            where  n.kf=kodf_)         and
       o.acc=c.acc(+)             and
       o.acc=p.acc(+)             and
       o.rnk=z.rnk and
       o.acc not in (select acc from otc_ff8_history_acc where datf=dat_) and
       nvl(o.dazs, dat_+1) > dat_ and 
       exists (select 1
               from nd_acc n, sal s
               where n.nd=c.nd and
                     n.acc=s.acc and
                     s.fdat=dat_ and
                     s.nls like '9129%' and
                     s.ost<>0);

logger.info ('P_FF8: etap 2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   delete
   from otc_ff8_history_acc o
   where datf=dat_ and
         nbs in ('1508') and r011 !='6';

logger.info ('P_FF8: etap 2-1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update otc_ff8_history_acc o
set k111 = nvl((select k111 from kl_k110 k where k.k110=o.k110 and d_open <= dat_spr_ and (d_close is null or d_close > dat_spr_)),'00'),
    cc   = (select trim(f.ddd) from kl_f3_29 f
            where f.kf=kodf_    and
                  f.r020=o.nbs and
                  (f.r012=o.sgn or o.sgn=0)),
    s032 = f_get_s032(o.acc,dat_,null,o.nd),
    s080 = f_get_rez_kat(acc, rnk, nd, datr_),
    s370 = f_get_s370(dat_, o.s370, o.acc, o.nd)
where datf=dat_;

update otc_ff8_history_acc o
set o.cc = (select max(trim(f.ddd)) from kl_f3_29 f
            where f.kf='F8' and f.r020 = o.nbs
              and f.r012 <> o.sgn
            )
where o.datf = dat_ and
      trim(o.cc) is null and
      o.nbs in ('2600','2605','2607','2620','2625','2627','2650','2655','2657');

update otc_ff8_history_acc o
   set cc ='33'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('3');

update otc_ff8_history_acc o
   set cc ='32'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('2');

update otc_ff8_history_acc o
   set cc ='31'
   where datf=dat_
     and nbs in ('2246','2248','2456','2457','2458')
     and r011 in ('1');

--                          счета просроченных процентов
     for u in ( select o.nls
                   from otc_ff8_history_acc o, otcn_acc a
                  where o.tip !='SPN'
                    and o.nls = a.nls
                    and length(trim(a.nls_alt)) >10
                    and ( a.nls_alt like '1509%'   or a.nls_alt like '1519%'
                       or a.nls_alt like '1529%'   or a.nls_alt like '2029%'
                       or a.nls_alt like '2039%'   or a.nls_alt like '2069%'
                       or a.nls_alt like '2079%'   or a.nls_alt like '2089%'
                       or a.nls_alt like '2209%'   or a.nls_alt like '2219%'
                       or a.nls_alt like '2229%'   or a.nls_alt like '2239%'  
                       or a.nls_alt like '2109%'   or a.nls_alt like '2119%'
                       or a.nls_alt like '2129%'   or a.nls_alt like '2139%' )
     ) loop
          update otc_ff8_history_acc
             set tip='SPN'
           where nls = u.nls;
     end loop;
--                          счета просроченного тела
     for u in ( select o.nls
                   from otc_ff8_history_acc o, otcn_acc a
                  where o.tip !='SP '
                    and o.nls = a.nls
                    and length(trim(a.nls_alt)) >10
                    and ( a.nls_alt like '1517%'   or a.nls_alt like '1527%'
                       or a.nls_alt like '2027%'   or a.nls_alt like '2037%'
                       or a.nls_alt like '2067%'   or a.nls_alt like '2077%'
                       or a.nls_alt like '2087%'   or a.nls_alt like '2207%'
                       or a.nls_alt like '2217%'   or a.nls_alt like '2227%'
                       or a.nls_alt like '2237%'   or a.nls_alt like '2107%'
                       or a.nls_alt like '2117%'   or a.nls_alt like '2127%'
                       or a.nls_alt like '2137%' )
     ) loop
          update otc_ff8_history_acc
             set tip='SP '
           where nls = u.nls;
     end loop;
--                          счета процентов
          update otc_ff8_history_acc
             set tip='SN '
           where tip !='SN ' and tip !='SPN'
             and (  nbs like '2__8'
                 or nbs like '15_8'
                 or nbs in ('1607','2607','2627','2657','3568') );

-- изменение S080 на новые значения "A" или "M" в соответствии с KL_S080
if dat_ >= to_date('31012017','ddmmyyyy') then
    update otc_ff8_history_acc o
    set o.s080 = 'A'
    where o.datf = dat_ and
          o.cc like '21%' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;

    update otc_ff8_history_acc o
    set o.s080 = 'M'
    where o.datf = dat_ and
          o.cc not like '21%' and
          NVL(o.s080, '0') in ('0','1','2','3','4','5') ;
end if;

update otc_ff8_history_acc o
set o.s260 = '08'
where o.s260='00'
  and substr(o.cc, 1, 2) in ('31', '35')
  and o.datf = dat_;

logger.info ('P_FF8: etap 3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

declare
    pnd_ number;
    ps270_ varchar2(2);
begin
    for i in (select acc, nd
              from otc_ff8_history_acc
              where datf=dat_ and
                    (s270 in ('00', '01') or trim(s270) is null))
    loop
        if pnd_ > 0 then
           pnd_ := i.nd;
        else
           pnd_ := null;
        end if;

        ps270_ := f_get_s270(dat_, null, i.acc, pnd_);

        if ps270_ <> '00' then
           update otc_ff8_history_acc
           set s270 = ps270_
           where datf=dat_ and
                 acc=i.acc;
        end if;
    end loop;
end;

logger.info ('P_FF8: etap 4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

merge into otc_ff8_history_acc o
using (select nd,kv,accs from cc_add where nd in (select nd
                                                  from   otc_ff8_history_acc
                                                  where  datf=dat_) and
                                           adds=0) c
on (o.nd=c.nd and
    o.datf=dat_)
when matched then update
     set o.kv_dog=c.kv
when not matched then -- фиктивная часть, для обеспечения совместимости с более низкими уровнями Oracle
     insert (o.nd, o.DATF, o.ACC )
     values (c.nd, dat_,   c.accs);

-- для s260 = '00'  по некоторому однозначному соответствию из KOD_F7 устанавливаем значения по умолчанию
update otc_ff8_history_acc o
set s260 = (case when cc in ('11','51','21') then '08'
                 when cc = '35' then '06'
                 when cc = '38' then '07'
                 else '00'
            end)
where datf = dat_ and
      s260 = '00';

logger.info ('P_FF8: etap 5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

declare
    nbs1_       varchar2(4);
    r013_       varchar2(1);
    o_r013_1    varchar2(1);
    o_se_1      number;
    o_comm_1    varchar2(100);
    o_r013_2    varchar2(1);
    o_se_2      number;
    o_comm_2    varchar2(100);
begin
    for i in (select acc, nd, nbs,kv, r013, ostq
              from otc_ff8_history_acc
              where datf=dat_ and
                    nls like '___8' and
                    ostq <> 0)
    loop
       if mfo_ not in (300465,333368,300205) then
          p_analiz_r013 (mfo_, mfou_, dat_, i.acc, i.nbs, i.kv, r013_, i.ostq, i.nd,
                    o_r013_1, o_se_1, o_comm_1, o_r013_2, o_se_2, o_comm_2);

          IF o_se_2 <> 0 THEN
             update otc_ff8_history_acc o
               set r013 = '2',
                   SUM_R013_1 = o_se_2
               where datf = dat_ and
                     acc = i.acc;
          end if;
       end if;
    end loop;
end;

logger.info ('P_FF8: etap 6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));


update otc_ff8_history_acc o
set r013 = (case when s370 = 'J' then '3'
                 else r013
            end)
where datf = dat_ and
      nls like '___9' and
      r013 in (0,1);

logger.info ('P_FF8: etap 7 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

declare
    pnd_        number;
    ps270_      varchar2(2);
    rzprr013_   number;
    sr013_      number;
    add_        number;
begin
    BEGIN
       SELECT TO_NUMBER (NVL (val, '0'))
          INTO rzprr013_
       FROM params
       WHERE par = 'RZPRR013';
    EXCEPTION WHEN NO_DATA_FOUND THEN
       rzprr013_ := '0';
    END;

    if rzprr013_ = '0' then
        for i in (select acc, ostq, kv
                  from otc_ff8_history_acc
                  where datf=dat_ and
                        nls like '___8' and  tip ='SPN' and
--                        nls like '___9' and
                        r013 in (0, 1) and
                        ostq <> 0)
        loop
            sr013_ := gl.p_icurval(i.kv, otcn_pkg.f_GET_R013(i.acc, dat_), dat_);

            IF i.ostq <> 0 and sr013_ < 0 and
               abs(sr013_) < abs(i.ostq)
            THEN
               update otc_ff8_history_acc o
               set r013 = '2',
                   SUM_R013_1 = sr013_
               where datf = dat_ and
                     acc = i.acc;
            end if;
        end loop;
    end if;
end;

logger.info ('P_FF8: etap 8 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--Alexy очищаем kv_dog для распределения по валютам
update otc_ff8_history_acc o
set kv_dog = null where datf = dat_;

update otc_ff8_history_acc
   set s245 ='2'
 where tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN','SNA');

logger.info ('P_FF8: etap 9 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- показник 04 - кількість чинних кредитних договорів, щодо яких прийнято
--               рішення про реструктуризацію - щодо сплати основного боргу
--               та сплати відсотків/комісій
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                         (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         f.nd in -- одновременно реструктуризация осн.долга и %%-в
                               (SELECT nd
                                  FROM (SELECT   nd
                                        FROM v_cck_restr a
                                        WHERE exists (SELECT 1
                                                      FROM v_cck_restr b
                                                      WHERE a.nd = b.nd and
                                                            dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                                            b.PR_NO = 1 and
                                                            b.vid_restr not in (1, 3, 16)) and -- реструктуризация осн.долга
                                              exists (SELECT 1
                                                      FROM v_cck_restr c
                                                      WHERE a.nd = c.nd and
                                                            dat_ between c.fdat and nvl(c.FDAT_END, dat_)  and
                                                            c.PR_NO = 1 and
                                                            c.vid_restr in (3, 16)) -- реструктуризация %%-в
                                             or
                                             dat_ between a.fdat and nvl(a.FDAT_END, dat_)  and
                                             a.PR_NO = 1 and
                                             vid_restr = 1 -- одновременно реструктуризация осн.долга и %%-в
                                       )
                               )  and
                         (length(trim(f.cc))=2 or f.tip='SP ')-- счета осн. задож-сти и прострочки по осн. задолж-ти
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '04'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);

-- показник 05 - кількість чинних кредитних договорів, щодо яких прийнято
--               рішення про реструктуризацію - щодо сплати основного боргу
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         f.nd in -- !!! только реструктуризация осн.долга
                               (SELECT nd
                                  FROM (SELECT   nd
                                        FROM v_cck_restr a
                                        WHERE exists (SELECT 1
                                                      FROM v_cck_restr b
                                                      WHERE a.nd = b.nd and
                                                            dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                                            b.PR_NO = 1 and
                                                            b.vid_restr not in (3, 16)) and -- есть реструктуризация осн.долга
                                              not exists (SELECT 1
                                                      FROM v_cck_restr c
                                                      WHERE a.nd = c.nd and
                                                            dat_ between c.fdat and nvl(c.FDAT_END, dat_)  and
                                                            c.PR_NO = 1 and
                                                            c.vid_restr in (1, 3, 16)) -- нет реструктуризация %%-в и всего
                                       )
                                ) and
                         (length(trim(f.cc))=2 or f.tip='SP ')-- счета осн. задож-сти и прострочки по осн. задолж-ти
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '05'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);


-- показник 06 - кількість чинних кредитних договорів, щодо яких прийнято
--               рішення про реструктуризацію - щодо сплати відсотків/комісій
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         f.nd in -- !!! только реструктуризация %%-в
                               (SELECT nd
                                  FROM (SELECT   nd
                                        FROM v_cck_restr a
                                        WHERE not exists (SELECT 1
                                                      FROM v_cck_restr b
                                                      WHERE a.nd = b.nd and
                                                            dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                                            b.PR_NO = 1 and
                                                            b.vid_restr not in (1, 3, 16)) and -- нет реструктуризация осн.долга и всего
                                              exists (SELECT 1
                                                      FROM v_cck_restr c
                                                      WHERE a.nd = c.nd and
                                                            dat_ between c.fdat and nvl(c.FDAT_END, dat_)  and
                                                            c.PR_NO = 1 and
                                                            c.vid_restr in (3, 16)) -- есть реструктуризация %%-в
                                       )
                                 ) and
                           (length(trim(f.cc))=2 or f.tip='SP ')-- счета осн. задож-сти и прострочки по осн. задолж-ти
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '06'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);


-- показник 08 - обсяг заборгованості за чинними кредитними договорами,
--               щодо яких прийнято рішення про реструктуризацію - за
--               основним боргом
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                         (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd, sum(sumr) sumr
                          from   v_cck_restr b
                          where  b.vid_restr not in (3, 16) and
                                 dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                 b.PR_NO = 1
                           group by nd) p
                  where  f.datf=dat_ and
                         (length(trim(f.cc))=2 or f.tip='SP ') and -- счета осн. задож-сти и прострочки по осн. задолж-ти
                         f.nd = p.nd
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245, 
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '08'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k
);


-- показник 09 - обсяг заборгованості за чинними кредитними договорами,
--               щодо яких прийнято рішення про реструктуризацію - за
--               нарахованими доходами
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd, sum(sumr) sumr
                          from   v_cck_restr b
                          where  b.vid_restr in (1, 3, 16) and
                                 dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                 b.PR_NO = 1
                          group by nd) p
                  where  f.datf=dat_ and
                         f.tip in ('SN ','SPN') and -- счета начисл. %% -в и простроченных %% -в
                         f.nd = p.nd
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '09'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k);


-- показник 10 - кількість чинних кредитних договорів, щодо яких прийнято
--               рішення про реструктуризацію протягом звітного періоду
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_ and
                         (length(trim(f.cc))=2 or f.tip ='SP ') and -- счета осн. задож-сти и прострочки по осн. задолж-ти
                         exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat between datb_ and dat_ and
                                        dat_ between v.fdat and nvl(v.FDAT_END, dat_)  and
                                        v.PR_NO = 1
                                 ) and
                         not exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat < datb_  and
                                        v.PR_NO = 1
                                        )
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '10'||kodp, cnt znap, nd, rnk, comm, nbuc, tobo
    from kred
);


-- показник 12 - обсяг заборгованості за чинними кредитними договорами,
--               щодо яких прийнято рішення про реструктуризацію протягом
--               звітного періоду - за основним боргом
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd,
                                sum(case when fdat < datb_ then 1 else 0 end) p1,
                                sum(case when fdat between datb_ and dat_ then 1 else 0 end) p2,
                                sum(case when fdat between datb_ and dat_ then sumr else 0 end) sumr
                            from   v_cck_restr v
                            where  vid_restr not in (3, 16) and
                                 fdat <= dat_ and
                                 dat_ between v.fdat and nvl(v.FDAT_END, dat_)  and
                                 v.PR_NO = 1
                          group by nd) p
                  where  f.datf=dat_ and
                         (length(trim(f.cc))=2 or f.tip ='SP ') and -- счета осн. задож-сти и прострочки по осн. задолж-ти
                         f.nd = p.nd and
                         p.p1 = 0 and
                         p.p2 >= 1 and
                         not exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat < datb_  and
                                        v.PR_NO = 1
                                        )
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '12'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k);

-- показник 13 - обсяг заборгованості за чинними кредитними договорами,
--               щодо яких прийнято рішення про реструктуризацію протягом
--               звітного періоду - за нарахованими доходами
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost,
                         p.sumr
                  from   OTC_ff8_HISTORY_ACC f,
                         (select nd,
                                sum(case when fdat < datb_ then 1 else 0 end) p1,
                                sum(case when fdat between datb_ and dat_ then 1 else 0 end) p2,
                                sum(case when fdat between datb_ and dat_ then sumr else 0 end) sumr
                            from   v_cck_restr v
                            where  vid_restr in (1, 3, 16) and
                                 fdat <= dat_ and
                                 dat_ between v.fdat and nvl(v.FDAT_END, dat_)  and
                                 v.PR_NO = 1
                          group by nd) p
                  where  f.datf=dat_ and
                         f.tip in ('SN ','SPN') and -- счета начисл. %% -в и простроченных %% -в
                         f.nd = p.nd and
                         p.p1 = 0 and
                         p.p2 >= 1 and
                         not exists (select nd
                                  from v_cck_restr v
                                  where v.nd = f.nd and
                                        v.fdat < datb_  and
                                        v.PR_NO = 1
                                        )
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo, p.sumr)
    select nls, kv, dt, '13'||kodp,
           (case when sumr = 0 or abs(ost) < sumr then abs(ost) else sumr end) znap,
           k.nd, rnk, comm||' SUMR='||to_char(sumr)||' OST='||to_char(abs(ost)), nbuc, tobo
    from kred k);

-- показник 15 - обсяг негативно класифікованої заборгованості за
--               реструктуризованими кредитними договорами - за основним боргом
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         (length(trim(f.cc))=2 or f.tip ='SP ') and  -- счета осн. задож-сти и прострочки по осн. задолж-ти
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr not in (3, 16) and -- in (1,2,4,5,7,8) and -- Вирко 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) and
                         f.s080 in ('Q','J')  and
                         f.s270 in ('01','07','08')
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'), s245,
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '15'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);


-- показник 16 - обсяг негативно класифікованої заборгованості за
--               реструктуризованими кредитними договорами -
--               за нарахованими доходами
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(f.nls)                   nls ,
                         nvl(f.kv_dog, f.kv)             kv  ,
                         dat_                       dt  ,
                         substr(f.cc,1,2)||
                         f.k111          ||
                         max(nvl(f.s260,'00'))||
                         max(f.s032)          ||
                         f.s080               ||
                         '00'               ||
--                         max(f.s270)          ||
                         lpad(nvl(f.kv_dog,f.kv),3,'0')||s245 kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         f.rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(f.ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         f.tip in ('SN ','SPN') and -- счета начисл. %% -в и простроченных %% -в
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr in (1, 3, 16) and -- Вирко 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) and
                          f.s080 in ('Q', 'J') and
                         (f.tip ='SN ' and f.r013 is not null  or  -- nvl(f.r013,'0') not in ('0', '3')
                          f.tip ='SPN' and f.r013 is not null  or  -- nvl(f.r013,'0') not in ('0', '1')
                          f.tip ='SN ' and f.s270 = '08' or
                          f.tip ='SPN' and f.s370 = 'J')
                  group by nvl(f.kv_dog,kv), substr(f.cc,1,2), f.k111, f.s080, lpad(nvl(f.kv_dog,f.kv),3,'0'), s245,
                           f.nd, f.rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), f.tobo)
    select nls, kv, dt, '16'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);

-- показник 18 - обсяг простроченої заборгованості за реструктуризованими
--               кредитними договорами - за основним боргом
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         s080               ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||'2' kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         f.tip ='SP ' and -- счета прострочки по осн. задож-сти
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr not in (3, 16) and -- in (1,2,4,5,7,8) and -- Вирко 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) and
--                         f.s080 in ('2', '3', '4', '5')  and
                         f.s270 in ('07', '08')  
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'),
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '18'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);


-- показник 19 - обсяг простроченої заборгованості за реструктуризованими
--               кредитними договорами - за нарахованими доходами
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, tobo)
select *
from (
    with kred as (select max(nls)                   nls ,
                         nvl(kv_dog,kv)             kv  ,
                         dat_                       dt  ,
                         substr(cc,1,2)||
                         k111          ||
                         max(nvl(s260,'00'))||
                         max(s032)          ||
                         NVL(s080,'0')      ||
                         '00'               ||
--                         max(s270)          ||
                         lpad(nvl(kv_dog,kv),3,'0')||'2' kodp,
                        (case when f.nd<0 then
                           null
                         else
                           f.nd
                         end)                       nd  ,
                         rnk                            ,
                         'Кількість рахунків - '||
                         to_char(count(*))          comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         tobo                           ,
                         1                          cnt ,
                         sum(ostq)                  ost
                  from   OTC_ff8_HISTORY_ACC f
                  where  f.datf=dat_                  and
                         f.tip ='SPN' and -- счета простроч. начисл. %% -в
                         f.nd in (select nd
                                  from   v_cck_restr b
                                  where  b.vid_restr in (1, 3, 16) and -- Вирко 11/08/2010 --18/01/2010
                                         dat_ between b.fdat and nvl(b.FDAT_END, dat_)  and
                                         b.PR_NO = 1
                                  ) 
                  group by nvl(kv_dog,kv), substr(cc,1,2), k111, s080, lpad(nvl(kv_dog,kv),3,'0'),
                           f.nd, rnk, decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), tobo)
    select nls, kv, dt, '19'||kodp, -ost znap, nd, rnk, comm, nbuc, tobo
    from kred);

p_ff7(dat_,'G',0,1);
commit;

update otc_ff7_history_acc o
set o.s260 = '08' 
where o.s260='00' 
  and substr(o.cc, 1, 2) in ('31', '35')
  and o.datf = dat_;
commit;

logger.info ('P_FF8: etap 10 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

for k in (select acc,nd,rnk from OTC_FF7_HISTORY_ACC where datf=dat_)
loop
    BEGIN
        select NVL(s080_351,'0')
           into s080r_
        from v_tmp_rez_risk
        where dat = dat_spr_
          and acc = k.acc
          and id not like 'DEB%'
          and nd = decode(is_number(k.nd),0,999999999,abs(k.nd))
          and s080 is not null
          and rownum = 1;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        BEGIN
           select NVL(s080_351,'0')
              into s080r_
           from v_tmp_rez_risk
           where dat = dat_spr_
             and acc = k.acc
             and id not like 'DEB%'
             and s080_351 is not null
             and rownum = 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           BEGIN
              select max(NVL(s080_351,'0'))
                 into s080r_
              from v_tmp_rez_risk
              where dat = dat_spr_
                and nd = decode(is_number(k.nd),0,999999999,abs(k.nd))
                and id not like 'DEB%'
                and s080_351 is not null;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              BEGIN
                 select max(NVL(s080_351,'0'))
                    into s080r_
                 from v_tmp_rez_risk
                 where dat = dat_spr_
                   and rnk = k.rnk
                   and id not like 'DEB%'
                   and s080_351 is not null;
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 BEGIN
                    select NVL(s080,'0')
                       into s080r_
                    from OTC_FF7_HISTORY_ACC
                    where datf = datp_
                      and acc = k.acc
                      and rownum = 1;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                     s080r_ := '0';
                 END;
              END;
           END;
        END;
    END;

    update OTC_FF7_HISTORY_ACC f
           set s080 = nvl(s080r_,'0')
           where datf=dat_ and acc=k.acc and nd=k.nd and rnk=k.rnk;

end loop;

-- изменение S080 на новые значения "A" или "M" в соответствии с KL_S080
if dat_ >= to_date('31012017','ddmmyyyy') then
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

logger.info ('P_FF8: etap 11 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- блок для формирования показателя 26
for k in (select acck, nlsk, kv,
                 NVL (SUM (gl.p_icurval (o.kv, o.s * 100, o.fdat)), 0) kos
            from (
                select decode(a.dk, 0, a.acc, b.acc) accd, a.tt, a.ref, a.kv,
                    decode(a.dk, 0, a.nls, d.nls) nlsd, a.s, a.sq, a.fdat,
                    c.nazn, decode(a.dk, 1, a.acc, b.acc) acck,
                     decode(a.dk, 1, a.nls, d.nls) nlsk
                from (select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                            a.nls LIKE '159%'  and
                            o1.sos >= 4
                      union
                      select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                            a.nls LIKE '240%'  and
                            o1.sos >= 4
                      union
                      select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                               a.nls like '15_9%' and 
                              o1.fdat > to_date('20171218','yyyymmdd')  and
                            o1.sos >= 4
                      union
                      select /*+parallel(8)*/ o1.fdat, o1.ref, o1.stmt, o1.dk, o1.tt,
                            o1.acc, o1.s / 100 s, o1.sq / 100 sq, a.nls, a.kv
                        from opldok o1, accounts a
                        where o1.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
                            o1.dk = 0 and
                            o1.tt not in ('096', 'ZG8', 'ZG9') and
                            o1.acc = a.acc and
                                (   a.nls like '20_9%'
                                 or a.nls like '21_9%'
                                 or a.nls like '22_9%'
                                 or a.nls like '26_9%' ) and
                              o1.fdat > to_date('20171218','yyyymmdd') and
                            o1.sos >= 4
                    ) a, opldok b, accounts d, oper c
                where a.ref = b.ref and
                    a.stmt = b.stmt and
                    a.fdat = b.fdat and
                    a.dk <> b.dk and
                    b.acc = d.acc and
                    d.nbs in (select r020 from kl_f3_29  where kf = 'F7') and
                    a.ref = c.ref and
                    c.sos = 5
                    ) o
              group by acck, nlsk, kv)
loop
   BEGIN
      update OTC_FF7_HISTORY_ACC
      set kosq = kosq - k.kos
      where datf=dat_
        and acc=k.acck;

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid, isp)
      select f.nls, nvl(f.kv_dog, f.kv), dat_, 'B8' || NVL(f.cc,'00') || NVL(f.k111,'00') ||
                      NVL(f.s260,'00') || NVL(f.s032,'0')|| NVL(s080,'0')||'00'||
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

logger.info ('P_FF8: etap 12 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

insert
into otcn_ff8_migr_nd(nd)
select /*+ hash(n) */
    n.nd
from opldok o, oper p, nd_acc n
where o.fdat = any (select fdat from fdat where fdat between datb_ and dat_) and
      o.tt= 'R01' and
      o.ref = p.ref and
      p.sos = 5 and
      o.acc = n.acc and
      to_char(n.nd) in (select unique nd from OTC_FF7_HISTORY_ACC f where f.datf=dat_) and
      lower(p.nazn) like 'мігр%кд%';
commit;

logger.info ('P_FF8: etap 12-1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

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
                         sum((case when substr(nls,1,4)='1502' then dosq else r_dos end)) ost -- выдача
                         --sum(r_dos) ost -- выдача
                         ,min (accc) isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_
                          and f.tpa = 1
                          and (f.ostq_kd <> 0 or (f.ostq_kd=0 and f.dosq+f.kosq<>0))
                          and daos <> to_date('01012011','ddmmyyyy')
                          and not exists
                          (select 1 from OTC_FF7_HISTORY_ACC f1 where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and f1.datf=datp_
                          -- если в прошлом месяце сумма по договору = 0, а в этом <> 0  - договор новый
                                   and (f1.ostq_kd <> 0
                                            or
                                       (f1.nbs in ('2202','2203') and f1.ostq_kd = 0 ))
                          )
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    order by 1)
    select nls, kv, dt, 'A7'||k1||k2||k3||s080||'00'||k4||s245 kodp, cnt  znap, nd, rnk, comm, nbuc, userid_, isp
    from kred
    union all
    select nls, kv, dt, 'B2'||k1||k2||k3||s080||'00'||k4||s245 kodp, abs(ost) znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nvl(ost,0) <> 0);

logger.info ('P_FF8: etap 12-2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

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
                         ,sum(kosq) kos
                         ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_ and
                          f.nls not like '9129%' and
                          f.ostq_kd = 0 and
                          f.tpa in (1, 4) and
                          (f.nkd is not null and
                           f.nkd in (SELECT F1.NKD
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD <> 0)
                                             or
                           f.nkd is null and
                           f.nd in (SELECT F1.ND
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD <> 0) )                          
                           and f.nd not in (select nd from otcn_ff8_migr_nd)
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, tobo, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'A8'||k1||k2||k3||s080||'00'||k4||s245 kodp, cnt  znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    union all
    select nls, kv, dt, 'B4'||k1||k2||k3||s080||'00'||k4||s245 kodp,
           --decode(qnt,0, kos,1,kos, greatest(0, kos-kos1)) znap,--Для столицы : погашение = сумма кредитовых - сумма дебетовых по всем счетам SS
           --если нет счета SS берется кредитовый оборот по счету
           --ести счета SS один, то береться Кт и Дт обороты с учетом переноса на просрочку (по счетам SS SP)
           --ести счетов SS несколько (в Столице) - береться сумма кредитовых - сумма дебетовых по всем счетам SS
          -- decode(qnt,0, kos2,1,kos, greatest(0, kos-kos1)) znap,
          kos znap,
           nd, rnk, comm, nbuc, userid_,isp
    from kred
    where kos<>0 and nls not like '9129%');

logger.info ('P_FF8: etap 12-3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- показник 03 - кількість кредитних договорів на звітну дату (00 - сума по кредитам для перевірки)
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                         cc||k111||max(f.s260)||max(s032)||NVL(s080,'0')||'00'||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
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
                  where f.datf = dat_
                        and ( f.ostq_kd <> 0 or
                              (f.ostq_kd = 0 and
                               f.nbs in ('2600','2605','2607',
                                         '2620','2625','2627',
                                         '2650','2655','2657'
                                        )
                              )
                             )
                        and f.tpa in (1, 3, 4)
                  group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                           decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'A3'||kodp, cnt  znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nls not like '9129%'
    union all
    select nls, kv, dt, 'A0'||kodp, -1*ost znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nls not like '9129%');

logger.info ('P_FF8: etap 12-4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- 13, 15 - выдача и погашение по существующим договорам
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                         cc||k111||max(f.s260)||max(s032)||s080||'00'||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
                        max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                        nvl(nkd,nd) comm,
                        decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                        1 cnt, sum(ostq) ost,
                        sum((case when substr(nls,1,4)='1502' then dosq else r_dos end)) r_dos -- выдача
                        --sum (r_dos) r_dos
                         ,sum(kosq) kos
                         ,min (accc)  isp
                  from OTC_FF7_HISTORY_ACC f
                  where f.datf=dat_
                         and f.tpa = 1
                         and f.nd not in (select nd from otcn_ff8_migr_nd)
                  group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                           decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'B5'||kodp,
           --decode(qnt,0, kos,1,kos, greatest(0, kos-kos1))  znap, --Для столицы : погашение = сумма кредитовых - сумма дебетовых по всем счетам SS
           --если нет счета SS берется кредитовый оборот по счету
           --ести счета SS один, то береться Кт и Дт обороты с учетом переноса на просрочку (по счетам SS SP)
           --ести счетов SS несколько (в Столице) - береться сумма кредитовых - сумма дебетовых по всем счетам SS
           --decode(qnt,0, kos2,1,kos, greatest(0, kos-kos1)) znap,
           kos znap,
           nd, rnk, comm, nbuc, userid_,isp
    from kred kk
    where kos>0
          --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
          and exists (select 1 from rnbu_trace r where  (r.kodp like 'A3%' or r.kodp like 'A7%') and r.comm = kk.comm)
          and not exists (select 1 from rnbu_trace r where (/*r.kodp like '07%' or*/ r.kodp like 'A8%') and r.comm = kk.comm)
    union all
    select nls, kv, dt, 'B3'||kodp,
           r_dos  znap, --выдача (берется по файлу 03)
           nd, rnk, comm, nbuc, userid_,isp
    from kred kk
    where nvl(r_dos,0)>0
          --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
          and exists (select 1 from rnbu_trace r where  (r.kodp like 'A3%' or r.kodp like 'A8%') and r.comm = kk.comm)
          and not exists (select 1 from rnbu_trace r where (r.kodp like 'A7%') and r.comm = kk.comm)
);

logger.info ('P_FF8: etap 12-5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- 16 - передача по существующим договорам
INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
select *
from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt,
                         cc||k111||max(f.s260)||max(s032)||s080||'00'||lpad(nvl(kv_dog, kv),3,'0')||s245 kodp,
                        max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                        nvl(nkd,nd) comm,
                        decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                        1 cnt, sum(ostq) ost, sum (r_dos) r_dos
                         ,sum((case when nbs like '___6' then -dosq else kosq end)) kos
                         ,min (accc)  isp
                  from OTC_FF7_HISTORY_ACC f
                  where f.datf=dat_
                         and f.nls not like '9129%'
                         and f.nd in (select nd from otcn_ff8_migr_nd)
                  group by nvl(kv_dog, kv), cc,k111,lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                           decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                  )
    select nls, kv, dt, 'B6'||kodp,
           kos znap,
           nd, rnk, comm, nbuc, userid_,isp
    from kred kk
    where kos>0
);

logger.info ('P_FF8: etap 12-6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

--Для Сбербанка
--if nvl(GetGlobalOption('OB22'),0) = 1 or 300465 in (mfou_) or mfou_ not in (300465) then  -- было еще и для Демарка 353575 in (mfo_) then
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
                         ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_
                      and f.tpa in (2, 3)
                      and not exists
                      (select 1 from OTC_FF7_HISTORY_ACC f1 where nvl(f.nkd, f.nd) = nvl(f1.nkd, f1.nd) and f1.datf=datp_
                               and ((f1.ostq_kd <> 0 ) -- если в прошлом месяце сумма по договору = 0, а в этом <> 0  - договор новый
                                     OR (f1.nbs in ('2202','2203') and f1.ostq_kd = 0 ) )

                      )
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    order by 1)
    select nls, kv, dt, 'B2'||k1||k2||k3||s080||'00'||k4||s245 kodp, dos znap, nd, rnk, comm, nbuc, userid_,isp
    from kred
    where nvl(dos,0) <> 0);

    logger.info ('P_FF8: etap 12-7 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select nls, kv, dt, 'B3'||k1||k2||k3||s080||'00'||k4||s245 kodp, dos znap, nd, rnk, comm, nbuc, userid_,isp
    from (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                             max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245, 
                             max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                             nvl(nkd,nd) comm,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                             1 cnt,
                             sum(decode(f_acc_type(f.nbs),'SN ',(dosq), 'SPN',(dosq), 'DSK', (dosq), 0)) dos
                            ,min (accc)  isp, s080
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_
                              and f.tpa in (2, 3)
                             --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
                              and nvl(nkd,nd) in
                                     (SELECT R.COMM
                                        FROM RNBU_TRACE R
                                       WHERE R.KODP LIKE 'A3%' OR R.KODP LIKE 'A8%'
                                             minus
                                      SELECT R.COMM
                                        FROM RNBU_TRACE R
                                       WHERE R.KODP LIKE 'A7%')
                        group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                 decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ), s080
                        having sum(decode(f_acc_type(f.nbs),'SN ',(dosq), 'SPN',(dosq), 'DSK', (dosq), 0)) <> 0);

    logger.info ('P_FF8: etap 12-8 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

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
                             ,min (accc)  isp, s080
                        from OTC_FF7_HISTORY_ACC f
                        where f.datf=dat_ and
                          f.ostq_kd = 0 and
                          f.tpa in (2, 3) and
                          (f.nkd is not null and
                           f.nkd in (SELECT F1.NKD
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD = 0)
                                             or
                           f.nkd is null and
                           f.nd in (SELECT F1.ND
                                       FROM OTC_FF7_HISTORY_ACC F1
                                      WHERE  F1.DATF = datp_
                                            AND F1.OSTQ_KD <= 0) )
                          and f.nd not in (select nd from otcn_ff8_migr_nd)
                         group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                                  decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                        order by 1)
        select nls, kv, dt, 'B4'||k1||k2||k3||s080||'00'||k4||s245 kodp, kos znap, nd, rnk, comm, nbuc, userid_,isp
        from kred kk
        where nvl(kos,0) <> 0
          and kk.comm in (select r.comm from rnbu_trace r where r.kodp like 'A8%'));

    logger.info ('P_FF8: etap 12-9 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select nls, kv, dt, 'B5'||k1||k2||k3||s080||'00'||k4||s245 kodp, abs(kos) znap, nd, rnk, comm, nbuc, userid_,isp
    from (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                         max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245,
                         max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                         nvl(nkd,nd) comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         1 cnt,
                         sum(decode(f_acc_type(f.nbs),'SN ',(kosq), 'SPN', /*(-dosq+kosq)*/ (kosq), 'DSK', (kosq), 0)) kos
                         ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_
                          and f.tpa in (2, 3)
                          and f.nd not in (select nd from otcn_ff8_migr_nd)
                          --существующие договора - это действующие (есть в 03 показателе), но не новые (нет в 07 показателе) и не закрытые (нет в 08 показателе)
                          and nvl(nkd,nd) in
                                 (SELECT R.COMM
                                    FROM RNBU_TRACE R
                                   WHERE R.KODP LIKE 'A3%' OR R.KODP LIKE 'A8%'
                                         minus
                                  SELECT R.COMM
                                    FROM RNBU_TRACE R
                                   WHERE R.KODP LIKE 'A7%')
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    having sum(decode(f_acc_type(f.nbs),'SN ',(kosq), 'SPN', /*(-dosq+kosq)*/ (kosq), 'DSK', (kosq), 0))<>0);

    logger.info ('P_FF8: etap 12-10 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --Для ГОУ Сбербанка по МБК заменяем показатели 13 и 15 на 12 и 14
    if 300465 in (mfo_) then
       update rnbu_trace
       set kodp = decode(substr(kodp,1,2),'B3','B2','B5','B4')||substr(kodp,3)
       where substr(kodp,1,2) in ('B3','B5') and nls like '1%'
       ;
    end if;

    logger.info ('P_FF8: etap 12-11 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --Для Cбербанка формируем 18 показатель  для счетов % и дисконта - если нет выдачи/погашения по счетам основного долга
    -- первый вариант формирования показателя 18 был для кодов 13 и 15
    -- и для кода 15 сумма показателя выбиралась с отрицательным значением
    -- результат в некоторых случаях формировался отрицательным
    -- после просьбы Оли (Херсон СБ) показатель 18 формируем только для кода 15
   If nvl(GetGlobalOption('OB22'),0) = 1 or 300465 in (mfou_) then
       update rnbu_trace kk
       set kodp = 'B8'||substr(kodp,3), znap=decode(substr(kodp,1,2),'B2',znap, 'B3',znap, -znap)  --, znap=decode(substr(kodp,1,2),'13',znap, -znap)
       where --нет выдачи/погашения по счетам основного долга
             substr(kk.kodp,1,2) in ('B2','B3','B4','B5')
          and not exists (select 1 from rnbu_trace r,
                          kl_f3_29 n
                          where substr(r.nls,1,4) = n.r020
                            and nvl(n.s240,'0') = '0'
                            and n.kf='F7'
                            and r.comm = kk.comm
                            and substr(r.kodp,1,2) not in ('A0','A3','A7','A8','A9') )
          --выбираем счета % и дисконта
          and exists(select 1
                     from kl_f3_29 n
                     where substr(kk.nls,1,4) = n.r020
                       and nvl(n.s240,'0') = '1'
                       and n.kf='F7');
   End if;

   logger.info ('P_FF8: etap 12-12 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   if mfou_ not in (300465) then    -- было только для Демарка 353575
      update rnbu_trace kk
      set kodp = 'B8'||substr(kodp,3), znap=decode(substr(kodp,1,2),'B2',znap, 'B3',znap, -znap)
      where --нет выдачи/погашения по счетам основного долга
          substr(kk.kodp,1,2) in ('B2','B3','B4','B5')
          and not exists (select 1 from rnbu_trace r,
                          kl_f3_29 n
                          where substr(r.nls,1,4) = n.r020
                            and nvl(n.s240,'0') = '0'
                            and n.kf='F7'
                            and r.comm = kk.comm
                            and substr(r.kodp,1,2) not in ('A0','A3','A7','A8','A9') )
          --выбираем счета % и дисконта
          and exists(select 1
                     from kl_f3_29 n
                     where substr(kk.nls,1,4) = n.r020
                       and nvl(n.s240,'0') = '1'
                       and n.kf='F7');
   end if;

   logger.info ('P_FF8: etap 12-13 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --  18 - изменения в объёме задолженности - другое
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
    with kred as (select min(nls) nls, nvl(kv_dog, kv) kv, dat_ dt, cc||k111 k1,
                         max(f.s260) k2, max(s032) k3, lpad(nvl(kv_dog, kv),3,'0') k4, s245, 
                         max((case substr(nd,1,1) when '№' then null when '-' then null else nd end)) nd, rnk,
                          /*'Кількість рахунків - '||to_char(count(*))*/nvl(nkd,nd) comm,
                          decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                          1 cnt,
                          sum(dosq) dos, sum(kosq) kos
                          ,min (accc)  isp, s080
                    from OTC_FF7_HISTORY_ACC f
                    where f.datf=dat_ and
                          f.tpa in (2, 3) and
                          f.tip not in ('OVR', 'W4B')
                    group by nvl(kv_dog, kv), cc,k111, lpad(nvl(kv_dog, kv),3,'0'), s245, nvl(nkd,nd), rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), s080
                    order by 1)
    select nls, kv, dat_, 'B8'||k1||k2||k3||s080||'00'||k4||s245 kodp, dos-kos  znap, nd, rnk, comm, nbuc, userid_ ,isp
    from kred kk
    where dos-kos<>0
         and not exists (select 1
                         from rnbu_trace r
                         where substr(r.kodp,1,2) not in ('B3','B4','B5','B8') and
                               r.comm = kk.comm));

logger.info ('P_FF8: etap 13 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    --  18 - курсовая разница остатков в эквиваленте
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
    select *
    from (
    with kred as (select min(f.nls) nls, nvl(f.kv_dog, f.kv) kv, dat_ dt, 
                         f.cc||f.k111 k1,
                         max(f.s260) k2, max(f.s032) k3, 
                         lpad(nvl(f.kv_dog, f.kv),3,'0') k4, f.s245,
                         max(case substr(f.nd,1,1) when '№' then null when '-' then null else f.nd end) nd, 
                         f.rnk,
                         'курсовая разница  ND = ' || nvl(f.nkd, f.nd) comm,
                         decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_) ) nbuc,
                         1 cnt,
                         sum(f.ostq) ostq, sum(f1.ostq) ostqp,
                         min (f.accc) isp, f.s080
                    from OTC_FF7_HISTORY_ACC f, OTC_FF7_HISTORY_ACC f1 
                    where f.datf = dat_ 
                      and f.kv <> 980 
                      and f.dosq + f.kosq = 0  
                      and f1.datf = datp_
                      and f1.acc = f.acc 
                      and f.ost = f1.ost 
                      and  f1.ostq <> f.ostq
                    group by nvl(f.kv_dog, f.kv), f.cc, f.k111, 
                             lpad(nvl(f.kv_dog, f.kv),3,'0'), f.s245, 
                             nvl(f.nkd,f.nd), f.rnk,
                             decode(typ_, 0, nbuc1_, NVL(F_Codobl_Tobo(f.acc,typ_), nbuc1_)), 
                             f.s080
                    order by 1)
    select nls, kv, dat_, 'B8'||k1||k2||k3||s080||'00'||k4||s245 kodp, ABS(ostq - ostqp) znap, 
           nd, rnk, comm, nbuc, userid_ ,isp
    from kred kk
   );

logger.info ('P_FF8: etap 13-1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

-- AlexY Добавляем неработающие счета в колличество
FOR K IN
(SELECT ndo.acc,
        o.nls,
        o.kv,
        ndo.nd
   FROM otcn_acc o,
        (SELECT a.*, b.nd
           FROM (SELECT acc, MAX (datf) datf
                     FROM otc_ff7_history_acc
                     where datf < dat_
                 GROUP BY acc) a,
                otc_ff7_history_acc b
          WHERE a.acc = b.acc AND a.datf = b.datf) ndo
  WHERE     o.acc = ndo.acc
        AND tip = 'SS'
        AND dapp IS NOT NULL
        AND (dazs IS NULL OR dazs > dat_)
        AND o.acc NOT IN (SELECT acc FROM otcn_saldo)
        AND ndo.nd not in (select to_char(nd) from cc_deal where sos = 15 and wdate <= dat_)
        AND nls LIKE '2%'
        AND nd IN (SELECT DISTINCT TO_CHAR (NVL (nd, 0))
                     FROM rnbu_trace
                    WHERE kodp LIKE 'A3%')
        AND (nd, kv) NOT IN (SELECT DISTINCT TO_CHAR (NVL (nd, 0)), kv
                               FROM rnbu_trace
                              WHERE kodp LIKE 'A3%')
        AND nd NOT IN (SELECT to_char(c.nd) FROM cc_deal c WHERE c.nd = c.ndi))
loop
   for t in (select * from rnbu_trace where kodp like 'A3%' and to_char(nd) = k.nd)
   loop
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nd, rnk, comm, nbuc, userid,isp)
      VALUES (k.nls,k.kv,t.odate,substr(t.kodp,1,12)||lpad(to_char(k.kv),3,'0')||substr(t.kodp,16,1),1, t.nd, t.rnk, t.comm, t.nbuc, t.userid, t.isp);
   END LOOP;
END LOOP;

logger.info ('P_FF8: etap 14 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

FOR K IN

(SELECT nls,
        kv,
        dat_ odate,
           'A3'
        || (SELECT TRIM (f.ddd)
              FROM kl_f3_29 f
             WHERE f.kf = 'F7' AND f.r020 = SUBSTR (nls, 1, 4))
        || NVL ( (SELECT k111
                    FROM kl_k110 k
                   WHERE     k.k110 IN (SELECT ved
                                          FROM customer
                                         WHERE rnk = cc_v.rnk)
                         AND d_open <= dat_spr_
                         AND (d_close IS NULL OR d_close > dat_spr_)),
                '00')
        || f_get_s260 (nd,
                       acc,
                       (SELECT s260
                          FROM specparam
                         WHERE acc = cc_v.acc),
                       rnk,
                       SUBSTR (nls, 1, 4),
                       0)
        || f_get_s032 (acc,
                       dat_,
                       NULL,
                       nd)
        || s080
        || '00'
        || kv || '1'
           kodp,
        1 znap,
        nd,
        rnk,
        nd comm,
        DECODE (typ_, 0, nbuc1_, NVL (F_Codobl_Tobo (acc, typ_), nbuc1_))
           nbuc,
        (SELECT isp
           FROM accounts
          WHERE acc = cc_v.acc)
           isp
   FROM cc_v
  WHERE     vidd IN (1, 2, 3)
        AND dsdate <= dat_
        AND (dazs IS NULL OR dazs > dat_)
        AND nls NOT LIKE '9%'
        AND nd NOT IN (SELECT DISTINCT NVL (nd, 0) FROM rnbu_trace)
        AND nd NOT IN (SELECT ND FROM cc_deal c WHERE c.nd = c.ndi)
        AND EXISTS
               (SELECT 1
                  FROM saldoa
                 WHERE acc = cc_v.acc8 AND dos <> 0 AND fdat between trunc(dat_, 'mm') and dat_))
loop

    if substr(k.kodp, 3, 2) like '21%' and
       substr(k.kodp, 10, 1) in ('0','1','2','3','4','5')
    then
        kodp_ := substr(k.kodp,1,9) || 'A' || substr(k.kodp,11);
    END IF;

    IF SUBSTR(k.kodp, 3, 2) NOT LIKE '21%' AND
       SUBSTR(k.kodp, 10, 1) IN ('0','1','2','3','4','5')
    THEN
        kodp_ := SUBSTR(k.kodp,1,9) || 'M' || SUBSTR(k.kodp,11);
    END IF;

    INSERT INTO rnbu_trace (nls,
                        kv,
                        odate,
                        kodp,
                        znap,
                        nd,
                        rnk,
                        comm,
                        nbuc,
                        userid,
                        isp)
     VALUES (k.nls,
             k.kv,
             k.odate,
             kodp_,
             k.znap,
             k.nd,
             k.rnk,
             k.comm,
             k.nbuc,
             userid_,
             k.isp);

END LOOP;

logger.info ('P_FF8: etap 15 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

update rnbu_trace set kodp = decode(substr(kodp,1,2),'A3','20','B2','21','B3','22','B4','23','B5','23','B6','24','B7','25','B8','26',substr(kodp,1,2))||substr(kodp,3);

delete from rnbu_trace where kodp like 'A%' or kodp like 'B%';

-- видалення незакритих договорів, але по яких дата закінчення вже настала і фактичний залишок = 0
--delete 
--from rnbu_trace
--where kodp like '20%' and
--      trim(nvl(trim(to_char(nd)), comm)) in (
--        select f.nd
--        from  OTC_FF7_HISTORY_ACC f
--        Where f.datf = dat_ and
--              f.ostq_kd = 0 and
--              f.WDATE <= dat_);

----------------------------------------------------
if mfo_ = 380764 then
   update rnbu_trace
   set kodp = substr(kodp, 1, 4)||'00'||substr(kodp, 7)
   where substr(kodp, 3,2) in ('31', '32', '33', '34', '35', '38');
end if;
----------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_nbu(kodf, datf, kodp, nbuc, znap)
select kodf_, Dat_, kodp, nbuc, znap from
(
SELECT kodp, nbuc, SUM(znap) znap
FROM rnbu_trace
GROUP BY kodp, nbuc
) where znap<>0;

otc_del_arch(kodf_, dat_, 0);
OTC_SAVE_ARCH(kodf_, dat_, 0);
commit;

logger.info ('P_FF8: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------
--exception
--    when others then
--        logger.info ('P_FF8: errors '||sqlerrm||' for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END;
/
 

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FF8.sql =========*** End *** ===
PROMPT ===================================================================================== 


