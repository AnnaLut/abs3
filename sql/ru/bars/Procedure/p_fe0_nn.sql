

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE0_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE0_NN (Dat_ DATE, sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #E0 для КБ (универсальная)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 09/02/2015 (04.02.2015,03.02.2015,17.01.2015,16.01.2015)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.02.2015 - для СБ в код 318 будут вклчаться проводки
             Дт 100*  Кт 2902 OB22=('09','15')
04.02.2015 - не удалялись сторнировочные проводки в показателе 219 т.к.
             не формировался показатель 218.
             Теперь сначала формируем показатель 218 и затем после
             удаления сторнировочных проводок из показателя 219
             удаляет показатель 218
03.02.2015 - с 01.01.2015 исключаются показатели для ЮЛ (118,119,218)
             в показателе 219 исключаются операции покупки валюты
             для погашения кредита (AAL, AAE)
17.01.2015 - для УПБ в код 318 будут вклчаться проводки
             Дт 7419 Кт 362259537
16.01.2015 - для проводок Дт 100*, 2900 Кт 2902 добавлено обработку
             назначения платежа '%2%в пенс.фонд%,'%0.5%в пенс_йний фонд%'
04.11.2014 - для СБ (300465) и кода 119 добавил назначение платежа
             ("куп_вля _ноземно_ валюти")
08.10.2014 - для банка 300205 в код 318 добавлен отбор проводок
             Дт 100* Кт 290249567
02.10.2014 - для банка 300465 будем включать проводки коректирующие
             за месяц Дт 7419 Кт 3622
25.09.2014 - не включаем проводки с TT in ('I02','I03')
18.09.2014 - включаем проводки Дт 2900 Кт 3739 TT='310' и назначение
             'на купівлю'
             для 300465 удаляем проводки для металлов счет 3801 OB22='09'
16.09.2014 - исключаем проводки Дт 3801 Кт 100* и назначение
             платежа '%повернення коштів згідно договору%'
             и исключаем проводки Дт 3801 Кт 100* для которых валютная
             проводка Дт 2909 Кт 3800 (операция "MUX")
21.08.2014 - для проводок Дт 3801 Кт 100* добавлено условие для назначения
             платежа "lower(t.nazn) not like '%викуп%'"
             (не включались проводки где в назначении был текст '959')
12.08.2014 - объеденил формирование некоторых кодов для одного MFOU_
             один блок
28.07.2014 - для СБ (300465) и кода 119 добавил назначение платежа
             ("куп_вля валюти")
24.07.2014 - для банка Демарк при формировании кода 119 изменил условие
             NLSD not like '29003%' на NLSD <> '29003'
04.07.2014 - для 300465 и кода 318 добавил проводки Дт 26ХХ, 3541, 3739
             Кт 2902. Не будут включаться BAK операции для
             Дт 100*  Кт 2902
23.06.2114 - для банка Демарк код 119 формируем если Дт 2900 Кт 29003
13.06.2014 - для 300120 исключаем операцию "И_2"  и для кода 319 вместо
             кредита счета 3739 используем счет 3929
06.06.2014 - для 353575 в код 318 будет отбирать проводки
             Дт 7419 Кт 362268007
05.06.2014 - несущественные изменения
03.06.2014 - отбираем проводки Дт7419  Кт3622 и назначение "в пенс.фонд"
             (замечание УПБ)
02.06.2014 - для банка Надра исключаем проводки для которых TT='013'
             и Дт 2909 Кт не 20* и не 1919, Дт 3739 Кт не 20* и не 1919
             Дт 3801 Кт 6397  и значение доп.реквизита  D1#E0='0'
29.05.2014 - изменения формирования кодов 118,119 для банка Надра
             и кода 318 для банка Демарк
23.05.2014 - изменения для банка Надра
20.05.2014 - для 380764 в показатель 118 добавлено Дт 2900 Кт 1819
19.05.2014 - для 300120 внесены конкретные лицюсчета 2902, 3622
16.05.2014 - новая структура показателя и добавлены новые показатели
19.03.2010 - для облуправлений СБ вместо кода 110 будем выбирать код 120
10.03.2010 - для переменной KURS_ выполняем округление до 4 знаков после
             запятой
07.02.2010 - изменил формирование суммы док-та
03.02.2010 - выбираем данные файла #39 код 112 покупка валюты и
             файла #2A коды 131,132 покупка валюты за грн. для клиентов
01.02.2010 - выбираем данные файла #39 код 112 покупка валюты и
             файла #2A код 110 покупка валюты за грн. в пределах банка
31.08.2007 - выбираем данные файла #39 код 112 покупка валюты
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='E0';
fmt_     varchar2(20):='999990D0000';
--mn_      number:=100; -- для валютообменных операций в кассе, если курс в OPERW за единицу валюты
dl_      number:=100; -- для металлов
DatP_	 date; -- дата начала выходных дней, кот. предшествуют заданой дате
Dat_pmes date; -- последний рабочий день предыдущего месяца
buf_	 number;

typ_     number;
kv_      number;
kv1_     number;
ref_     number;
ref1_    number;
tt_      varchar2(3);
nls_     varchar2(15);
nlsk_    varchar2(15);
nls1_    varchar2(15);
nlsb_    varchar2(15);
mfo_     Varchar2(12);
mfou_    Number;
mfoa_    Varchar2(12);
mfob_    Varchar2(12);
comm_    Varchar2(200);
dat1_    Date;
data_    date;
kol_     number;
dig_     number;
bsu_     number;
sum_     number;
sum1_    number;
sum0_    number;
sun1_    number;
sun0_    number;
kodp_    varchar2(10);
kodp1_   varchar2(10);
znap_    varchar2(30);
VVV      varchar2(3) ;
ddd39_   varchar2(3) ;
ddd_     varchar2(3) ;
d39_     varchar2(200) ;
kurs_    varchar2(200) ;
tag_     varchar2(5) ;
a_       varchar2(20);
b_       varchar2(20);
userid_  number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
acc_     number;
accd_    number;
acck_    number;
pr_      number;
rate_o_  number;
div_     number;
nazn_    Varchar2(200);
dat_izm1 date := to_date('31/12/2014','dd/mm/yyyy');

CURSOR OPL_DOK IS
   SELECT a.tt, a.accd, a.nlsd, a.kv, a.acck, a.nlsk, a.ref, a.fdat,
          a.s*100, a.isp, a.nazn
   FROM tmp_file03 a
   WHERE a.kv = 980
ORDER BY 10, 8, 7;

CURSOR Basel IS
   SELECT nbuc, kodp, SUM(TO_NUMBER (znap))
   FROM RNBU_TRACE a
   WHERE userid=userid_
   GROUP BY nbuc, kodp;
-----------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_FILE03';

mfo_ := F_OURMFO();

-- МФО "родителя"
BEGIN
   SELECT mfou
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;

p_proc_set(kodf_,sheme_,nbuc1_,typ_);
Datp_ := calc_pdat(dat_);
Dat1_:= TRUNC(Dat_,'MM');

-- с 01.01.2015 показатели 118,119,218 не должны формироваться
if Dat_ <= dat_izm1 then

-- код 118
if mfou_ not in (380764) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '3640%' and nbsk like '2900%'
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '3801%' and nbsk  like '1819%'
      and LOWER(nazn) like '%куп_вля%'
      and LOWER(nazn) not like '%swap%'
   ) ;

end if;

if mfou_ not in (300205, 380764) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and dat_
      and kv=980
      and nbsd like '3801%' and nbsk  like '2900%'
      and LOWER(nazn) like '%куп_вля за рахунок%'
   ) ;
end if;

if mfou_ = 300205 then
   -- код 118
    insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '3801%' and nlsk  like '290009228%'
   ) ;

   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nlsd like '2900%' and nlsd not like '290009228%')
      and nlsk like '290009228%'
   ) ;
end if;

if mfou_ = 380764 then
   -- код 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, -S, -SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '2900%'
      and nbsk like '1819%'
   ) ;

   -- код 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nlsd like '34099000000001%'
      and nbsk like '2909%'
      and ref in (144533604,141436535)
   ) ;

   -- код 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nlsd like '29002300386007%' or nlsd like '29002300386502%')
      and nbsk like '2900%'
   ) ;

   -- код 118
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 118
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and ( (nbsd like '1819%' and nbsk like '3640%') or
            (nlsd like '19197300386513%' and nbsk like '2900%')
          )
   ) ;

   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and tt like '013%'
      and ( ( (nbsd like '220%' or nbsd like '223%' or nbsd like '2600%') and
               nbsk like '3801%') or
            (nbsd like '3801%'  and nbsk like '6397%') or
            (nbsd like '2909%'  and nbsk not like '20%' and nbsk not like '1919%')
          )
   ) ;

   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '2900%'
      and (nlsk like '29002300386007%' or nlsk like '29002300386502%')
   ) ;

   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select p.ACCD, p.TT, p.REF, p.KV, p.NLSD, p.S, p.SQ, p.FDAT, p.NAZN, p.ACCK, p.NLSK, 119
    from provodki_otc p
    where p.fdat between Dat1_ and Dat_
      and p.kv=980
      and p.tt like '013%'
      and ( (p.nbsd like '3739%' and p.nbsk like '3801%') or
            (p.nbsd like '3801%' and p.nbsk like '3579%')
          )
      and exists ( select 1 from operw w
                   where w.ref = p.ref
                     and w.tag like 'D1#E0%'
                     and NVL(trim(w.value),'0') = '1'
                 )
   ) ;

end if;

if mfou_ = 300120 then   --not in (300205, 300465, 353575, 380764) then
   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and dat_
      and kv=980
    --and (nlsd not like '2900%' and nlsd not like '3640%' and nlsd not like '2902%') and nlsk  like '2900%' and kv=980
      and nbsd like '2900%' and nbsk like '2900%'
      and LOWER(nazn) like '%куп_вл_%'
   ) ;
end if;

if mfou_ = 300465 then
   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and dat_
      and kv=980
      and nbsd like '2900%' and nbsk like '3739%'
      and ( LOWER(nazn) like '%для куп_вл_%' or
            LOWER(nazn) like '%на куп_вл_%' or
            LOWER(nazn) like '%куп_вл_ валюти%' or
            LOWER(nazn) like '%куп_вл_ _ноземно_ валюти%'
          )
      and ob22d='01'
      and tt='310'
   ) ;
end if;

if mfou_ = 353575 then
   -- код 119
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 119
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nlsd like '2900%' and nlsd <> '29003')
      and nlsk like '29003%'
   ) ;
end if;

end if;
-- c 01.01.2015 коды 118,119,218 не будут формироваться

-- код 218
 insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
select * from
(
select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 218
from provodki_otc
where fdat between Dat1_ and Dat_
and kv=980
and nbsd like '3801%' and nbsk like '100%'
) ;

-- только для банка Надра
if mfou_ = 380764 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 218
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '2909%' and nbsk like '100%'
      and ( lower(nazn) like '%в_плата гривневого _кв_валенту%'        or
            lower(nazn) like '%в_дача гривневого _кв_валент_%'         or
            lower(nazn) like '%видача за придбану _ноземну валюту%'    or
            lower(nazn) like '%в_плата нерозм_нного залишку%'
        )
   ) ;
end if;


-- код 219
 insert into tmp_file03
                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
select * from
(
select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 219
from provodki_otc
where fdat between Dat1_ and Dat_
   and kv=980
   and nbsd like '100%'  and nbsk  like '3801%'
   and tt not in ('AAL','AAE')
) ;

-- код 318
if mfou_ not in (300120, 300205, 300465, 380764, 353575) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '3522%' or nbsd like '7419%') and nbsk  like '3622%'
      and ( lower(nazn) like '%пф%'                            or
            lower(nazn) like '%пфу%'                           or
            lower(nazn) like '%в пенс.фонд%'                   or
            lower(nazn) like '%в_драхування збору на обов%'    or
            lower(nazn) like '%нарахування суми збору до пенс_йного фонду%'    or
            lower(nazn) like '%зб_р на обовяз.пенс.страх%'     or
            lower(nazn) like '%сбор%от покупки валют_%'        or
            lower(nazn) like '%сбор%от конвертации валют_%'    or
            lower(nazn) like '%зб_р%в_д куп_вл_%'              or
            lower(nazn) like '%обов_язкове%пенс. страхування%' or
            lower(nazn) like '%обов_язкове%пенс_йне страхування%'
          )
   ) ;
end if;

-- код 318
if mfou_ not in (300120, 300205, 300465, 380764, 353575) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')  and nbsk  like '2902%'
      and ( lower(nazn) like '%пф%'                            or
            lower(nazn) like '%пфу%'                           or
            lower(nazn) like '%0.5%в пенс.фонд%'               or
            lower(nazn) like '%0.5%в пенс_йний фонд%'          or
            lower(nazn) like '%2%в пенс.фонд%'                 or
            lower(nazn) like '%в_драхування збору на обов%'    or
            lower(nazn) like '%зб_р на обовяз.пенс.страх%'     or
            lower(nazn) like '%сбор%от покупки валют_%'        or
            lower(nazn) like '%сбор%от конвертации валют_%'    or
            lower(nazn) like '%зб_р%в_д куп_вл_%'              or
            lower(nazn) like '%обов_язкове%пенс. страхування%' or
            lower(nazn) like '%обов_язкове%пенс_йне страхування%'
          )
   ) ;
end if;

if mfou_ = 300120 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '3522%' or nbsd like '7419%')
      and (nlsk like '3622800050%' or nlsk like '3622600003%')
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')
      and (nlsk like '2902700015%' or nlsk like '2902800061%')
   ) ;
end if;

if mfou_ = 300205 then
   -- insert into tmp_file03
   --                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   --select * from
   --(
   -- select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
   -- from provodki_otc
   -- where fdat between Dat1_ and Dat_
   --   and kv=980
   --   and nbsd like '7419%'
   --   and (nlsk like '362289536%'or  nlsk like '362259537%')
   --) ;

   -- insert into tmp_file03
   --                (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   --select * from
   --(
   -- select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
   -- from provodki_otc
   -- where fdat between Dat1_ and Dat_
   --   and kv=980
   --   and (nbsd like '100%' or nbsd like '2900%')
   --   and (nlsk  like '290279566%' or nlsk  like '290249567%')
   --) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '100%' and nlsk  like '290249567%'
   ) ;

end if;

if mfou_ = 380764 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '3409%' or nbsd like '3522%' or nbsd like '7419%')
      and nbsk  like '3622%'
      and ob22k in ('15','16')
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')
      and nbsk  like '2902%'
      and ob22k in ('06','07')
   ) ;

end if;

if mfou_ = 300465 then
   if dat_ <= to_date('31122014','ddmmyyyy') then
      insert into tmp_file03
                     (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
     select * from
     (
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
      from provodki_otc
      where fdat between Dat1_ and Dat_
        and kv=980
        and nbsd like '7419%' and nbsk  like '3622%'
        and ob22k in ('12','35')
      UNION
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
      from provodki_otc
      where fdat between Dat_ and Dat_ + 25
        and kv=980
        and vob = 96
        and nbsd like '7419%' and nbsk  like '3622%'
        and ob22k in ('12','35')
     ) ;

      insert into tmp_file03
                     (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
     select * from
     (
      select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
      from provodki_otc
      where fdat between Dat1_ and Dat_
        and kv=980
        and (nbsd like '100%' or nbsd like '26%' or nbsd like '2900%' or
             nbsd like '3541%' or nbsd like '3739%' or nbsd like '7399%')
        and nbsk  like '2902%'
        and ob22k in ('09','15')
     ) ;
   end if;

   if Dat_ > to_date('31122014','ddmmyyyy') then
      insert into tmp_file03
                     (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
       select * from
       (
        select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
        from provodki_otc
        where fdat between Dat1_ and Dat_
          and kv=980
          and nbsd like '100%'
          and nbsk  like '2902%'
          and ob22k in ('09','15')
       ) ;
   end if;

end if;

if mfou_ = 353575 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and nbsd like '7419%'
      and (nlsk like '362268007%' or nlsk like '362210107%')
   ) ;

    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 318
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '100%' or nbsd like '2900%')
      and (nlsk  like '29027010%' or nlsk like '290230110%' or
           nlsk like '362210107%' or nlsk like '362268007%')
   ) ;

end if;

-- код 319
if mfou_ not in (300120, 300465, 380764, 353575) then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv=980
      and (nbsd like '2902%' or nbsd like '3622%') and nbsk  like '3739%'
      and ( lower(nazn) like '%зб_р на обов.держ.пенс.страх%'              or
            lower(nazn) like '%зб_р на обов_язк. держ. пенс. страх%'       or
            lower(nazn) like '%з куп_вл_ безгот_вково_ _ноземно_ валюти%'  or
            lower(nazn) like '%05%ком_с_я при куп_вл_ валют_%'             or
            lower(nazn) like '%з куп_вл_ гот_вково_ _ноземно_ валюти%'     or
            lower(nazn) like '%пенс_йний зб_р%'                            or
            lower(nazn) like '%зб_р%в пф%'                                 or
            lower(nazn) like '%зб_р%в пфу%'
          )
   ) ;
end if;

if mfou_ = 300120 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( ( (nlsd like '2902700015%' or nlsd like '2902800061%') and nbsk  like '3929%' ) or
            ( (nlsd like '3622800050%' or nlsd like '3622600003%') and nbsk  like '3929%' )
          )
   ) ;
end if;

if mfou_ = 353575 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( ( (nlsd like '29027010%' or nlsd like '290230110%' or
               nlsd like '362210107%' or nlsd like '362268007%' ) and nbsk  like '3929%' )
          )
   ) ;
end if;

if mfou_ = 380764 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( (nbsd like '2902%' and nbsk  like '3739%' and ob22d in ('06','07')) or
            (nbsd like '3622%' and nbsk  like '3739%' and ob22d in ('15','16'))
          )
   ) ;
end if;

if mfou_ = 300465 then
    insert into tmp_file03
                   (ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, ISP)
   select * from
   (
    select ACCD, TT, REF, KV, NLSD, S, SQ, FDAT, NAZN, ACCK, NLSK, 319
    from provodki_otc
    where fdat between Dat1_ and Dat_
      and kv = 980
      and ( (nbsd like '2902%' and nbsk  like '3739%' and ob22d in ('09','15')) or
            (nbsd like '3622%' and nbsk  like '3739%' and ob22d in ('12','35'))
          )
   ) ;
end if;

if mfou_ not in (380764) then
   -- удаление проводок Дт 2900 Кт 2900 и определенные назначения платежа
   delete from tmp_file03
   where nlsd like '2900%' and nlsk like '2900%'
   and ( lower(nazn) like '%повернення зайво перерахованих%' or
         lower(nazn) like '%повернення залишку кошт_в%'      or
         lower(nazn) like '%повернення кошт_в%'              or
         lower(nazn) like '%возврат излишне перечисленных%'  or
         lower(nazn) like '%возврат средств%'                or
         lower(nazn) like '%возврат неиспользованных ср-в%'  or
         lower(nazn) like '%возврат перечисленных средств%'  or
         lower(nazn) like '%возврат ср-в , перечисленных%'   or
         lower(nazn) like '%возврат ср-в перечисленных на покупку%'
       );
   --and lower(nazn) not like '%частичный возврат ср-в перечисленных на покупку%';
end if;


-- удаление проводок Дт 3801 Кт 100 и определенные назначения платежа
--delete from tmp_file03
--where nlsd like '3801%' and nlsk like '100%'
--and ( lower(nazn) like '%повернення кошт_в зг_дно договору%'
--    );

-- удаление проводок по оплате переводов (операция "MUX")
   DELETE FROM tmp_file03 t
   WHERE t.nlsd like '3801%' and t.nlsk like '100%'
     and exists ( select 1
                  from provodki_otc o
                  where o.fdat between Dat1_ and Dat_
                    and o.ref = t.ref
                    and o.kv <> 980
                    and o.nbsd like '2909%'
                    and o.nbsk like '3800%');

-- удаление проводок по металлах
   DELETE FROM tmp_file03 t
   WHERE ( (t.nlsd like '100%' and t.nlsk like '3801%') or
           (t.nlsd like '3801%' and t.nlsk like '100%')
         )
     and exists ( select 1
                  from provodki_otc o
                  where o.fdat between Dat1_ and Dat_
                    and o.ref = t.ref
                    and o.kv in (959,961,962,964)
               );

   DELETE FROM tmp_file03 t
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%')
         )
     and ( lower (t.nazn) like '%959%' or lower (t.nazn) like '%xau%' or
           lower (t.nazn) like '%961%' or lower (t.nazn) like '%xag%' or
           lower (t.nazn) like '%962%' or lower (t.nazn) like '%xpt%' or
           lower (t.nazn) like '%964%' or lower (t.nazn) like '%xpd%' or
           lower (t.nazn) like '%метал%' or
           lower (t.nazn) like '%злиток%' or
           lower (t.nazn) like '%зливок%' or
           lower (t.nazn) like '%злитк%'
         )
     and lower (t.nazn) not like '%в_куп%';

   if mfou_ = 300465 then
      -- удаление проводок по металлах
      DELETE FROM tmp_file03 t
      WHERE ( (t.nlsd like '100%' and t.nlsk like '3801%') or
              (t.nlsd like '3801%' and t.nlsk like '100%')
            )
         and exists ( select 1
                      from provodki_otc o
                      where o.fdat between Dat1_ and Dat_
                        and o.ref = t.ref
                        and (o.nbsd like '3801%' or o.nbsk like '3801%')
                        and (o.ob22d ='09' or o.ob22k = '09')
                    );

      -- удаление проводок Дт 100 Кт 3801 операции I02, I03
      DELETE FROM tmp_file03
      WHERE ( (nlsd like '3801%' and nlsk like '100%') or
              (nlsd like '100%' and nlsk like '3801%')
            )
        and tt in ('I02','I03');

   end if;

-- удаление сторнированных проводок
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and ref in ( select o.ref
                  from tmp_file03 o
                  where o.tt = 'BAK');

-- удаление BAK операций
   DELETE FROM tmp_file03
   WHERE ( (nlsd like '100%' and nlsk like '3801%') or
           (nlsd like '3801%' and nlsk like '100%') or
           (nlsd like '100%' and nlsk like '2902%') or
           (nlsd like '2902%' and nlsk like '100%')
         )
     and tt = 'BAK';

-- с 01.01.2015 показатели 118,119,218 не должны формироваться
-- наполняли код 218 для удаления сторнировочных проводок (операция "BAK")
if Dat_ > dat_izm1 then
   -- удаление кода 218
   DELETE FROM tmp_file03
   WHERE isp = 218;
end if;

-- зворотній обмін не використаної гривні
if mfou_ = 300120 then
   DELETE FROM tmp_file03
   WHERE nlsd like '100%' and nlsk like '3801%'
     and tt in ('И2', 'И_2') ;
end if;

if mfou_ = 380764 then
   DELETE FROM tmp_file03
   WHERE nlsd like '29002300386007%' and nlsk like '29002300386502%' ;

   DELETE FROM tmp_file03
   WHERE nlsd like '100%' and nlsk like '3801%'
     and tt = 'AA8' ;

   --DELETE FROM tmp_file03
   --WHERE nlsd like '2900%'
   --  and (nlsk like '2900%' and nlsk not like '29002300386007%' and nlsk not like '29002300386502%') ;

   delete from tmp_file03
   where (nlsd like '29002300386007%' or nlsd like '29002300386502%')
     and nlsk like '2900%'
     and isp = 118;

   -- удаление сторнированных проводок
   DELETE FROM tmp_file03 t
   WHERE t.tt = '013'
     and ( (t.nlsd like '2909%' and t.nlsk not like '20%' and t.nlsk not like '1919%') or
           (t.nlsd like '3739%' and t.nlsk like '3801%') or
           (t.nlsd like '3801%' and (t.nlsk like '3579%' or  t.nlsk like '6397%'))
         )
     and exists ( select 1
                  from operw o
                  where o.ref = t.ref
                    and o.tag like 'D1#E0%'
                    and NVL(trim(o.value),'0') = '0');

   for k in ( select ref, s
              from tmp_file03
              where (nlsd like '29002300386007%' or nlsd like '29002300386502%')
                and nlsk like '2900%'
                and nlsk not like '29002300386007%' and nlsk not like '29002300386502%'
                and ( lower(nazn) like '%возврат излишне перечисленных%'                    or
                      lower(nazn) like '%повернення зайво перерахованих%'                   or
                      lower(nazn) like '%повернення кошт_в взв_язку з невиконанням заявки%' or
                      lower(nazn) like '%возврат неиспользованных ср-в%'                    or
                      lower(nazn) like '%частичный возврат ср-в%'                           or
                      lower(nazn) like '%возврат ср-в , перечисленных%'                     or
                      lower(nazn) like '%возврат ср-в ,перечисленных%'                      or
                      lower(nazn) like '%возврат перечисленных средств на покупку%'         or
                      lower(nazn) like '%возврат ср-в перечисленных на покупку%'
                    )
            )
      loop

         update tmp_file03 t set ISP=119, t.s = 0 - t.s
         WHERE t.ref = k.ref
           and t.s = k.s ;

      end loop;

end if;

-- межбанк
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO tt_, accd_, nls_, kv_, acck_, nlsk_, ref_, data_, sum1_, ddd_, nazn_ ;
   EXIT WHEN OPL_DOK%NOTFOUND;

   IF SUM1_ != 0 then

      IF ddd_ in ('118','119','219','318') THEN
         nls1_:=nls_;
         acc_:=accd_;
      ELSE
         nls1_:=nlsk_;
         acc_:=acck_;
      END IF;

      IF mfou_ = 380764 and
         (nls_ like '29002300386007%' or nls_ like '29002300386502%')
         and nlsk_ like '2900%'
         and ddd_ in ('118','119') THEN
         nls1_:=nlsk_;
         acc_:=acck_;
      END IF;

      IF nls_ like '7419%' and nlsk_ like '3622%'
      THEN
         BEGIN
            select accd
               into acc_
            from provodki_otc
            where ref = ref_
              and nlsd like '100%'
              and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               select acck
                  into acc_
               from provodki_otc
               where ref = ref_
                 and nlsk like '100%'
                 and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         END;
      END IF;

      -- определяем код области
      if typ_ > 0 then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      if ddd_ = '319' then
         nbuc_ := nbuc1_;
      end if;

      kodp_:= '1' || ddd_ || '000' ;
      znap_:= TO_CHAR(sum1_);

      comm_ := substr('TT = '||tt_ ||' Дт = ' || nls_ || ' Кт = ' || nlsk_ || ' Ref = ' || to_char(ref_) || ' Nazn = ' || nazn_, 1, 200);

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, comm, ref) VALUES
                             (nls1_, kv_, data_, kodp_, znap_, nbuc_, comm_, ref_);
   END IF;

END LOOP;
CLOSE OPL_DOK;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf=dat_;
---------------------------------------------------
OPEN basel;
   LOOP
      FETCH basel
      INTO nbuc_, kodp_, sum0_;
      EXIT WHEN basel%NOTFOUND;

      IF sum0_<>0 then

         -- сумма
         INSERT INTO tmp_nbu
              (kodf, datf, kodp, znap, nbuc)
         VALUES
              (kodf_, Dat_, kodp_, to_char(sum0_), nbuc_) ;

      end if;

   END LOOP;
CLOSE basel;
----------------------------------------
END p_fE0_NN;
/
show err;

PROMPT *** Create  grants  P_FE0_NN ***
grant EXECUTE                                                                on P_FE0_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE0_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
