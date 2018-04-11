CREATE OR REPLACE PROCEDURE BARS.P_FD5_NN (Dat_   DATE,
                                           sheme_ VARCHAR2 DEFAULT 'G',
                                           prnk_   number   DEFAULT null) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    #D5 for KB
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     : v.17.012      10/04/2018 (06/04/2018, 13/03/2108)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
           prnk_ - РНК контрагента
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   Структура показника    L D BBBB Z LL YY 9 Ц R QQ Ч VVV MMM T ГГ N I

  1     L          1/2    (сума/%ставка)
  2     D          1/2/6  (залишок ДТ/залишок КТ/оборот КТ)
  3     BBBB       балансовий рахунок
  7     Z          R011
  8     LL         K111 вид економiчноi дiяльностi
 10     YY         K072 код сектора економiки
 11     9          (K081)     с 30.06.2017 параметр K140
 12     Ц          S183 код початкового строку погашення
 13     R          K030 код резидентностi
 14     QQ         K051 код организац.правовой формы хоз-ия
 16     Ч          S032 код виду забезпечення кредиту
 17     VVV        R030 код валюти
 20     MMM        K040 код краiни
 23     T          S080 категорiя ризику
 24     ГГ         S260 код iндивiдуального споживання по цiлях
 26     N          2/3/4 (залишок/середн.залишок/проц.доходи)
 27     I          S190 код строку прострочення погашення боргу

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 10/04/2018 - змінений блок для вирівнювання залишків по рах. резервів
              (параметр K072 вибирається 2 символи замість одного)
 02/04/2018 - будемо додатково включати бал.рах. '***9' з типом 'SNA' 
 13/03/2018 - для резидентов и бал. счета 2625 параметр K072 = '42' 
 12/03/2018 - для нерезидентов и бал. счета 2625 параметр K072 = 'N8' 
 09/02/2018 - для ФЛ резидента и бал.счета 9129 изменяем K072 на '42' 
              если K072='00'
              для 2203, 2206, 2208 R011='1'
 06/02/2018 - в коде показателя бал.счет 6046 заменяем на 6055  
 24/01/2018 - для показателя різниця заокруглень изменил символ 'N' на 
              '42'
              для формирования средних остатков по основным счетам 
              добавил гр. признанных доходов 605 (переброска с гр.604)
 12/01/2018 - новая структура показателя 
              (параметр K072 2-х значный вместо однозначного) 
 08.12.2017 -для блока списания за счет резерва изменено формирование
             части показателя S190 (вместо 25 позиции берем 27 т.к.
             изменилась структура показателя)
 21.09.2017 -для 2607,2627 неверно заполнялось поле ACC в RNBU_TRACE
             Исправлено. 
 08.09.2017 -убрал некоторые блоки для МФО=353575 и VIEW SAL заменил на
             таблицу OTCN_SALDO 
 08.08.2017 -за 31.07.2017 в Донецке файл формировался 45 минут
             пердаем во все регионы  
 14.07.2017 -в блоке обработки счетов резерва изменил условие 
             для 2607,2627 вместо NLS, KV будем использовать ACC 
 11.07.2017 -добавил обработку бал.счета 3690 как счета резерва
            (кроме групп 159, 240 добавил 369)
 10.07.2017 -для k072 in ('0','5','6','7','H','I','J','K','N','R','Z','Y')
             устанавливаем k140='9' 
 06.07.2017 -удалены закоментаренные блоки и изменены условия 
             для выборки параметра K140
 05.07.2017 -вместо кода '9'(K081) будет формироваться доп.параметр K140
             для параметра S190 на 01.07.2017 введены новые значения
             (0, A, B, C, D, E, F, G)
 09.03.2017 -добавил условие для 9129 при определении S080 из NBU23_REZ 
 07.02.2017 -на 01.02.2017 вместо поля KAT будем использовать поле S080
             и вместо поля OBS будем использовать поле KOL_351 
 11.01.2017 -выравнивание резервов по балансу: код области корректирующей
             записи равен коду области записи с выбранным кодом показателя
 29.12.2016 -для карточных счетов 2202/2203 по w4_acc уточняется
             начальный срок S180
 26/04/2016 - в процедуре P_GET_S080_S180 добавлена выборка типа счета 
              поле "tip" для обработки счетов типа "SNA"
              код строка S180(S183) будем выбирать из типов (SS, SP)             
 04/04/2016 - новая структура показателя (добавляется код строку 
              прострочення погашення боргу - S190) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     VARCHAR2(2):='D5';
S080_     VARCHAR2(1);
S080_os   VARCHAR2(1);
S080_r    VARCHAR2(1);
S180_     VARCHAR2(1);
S180_k    VARCHAR2(1);
S181_     VARCHAR2(1);
S183_     Varchar2(1);
s190_     Varchar2(1);
s260_     VARCHAR2(2);
s260_k    VARCHAR2(2);
vidd_     NUMBER;
nd_       NUMBER;
sql_      VARCHAR2(3000);
def_r011_ VARCHAR2(1);
def_s181_ VARCHAR2(1);
kol_dz    Number;
typ_      NUMBER;
tips_     VARCHAR2(3);
nbs_      VARCHAR2(4);
nbs1_     VARCHAR2(4);
nls_      VARCHAR2(15);
mfo_      VARCHAR2(12);
data_     DATE;
datfp_    DATE;  -- отчетная дата предыдущего месяца
datp_     DATE;  -- дата начала выходных дней, кот. предшествуют заданой дате
datpf_    DATE;  -- предыдущая рабочая дата
DatN_     DATE;
d_close_  DATE;
kv_       SMALLINT;
isp_      NUMBER;
custtype_ NUMBER;
re_       SMALLINT;
codcagent_ SMALLINT;
sum_2401  NUMBER;
sn_       DECIMAL(24);
se_       DECIMAL(24);
s_zd2_    NUMBER;
Ostn_     DECIMAL(24);
Ostq_     DECIMAL(24);
Dos96_    DECIMAL(24);
Kos96_    DECIMAL(24);
Dosq96_   DECIMAL(24);
Kosq96_   DECIMAL(24);
rnk_      NUMBER;
acc_      NUMBER;
accr_     NUMBER;
acc1_     NUMBER;
acc2_     NUMBER;
acco_     NUMBER;
acc_2607_ NUMBER;
acc_r_    NUMBER;
dk_       CHAR(1);
kodp_     VARCHAR2(35);
kodp1_    VARCHAR2(35);
znap_     VARCHAR2(70);
r011_     CHAR(1);
r011_2_   CHAR(1);
r011_new_ CHAR(1);
r012_     CHAR(1);
k071_     CHAR(1);
k072_     CHAR(2);
k081_     CHAR(1);
k140_     CHAR(1);
k111_     CHAR(2);
r031_     CHAR(1);
k051_     CHAR(2);
s031_     Varchar2(2);
s031_1    Varchar2(2);
s031_2    Varchar2(2);
s032_     Varchar2(1);
kol_      Number;
kol1_     Number;
kol2_     Number;
country_  NUMBER;
countryh_ NUMBER;
userid_   NUMBER;
nbuc1_    VARCHAR2(12);
nbuc_     VARCHAR2(30);
sql_acc_  VARCHAR2(10000):='';
sql_doda_ VARCHAR2(200):='';
ret_      NUMBER;
mfou_      NUMBER;
komm_     NUMBER; --сумма коммисионных
kommr_    NUMBER; --сумма коммисионных
kolvo_    number;
comm_     varchar2(200);
dat_kl_   date;
rezid_    NUMBER;
comm_add_ varchar2(20);
spcnt_     NUMBER;
spcnt_old_ NUMBER;
spcnt1_    VARCHAR2 (10);
flag_      BOOLEAN        := TRUE;
fmt_       VARCHAR2 (20)  := '9999990D9999';
fmt2_      VARCHAR2 (30)  := '999G999G999G990D99';
sob_       NUMBER;
sobpr_     NUMBER;
kom_       number;
old_prc_   number;
basey_     number;
b_yea      number;
cntr_      NUMBER;

PrcEf_     boolean:=false;

type t_otcn_log is table of number index by pls_integer;
table_otcn_log3_ t_otcn_log;

dat_izm1    date := to_date('01072011','ddmmyyyy');
dat_izm2    date := to_date('01102011','ddmmyyyy');
dat_izm3    date := to_date('30082012','ddmmyyyy');
dat_izm4    date := to_date('31032016','ddmmyyyy');
dat_izm5    date := to_date('30062017','ddmmyyyy');
dat_izm6    date := to_date('29122017','ddmmyyyy');

dat1_       date;
dat2_       date;
dat23_      date;
dat_spr_    date := last_day(dat_)+1;

nbs_r013_   varchar2(5);
recid_      number;
cid_        number := f_snap_dati(dat_, 2);
datpp_      date;
dats_       date := trunc(dat_, 'mm');

is_bpk      integer;
product_    w4_product.grp_code%TYPE;
kol_351_    NUMBER;

acc_type_   varchar2(3);

CURSOR SALDO IS
   SELECT  a.rnk, a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ost, a.ostq,
           a.dos96, a.kos96, a.dosq96, a.kosq96, s.isp, s.accc, s.tip
   FROM otcn_saldo a, accounts s
   WHERE a.acc=s.acc AND
         ((s.nbs NOT IN ('1600','2600','2605','2620','2625','2650','2655') AND  
           a.ost-a.dos96+a.kos96 <> 0) OR
          (s.nbs IN ('1600','2600','2605','2620','2625','2650','2655') AND  
           a.ost-a.dos96+a.kos96 < 0) OR
          (s.nbs='1500' AND a.ost-a.dos96+a.kos96 > 0) );

CURSOR BaseL IS
   SELECT a.kodp, a.nbuc, SUM (a.znap)
   FROM rnbu_trace a
   GROUP BY a.kodp, a.nbuc;

CURSOR BaseL1 IS
   SELECT nbuc, kodp, SUM (TO_NUMBER (znap)),
            SUM (TO_NUMBER (znap_pr))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP, '0' ZNAP_PR
         FROM RNBU_TRACE a
         WHERE a.kodp like '4%'
           and exists (select 1 from kod_d5_1 where r020=substr(a.kodp,3,4))
         UNION ALL
         SELECT a.nbuc NBUC, '4'||substr(a.kodp,2) KODP, '0' ZNAP,
                a.znap ZNAP_PR
         FROM RNBU_TRACE a
         WHERE a.kodp like '3%'
           and exists (select 1 from kod_d5_1 where r020=substr(a.kodp,3,4)))
   GROUP BY nbuc, kodp;

CURSOR BaseL2 IS
   SELECT nbuc, kodp, SUM (TO_NUMBER (znap))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP
         FROM RNBU_TRACE a
         WHERE a.kodp like '1%')
   GROUP BY nbuc, kodp;

CURSOR BaseL3 IS
   SELECT nbuc, kodp, SUM (TO_NUMBER (znap))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP
         FROM RNBU_TRACE a
         WHERE a.kodp like '1%')
   GROUP BY nbuc, kodp;

-------------------------------------------------------------------
PROCEDURE p_ins_log (p_kod_ VARCHAR2, p_val_ NUMBER)
IS
        mes_ VARCHAR2(200);
BEGIN
   IF     kodf_ IS NOT NULL
      AND userid_ IS NOT NULL
      AND (p_val_ IS NULL OR (p_val_ IS NOT NULL AND p_val_ <> 0))
   THEN
      mes_ :=  p_kod_ || Trim(TO_CHAR (p_val_ / 100, fmt2_));

      IF LENGTH(mes_)>=100 THEN
          INSERT INTO OTCN_LOG(kodf, userid, txt)
               VALUES (kodf_, userid_, SUBSTR(mes_,1,99));

          INSERT INTO OTCN_LOG(kodf, userid, txt)
               VALUES (kodf_, userid_, SUBSTR(mes_,100,99));
      ELSE
          INSERT INTO OTCN_LOG(kodf, userid, txt)
               VALUES (kodf_, userid_, mes_);
      END IF;
   END IF;
END;


PROCEDURE p_obrab_data(p_type_ IN NUMBER) IS
   acco_    number;
   s080r_   varchar2(1);  
BEGIN
   if p_type_ = 1 then
      comm_ := '';
   elsif p_type_ = 2 then
      comm_ := 'Відсотки ';
   elsif p_type_ = 3 then
       if substr(nbs_,4,1) = '6' then
          comm_ := 'Середні залишки по дисконтах/преміях ';
       else
          comm_ := 'Середні залишки по осн. боргу ';
       end if;
   elsif p_type_ = 4 then
      comm_ := 'Визнані процентні доходи ';
   elsif p_type_ = 5 then
      comm_ := 'Амортизація дисконту ';
   end if;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   nd_ := null;
   acc2_ := null;
   acc_2607_ := null;

   if nbs_ in ('2600', '2607', '2620', '2627', '2650', '2655', '2657') or 
      nbs_ = '3600' and acc_ <> accr_
   then --овердрафты
      IF nbs_ in ('2607', '2627', '2657')
      THEN
         acc_2607_ := acc_;

         BEGIN
            SELECT i.acc 
               INTO acco_
            FROM int_accn i, accounts a
            WHERE i.acra = acc_
              AND ID = 0
              AND i.acc = a.acc
              AND a.nbs LIKE SUBSTR (nbs_, 1, 3) || '%'
              AND a.nbs <> nbs_ 
              AND a.dazs is null;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               acco_ := NULL;
         WHEN TOO_MANY_ROWS THEN
            raise_application_error(-20000, '>1 основного рахунку в int_accn для ACC = '||acc_);
         END;
      ELSIF nbs_ = '3600' THEN
         acco_ := accr_;
      else
         acco_ := acc_;
      END IF;

      begin
        select a.nd
           into nd_
        from acc_over a, accounts s
        where a.acco = s.acc
          and s.nbs not like '22%'  
          and a.acco = acco_ 
          and NVL (a.sos, 0) <> 1;
      exception
        when NO_DATA_FOUND THEN
          begin
            select max(nd)
               into nd_
            from acc_over_archive a, accounts s
            where a.acco = s.acc
              and s.nbs not like '22%'
              and a.acco = acco_;
          exception
            when NO_DATA_FOUND THEN
              nd_ := NULL;
          END;
      END;
   elsif nbs_ like '1%' then -- межбанк
       if acc_type_ not like 'RZ%' then
          BEGIN
             SELECT n.nd, c.vidd
                INTO nd_, vidd_
             FROM nd_acc n, cc_deal c
             WHERE n.acc = acc_
               AND n.nd = c.nd
               AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                      FROM nd_acc a, cc_deal p
                                      WHERE a.acc = acc_
                                        AND a.nd = p.nd
                                        AND dat_ between p.sdate and p.wdate);
          EXCEPTION WHEN NO_DATA_FOUND THEN
              BEGIN
                 SELECT n.nd, c.vidd
                    INTO nd_, vidd_
                 FROM nd_acc n, cc_deal c
                 WHERE n.acc = acc_
                   AND n.nd = c.nd
                   AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                          FROM nd_acc a, cc_deal p
                                          WHERE a.acc = acc_
                                            AND a.nd = p.nd);
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 nd_ := NULL;
                 vidd_ := NULL;
              END;
          end;
       end if;
   else -- все остальные
       if acc_type_ not like 'RZ%'
       then
          BEGIN
             SELECT n.nd, c.vidd
                INTO nd_, vidd_
             FROM nd_acc n, cc_deal c
             WHERE n.acc = acc_
               AND n.nd = c.nd
               AND (c.sdate, c.nd) = (SELECT MAX (p.sdate), MAX (p.nd)
                                      FROM nd_acc a, cc_deal p
                                      WHERE a.acc = acc_
                                        AND a.nd = p.nd
                                        AND p.sdate <= dat_);
          EXCEPTION WHEN NO_DATA_FOUND THEN
             nd_ := NULL;
             vidd_ := NULL;
          END;
       end if;
   end if;

   BEGIN
      sql_ := 'SELECT b.custtype, MOD(b.codcagent ,2), nvl(d.k111,''00''), '||
                         'nvl(trim(e.k071),''0''), nvl(trim(e.k072),''00''), '||
                         'nvl(substr(trim(f.value),1,1),''9''), '|| 
                         'nvl(substr(ltrim(rtrim(b.sed)),1,2),''00''), '||
                         'nvl(b.country,804), nvl(trim(e.d_close),NULL), b.codcagent '||
                  'FROM  customer b, customerw f, '||
                    '(select K110, K111, decode(D_CLOSE, to_date(''30042007'',''ddmmyyyy''), null, D_CLOSE) D_CLOSE '||
                    'from kl_k110 where d_open <= :dat_ and '||
                       ' (d_close is null or d_close > :dat_ or d_close = to_date(''30042007'',''ddmmyyyy''))) d,
                        (select K070, K071, K072, D_CLOSE
                         from kl_k070
                         where d_open <= :dat_spr_ and
                              (d_close is null or d_close > :dat_spr_)) e '||
                  'WHERE b.rnk=:rnk_      AND '||
                       ' b.rnk = f.rnk(+) AND '||
                       ' f.tag(+) like ''K140%'' and '||
                       ' b.ved=d.k110(+)  AND '||
                       ' b.ise=e.k070(+) ';

      EXECUTE IMMEDIATE sql_ INTO custtype_,re_, k111_, k071_, k072_, k140_,
                                  k051_, country_, d_close_, codcagent_
      USING dat_spr_, dat_spr_, dat_spr_, dat_spr_, rnk_;

      countryh_ := f_country_hist(rnk_, dat_);

      if countryh_ is not null then
         country_ := countryh_;
      end if;
      
      if country_ = '804' then
         re_ := 1;
      else
         re_ := 0;
      end if;
   END ;

   if (d_close_ is not null and d_close_ <= Dat_) OR nbs_ in ('2625') then
      BEGIN
         SELECT NVL(lpad(trim(k072), 2, 'X'), k072_)
            INTO k072_
         FROM specparam
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         null;
      END ;
   end if;

   if nbs_ = '2625' and re_ = 1 and k072_ not in ('42','43')
   then
      k072_ := '42';
   end if;

   if nbs_ = '2625' and re_ = 0 and k072_ <> 'N8'
   then
      k072_ := 'N8';
   end if;

   BEGIN
      SELECT acc, NVL(Trim(r011),'0'), NVL(Trim(s031),'90'),
         DECODE(Trim(s180), NULL, Fs180(acc_, SUBSTR(nbs_,1,1), dat_), s180),
         NVL(trim(s080),'0'), lpad(NVL(trim(s260),'00'), 2, '0'),
         decode(trim(s181), null, ' s181p не заповнено', ' s181p='||trim(s181))
      INTO acc1_, r011_, s031_1, s180_, s080_, s260_, comm_add_
      FROM specparam
      WHERE acc=acc_ ;

      kolvo_ := 1;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      kolvo_ := 0;
      acc1_:= 0;
      r011_:='0';
      s180_:= Fs180(acc_, SUBSTR(nbs_,1,1), dat_);  --'0';
      s031_1:='90';
      s080_ := '0';
      s260_ := '00';
   END ;

   P_GET_S080_S180(dat_, mfou_, acc_, nls_, kv_, acc2_, nd_, vidd_, rezid_, comm_, s080_, s180_);
   
   -- на 01.04.2016 новый код в структуре показателя S190 
   --               (это поле OBS в NBU23_REZ)
   -- на 01.02.2017 новое поле в NBU23_REZ S080(класс) и KOL_351(кол-во дней просрочки)
   if Dat_ > to_date('30112012','ddmmyyyy') then
      BEGIN
         select NVL(s080,'0'), NVL(kol_351, 1)
            into s080r_, kol_351_
         from nbu23_rez
         where fdat = dat23_
           and acc = acc_
           and nd = nd_
           and rownum = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            select NVL(s080, '0'), NVL(kol_351, 1)
               into s080r_, kol_351_
            from nbu23_rez
            where fdat = dat23_
              and acc = acc_
              and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               select NVL(s080, '0'), NVL(kol_351, 1)
                  into s080r_, kol_351_
               from nbu23_rez
               where fdat = dat23_
                 and nd = nd_
                 and nls not like '9%'
                 and nls not like '3%'
                 and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select NVL(s080, '0'), NVL(kol_351, 1)
                     into s080r_, kol_351_
                  from nbu23_rez
                  where fdat = dat23_
                    and rnk = rnk_
                    and nls not like '9%'
                    and nls not like '3%'
                    and rownum = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  BEGIN
                     select NVL(s080, '0'), NVL(kol_351, 1)
                        into s080r_, kol_351_
                     from nbu23_rez
                     where fdat = dat23_
                       and rnk = rnk_
                       and rownum = 1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     s080r_ := '0';
                     kol_351_ := 1;
                  END;
               END;
            END;
         END;
      END;
   end if;
   
   if nvl(trim(s080r_), '0') <> '0' then
      s080_ := nvl(trim(s080r_), '0');
   end if;

   if s080_ in ('0', '1', '2', '3', '4', '5')
   then
      s080_ := 'A';
   end if;

   if kol_351_ < 8 
   then
      s190_ := '1';
   elsif kol_351_ < 31 
   then
      s190_ := '2';
   elsif kol_351_ < 91
   then
      s190_ := '3';
   elsif kol_351_ < 181 
   then
      s190_ := '4';
   else
      s190_ := '5';
   end if;

   -- на 01.07.2017 новые значения параметра S190
   if dat_ >= dat_izm5
   then
      if kol_351_ = 0 
      then
         s190_ := '0';
      elsif kol_351_ > 0 and kol_351_ < 8 
      then
         s190_ := 'A';
      elsif kol_351_ < 31 
      then
         s190_ := 'B';
      elsif kol_351_ < 61
      then
         s190_ := 'C';
      elsif kol_351_ < 91
      then
         s190_ := 'D';
      elsif kol_351_ < 181 
      then
         s190_ := 'E';
      elsif kol_351_ < 361 
      then
         s190_ := 'F';
      else
         s190_ := 'G';
      end if;
   end if;

   s260_ := lpad(f_get_s260 (nd_, acc_, s260_, rnk_, nbs_), 2, '0');

   if s260_ = '00' 
   then
      s260_ := lpad(f_get_s260_bpk(nd_, acc_, 1, s260_, dat_), 2, '0');
   end if;

   if s260_ = '00' 
   then
      s260_ := lpad(f_get_s260_bpk(nd_, acc_, 2, s260_, dat_), 2, '0');
   end if;

   spcnt_ :=  nvl(Acrn.fproc (acc_, dat_), 0);
   kom_ :=  (case when accr_ is null then 0 else nvl(Acrn.fprocn (accr_, 2, dat_), 0) end);

   old_prc_ := spcnt_;

   PrcEf_ := false;

   flag_ := TRUE;

   if p_type_ = 1 and dat_ <= dat_izm3 then
       begin
          select r020
             into nbs1_
          from kod_d5_1
          where r020=nbs_;

          -- перерасчет годовой % ставки с учетом ежемесячной коммисии
          if 300465 NOT IN (mfo_, mfou_) and
             se_ < 0 and kom_ <> 0
          then
              old_prc_ := spcnt_;

              declare
                 metr_ number;
              begin
                 select metr
                 into metr_
                 from int_accn
                 where acc=accr_
                   and id=2;

                 if metr_ = 97 then
                     null;
                 else
                     spcnt_ := ROUND (spcnt_ + 12 * kom_, 4);

                     p_ins_log('Cчет '''||nls_||
                                '. %MesKom='||Trim(TO_CHAR(kom_))||
                                '. OldPrc='||Trim(TO_CHAR(old_prc_))||
                                '. NewPrc='||LTRIM(TO_CHAR (spcnt_))||
                                '.', NULL);
                 end if;
              exception
                 when no_data_found then
                      metr_ := null;
              end;
          elsif 300465 IN (mfo_, mfou_)
          then
             -- По эффективной % ставке (если она рассчитана)
             -- пока что только для Демарка
             old_prc_ := spcnt_;
             PrcEf_ := false;
             spcnt_ := 0;

             -- для кредитов эффект. % ставка на счете 8999
             if trim(tips_) in ('SS','SP','SL') and se_ < 0 and nls_ like '2%' then
                declare
                  acc8_ number;
                begin
                   select max(a.acc)
                      into acc8_
                   from accounts a, nd_acc n
                   where a.nls like '8999%' and
                         a.acc = n.acc and
                         n.nd = nd_;

                   if nvl(acc8_, 0) <> 0 then
                      spcnt_ := Acrn.fprocn (acc8_, -2, dat_);

                      if spcnt_ <> 0 then
                         PrcEf_ := true;
                      end if;
                   end if;
                exception
                          when no_data_found then
                   PrcEf_ := false;
                end;
             end if;

             -- если не нашли эффект. % ставка на счете 8999, то попытаемся ее найти на счете номинала
             if not PrcEf_ then
                spcnt_ := Acrn.fprocn (acc_, -2, dat_);

                if spcnt_ <> 0 then
                   PrcEf_ := true;
                else
                   PrcEf_ := false;
                end if;
             end if;

             if PrcEf_ and spcnt_ <> 0 then
                p_ins_log('Cчет '''||nls_||
                          '. OldPrc='||Trim(TO_CHAR(old_prc_))||
                          '. EffPrc='||LTRIM(TO_CHAR (round(spcnt_, 4)))||
                          '.', NULL);
             else
                -- восстанавливаем старую %% ставку
                spcnt_ := old_prc_;
                PrcEf_ := false;
             end if;
          end if;

          -- для указанных бал.счетов должна быть реальная %% ставка
          if nbs_ in ('1510','1521','1610','1621','2600','2605','2620','2650','2655') then
             spcnt_ := old_prc_;
          end if;
       exception when no_data_found then
          null;
       end;
   end if;

   IF (nbs_ in ('1819','2900','2901','2902','2903','2905','2909','3579') or
       substr(nbs_, 4, 1) in ('7', '9') and nd_ is null) and
      (s180_ is NULL OR s180_='0') 
   THEN
      s180_:='1';
   END IF;

   IF nbs_ IN ('1600','1607','2600','2605','2607','2620','2625','2627',
               '2650','2655','2657') THEN
      s180_:='1';
   END IF;

   comm_ := comm_ || ' s180p='||s180_ ||comm_add_;

-- проверка на наличие счета в БПК и корректировка S180 
      if    nbs_ ='2202' and s180_>='C'
         or nbs_ ='2203' and s180_<'C'  then

         select count(*)   into is_bpk
           from w4_acc
          where acc_ in (acc_ovr,acc_2207,acc_2208,acc_2209);

         if  is_bpk =1  then
                   BEGIN
                      select s.value, p.grp_code 
                      into s180_, product_  
                      from w4_sparam s, w4_product p, w4_acc a, w4_card c
                      where s.grp_code = p.grp_code
                        and s.sp_id = 4 
                        and s.nbs = nbs_
                        and acc_ in (a.acc_ovr,a.acc_2207,a.acc_2208,a.acc_2209)
                        and a.card_code = c.code 
                        and c.product_code = p.code
                        and rownum = 1;
  
                        comm_ := comm_ || ' заміна S180 на ' || s180_ || ' продукт ' || product_;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      null;
                   END;
         end if;
      end if;

   BEGIN
      SELECT NVL(s183,'0')
      INTO S183_
      FROM kl_s180
      WHERE s180=s180_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      s183_:='0';
   END ;

   if nbs_ in ('6014', '6015') then
      s183_ := 'B';
   elsif nbs_ in ('6016','6020','6021','6050') then
      s183_ := '1';
   end if;

   s031_2:=f_get_s031(acc_, dat_, s031_1, nd_);
   s032_:=f_get_s032(acc_, dat_, s031_2, nd_);

   comm_ := substr(comm_ || ' s031spec='||s031_1||' s031nd='||s031_2||' s032='||s032_, 1, 200);

   IF re_=0 THEN
      if dat_ >= dat_Izm6 
      then   
         if codcagent_ = 2 then
            k072_ := 'N3';
         elsif codcagent_ = 4 then
            k072_ := 'N7';
         elsif codcagent_ = 6 and k051_ = '91' then
            k072_ := 'N7';
         elsif codcagent_ = 6 and k051_ <> '91' then
            k072_ := 'N8';
         else 
            null;
         end if;
      end if;
      k051_:='00';
      k111_:='00';
   END IF;

   IF SUBSTR(nbs_,1,3) IN ('260','261','206','207','208') AND
      k051_ IN ('34','91') AND k072_<>'41' THEN
      k072_:='41';
   END IF;

   IF re_<>0 AND SUBSTR(nbs_,1,3) IN ('260','261','206','207','208') AND
      k051_ IN ('34','91') AND k111_='65' AND k072_<>'2K' THEN
      k072_:='2K';
   END IF;

   IF re_<>0 AND SUBSTR(nbs_,1,3) IN ('260','261','206','207','208') AND
      k051_ IN ('34','91') AND k111_='66' AND k072_<>'2E' THEN
      k072_:='2E';
   END IF;

   IF re_<>0 AND SUBSTR(nbs_,1,3) IN ('260','261','206','207','208') AND
      k051_ IN ('34','91') AND k111_='67' AND k072_<>'2E' THEN
      k072_:='2E';
   END IF;

   IF SUBSTR(nbs_,1,3) IN ('220','221','222','223','262','263') AND
      k051_ IN ('34','91') AND k072_<>'42' THEN
      k072_:='42';
      k051_:='00';
      k111_:='00';
   END IF;

   IF re_ <> 0 and codcagent_ = 5 and nbs_ = '9129' and k072_= '00' 
   THEN
      k072_:='42';
      k051_:='00';
      k111_:='00';
   END IF;

   if nbs_ = '2062' then 
      nbs_ := '2063';
   elsif nbs_ = '2202' then
      nbs_ := '2203';
   else
      null;
   end if;
   if nbs_ = '2063' and r011_ = '0'
   then
      r011_ := '3';
   end if;
   if nbs_ in ('2203', '2206', '2208') 
   then
      r011_ := '1';
   end if;

   dk_:=Iif_N(se_,0,'1','2','2');

   comm_ := substr(comm_ || ' s183='||s183_, 1, 200);

   if dat_ > dat_izm3 and p_type_ in (4, 5) then
      r011_ := '0';
   end if;

   if k072_ in ('N1','N2','N3','N4','N5','N6','N7','N8','21','22','23',
                '30','31','32','41','42','43','51','5Y','1X','2X')
               --('0','5','6','7','H','I','J','K','N','R','Z','Y')
   then
      k140_ := '9';
   end if;

   --- c 30.06.2017 вместо кода '9'(K081) будет формироваться доп.параметр K140
   if Dat_ >= dat_Izm5 then
      kodp_:= dk_ || nbs_ || r011_ || k111_ || k072_ || k140_ ||
              s183_ || TO_CHAR(2-re_) || k051_ || s032_ ||
              LPAD(kv_,3,'0') || LPAD(country_, 3, '0') || s080_ || nvl(trim(s260_),'00');
   else 
      --- c 31.08.2007 вместо кода K081 будет формироваться код '9'
      if Dat_ >= to_date('30012009','ddmmyyyy') then
         kodp_:= dk_ || nbs_ || r011_ || k111_ || k072_ || '9' ||
                 s183_ || TO_CHAR(2-re_) || k051_ || s032_ ||
                 LPAD(kv_,3,'0') || LPAD(country_, 3, '0') || s080_ || nvl(trim(s260_),'00');
      else
         if dat_ >= to_date('28082007','ddmmyyyy') then
            kodp_:= dk_ || nbs_ || r011_ || k111_ || k072_ || '9' || s183_ ||
                   TO_CHAR(2-re_) || k051_ || s032_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
         else
            kodp_:= dk_ || nbs_ || r011_ || k111_ || k072_ || k081_ || s183_ ||
                 TO_CHAR(2-re_) || k051_ || s032_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
         end if;
      end if;
   end if;

   select count(*)
      into kol_
   from kod_d5_1
   where r020=nbs_;

   if kol_ = 0 then
      spcnt_ := 0;
   end if;

   if dat_ >= dat_izm2 and dat_ <= dat_izm3 then
      kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
   elsif dat_ > dat_izm3 then
      kodp_ :=  kodp_ || (case when p_type_ = 1 then '2' -- звичайні залишки
                               when p_type_ in (2, 3) then '3' -- середні залишки та розрахована % ставка
                               when p_type_ in (4, 5) then '4' -- визнані процентні доходи та амортизація
                               else ''
                          end);
   end if;

   kodp1_ := kodp_;

   if Dat_ >= dat_izm1 then
      kodp1_ := '1' || kodp_;

      if Dat_ > dat_izm3 then
         if p_type_ in (4, 5) then -- визнані процентні доходи
            kodp1_ := '16' || substr(kodp1_, 3);

         elsif p_type_ = 2 then -- розрахована % ставка
            kodp1_ := '21' || substr(kodp1_, 3);
         end if;

         if p_type_ = 5 or p_type_ = 3 and substr(nbs_,4,1) = '6' then
            acc_ := accr_;
         end if;
      end if;
   end if;

   if dat_ >= dat_izm4 
   then
      kodp1_ := kodp1_ || NVL(trim(s190_), '1');
   end if;

   IF nbs_ in ('2607', '2627', '2657')
   THEN
      acc_r_ := acc_2607_;
   else 
      acc_r_ := acc_;
   end if;

   znap_:= TO_CHAR(ABS(se_)) ;

   INSERT INTO rnbu_trace
      (nls, kv, odate, kodp, znap, nbuc, isp, rnk, acc, comm, nd)
   VALUES
      (nls_, kv_, data_, kodp1_, znap_,nbuc_,isp_,rnk_, acc_r_, comm_, nd_);

   if Dat_ >= dat_izm1 and Dat_ <= dat_izm3 then
      if kol_ > 0  then
         kodp1_ := '2' || kodp_;
         znap_ := LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_));

         INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, isp, rnk, acc, comm, nd)
         VALUES
            (nls_, kv_, data_, kodp1_, znap_,nbuc_,isp_,rnk_, acc_r_, comm_, nd_);

         kodp1_ := '3' || kodp_;
         znap_ := TO_CHAR (ABS(se_)*ROUND(spcnt_,4));
         
         INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, isp, rnk, acc, comm, nd)
         VALUES
            (nls_, kv_, data_, kodp1_, znap_, nbuc_, isp_, rnk_, acc_r_, comm_, nd_);

         kodp1_ := '4' || kodp_;

         if spcnt_ = 0 then
            znap_ := '0';
         else
            znap_ := TO_CHAR (ABS(se_));
         end if;
         
         INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc, isp, rnk, acc, comm, nd)
         VALUES
            (nls_, kv_, data_, kodp1_, znap_, nbuc_, isp_, rnk_, acc_r_, comm_, nd_);
      end if;
   end if;
END;
-------------------------------------------------------------------
BEGIN
    commit;

    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    -------------------------------------------------------------------
    logger.info ('P_FD5_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
    -------------------------------------------------------------------
    userid_ := user_id;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FD5_PROC';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FD5_DOCS';
    -------------------------------------------------------------------
    -- определение кода МФО или кода области для выбранного файла и схемы
    P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

    mfo_:=F_Ourmfo();

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
    
    -- вираховуємо зв_тну дату "станом на" для класиф_катора
    dat_kl_ := add_months(trunc(dat_, 'mm'), 1);

    -- вираховуємо дату на яку розраховано резерв
    Dat23_ := TRUNC(add_months(Dat_,1),'MM');

    -- вместо классификатора KL_R020 будем использовать KOD_R020
    if prnk_ is null then
        sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''D5'' and r020 not like ''6%'' ';
        sql_acc_ := sql_acc_ || 'and d_open<=to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'') ';
        sql_acc_ := sql_acc_ || 'and (d_close is null or d_close>to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'')) ';

        ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_);
    else
        sql_acc_ := 'select * from accounts where rnk = '||to_char(prnk_)||' and nbs in ';
        sql_acc_ := sql_acc_ || '(select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''D5'' and r020 not like ''6%'' ';
        sql_acc_ := sql_acc_ || 'and d_open<=to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'') ';
        sql_acc_ := sql_acc_ || 'and (d_close is null or d_close>to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy''))) ';

        ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);
    end if;

    -- дата начала периода вых. дней, которые предшествовали рабочей дате
    datp_ := Calc_Pdat (dat_);

    -- код пользователя, данные по расчету резерву которого использовались
    -- при формировании фонда
    -- если фонд не формировался = код текущего пользователя
    BEGIN
       SELECT userid
         INTO rezid_
       FROM rez_protocol
       WHERE dat = dat_ and
           ref in (SELECT max(ref)
                    FROM rez_protocol
                   WHERE dat = dat_);
    EXCEPTION WHEN NO_DATA_FOUND THEN
       null;
    END;

    for k in (select kv, count(*) co
              from otcn_saldo
              where nbs like '2401%'
               and NVL(Ost,0) - NVL(dos96,0) + NVL(kos96,0) <> 0
              group by kv )
    loop
       table_otcn_log3_(k.kv):=k.co;
    end loop;

    logger.info ('P_FD5_NN: etap 1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    ----------------------------------------------------------------------------
    -- все счета + корректирующие проводки и по счетам после отчетной даты
    OPEN SALDO ;
    LOOP
       FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                        Dos96_, Kos96_, Dosq96_, Kosq96_, isp_, accr_, tips_;
       EXIT WHEN SALDO%NOTFOUND;

       select nvl(max(acc_type), 'ZZZ')
       into acc_type_
       from nbur_lnk_type_r020
       where acc_r020 = nbs_ and
              start_date <= dat_ and
              nvl(finish_date, dat_ + 1) > dat_;

       if ( (nbs_ not in ('1590', '1592', '2400', '2401', '3690', '3692') and
             acc_type_ not like 'RZ%') OR 
            (acc_type_ like 'RZ%' and tips_ = 'SNA')
          )
       then

           IF kv_ <> 980 THEN
              se_:=Ostq_-Dosq96_+Kosq96_;
           ELSE
              se_:=Ostn_-Dos96_+Kos96_;
           END IF;

           IF se_<>0 THEN
              p_obrab_data(1);
           END IF;
       end if;
    END LOOP;
    CLOSE SALDO;

    logger.info ('P_FD5_NN: etap 2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    ------------------------------------------------------------------------------
    -- формирование показателей для счетов резерва 1590, 2400, 2401, 3690, 3692
    if dat_ >= dat_izm1 then
       -- проверяем выполнялся или нет расчет резерва
       select count(*)
          into kol_
       from tmp_rez_risk
       where dat=Dat_
         and id=rezid_;

       kol_ := 9; -- добавил 15.01.2013 чтобы формировать только по VIEW V_TMP_REZ_RISK (NBU23_REZ)

       if kol_ = 0 then
          -- только счета резерва + корректирующие проводки по счетам после отчетной даты
          OPEN SALDO ;
             LOOP
                FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                                 Dos96_, Kos96_, Dosq96_, Kosq96_, isp_, accr_, tips_;
                EXIT WHEN SALDO%NOTFOUND;

                select nvl(max(acc_type), 'ZZZ')
                into acc_type_
                from nbur_lnk_type_r020
                where acc_r020 = nbs_ and
                      start_date <= dat_ and
                      nvl(finish_date, dat_ + 1) > dat_;

                if nbs_ in ('1590', '1592', '2400', '2401', '3690')
                   or acc_type_ like 'RZ%'
                then
                   IF kv_ <> 980 THEN
                      se_:=Ostq_-Dosq96_+Kosq96_;
                   ELSE
                      se_:=Ostn_-Dos96_+Kos96_;
                   END IF;

                   IF se_<>0 THEN
                      p_obrab_data(1);
                   END IF;

                end if;

             END LOOP;
          CLOSE SALDO;
       else
          for k in (select /*+ leading(r) */
                           t.nls, t.kv, t.dat, t.szq, t.sz, gl.p_icurval(t.kv, t.sz, dat_) sz1,
                           t.s080, t.rnk, t.nd nd, t.tobo,
                           r.acc, r.odate, r.kodp, r.comm, r.nd ndr, t.id, nvl(s.r013, '0') r013,
                           substr(r.kodp,7,1) r011
                    from v_tmp_rez_risk t, rnbu_trace r, specparam s, agg_monbals m 
                    where t.dat=Dat23_
                      and t.acc = r.acc
                      and not ( substr(r.kodp,3,4) like '15_9' or 
                                substr(r.kodp,3,4) like '2__9' or
                                substr(r.kodp,3,4) like '369_' 
                              ) 
                      and substr(r.kodp,3,4) not in ('2607', '2627', '2657')
                      and r.kodp like '1%' || (case when dat_ > dat_izm3 then '2' else '' end) || (case when dat_ >= dat_izm4 then '_' else '' end)
                      and t.acc = s.acc(+)
                      and t.acc = m.acc 
                      and m.fdat = dats_
                      and m.ost - m.crdos + m.crkos <> 0                            
                            union all
                     select /*+ leading(r) */
                            t.nls, t.kv, t.dat, t.szq, t.sz, gl.p_icurval(t.kv, t.sz, dat_) sz1,
                            t.s080, t.rnk, t.nd nd, t.tobo,
                           r.acc, r.odate, r.kodp, r.comm, r.nd ndr, t.id, nvl(s.r013, '0') r013,
                           substr(r.kodp,7,1) r011  
                    from v_tmp_rez_risk t, rnbu_trace r, specparam s
                    where t.dat=Dat23_
                      and substr(r.kodp,3,4) in ('2607', '2627', '2657')
                      and t.nbs = substr(r.kodp,3,4) 
                      and t.acc = r.acc 
                      and r.kodp like '1%' || (case when dat_ > dat_izm3 then '2' else '' end) || (case when dat_ >= dat_izm4 then '_' else '' end)
                      and t.acc = s.acc(+)
                   )
          loop
             se_ := NVL(k.sz1, k.szq);
             dk_ := '2';
             r011_ := k.r011;
             k111_ := substr(k.kodp,8,2);
             k072_ := substr(k.kodp,10,2);
             k140_ := substr(k.kodp,12,1);
             s183_ := substr(k.kodp,13,1);
             re_ :=   substr(k.kodp,14,1);
             k051_ := substr(k.kodp,15,2);
             s032_ := substr(k.kodp,17,1);
             country_ := substr(k.kodp,21,3);
             s080_ := substr(k.kodp,24,1);
             s260_ := substr(k.kodp,25,2);
             s190_ := substr(k.kodp,28,1);
             comm_ := substr('Резерв по рахунку s080 = ' || s080_ || '  ' || k.comm,1,200);
             nd_ := k.nd;
             rnk_ := k.rnk;
             acc_ := k.acc;
             nls_ := k.nls;
             kv_ := k.kv;
             data_ := k.odate;

             IF typ_ > 0 THEN
                nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
             ELSE
                nbuc_ := nbuc1_;
             END IF;

             nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id);

             nbs_ := substr(nbs_r013_, 1, 4);

             if nbs_ like '159%' OR nbs_ like '240%'
             then
                nbs_ := substr(k.kodp,3,3) || '9';
             end if;

             if substr(k.kodp,3,3) in ('260', '262', '265')
             then
                r011_ := '0';
             end if;

             -- обработка счетов резерва
             if se_ <> 0 and nbs_ not in ('3590') 
             then
                -- c 30.06.2017 вместо кода '9'(K081) будет формироваться доп.параметр K140
                if Dat_ >= dat_Izm5
                then
                   kodp_:= '1' || dk_ || nbs_ || r011_ || k111_ || k072_ || k140_ ||
                           s183_ || re_ || k051_ || s032_ ||
                           LPAD(kv_,3,'0') || LPAD(country_, 3, '0')  || s080_ || s260_ ;

                else
                   kodp_:= '1' || dk_ || nbs_ || r011_ || k111_ || k072_ || '9' ||
                           s183_ || re_ || k051_ || s032_ ||
                           LPAD(kv_,3,'0') || LPAD(country_, 3, '0')  || s080_ || s260_ ;
                end if;

                if dat_ >= dat_izm1 and dat_ <= dat_izm3 then
                   kodp_:= kodp_ || '0';
                end if;

                if dat_ > dat_izm3 then
                   kodp_:= kodp_ || '2';
                end if;

                if dat_ >= dat_izm4 
                then
                   kodp_ := kodp_ || NVL(trim(s190_), '1');
                end if;

                znap_ := to_char(ABS(se_));

                INSERT INTO rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, isp, rnk, acc, comm, nd)
                VALUES
                   (nls_, kv_, data_, kodp_, znap_, nbuc_, isp_, rnk_, acc_, comm_, nd_);
             end if;
          end loop;
          
          -- блок для формирования разницы остатков по счетам 1590,1592,2400,2401,3590,3690
          for k in (select a.nbs, a.kv, 2-MOD(c.codcagent ,2) REZ,
                           'Q' S080,   
                           '2' r013, 
                           sum(a.Ost) Ostn, sum(a.Ostq) Ostq,
                           sum(a.Dos96) dos96, sum(a.Kos96) Kos96,
                           sum(a.Dosq96) Dosq96, sum(a.Kosq96) kosq96
                    from otcn_saldo a, customer c, specparam s
                    where (a.nbs in ('1590', '1592', '3690') or 
                           a.nbs like '15_9' or a.nbs like '2__9') 
                      and a.rnk = c.rnk
                      and a.acc = s.acc(+)
                      and (a.Ost-a.Dos96+a.Kos96 <> 0  or a.Ostq-a.Dosq96+a.Kosq96<>0)
                    group by a.nbs, a.kv, 2-MOD(c.codcagent ,2),
                             'Q',  
                             '2'  
                    order by 1,2)
          loop
             IF k.kv <> 980 THEN
                se_:=k.Ostq - k.Dosq96 + k.Kosq96;
             ELSE
                se_:=k.Ostn - k.Dos96 + k.Kos96;
             END IF;

             select NVL(sum(to_number(r.znap)),0)
                into sn_
             from rnbu_trace r
             where r.kodp like '1_' || k.nbs || '_______' || k.rez || '___' || k.kv || '___'|| '_' || '__2_'
               --and r.nls not like '9129%'
               and r.nls not like '351%'
               and r.nls not like '354%'
               and r.nls not like '355%';

             -- формируем разницу остатков
             if se_ <> sn_ and ABS(se_ - sn_) <= 100 then
                znap_ := to_char(se_ - sn_);
                comm_ := 'Рiзниця залишкiв по бал.рах. ' || k.nbs || ' валюта = ' ||
                         lpad(to_char(k.kv),3,'0') || ' кат. ризику = ' || k.s080 ||
                         ' резидентність = ' || to_char(k.rez) ||
                         ' залишок по балансу = ' ||to_char(ABS(se_)) ||
                         ' сума в файлi =  ' || to_char(sn_);
          
                BEGIN
                   select r.recid
                      INTO recid_
                   from rnbu_trace r
                   where r.kodp like '12'||k.nbs||decode(k.nbs, '1590', '1', '0')||
                                            '______'||k.rez||'___'||k.kv||'___'||'_'|| '__2_'
                     and rownum=1;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   recid_ := null;
                   kodp_:= '1' || '2' || k.nbs || '0' || '00' || '42' || '9' ||
                           'B' || k.rez || '00' || '9' ||
                           LPAD(k.kv,3,'0') || '804' || 'A' || '08';
          
                   if dat_ >= dat_izm1 and dat_ <= dat_izm3 then
                      kodp_:= kodp_ || '0';
                   end if;

                   if dat_ > dat_izm3 then
                      kodp_:= kodp_ || '2';
                   end if;

                   if dat_ > dat_izm4 then
                      kodp_:= kodp_ || '1';
                   end if;
        
                   nbuc_ := nbuc1_;
                END;

                if recid_ is not null then
                   select kodp, nbuc
                   into kodp_, nbuc_
                   from rnbu_trace
                   where recid = recid_;
                end if;

                INSERT INTO rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, comm)
                VALUES
                   (k.nbs||' (R013='||k.r013||')', k.kv, dat_, kodp_, znap_, nbuc_, comm_);
             end if;
          end loop;
       end if;
    end if;

    logger.info ('P_FD5_NN: etap 3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    if dat_ > dat_izm3 then
       declare
           datp_       date;
           datr1_      date;
           datr2_      date;
           dat_kor_    date;

           dob_        number;
           dobp_       number;

           acca_       number;
           nlsa_       varchar2(15);
           sumh_       number;
           sumh_all_   number;
           sump_       number;
           zal_dob_    number;

           fl_kr_      number := 0;
           fl_         number := 0;
           fl_pob_     number := 0;
           pr_year_    number := 0;
       begin
           dat1_ := trunc(dat_, 'mm');
           dat2_ := last_day(dat_);

           kol_ := dat2_ - dat1_ + 1;

           if MOD (TO_NUMBER (TO_CHAR (dat_, 'YYYY')), 4) = 0 then
              b_yea := 366; -- для високосних років
           else
              b_yea := 365;
           end if;

           -- дата закінчення періоду коригуючих проводок
           dat_kor_ := dat2_ + 7;

           select max(fdat)
           into datp_
           from fdat
           where fdat < dat1_;

           select min(fdat), max(fdat)
           into datr1_, datr2_
           from fdat
           where fdat between dat1_ and dat2_;

           -- визнані процентні доходи по нарахуванню відсотків та середні залишик по кредитах
           insert into OTCN_FD5_PROC (ACC, NLS, KV, RNK, ISP, ACCC, TIP, DOS,
                IACC, ND, SUMH, CNT, RNUM, SH)
           select z.acc, z.nls, z.kv, z.rnk, z.isp, z.acc, z.tip, z.dos,
                nvl(z.iacc, z.ACC_OVR) iacc, decode(z.iacc, null, z.ond, z.nd) nd,
                decode(z.iacc, null, z.sumh2, z.sumh1) sumh,
                count(z.acc) over (partition by z.acc) cnt,
                DENSE_RANK() over (partition by z.acc order by z.iacc, z.acc_ovr) rnum,
                sum(decode(z.iacc, null, z.sumh2, z.sumh1)) over (partition by z.acc) sh
           from (
                 select a.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, a.dos,
                    i.acc iacc, b.ACC_OVR, b.nd ond, n.nd, null kodp,
                    decode(i.acc, null, 0, ot_sumh (i.acc, datr1_, datr2_, -1, dat_, a.kv)) sumh1,
                    decode(b.ACC_OVR, null, 0, ot_sumh (b.ACC_OVR, datr1_, datr2_, -1, dat_, a.kv)) sumh2
                 from
                   (select s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, sum(s.dos) dos
                    from accounts a, saldoa s
                    where s.acc= a.acc and
                    s.fdat between datr1_ and dat_kor_ and
                    s.dos <> 0 and
                    a.nbs in ('1528','1607','2018', '2028', '2038', '2068', '2078', '2088', '2607', '2657',
                              '2108', '2118', '2128', '2138', '2208', '2218', '2228', '2238', '2627') and
                    trim(a.tip) in ('SN', 'ODB') and
                    (prnk_ is null or a.rnk = prnk_)
                    group by s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip) a
                    left outer join int_accn i
                    on (a.acc = i.acra and
                        i.id = 0 and
                        i.acc <> i.acra and 
                        not exists (select 1 from accounts where acc= i.acc and dazs is not null))
                    left outer join (select acc_2208, acc_ovr, nd
                                     from bpk_acc
                                     where acc_2208 is not null and acc_ovr is not null
                                        union
                                     select acc_2208, acc_2207 acc_ovr, nd
                                     from bpk_acc
                                     where acc_2208 is not null and acc_2207 is not null) b
                    on (a.acc = b.ACC_2208)
                    left outer join (select acc, max(nd) nd from nd_acc group by acc) n
                    on (a.acc = n.acc)
                 where (i.acc is not null or b.ACC_OVR is not null) and
                       not (i.acc is not null and b.ACC_OVR is not null)) z
           where sumh1 + sumh2 <> 0;

           -- визнані процентні доходи по нарахуванню прострочених відсотків та середні залишик по кредитах
           insert into OTCN_FD5_PROC (ACC, NLS, KV, RNK, ISP, ACCC, TIP, DOS,
                IACC, ND, SUMH, CNT, RNUM, SH)
           select z.acc, z.nls, z.kv, z.rnk, z.isp, z.acc, z.tip, z.dos,
                nvl(z.iacc, z.ACC_OVR) iacc, decode(z.iacc, null, z.ond, z.nd) nd,
                decode(z.iacc, null, z.sumh2, z.sumh1) sumh,
                count(z.acc) over (partition by z.acc) cnt,
                DENSE_RANK() over (partition by z.acc order by z.iacc, z.acc_ovr) rnum,
                sum(decode(z.iacc, null, z.sumh2, z.sumh1)) over (partition by z.acc) sh
           from (
                 select a.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, a.dos,
                    i.acc iacc, b.ACC_OVR, b.nd ond, n.nd, null kodp,
                    decode(i.acc, null, 0, ot_sumh (i.acc, datr1_, datr2_, -1, dat_, a.kv)) sumh1,
                    decode(b.ACC_OVR, null, 0, ot_sumh (b.ACC_OVR, datr1_, datr2_, -1, dat_, a.kv)) sumh2
                 from
                   (select s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, sum(s.dos) dos
                    from accounts a, saldoa s
                    where s.acc= a.acc and
                    s.fdat between datr1_ and dat_kor_ and
                    s.dos <> 0 and
                    a.nbs in ('1508', '1518', '1528', '2028', '2038', '2068', '2078', '2088',
                              '2108', '2118', '2128', '2138', '2208', '2218', '2228', '2238') and
                    trim(a.tip) = 'SPN' and
                    (prnk_ is null or a.rnk = prnk_)
                    group by s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip) a
                    left outer join int_accn i
                    on (a.acc = i.acra and
                        i.id = 0 and
                        i.acc <> i.acra and 
                        not exists (select 1 from accounts where acc= i.acc and dazs is not null))
                    left outer join (select acc_2209, acc_ovr, nd
                                     from bpk_acc
                                     where acc_2209 is not null and acc_ovr is not null
                                        union
                                     select acc_2209, acc_2207 acc_ovr, nd
                                     from bpk_acc
                                     where acc_2209 is not null and acc_2209 is not null) b
                    on (a.acc = b.ACC_2209)
                    left outer join (select acc, max(nd) nd from nd_acc group by acc) n
                    on (a.acc = n.acc)
                 where (i.acc is not null or b.ACC_OVR is not null) and
                       not (i.acc is not null and b.ACC_OVR is not null)) z
           where sumh1 + sumh2 <> 0;
           
           -- середні залишки по преміях (буде CNT = 0)
           insert into OTCN_FD5_PROC (ACC, iacc, NLS, KV, RNK, ISP, ACCC, TIP, DOS,
                ND, SUMH, CNT)
           select *
           from (
                 select a.acc, a.acc iacc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, a.dos, n.nd,
                    ot_sumh (a.acc, datr1_, datr2_, -1, dat_, a.kv) sumh, 0 cnt
                 from
                   (select s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, sum(s.dos) dos
                    from accounts a, saldoa s
                    where s.acc= a.acc and
                    s.fdat between datr1_ and dat_kor_ and
                    s.dos <> 0 and
                    a.nbs in ('1525','2065','2075','2085','2105','2115','2125','2135','2205','2215','2235') and
                    (prnk_ is null or a.rnk = prnk_)
                    group by s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip) a
                    left outer join (select acc, max(nd) nd from nd_acc group by acc) n
                    on (a.acc = n.acc)) z
           where sumh <> 0;

           -- середні залишки по дисконтах (буде CNT = 0)
           insert into OTCN_FD5_PROC (ACC, iacc, NLS, KV, RNK, ISP, ACCC, TIP, DOS,
                ND, SUMH, CNT)
           select *
           from (
                 select a.acc, a.acc iacc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, a.dos, n.nd,
                    ot_sumh (a.acc, datr1_, datr2_, 1, dat_, a.kv) sumh, 0 cnt
                 from
                   (select s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, sum(s.dos) dos
                    from accounts a, saldoa s
                    where s.acc= a.acc and
                    s.fdat between datr1_ and dat_kor_ and
                    s.dos <> 0 and
                    a.nbs in ('1526', '2016','2026','2036','2066','2076','2086','2106','2116','2126',
                        '2136','2206','2216','2226','2236','3600') and
                    (prnk_ is null or a.rnk = prnk_)
                    group by s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip
                    ---------
                      union
                    ---------
                    select s.acc, s.nls, s.kv, s.rnk, a.isp, a.accc, a.tip, 0 dos
                    from otcn_saldo s, otcn_acc a
                    where s.nbs in ('1526','2016','2026','2036','2066',
                                    '2076','2086','2106','2116','2126',
                                    '2136','2206','2216','2226','2236','3600') and
                    (prnk_ is null or s.rnk = prnk_) and
                    s.acc = a.acc and 
                    NVL(s.Ost,0) - NVL(s.dos96,0) + NVL(s.kos96,0) <> 0 and
                    not exists (select 1
                                from saldoa p
                                where p.fdat between datr1_ and dat_kor_ and
                                      p.acc = s.acc and
                                      p.dos <> 0)
                    ---------
                      union
                    ---------
                    select s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, 0 dos
                    from accounts a, saldoa s
                    where s.acc= a.acc and
                    s.fdat between datr1_ and dat_kor_ and
                    a.nbs in ('1526', '2016','2026','2036','2066','2076','2086','2106','2116','2126',
                        '2136','2206','2216','2226','2236','3600') and
                    (prnk_ is null or a.rnk = prnk_) and
                    exists (select 1
                            from otcn_saldo p
                            where p.acc = a.acc and
                                  p.ost = 0)
                    group by s.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip
                    having sum(s.dos)=0 and sum(s.kos)<>0
                    ) a
                    left outer join (select acc, max(nd) nd from nd_acc group by acc) n
                    on (a.acc = n.acc)) z
           where sumh <> 0;

            update OTCN_FD5_PROC p
            set iacc = nvl((select max(acc) from int_accn i where i.acra = p.acc and i.id=2), iacc)
            where nls like '3600%' and
                 nd is null and
                 acc = iacc;

            update OTCN_FD5_PROC p
            set nd = (select max(a.nd) from acc_over a where a.acco = iacc and NVL (a.sos, 0) <> 1)
            where substr(nls, 1, 4) in ('2607', '3600') and
                 nd is null and
                 acc <> iacc;

           insert into OTCN_FD5_DOCS (ACC, NBS, REF, FDAT, S, NAZN)
           select /*+ ordered */
                o.acc, decode(r.dk, 1, substr(r.nlsb,1,4), substr(r.nlsa,1,4)) nbs, 
                o.REF, o.fdat, o.s, r.NAZN
           from saldoa s, opldok o, opldok p, accounts a, oper r
           where s.fdat between datr1_ and dat_kor_ and
               s.acc in (select acc from OTCN_FD5_PROC where kv = 980) and
               s.dos > 0 AND
               s.fdat = o.fdat and
               s.acc = o.acc and
               o.dk = 0 and
               o.ref = p.ref and
               o.stmt = p.stmt and
               p.dk = 1 and
               p.acc = a.acc and
               (a.nbs in ('6013', '6014', '6015', '6016', '6017', '6018', '8029')
                or a.nbs like '602%'
                or a.nbs like '603%'
                or a.nbs like '604%'
                or a.nbs like '605%'
                or a.nbs like '606%'
                or a.nbs like '607%'
                or a.nbs like '608%'
                or a.nbs like '609%'
                or a.nbs like '610%'
                or a.nbs like '611%') and
               o.tt not in ('BAK', '515') and
               o.ref = r.ref and
               r.sos = 5 and
               (r.vob <> 96 and o.fdat <= dat2_ or
                r.vob = 96 and  o.fdat > dat2_) and
                lower(r.nazn) not like '%штраф%' and
                lower(r.nazn) not like '%плата%прост%';

           insert into OTCN_FD5_DOCS (ACC, NBS, REF, FDAT, S, NAZN)
           select /*+ ordered */
                o.acc, decode(r.dk, 1, substr(r.nlsb,1,4), substr(r.nlsa,1,4)) nbs, o.REF, o.fdat,
                r.s2, r.NAZN
           from saldoa s, opldok o, opldok p, accounts a, oper r
           where s.fdat between datr1_ and dat_kor_ and
               s.acc in (select acc from OTCN_FD5_PROC where kv <> 980) and
               s.dos > 0 AND
               s.fdat = o.fdat and
               s.acc = o.acc and
               o.dk = 0 and
               o.ref = p.ref and
               o.stmt = p.stmt and
               p.dk = 1 and
               p.acc = a.acc and
               a.nbs = '3800' and
               o.tt not in ('BAK', '515') and
               o.ref = r.ref and
               r.sos = 5 and
               (r.vob <> 96 and o.fdat <= dat2_ or
                r.vob = 96 and  o.fdat > dat2_) and
               lower(r.nazn) not like '%штраф%' and
               lower(r.nazn) not like '%плата%прост%' and
               exists (select 1
                       from opldok o1, opldok p1, accounts a1
                       where o1.ref = o.ref and
                            o1.ref = p1.ref and
                            p1.acc = a1.acc and
                            p1.dk = 1 and
                           (a1.nbs in ('6013', '6014', '6015', '6016', '6017', '6018', '8029')
                            or a1.nbs like '602%'
                            or a1.nbs like '603%'
                            or a1.nbs like '604%'
                            or a1.nbs like '605%'
                            or a1.nbs like '606%'
                            or a1.nbs like '607%'
                            or a1.nbs like '608%'
                            or a1.nbs like '609%'
                            or a1.nbs like '610%'
                            or a1.nbs like '611%'));

           -- вибираємо рахунки, де один процентний рахунок відповідає рахунку активу
           for k in (select 
                        b.ACC, b.NLS, b.KV, b.RNK, b.ISP, b.ACCC, b.TIP, b.DOS, b.IACC, b.ND, b.SUMH,                        
                        a.acc acca, a.nls nlsa, a.kv kva, a.isp ispa, a.rnk rnka, a.tip tipa, a.accc accca,
                        r.nd nda, r.kodp kodpa, c.kodp, nvl(c.nbuc, r.nbuc) nbuc
                     from OTCN_FD5_PROC b, rnbu_trace c, accounts a, rnbu_trace r
                     where b.CNT = 1 and
                        b.acc = c.acc(+) and
                        b.iacc = a.acc and
                        a.nls not like '8%' and 
                        a.nls not like '9%' and
                        substr(a.nls,1,4) not in ('1607','2607', '2627', '2657') and
                        nvl(c.kodp(+), '__'||substr(b.nls,1,4)||'2') like '__'||substr(b.nls,1,4)||'%2' and
                        a.acc = r.acc(+) and
                        nvl(r.kodp(+), '__'||substr(a.nls,1,4)||'2') like '__'||substr(a.nls,1,4)||'%2')
           loop
              fl_ := 0;

              if k.nbuc is null then
                 IF typ_>0 THEN
                    nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
                 ELSE
                    nbuc_ := nbuc1_;
                 END IF;
              else
                 nbuc_ := k.nbuc;
              end if;

              for k1 in (select nbs, dob
                         from (
                             select nbs, nvl(sum(s), 0) dob
                             from OTCN_FD5_DOCS
                             where acc = k.acc
                             group by nbs
                            ))
              loop
                  if k1.dob <> 0 then
                     fl_ := 1;

                      if k.kodp is not null then
                         if k1.nbs in ('6013', '6014', '6015') then
                            s183_ := 'B';
                         elsif k1.nbs in ('6016','6020','6021','6050') then
                            s183_ := '1';
                         else
                            s183_ := substr(k.kodp, 12, 1);
                         end if;

                         kodp_ := '16'||k1.nbs||'0'||substr(k.kodp, 8, 4)||S183_||
                                substr(k.kodp, 13, 4)||'980'||substr(k.kodp, 20, 6)||'4';

                         if dat_ >= dat_izm4 
                         then
                            kodp_ := kodp_ || substr(k.kodp, 27, 1);
                         end if;

                         znap_ := to_char(k1.dob);

                         comm_ := 'Визнані процентні доходи ';

                         INSERT INTO rnbu_trace
                               (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                         VALUES
                               (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acca, k.rnk, k.isp, k.nd);
                      else
                         rnk_ := k.rnk;
                         acc_ := k.acca;
                         nbs_ := k1.nbs;
                         nls_ := k.nls;
                         kv_  := 980;
                         isp_ := k.isp;
                         accr_:= k.accc;
                         tips_:= k.tip;
                         se_ := k1.dob;

                         p_obrab_data(4);
                      end if;
                  end if;
              end loop;

              -- якщо є визнані проценті доходи, то формуємо середні залишки
              if fl_ = 1 then
                  if k.kodpa is not null then
                     kodp_ := substr(k.kodpa, 1, 25)||'3';
                     if dat_ >= dat_izm4 
                     then
                        kodp_ := kodp_ || substr(k.kodpa, 27, 1);
                     end if;
                     znap_ := to_char(abs(k.sumh));

                     comm_ := 'Середні залишки по основному боргу/простроченому основному боргу ';

                     INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                     VALUES
                           (k.nlsa, k.kva, dat_, kodp_, znap_, nbuc_, comm_, k.acca,
                            k.rnka, k.ispa, k.nda);
                  else
                     rnk_ := k.rnka;
                     acc_ := k.acca;
                     nbs_ := substr(k.nlsa, 1, 4);
                     nls_ := k.nlsa;
                     kv_  := k.kva;
                     isp_ := k.ispa;
                     accr_:= k.accca;
                     tips_:= k.tipa;
                     se_  := k.sumh;

                     p_obrab_data(3);
                  end if;
              end if;
           end loop;

           -- вибираємо рахунки, де одному процентному рахунку відповідає більше одного рахунку активу
           for k in (select z.*, s2 - (sum(s1) over (partition by z.acc))  zal_sum,
                        r.nd nda, r.kodp kodpa, c.kodp, nvl(c.nbuc, r.nbuc) nbuc
                    from (select 
                              p.ACC, p.NLS, p.KV, p.RNK, p.ISP, p.ACCC, p.TIP, p.DOS, p.IACC, p.ND,
                              p.SUMH, p.CNT, p.RNUM, p.SH,
                              a.acc acca, a.nls nlsa, a.kv kva, a.isp ispa, a.rnk rnka, a.tip tipa, a.accc accca,
                              (select nvl(sum(s),0) from OTCN_FD5_DOCS where acc = p.acc and instr(nazn, a.nls)>0) s1,
                              (select nvl(sum(s),0) from OTCN_FD5_DOCS where acc = p.acc) s2,
                              (select count(distinct nbs) from OTCN_FD5_DOCS where acc = p.acc) cnt_nbs,
                              (select max(nbs) from OTCN_FD5_DOCS where acc = p.acc) nbs
                          from OTCN_FD5_PROC p, accounts a
                          where p.cnt>1 and
                            p.iacc = a.acc and
                            a.nls not like '8%' and 
                            a.nls not like '9%' and
                            substr(a.nls,1,4) not in ('1607','2607', '2627', '2657','8026')
                         ) z, rnbu_trace c, rnbu_trace r
                     where z.s2 <> 0 and
                           z.acc = c.acc(+)  and
                           nvl(c.kodp(+), '__'||substr(z.nlsa,1,4)||'2') like '__'||substr(z.nlsa,1,4)||'%2' and
                           z.iacc = r.acc(+) and
                           substr(r.kodp(+),3,4) not in ('1607','2607', '2627', '2657') and
                           nvl(r.kodp(+), '__'||substr(z.nls,1,4)||'2') like '__'||substr(z.nls,1,4)||'%2')
           loop
              fl_ := 0;

              if k.s1 <> 0 then
                  fl_ := 1;

                  if k.nbuc is null then
                     IF typ_>0 THEN
                        nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
                     ELSE
                        nbuc_ := nbuc1_;
                     END IF;
                  else
                     nbuc_ := k.nbuc;
                  end if;

                  if k.kodp is not null then
                     if k.nbs in ('6013', '6014', '6015') then
                        s183_ := 'B';
                     elsif k.nbs in ('6016','6020','6021','6050') then
                        s183_ := '1';
                     else
                        s183_ := substr(k.kodp, 12, 1);
                     end if;

                     kodp_ := '16'||k.nbs||'0'||substr(k.kodp, 8, 4)||S183_||
                            substr(k.kodp, 13, 4)||'980'||substr(k.kodp, 20, 6)||'4';

                     if dat_ >= dat_izm4 
                     then
                        kodp_ := kodp_ || substr(k.kodp, 27, 1);
                     end if;
                     znap_ := to_char(k.s1);

                     comm_ := 'Визнані процентні доходи ';

                     INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                     VALUES
                           (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acca, k.rnk, k.isp, k.nd);
                  else
                     rnk_ := k.rnk;
                     acc_ := k.acca;
                     nbs_ := k.nbs;
                     nls_ := k.nls;
                     kv_  := 980;
                     isp_ := k.isp;
                     accr_:= k.accc;
                     tips_:= k.tip;
                     se_ := k.s1;

                     p_obrab_data(4);
                  end if;
              end if;

              if k.zal_sum <> 0 then
                 fl_ := 1;

                  if k.kodp is not null then
                     if k.nbs in ('6013', '6014', '6015') then
                        s183_ := 'B';
                     elsif k.nbs in ('6016','6020','6021','6050') then
                        s183_ := '1';
                     else
                        s183_ := substr(k.kodp, 12, 1);
                     end if;

                     kodp_ := '16'||k.nbs||'0'||substr(k.kodp, 8, 4)||S183_||
                            substr(k.kodp, 13, 4)||'980'||substr(k.kodp, 20, 6)||'4';
                     if dat_ >= dat_izm4 
                     then
                        kodp_ := kodp_ || substr(k.kodp, 27, 1);
                     end if;
                     znap_ := to_char(ROUND(k.zal_sum * (K.sumh / K.sh)));

                     comm_ := 'Визнані процентні доходи ';

                     INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                     VALUES
                           (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acca, k.rnk, k.isp, k.nd);
                  else
                     rnk_ := k.rnk;
                     acc_ := k.acca;
                     nbs_ := k.nbs;
                     nls_ := k.nls;
                     kv_  := 980;
                     isp_ := k.isp;
                     accr_:= k.accc;
                     tips_:= k.tip;
                     se_ := ROUND(k.zal_sum * (k.sumh / k.sh));

                     p_obrab_data(4);
                  end if;
              end if;

              -- якщо є визнані проценті доходи, то формуємо середні залишки
              if fl_ = 1 then
                  if k.kodpa is not null then
                     kodp_ := substr(k.kodpa, 1, 25)||'3';
                     if dat_ >= dat_izm4 
                     then
                        kodp_ := kodp_ || substr(k.kodpa, 27, 1);
                     end if;
                     znap_ := to_char(abs(k.sumh));

                     comm_ := 'Середні залишки по основному боргу/простроченому основному боргу ';

                     INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                     VALUES
                           (k.nlsa, k.kva, dat_, kodp_, znap_, nbuc_, comm_, k.acca,
                            k.rnka, k.ispa, k.nda);
                  else
                     rnk_ := k.rnka;
                     acc_ := k.acca;
                     nbs_ := substr(k.nlsa, 1, 4);
                     nls_ := k.nlsa;
                     kv_  := k.kva;
                     isp_ := k.ispa;
                     accr_:= k.accca;
                     tips_:= k.tipa;
                     se_  := k.sumh;

                     p_obrab_data(3);
                  end if;
              end if;
           end loop;

           -- додаємо середній залишок та обороти по рахунках дисконту та премії
           for k in (select z.*, sum(SUMHA) over (partition by z.acc) sumha_all,
                        count(z.iacc) over (partition by z.acc) cnt
                     from (select 
                            b.ACC, b.NLS, b.KV, b.RNK, b.ISP, b.ACCC, b.TIP, b.DOS, b.ND,
                            b.SUMH, c.nbuc,
                            c.kodp, d.IACC, d.SUMH SUMHA,
                            (select nvl(sum(s),0) from OTCN_FD5_DOCS where acc = b.acc) sumd,
                            (select max(nbs) from OTCN_FD5_DOCS where acc = b.acc) nbs
                         from OTCN_FD5_PROC b, accounts a, rnbu_trace c, OTCN_FD5_PROC d
                         where b.CNT = 0  and
                            b.acc = a.acc and
                            a.acc = c.acc(+) and
                            nvl(c.kodp(+), '__'||substr(a.nls,1,4)||'2') like '__'||substr(a.nls,1,4)||'%2' and
                            b.nd = d.nd and
                            d.cnt <> 0) z
                     )
           loop
               if k.nbuc is null then
                 IF typ_>0 THEN
                    nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
                 ELSE
                    nbuc_ := nbuc1_;
                 END IF;
              else
                 nbuc_ := k.nbuc;
              end if;

              if k.sumh <> 0 and k.sumha_all <> 0 then
                  se_  := round(k.sumh * (k.sumha / k.sumha_all));

                  if k.kodp is not null then
                     kodp_ := substr(k.kodp, 1, 25)||'3';
                     if dat_ >= dat_izm4 
                     then
                        kodp_ := kodp_ || substr(k.kodp, 27, 1);
                     end if;
                     znap_ := to_char(abs(se_));

                     comm_ := 'Середні залишки по дисконтах/преміях ';

                     INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                     VALUES
                           (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.iacc,
                            k.rnk, k.isp, k.nd);
                  else
                     rnk_ := k.rnk;
                     acc_ := k.acc;
                     nbs_ := substr(k.nls, 1, 4);
                     nls_ := k.nls;
                     kv_  := k.kv;
                     isp_ := k.isp;
                     accr_:= k.iacc;
                     tips_:= k.tip;

                     p_obrab_data(3);
                  end if;
              end if;

              if k.sumd <> 0 and k.sumha_all <> 0 then
                  se_  := round(k.sumd * (k.sumha / k.sumha_all));

                  if k.kodp is not null then
                     if k.nbs in ('6013', '6014', '6015') then
                        s183_ := 'B';
                     elsif k.nbs in ('6016','6020','6021','6050') then
                        s183_ := '1';
                     else
                        s183_ := substr(k.kodp, 12, 1);
                     end if;

                     kodp_ := '16'||k.nbs||'0'||substr(k.kodp, 8, 4)||S183_||
                            substr(k.kodp, 13, 4)||'980'||substr(k.kodp, 20, 6)||'4';
                     if dat_ >= dat_izm4 
                     then
                        kodp_ := kodp_ || substr(k.kodp, 27, 1);
                     end if;

                     znap_ := to_char(abs(se_));

                     comm_ := 'Амортизація дисконту ';

                     INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                     VALUES
                           (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.iacc,
                            k.rnk, k.isp, k.nd);
                  else
                     rnk_ := k.rnk;
                     acc_ := k.acc;
                     nbs_ := k.nbs;
                     nls_ := k.nls;
                     kv_  := 980;
                     isp_ := k.isp;
                     accr_:= k.iacc;
                     tips_:= k.tip;

                     p_obrab_data(5);
                  end if;
              end if;
           end loop;
       end;
    end if;

    logger.info ('P_FD5_NN: etap 4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    -- списання за рахунок резерву
    if dat_ >= dat_izm5 then

       begin
          dat1_ := trunc(dat_, 'mm'); -- дата начала месяца

          select max(fdat) -- отчетная дата предыдущего месяца
             into datfp_
          from fdat
          where fdat < dat1_ 
            and fdat NOT IN (SELECT holiday FROM holiday);

          for k in (select fdat, ref, acc, nls, kv, sq, nbs, acca,
                           sum(sq) over (partition by acc) sum_all
                    from (select /*+ ordered */
                                 o.fdat, o.ref, o.acc, a.nls, a.kv,
                                 decode(o.dk, 0, 1, -1) * gl.p_icurval(a.kv, o.s, dat_) sq,
                                 a.nbs, z.acc acca
                          from accounts a, opldok o, opldok z, accounts x, oper p
                          where o.fdat = any (select fdat from fdat where fdat between dat1_ and dat_) and
                            o.acc = a.acc and
                            (a.nls like '1590%' or
                             a.nls like '1592%' or
                             a.nls like '15_9%' or
                             a.nls like '2__9%' or
                             a.nls like '3690%' or 
                             a.nls like '3692%'
                            )
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
                            and p.vdat between dat1_ and dat_
                           )
                       )
           loop
               if k.sum_all <> 0 then
                  begin
                      select kodp, znap
                          into  kodp_, znap_
                      from rnbu_trace_arch
                      where datf =  datfp_ and 
                            kodf = 'D5' and 
                            acc = k.acca and
                            kodp like '12'||substr(k.nls,1,4)||'%' and
                            rownum = 1;
                  exception
                     when no_data_found then
                         kodp_ := null;
                  end;
    
                  if kodp_ is not null then
                     INSERT INTO rnbu_trace
                                 (recid, userid, nls, kv, odate, kodp,
                                  znap, acc, rnk, isp, mdate, ref,
                                  comm, nbuc, tobo
                                 )
                      select s_rnbu_record.NEXTVAL recid,
                             userid_, nls, kv, k.fdat, 
                             '10' || substr(kodp,3,23) || '5' || decode(Dat_, dat_izm5, 'G', substr(kodp,27,1)), 
                             to_char(k.sq), acc,
                             rnk, isp, mdate, k.ref,
                             'Списання за рахунок резерву РЕФ = '||to_char(k.ref) comm,
                             nbuc, tobo
                      from rnbu_trace_arch
                      where datf =  datfp_ and 
                            kodf = 'D5' and 
                            acc = k.acca and
                            kodp like '12'||substr(k.nls,1,4)||'%' and
                            rownum = 1;
                  end if;
               end if;
           end loop;
       end;
    end if;

    logger.info ('P_FD5_NN: etap 5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    update rnbu_trace set kodp = substr(kodp,1,2) || '6055' || substr(kodp,7)
    where substr(kodp,3,4)='6046';

    ---------------------------------------------------
    DELETE FROM tmp_nbu WHERE kodf=kodf_ AND datf= dat_;
    ---------------------------------------------------
    if Dat_ < dat_izm1 then
       OPEN BaseL;
       LOOP
          FETCH BaseL INTO  kodp_, nbuc_, znap_;
          EXIT WHEN BaseL%NOTFOUND;
          INSERT INTO tmp_nbu
               (kodf, datf, kodp, znap, nbuc)
          VALUES
               (kodf_, Dat_, kodp_, znap_, nbuc_);
       END LOOP;
       CLOSE BaseL;
    end if;


    if Dat_ between dat_izm1 and dat_izm3 then
       p_ins_log('---------------------------------------', NULL);
       p_ins_log('ПЕРЕСЧЕТ % ставок с учетом коммисионных', NULL);
       p_ins_log('---------------------------------------', NULL);

       BEGIN
          SELECT 1
             INTO kolvo_
          FROM CC_TAG
          WHERE tag='D_KDO';
       EXCEPTION
                 WHEN NO_DATA_FOUND THEN
          INSERT INTO CC_TAG(tag, name)
                     VALUES ('D_KDO', 'Дата включения коммисии (KDO) в #03');
       END;

       -- ПЕРЕСЧЕТ % ставок с учетом коммисионных
       FOR i IN (SELECT  a.kodp, a.acc acc_, a.nls, a.kv, TO_NUMBER (a.znap) ost, b.znap prc,
                         (TO_NUMBER (a.znap) * TO_NUMBER (b.znap))/36500 ost_prc, b.recid,
                         TRANSLATE(t.txt,',','.') kom, s.mdate-dat_ term, c.nd nd, c.cc_id,
                         ABS(Gl.P_Icurval(a.KV, c.LIMIT * 100, Dat_)) s_zd2, s.mdate
                 FROM RNBU_TRACE a, RNBU_TRACE b, ND_ACC n, CC_DEAL c, ND_TXT t, ACCOUNTS s
                 WHERE SUBSTR (a.kodp, 2, 24) = SUBSTR (b.kodp, 2, 24)
                   AND SUBSTR (a.kodp, 27, 1) = SUBSTR (b.kodp, 27, 1)
                   AND a.kodp like '1%'||(case when dat_ > dat_izm3 then '2' else '' end)
                   AND b.kodp like '2%'
                   and nvl(a.nd, 0) <> 1
                   AND a.acc = b.acc
                   AND a.recid = b.recid - 1
                   AND a.odate = b.odate
                   AND a.acc=n.acc
                   AND n.nd=c.nd
                   AND (c.sdate,c.nd)= (SELECT MAX(p.sdate), MAX(p.nd)
                                        FROM ND_ACC a, CC_DEAL p
                                        WHERE a.acc=n.acc AND
                                              a.nd=p.nd AND
                                              p.sdate<=dat_)
                   AND n.nd=t.nd
                   AND t.tag='KDO'
                   AND a.acc=s.acc
                 ORDER BY a.kodp)
        LOOP
        ---------------------------------------------------------
           BEGIN
              komm_ := TO_NUMBER(i.kom) * 100;
           EXCEPTION
                     WHEN OTHERS THEN
              IF SQLCODE=-6502 THEN
                 komm_ := 0;
              ELSE
                 RAISE_APPLICATION_ERROR(-20001, 'Помилка: '||SQLERRM);
              END IF;
           END;

           -- проверка для траншей: если в первый транш коммисия включена, то дальше - не включать
           BEGIN
              SELECT TO_DATE(txt, 'ddmmyyyy')
                 INTO datp_
              FROM ND_TXT
              WHERE nd=i.nd AND
                    tag='D_KDO';
           EXCEPTION
                     WHEN NO_DATA_FOUND THEN
              datp_ := NULL;
           END;

           IF komm_>0 AND NVL(i.term,0)>0 AND NVL(datp_, dat_) = dat_ THEN
              -- проверка количества ссудных счетов в договоре и общей суммы по договору
              SELECT COUNT(*), SUM(TO_NUMBER(znap))
                 INTO kolvo_, se_
              FROM ND_ACC n, RNBU_TRACE r
              WHERE n.ND=i.nd AND
                    n.acc=r.acc AND
                    SUBSTR(r.KODP,1,1)='1';

              -- если в договоре не один ссудный счет
              IF kolvo_ > 1 THEN
                 -- распределение пропорционально остаткам
                 komm_ := komm_ * (i.ost / se_);
              END IF;

              kommr_ := komm_ / i.term;

              if 353575 IN (mfo_,mfou_) THEN
                 b_yea := 365;
              else
                 -- Визначення базового року (360 чи 365)
                 BEGIN
                    SELECT basey
                       into basey_
                    FROM int_accN
                    WHERE acc=i.acc_ and
                          id=0;
                 EXCEPTION
                           WHEN NO_DATA_FOUND THEN
                    basey_:=0;
                 END;

                 IF basey_ in (2, 3, 12) THEN
                    b_yea := 360;
                 ELSE
                    b_yea := 365;
                 END IF;
              end if;

              s_zd2_ := i.s_zd2;

              if i.s_zd2 = 0 then
                 select max(ABS(Gl.P_Icurval(i.KV, LIM2, Dat_)))
                    into s_zd2_
                 from cc_lim
                 where fdat<=Dat_
                   and nd=i.nd
                 group by nd;
              end if;

              BEGIN
                 cntr_ := ((s_zd2_ * i.prc / (b_yea * 100) + kommr_) / s_zd2_) * b_yea * 100;
              EXCEPTION
                        WHEN OTHERS THEN
                 RAISE_APPLICATION_ERROR(-20001, 'рах. '||i.nls||' Реф.дог. '||i.nd||' Помилка: не заповнена сума лiмiту');
              END;

              -- обновление процентной ставки
              -- в протоколе
              UPDATE RNBU_TRACE
                 SET znap = Trim(TO_CHAR (ROUND (cntr_, 4), fmt_))
              WHERE recid=i.recid;

              -- обновление (остатка*процентную ставку)
              -- в протоколе
              UPDATE RNBU_TRACE
                 SET znap = Trim(TO_CHAR (se_*ROUND(cntr_,4)))
              WHERE nls=i.nls and kv=i.kv and kodp like '3%';

              IF datp_ IS NULL THEN
                 -- доп. реквизиты для КД
                 INSERT INTO ND_TXT (nd, tag, txt)
                              VALUES(i.nd, 'D_KDO', TO_CHAR(dat_, 'ddmmyyyy'));
              END IF;

              p_ins_log('Cчет '''||i.nls||
                        '''. Реф КД = '||Trim(TO_CHAR(i.nd))||
                        '. SK='||Trim(TO_CHAR(i.s_zd2))||
                        '. Kom='||Trim(TO_CHAR(komm_))||
                        '. Prc='||Trim(TO_CHAR(i.prc))||
                        ', PrcN='||LTRIM(TO_CHAR (ROUND (cntr_, 4), fmt_))||
                        '. Term='||i.term||'.'||
                        '. BaseY='||to_char(b_yea)||'.', NULL);
           END IF;
        END LOOP;

        -- показники для рахунк?в з процентною ставкою
        OPEN BaseL1;

        LOOP
           FETCH BaseL1
            INTO nbuc_, kodp_, sob_, sobpr_;

           EXIT WHEN BaseL1%NOTFOUND;

           INSERT INTO TMP_NBU
                       ( kodf,  datf, kodp,  znap,           nbuc )
                VALUES ( kodf_, dat_, kodp_, TO_CHAR (sob_), nbuc_ );

           if sob_ <> 0 then
              spcnt1_ := LTRIM (TO_CHAR (ROUND (sobpr_ / sob_, 4), fmt_));
           else
              spcnt1_ := '0.0000';
           end if;

           INSERT INTO TMP_NBU
                       ( kodf,  datf, kodp,                    znap,    nbuc )
                VALUES ( kodf_, dat_, '2'||substr(kodp_,2), spcnt1_, nbuc_ );
        END LOOP;

        CLOSE BaseL1;

        -- показники для рахунк?в без процентної ставки
        OPEN BaseL2;
        LOOP
           FETCH BaseL2 INTO  nbuc_, kodp_, znap_;
           EXIT WHEN BaseL2%NOTFOUND;
           INSERT INTO tmp_nbu
                (kodf, datf, kodp, znap, nbuc)
           VALUES
                (kodf_, Dat_, kodp_, znap_, nbuc_);
        END LOOP;
        CLOSE BaseL2;


        DELETE FROM RNBU_TRACE
           WHERE userid = userid_ AND
                 kodp like '3%';
    end if;

    if Dat_ >= dat_izm2 and Dat_ <= dat_izm3 then
       -- показники для рахунк?в з процентною ставкою
       OPEN BaseL1;

       LOOP
          FETCH BaseL1
           INTO nbuc_, kodp_, sob_, sobpr_;

          EXIT WHEN BaseL1%NOTFOUND;

          if sob_ <> 0 then
             spcnt1_ := LTRIM (TO_CHAR (ROUND (sobpr_ / sob_, 4), fmt_));
          else
             spcnt1_ := '0.0000';
          end if;

          if spcnt1_ <> '0.0000' then
             INSERT INTO TMP_NBU
                         ( kodf,  datf, kodp,                    znap,    nbuc )
                  VALUES ( kodf_, dat_, '2'||substr(kodp_,2), spcnt1_, nbuc_ );
          end if;

       END LOOP;

       CLOSE BaseL1;

       -- показники суми для вс?х рахунк?в
       OPEN BaseL2;

        LOOP
           FETCH BaseL2
            INTO nbuc_, kodp_, sob_;

           EXIT WHEN BaseL2%NOTFOUND;

           INSERT INTO TMP_NBU
                       ( kodf,  datf, kodp,  znap,           nbuc )
                VALUES ( kodf_, dat_, kodp_, TO_CHAR (sob_), nbuc_ );

        END LOOP;

        CLOSE BaseL2;


        DELETE FROM RNBU_TRACE
           WHERE userid = userid_ AND
                 (kodp like '3%' or kodp like '4%');
    end if;

    logger.info ('P_FD5_NN: etap 6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    if dat_ > dat_izm3 then
        kol_ := dat2_ - dat1_ + 1;

        -- показники для залишків та оборотів
        INSERT INTO tmp_nbu(kodf, datf, kodp, znap, nbuc)
        SELECT kodf_, Dat_, kodp, SUM (TO_NUMBER (znap)), nbuc
        FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP
              FROM RNBU_TRACE a
              WHERE a.kodp like '1%' and
                a.kodp not like '__3600%')
        GROUP BY kodf_, Dat_, kodp, nbuc;   

        -- формуємо показники по розрахованим процентам
        for k in (SELECT b.nbuc, b.kodp,
                         abs(sum(b.znap) + nvl(sum(d.znap),0)) zn1,
                         abs(sum(c.znap)) zn2,
                         nvl(abs(sum(d.znap)),0) zn3
                   FROM (SELECT a.nbuc NBUC, a.acc, kodp,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '11%3_'
                         group by a.nbuc, a.acc, kodp) b,
                         (SELECT a.nbuc NBUC, a.acc,
                            sum(a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE (a.kodp like '15%4_' or a.kodp like '16%4_')
                         group by a.nbuc, a.acc) c,
                         (SELECT a.nbuc NBUC, a.acc, kodp,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '12%3_'
                         group by a.nbuc, a.acc, kodp) d
                   where b.acc = c.acc and b.acc = d.acc(+)
                group by b.nbuc, b.kodp  )
        loop
           if k.zn1 <> 0 then
              nbuc_ :=k.nbuc;

              kodp_ := '2'||substr(k.kodp,2);

              if dat_ < to_date('30092013','ddmmyyyy') then
                 znap_ := Trim(TO_CHAR (round(((k.zn2 / k.zn1) / kol_) * b_yea * 100, 4), fmt_));
              else
                 znap_ := Trim(TO_CHAR (round((k.zn2 / k.zn1) * 12 * 100, 4), fmt_));
              end if;                
              
              if kodp_ not like '__3600%' then
                 INSERT INTO tmp_nbu
                       (kodf, datf, kodp, znap, nbuc)
                 VALUES
                       (kodf_, Dat_, kodp_, znap_, nbuc_);
              end if;
           end if;
        end loop;

        -- додаємо записи в протокол
        for k in (SELECT b.acc, b.nls, b.kv, b.rnk, b.nd, b.kodp, b.nbuc,
                         abs(sum(b.znap) + nvl(sum(d.znap),0)) zn1,
                         abs(sum(c.znap)) zn2,
                         nvl(abs(sum(d.znap)),0) zn3
                   FROM (SELECT a.acc, a.nls, a.kv, a.rnk, a.nd, a.kodp, a.nbuc,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '11%3_'
                         group by a.acc, a.nls, a.kv, a.rnk, a.nd, a.kodp, a.nbuc) b,
                         (SELECT a.nbuc NBUC, a.acc,
                            sum(a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '1%4_'
                         group by a.nbuc, a.acc) c,
                         (SELECT a.nbuc NBUC, a.acc, kodp,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '12%3_'
                         group by a.nbuc, a.acc, kodp) d
                   where b.acc = c.acc and b.acc = d.acc(+)
                group by b.acc, b.nls, b.kv, b.rnk, b.nd, b.kodp, b.nbuc)
        loop
           if k.zn1 <> 0 then
              nbuc_ := k.nbuc;

              kodp_ := '2'||substr(k.kodp,2);

              if dat_ < to_date('30092013','ddmmyyyy') then
                 znap_ := Trim(TO_CHAR (round(((k.zn2 / k.zn1) / kol_) * b_yea * 100, 4), fmt_));
              else
                 znap_ := Trim(TO_CHAR (round((k.zn2 / k.zn1) * 12 * 100, 4), fmt_));
              end if;                

              comm_ := 'Розрахована % ставка: середній залишок = '||to_char(k.zn1)||
                        ' процентні доходи = '||to_char(k.zn2) ||
                        (case when k.zn3 = 0 then '' else ' дисконт = '||to_char(k.zn3) end) ||
                        ' днів = ' || to_char(kol_)|| ' рік = ' ||to_char(b_yea);

              if kodp_ not like '__3600%' then
                 INSERT INTO rnbu_trace
                       (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, nd)
                 VALUES
                       (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acc,
                        k.rnk, k.nd);
              end if;
           end if;
        end loop;

        for k in (SELECT b.nbuc, b.kodp, abs(sum(b.znap) + sum(a.znap)) zn1, abs(sum(c.znap)) zn2
                   FROM (SELECT a.nbuc NBUC, a.acc, kodp,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '11%3_'
                         group by a.nbuc, a.acc, kodp) a,
                         (SELECT a.nbuc NBUC, a.acc, kodp,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '12%3_'
                         group by a.nbuc, a.acc, kodp) b,
                         (SELECT a.nbuc NBUC, a.acc,
                            sum(a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '1%4_'
                         group by a.nbuc, a.acc) c
                   where a.acc = b.acc and b.acc = c.acc
                group by b.nbuc, b.kodp )
        loop
           if k.zn1 <> 0 then
              nbuc_ :=k.nbuc;

              kodp_ := '2'||substr(k.kodp,2);

              if dat_ < to_date('30092013','ddmmyyyy') then
                 znap_ := Trim(TO_CHAR (round(((k.zn2 / k.zn1) / kol_) * b_yea * 100, 4), fmt_));
              else
                 znap_ := Trim(TO_CHAR (round((k.zn2 / k.zn1) * 12 * 100, 4), fmt_));
              end if;                

              if kodp_ not like '__3600%' then
                 INSERT INTO tmp_nbu
                       (kodf, datf, kodp, znap, nbuc)
                 VALUES
                       (kodf_, Dat_, kodp_, znap_, nbuc_);
              end if;
           end if;
        end loop;

        -- додаємо записи в протокол
        for k in (SELECT b.acc, b.nls, b.kv, b.rnk, b.nd, b.kodp, b.nbuc,
                         abs(sum(a.znap + b.znap)) zn1, abs(sum(c.znap)) zn2
                   FROM (SELECT a.acc, a.nls, a.kv, a.rnk, a.nd, a.kodp, a.nbuc,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '12%3_'
                         group by a.acc, a.nls, a.kv, a.rnk, a.nd, a.kodp, a.nbuc) b,
                         (SELECT a.nbuc NBUC, a.acc,
                            sum(a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '11%3_'
                         group by a.nbuc, a.acc) a,
                         (SELECT a.nbuc NBUC, a.acc,
                            sum(a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '1%4_'
                         group by a.nbuc, a.acc) c
                   where a.acc = b.acc and b.acc = c.acc
                group by b.acc, b.nls, b.kv, b.rnk, b.nd, b.kodp, b.nbuc)
        loop
           if k.zn1 <> 0 then
              nbuc_ := k.nbuc;

              kodp_ := '2'||substr(k.kodp,2);

              if dat_ < to_date('30092013','ddmmyyyy') then
                 znap_ := Trim(TO_CHAR (round(((k.zn2 / k.zn1) / kol_) * b_yea * 100, 4), fmt_));
              else
                 znap_ := Trim(TO_CHAR (round((k.zn2 / k.zn1) * 12 * 100, 4), fmt_));
              end if;                

              comm_ := 'Розрахована % ставка (з врахуванням дисконту): середній залишок = '||to_char(k.zn1)||' процентні доходи = '||to_char(k.zn2) ||
                    ' днів = ' || to_char(kol_)|| ' рік = ' ||to_char(b_yea);

              if kodp_ not like '__3600%' then
                 INSERT INTO rnbu_trace
                       (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, nd)
                 VALUES
                       (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acc,
                        k.rnk, k.nd);
              end if;
           end if;
        end loop;
    end if;

    if prnk_ is null then
      --------------------------------------------------------
      --P_Ch_Filed5(kodf_,dat_,userid_);
      --------------------------------------------------------

      otc_del_arch(kodf_, dat_, 0);
      OTC_SAVE_ARCH(kodf_, dat_, 0);
      commit;
    end if;
    
    logger.info ('P_FD5_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));    
END P_Fd5_Nn;
/

show err;
