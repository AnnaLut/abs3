PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F08_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F08_NN ***


CREATE OR REPLACE PROCEDURE BARS.P_F08_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #08 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :13/05/2019 (14/03/2019)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
13.05.2019 для 1911,1919 зм_нено формування параметру K072 (якщо K072 не
           20,21,22,23 то будемо формувати значення '21')
14.03.2019 для бал.счетов 2805,3510,3519,3550,3551,3552,3559,3578
           и S183='0' изменяем S183_ на '1'
           для всіх бал.рахунків параметр S183 змінюємо з "0" на "1"
06.03.2019 добавлено блок для заміни параметру K072 для від'ємних значень
           показника для бал.рахунків 6 і 7 класів
28.12.2018 изменения для групп бал.счетов 612, 630
07.12.2019 для бал.рах. 3500,3600 параметр R011 будемо формувати нульовим
30.11.2018 включено для обробки два бал.рахунки 3500 _ 3600 як_ будуть
           включатися в файл #08X _ не будуть включатися в файл #08.
09.10.2018 при розбитт_ залишку для групи бал.рах. 704 параметр R011
           формуємо _з значенням "0"
07.08.2018 для 3521,3522,3621,3622 зм_нено формування параметру K072
08.05.2018 для бал.счета 3648 параметр R011 будем формировать равным нулю
09.02.2018 для 3653, 3658 зм_нено формування параметру K072
08.02.2018 для бал.счетов 2924, 3570 и S183='0' изменяем S183_ на '1'
06.02.2018 для группы 290 и бал.счетов 2920, 2924 R011='0'
22.01.2018 изменено формирование параметра K072 для ФЛ и для некотр_х
           бал.счетов
18.01.2018 для таблицы KL_K070 изменео условие p.D_CLOSE is null на
           p.D_CLOSE(+) is null (возникала ошибка)
11.01.2018 новая структура показателя добавлено 3-х значный код страны
20.03.2017 объеденнены некоторые блоки для присвоения переменной S_
           значения 'I'
07.06.2016 для групп бал.счетов 602,604,605 и Кт оборотов в кореспонденции
           со счетами дискрнта формируем показатель со знаком плюс
03.06.2016 при разбивке остатка по R013 не формировался код бал.счета
           Исправлено.
04.04.2016 вместо значения '00' для S130 будет формироваться значение '90'
           которое имеется в классификаторе KL_S130
30.03.2016 на 01.04.2016 будет формироваться новая часть показателя
           "код виду ц_нних папер_в" (параметр S130 2-х значный код)
20.01.2016 исключаем проводки перекрытия корректирующих за декабрь
           после перехода на новые DRAPSы
03.07.2015 для ГОУ изменил формирование кода 704
19.06.2015 для KL_K070 добавлено условие "D_CLOSE is null"
09.06.2015 изменения для групп бал.счетов 602, 605, 609, 702, 707, 709
20.05.2015 внесены все изменения которые были выполнены только для ГОУ
10.03.2015 из месячных корректирующих вычитаем годовые корректирующие
           проводки выполненные в следующем за отчетным месяце
25.02.2015 для нерезидентов параметр K072 будет равен '0'
           (изменения необходимы для ФЛ предпринимателей Крыма)
19.01.2015 для mfou_ <> 300465 и отчетного месяца 12 вызываем функцию
           f_pop_otcn(Dat_, 4, sql_acc_, null, 1)
19.12.2013 в табл. OTCN_F08_HISTORY добавлено поле VOB для ускорения
           формирования файла
09.12.2013 вместо VIEW PROVODKI будем использовать табл. OPLDOK и табл.
           ACCOUNTS (очень долго наполнялась табл. OTCN_F08_HISTORY)
20.06.2013 для обратных(коректировочных) проводок по 6,7 классам не
           выбирались параметры контрагента корреспондирующих счетов
           2,3 классов. Исправлено. (замечание Донецкого РУ)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='08';
typ_ number;
acc_     number;
nbs_     varchar2(4);
nbs1_    varchar2(4);
nls_     varchar2(15);
nls1_    varchar2(15);
rnk_     Number;
isp_     Number;
data_    date;
dat1_    date;
dat2_    date;
datng_   date;
kv_      SMALLINT;
sk_      NUMBER;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
se_      DECIMAL(24);
se1_     DECIMAL(24);
se_k_    DECIMAL(24);
mfo_     Number;
mfou_    Number;
dk_      char(1);
kodp_    varchar2(20);
znap_    varchar2(30);
r011_    varchar2(1);
r013_    varchar2(1);
s130_    Varchar2(2);
s180_    Varchar2(1);
s183_    Varchar2(1);
k072_    varchar2(2);
s_       char(2);
s1_      char(2);
s2_      char(2);
r_       char(1);
r1_      char(1);
userid_  number;
userid1_ number;
flag_    number;
nbuc1_   varchar2(12);
nbuc_    varchar2(12);
DatN_    date;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
sql_z      VARCHAR2 (2000):='';
ret_     number;
fa7p_    NUMBER;
nd_      NUMBER;
comm_    rnbu_trace.comm%type;
comm1_   rnbu_trace.comm%type;
freq_    NUMBER;
dos_     number;
dose_    number;
kol_     number;
pr_se_   number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
d_sum_   number;
k_sum_   number;

-- ДО 30 ДНЕЙ
o_r013_1   VARCHAR2 (1);
o_se_1     DECIMAL (24);
o_comm_1   rnbu_trace.comm%TYPE;
-- ПОСЛЕ 30 ДНЕЙ
o_r013_2   VARCHAR2 (1);
o_se_2     DECIMAL (24);
o_comm_2   rnbu_trace.comm%TYPE;
tip_       accounts.tip%type;
country_   varchar2(3);
dat_Izm1  date := to_date('29/12/2017','dd/mm/yyyy');
custtype_  Number;
codcagent_ Number;
ob22_      accounts.ob22%type;

CURSOR Saldo IS
   select a.*, n.nd, i.freq
   from (
     SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs,
              NVL(cc.r011,'0') r011, NVL(cc.r013,'0') r013,
              NVL(lpad (trim(cc.k072), 2, 'X'),'XX') k072,
              s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96,
              s.dos99, s.kos99, s.dosq99, s.kosq99,
              s.doszg, s.koszg, a.isp, a.tobo, a.nms, a.tip,
              NVL(cc.s130,'90') S130, lpad (to_char(c.country), 3, '0'), nvl(a.ob22, '00')
       FROM  otcn_saldo s, specparam cc, otcn_acc a, customer c
       WHERE (s.ost-s.dos96+s.kos96+s.doszg-s.koszg <> 0 OR
              s.ostq-s.dosq96+s.kosq96 <> 0)
         and s.acc = a.acc
         and s.acc = cc.acc(+)
         and s. rnk = c.rnk) a
    left outer join (select n.acc, max(n.nd) nd
                      from nd_acc n, cc_deal e
                      WHERE e.sdate <= Dat_
                        AND e.nd = n.nd
                      group by n.acc ) n
    on (a.acc = n.acc)
    left outer join (SELECT n8.nd, max(i.freq) freq
                              FROM accounts a8, nd_acc n8, int_accn i
                             WHERE a8.nbs = '8999'
                               AND n8.acc = a8.acc
                               AND a8.acc = i.acc
                               AND i.ID = 0
                            group by n8.nd) i
    on (i.nd = n.nd)     ;
-----------------------------------------------------------------------------
--- процедура формирования протокола
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_rnk_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_kv_ smallint, p_r011_ varchar2,
                p_r013_ varchar2, p_k072_ varchar2,
                p_s183_ varchar2, p_s130_ varchar2,
                p_country_ varchar2,
                p_znap_ varchar2, p_isp_ number, p_nbuc_ varchar2) IS

kod_ varchar2(18);

begin
   BEGIN
      SELECT NVL(trim(k.k072),'00'), to_char(2 - MOD(c.codcagent,2)),
             c.custtype, c.codcagent
      INTO s_, r_, custtype_, codcagent_
      FROM customer c, kl_k070 k
      WHERE c.rnk=p_rnk_ AND c.ise=k.k070(+) and k.d_close(+) is null;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      s_:='00';
      r_:='1';

      SELECT c.custtype, c.codcagent
         INTO custtype_, codcagent_
      FROM customer c
      WHERE c.rnk=p_rnk_;
   END;

   if p_k072_ is not null and p_k072_<>'XX' then
      s_:= p_k072_;
   end if;

   if (substr(p_nbs_,1,3) in ('600','700') OR p_nbs_ in ('6126','6127','6128')) and
       s_<>'20'
   then
      s_:= '20';
   end if;

   if substr(p_nbs_,1,3) in ('601','608','701','708') and r_=1 and
       s_ not in ('21','22','23')
   then
      s_:= '22';
   end if;

   if substr(p_nbs_,1,3) in ('601','608','701','708') and r_=2 and
      s_ not in ('N1','N2','N3','N4','N5','N6','N7','N8')
   then
      s_:= 'N2';
   end if;

   if p_nbs_ in ('3520','3521','3620','3621') and s_ not in ('30','32') then
      s_:='30';
   end if;

   if p_nbs_ in ('3522','3622') and s_ not in ('30','31','32','33') then
      s_:='30';
   end if;

   if p_nbs_ in ('3623') and s_<>'30' then
      s_:='30';
   end if;

   if (p_nbs_ in ('3653','3658') or
      substr(p_nbs_,1,3) in ('355','605','606','610','611','704')) and
      r_=1 and s_ not in ('42','43')
   then
      s_:= '42';
   end if;

   if (p_nbs_ in ('3653','3658') or
      substr(p_nbs_,1,3) in ('355','605','606','610','611','704')) and
      r_=2 and s_ not in ('N8')
   then
      s_:= 'N8';
   end if;

   if p_nbs_ in ('6140') or
      substr(p_nbs_,1,3) in ('601','613','701','713') and
      r_=2 and s_ not in ('N3')
   then
      s_:= 'N3';
   end if;

   -- только для резидентов
   if p_nbs_ in ('2902','2903','2909','6020','6025') and r_<>2 and s_='00'
   then
      s_:='12';
   end if;

   -- только для резидентов
   if p_nbs_ in ('2809','2920','2924','3522','3621','3622') and r_<>2 and s_='00'
   then
      s_:='42';
   end if;

   if ( p_nbs_ in ('6090','6091','6092','6093','6094','6095',
                  '6120','6121','6122','6123','6124','6125',
                  '7140') OR substr(p_nbs_,1,3) in ('602','603','607','630','702')
      ) and custtype_ = 2 and r_ = 2 and s_ in ('00', 'N2')
   then
      s_ := 'N6';
   end if;

   if custtype_ = 2 and codcagent_ = 3 and s_ = '00'
   then
      s_ := '12';
   end if;

   if custtype_ = 2 and codcagent_ = 4 and s_ = '00'
   then
      s_ := 'N6';
   end if;

   if custtype_ = 3 and codcagent_ = 5 and s_ not in ('42','43')
   then
      s_ := '42';
   end if;

   if custtype_ = 3 and codcagent_ = 6 and s_ not in ('N8')
   then
      s_ := 'N8';
   end if;

   if p_nbs_ = '7030' and r_=1 and s_ not in ('30', '31', '32', '33')
   then
      s_:= (case
                when ob22_ in ('01', '06', '07', '08','51') then '30'
                when ob22_ in ('47', '48') then '31'
                else '30'
            end);
   end if;

   if p_nbs_ in ('1911','1919') and s_ not in ('20', '21', '22', '23')
   then
      s_:= '21';
   end if;

   if p_nbs_ in ('1919') and s_ = '2D' then
      s_:='21';
   end if;

    if substr(p_nbs_,1,3) = '602' and s_ = '21' then
       s_ := '2B';
    end if;

   Ostn_:= to_number(p_znap_);

   if substr(p_nbs_,1,3) in ('602','605','609','612','630') then
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsk=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob=96 and
                      nlsk=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop
         if substr(k.nlsd,1,1) in ('1','2','3') and k.nlsd not like '3739%' then
            select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                   ca.tobo, ca.nms
              into s1_, r1_, s2_, tobo_, nms_
            from accounts ca, customer c, specparam s, kl_k070 p
            where ca.acc=k.accd and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) and
                  p.d_close(+) is null ;
         else
            s1_:='XX';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s2_ <> '00' then
            s1_ := s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := - k.s;
         else
            se_ := k.s;
         end if;

         if mfo_ = 324805
         then
            if substr(p_nbs_,1,3) = '602' then
               s1_ := 'N6';
            else
               s1_ := 'N2';
            end if;

            r1_ := '2';
         end if;

        -- тимчасово, бо N2 чомусь не є допустимим значенням (наприклад, посольство КНР)
         if substr(p_nbs_,1,3) = '605' and s1_ <> 'N8' and r1_ = '2' then
            s1_:='N8';
         end if;

         if substr(p_nbs_,1,3) = '605' and s1_ not in ('42', '43') and r1_ = '1' then
            s1_:='42';
         end if;

         if dat_ < dat_Izm1
         then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
         else
            kod_:= p_tp_ || p_nbs_ || '0' || s1_ || r1_ || lpad(p_kv_,3,'0') ||
                   '1' || p_s130_ || p_country_;
         end if;

         if se_ <> 0 then
            if k.nlsd like '6%' then
               nls1_ := k.nlsk;
               comm1_ := comm_;
            else
               nls1_ := k.nlsd;
               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;

            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (nls1_, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;

      -- для проводок по Дебету пассивного счета и нет Дт счетов 2,3 ... классов
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and  Dat_
                  and nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob=96 and
                      nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop

         if substr(k.nlsk,1,1) in ('1','2','3') then
            select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                   ca.tobo, ca.nms
              into s1_, r1_, s2_, tobo_, nms_
            from accounts ca, customer c, specparam s, kl_k070 p
           where ca.acc=k.acck and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) and
                  p.d_close(+) is null;
         else
            s1_:='XX';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s2_<>'00' then
            s1_:=s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := k.s;
         else
            se_ := - k.s;
         end if;

         if mfo_ = 324805
         then
            if substr(p_nbs_,1,3) in ('602', '702') then
               s1_ := 'N6';
               s_  := 'N6';
            else
               s1_ := 'N2';
               s_  := 'N2';
            end if;

            r_ := '2';
            r1_ := '2';
         end if;

        -- тимчасово, бо N2 чомусь не є допустимим значенням (наприклад, посольство КНР)
         if substr(p_nbs_,1,3) = '605' and s1_ <> 'N8' and r1_ = '2' then
            s1_:='N8';
         end if;

         if substr(p_nbs_,1,3) = '605' and s1_ not in ('42', '43') and r1_ = '1' then
            s1_:='42';
         end if;

         if dat_ < dat_Izm1
         then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
         else
            kod_:= p_tp_ || p_nbs_ || '0' || s1_ || r1_ || lpad(p_kv_,3,'0') ||
                   '1' || p_s130_ || p_country_;
         end if;

         if se_ <> 0 and k.nlsk not like '6%'
         then
            comm1_ := '';
            comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

         if se_ <> 0 and k.nlsk like '6%'
         then
            if dat_ < dat_Izm1
            then
               kod_:= p_tp_ || p_nbs_ || p_r013_ || s_ || r_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
            else
               kod_:= p_tp_ || p_nbs_ || '0' || s_ || r_ || lpad(p_kv_,3,'0') ||
                      '1' || p_s130_ || p_country_;
            end if;

            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsd, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;
   end if;

   if ( substr(p_nbs_,1,3) in ('702','707','709') and mfo_<>300465) OR
      ( substr(p_nbs_,1,3) in ('702','707','709') and mfo_=300465 and
         p_k072_ in ('XX','21')
      )
   then
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob=96 and
                      nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop
         comm1_ := comm_;

         if substr(k.nlsk,1,1) in ('2','3','8') then
            if k.nlsk like '2%' OR k.nlsk like '3%' then
               select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, specparam s, kl_k070 p
               where ca.acc=k.acck and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close(+) is null ;
               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;
            if k.nlsk like '8%' then
               select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, specparam s, kl_k070 p
               where ca.acc=k.acck  and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close(+) is null;

               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;
         else
            s1_:='XX';
            r1_:='1';
            s2_:=s_ ;
         end if;

         se_:= 0;  -- 09.06.2013 ниже есть блок для обратных проводок

         if s2_ <> '00' then
            s1_ := s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := k.s;
         else
            se_ := - k.s;
         end if;

         if mfo_ = 324805
         then
            s1_ := 'N2';
            r1_ := '2';
         end if;

        -- тимчасово, бо N2 чомусь не є допустимим значенням (наприклад, посольство КНР)
         if substr(p_nbs_,1,3) in ('702') and s1_='N2' and r1_ = '2' then
            s1_:='N6';
         end if;

         if substr(p_nbs_,1,3) = '702' and s1_='42' and r1_ = '1' then
            s1_:='41';
         end if;

         if substr(p_nbs_,1,3) = '702' and s1_='21' and r1_ = '1' then
            s1_:='2D';
         end if;
                  if dat_ < dat_Izm1
         then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
         else
            kod_:= p_tp_ || p_nbs_ || '0' || s1_ || r1_ || lpad(p_kv_,3,'0') ||
                   '1' || p_s130_ || p_country_;
         end if;

         if se_ <> 0 then
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;

----- для проводок по кредиту активного счета и нет Кт счетов 2,3 ... классов
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat  between Datng_ and Dat_ and
                      nlsk=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob = 96 and
                      nlsk=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop

         comm1_ := comm_;

         if substr(k.nlsd,1,1) in ('2','3','8') then
            if k.nlsd like '2%' OR k.nlsd like '3%' then
               select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, specparam s, kl_k070 p
               where ca.acc=k.accd and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close(+) is null;

               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;

            if k.nlsd like '8%' then
               select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                      ca.tobo, ca.nms
                 into s1_, r1_, s2_, tobo_, nms_
               from accounts ca, customer c, specparam s, kl_k070 p
               where ca.acc=k.accd  and
                     ca.rnk=c.rnk  and
                     ca.acc=s.acc(+) and
                     c.ise = p.k070(+) and
                     p.d_close(+) is null;

               comm1_ := '';
               comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
            end if;
         else
            s1_:='X';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s2_ <> '00' then
            s1_ := s2_;
         end if;

         if p_tp_ = '1'
         then
            se_ := - k.s;
         else
            se_ := k.s;
         end if;

         if mfo_ = 324805
         then
            s_ := 'N2';
            r_ := '2';
            s1_ := 'N2';
            r1_ := '2';
         end if;

        -- тимчасово, бо N2 чомусь не є допустимим значенням (наприклад, посольство КНР)
         if substr(p_nbs_,1,3) in ('702') and s1_='N2' and r1_ = '2' then
            s1_:='N6';
         end if;

         if substr(p_nbs_,1,3) = '702' and s1_='42' and r1_ = '1' then
            s1_:='41';
         end if;

         if substr(p_nbs_,1,3) = '702' and s1_='21' and r1_ = '1' then
            s1_:='2D';
         end if;

         if dat_ < dat_Izm1
         then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
         else
            kod_:= p_tp_ || p_nbs_ || '0' || s1_ || r1_ || lpad(p_kv_,3,'0') ||
                   '1' || p_s130_ || p_country_;
         end if;

         if se_ <> 0 and k.nlsd not like '7%' then
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsd, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_ ;
         end if;

         if se_ <> 0 and k.nlsd like '7%' then

            if dat_ < dat_Izm1
            then
               kod_:= p_tp_ || p_nbs_ || p_r013_ || s_ || r_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
            else
               kod_:= p_tp_ || p_nbs_ || '0' || s_ || r_ || lpad(p_kv_,3,'0') ||
                      '1' || p_s130_ || p_country_;
            end if;

            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm_);

            Ostn_:= Ostn_ - se_ ;
         end if;

      end loop;
   end if;

   if substr(p_nbs_,1,3)='704' and mfo_=300465 then
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob = 96 and
                      nlsd=trim(p_nls_)
                group by accd, nlsd, kv, acck, nlsk )
      loop
         comm1_ := comm_;

         if substr(k.nlsk,1,1) in ('2','8') then
            select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                   ca.tobo, ca.nms, c.codcagent, c.custtype
                 into s1_, r1_, s2_, tobo_, nms_, codcagent_, custtype_
            from accounts ca, customer c, specparam s, kl_k070 p
            where ca.acc=k.acck and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) and
                  p.d_close(+) is null;

            comm1_ := '';
            comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
         else
            s1_:='XX';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s1_ = 'XX' and s2_<>'00' then
            s1_:=s2_;
         end if;

         if s1_ in ('N1','N2','N3','N4','N5','N6','N7','N8')
         then
            r1_:='2';
         end if;

         if p_tp_ = '1'
         then
            se_ := k.s;
         else
            se_ := - k.s;
         end if;

         if mfo_ = 324805
         then
            s1_ := 'N2';
            r1_ := '2';
         end if;

         if custtype_ = 3 and codcagent_ = 5 and s1_ not in ('42','43')
         then
            s1_ := '42';
         end if;

         if (custtype_ = 3 and codcagent_ = 6 or r1_ = '2') and s1_ not in ('N8')
         then
            s1_ := 'N8';
         end if;

         if dat_ < dat_Izm1
         then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
         else
            kod_:= p_tp_ || p_nbs_ || '0' || s1_ || r1_ || lpad(p_kv_,3,'0') ||
                   '1' || p_s130_ || p_country_;
         end if;

         if se_ <> 0 then
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;
---------------
----- для проводок по кредиту активного счета и нет Дт счетов 2,3,8 ... классов
      for k in (select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Datng_ and Dat_
                  and nlsk like p_nls_ || '%'
                group by accd, nlsd, kv, acck, nlsk
                union
                select accd, nlsd, kv, decode(kv,980,sum(s*100),sum(sq*100)) s,
                       acck, nlsk
                from otcn_f08_history
                where fdat between Dat_+1 and Dat_+29 and
                      vob = 96 and
                      nlsk like p_nls_ || '%'
                group by accd, nlsd, kv, acck, nlsk )
      loop

         comm1_ := comm_;

         if substr(k.nlsd,1,1) in ('2','8') then
            select NVL(p.k072,'00'), 2-mod(c.codcagent,2), nvl(lpad(trim(s.k072), 2, 'X'),'00'),
                   ca.tobo, ca.nms, c.codcagent, c.custtype
                 into s1_, r1_, s2_, tobo_, nms_, codcagent_, custtype_
            from accounts ca, customer c, specparam s, kl_k070 p
            where ca.acc=k.accd and
                  ca.rnk=c.rnk  and
                  ca.acc=s.acc(+) and
                  c.ise = p.k070(+) and
                  p.d_close(+) is null;

            comm1_ := '';
            comm1_ := substr(comm1_ || tobo_ || '  ' || nms_, 1, 200);
         else
            s1_:='XX';
            r1_:='1';
            s2_:=s_ ;
         end if;

         if s1_ = 'XX' and s2_<>'00' then
            s1_:=s2_;
         end if;

         if s1_ in ('N1','N2','N3','N4','N5','N6','N7','N8')
         then
            r1_:='2';
         end if;

         if p_tp_ = '1'
         then
            se_ := - k.s;
         else
            se_ := k.s;
         end if;

         if mfo_ = 324805
         then
            s_ := 'N2';
            r_ := '2';
            s1_ := 'N2';
            r1_ := '2';
         end if;

         if custtype_ = 3 and codcagent_ = 5 and s1_ not in ('42','43')
         then
            s1_ := '42';
         end if;

         if (custtype_ = 3 and codcagent_ = 6 or r1_ = '2') and s1_ not in ('N8')
         then
            s1_ := 'N8';
         end if;

         if dat_ < dat_Izm1
         then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || s1_ || r1_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
         else
            kod_:= p_tp_ || p_nbs_ || '0' || s1_ || r1_ || lpad(p_kv_,3,'0') ||
                   '1' || p_s130_ || p_country_;
         end if;

         if se_ <> 0 then
            INSERT INTO rnbu_trace
                    (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
            VALUES  (k.nlsk, k.kv, dat_, kod_, to_char(se_), p_nbuc_, rnk_, isp_, comm1_);

            Ostn_:= Ostn_ - se_;
         end if;

      end loop;

   end if;

   if substr(p_nbs_,1,3) in ('702','707','709') and s_='00' and mfo_=300465 then
      r_:='2';
   end if;

   if Ostn_ <> 0 then

      if dat_ < dat_Izm1
      then
         kod_:= p_tp_ || p_nbs_ || p_r013_ || s_ || r_ || lpad(p_kv_,3,'0') || p_s183_ || p_s130_;
      else
         if substr(p_nbs_,1,3) in ('605','704') OR p_nbs_ in ('3500','3600')
         then
            kod_:= p_tp_ || p_nbs_ || '0' || s_ || r_ || lpad(p_kv_,3,'0') ||
                   p_s183_ || p_s130_ || p_country_;
         else
            kod_:= p_tp_ || p_nbs_ || p_r011_ || s_ || r_ || lpad(p_kv_,3,'0') ||
                   p_s183_ || p_s130_ || p_country_;
         end if;
      end if;

      INSERT INTO rnbu_trace
               (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm)
      VALUES  (p_nls_, p_kv_, p_dat_, kod_, to_char(Ostn_), p_nbuc_, rnk_, isp_, comm_);
   end if;
exception
    when others then
        raise_application_error(-20002, 'Помилка в процедур?: '||sqlerrm);
end;
----------------------------------------------------------------------------
BEGIN

commit;

EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

logger.info ('P_F08_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_,'MM');
Datng_:= to_date('0201'||to_char(Dat_,'YYYY'),'ddmmyyyy');

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
-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

-- вместо классификатора KL_R020 будем использовать KOD_R020
sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''08'' union select ''3500'' from dual union select ''3600'' from dual ';

   if mfou_ <> 300465 and to_char(Dat_,'MM')='12' then
      ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
   else
      if to_char(Dat_,'MM') in ('01','02','03','04','05','06') then
         ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
      else
         ret_ := f_pop_otcn(Dat_, 2, sql_acc_);
      end if;
   end if;

-- при формировании файла за январь месяц
-- из таблицы OTCN_F08_HISTORY удаляем проводки за предыдущий год
if to_char(dat_,'MM')='01' then
   delete from otcn_f08_history
   where fdat < Dat1_;
end if;

delete from otcn_f08_history
where fdat between Dat1_ and Dat_;

delete from otcn_f08_history
where fdat between Dat_+1 and Dat_+29
  and vob = 96 ;

-- для отбора проводок в первом месяце исключаем первый день года
-- т.к. в этот день выполняются проводки перекрытия 6,7 классов на 5040(5041)
-- предыдущего года
if to_char(dat_,'MM')='01' then
   Dat1_ := Dat1_ + 1;
end if;

commit;

---------------------------------------------------------------------
-- новый вариант блока наполнения таблицы OTCN_F08_HISTORY
 insert /*+ APPEND */
 into otcn_f08_history
            (accd,tt,ref,kv,nlsd,s,sq,fdat,nazn,acck,nlsk,userid,tobo,vob)
 select accd,tt,ref,kv,trim(nlsd),s,sq,fdat,nazn,acck,trim(nlsk),isp,'0',vob
        from (SELECT p.userid isp, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos,
                       DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn,
                       o.tt, o.REF, o.sq/100 sq, o.fdat, o.stmt, o.txt,
                       (case when ad.nls like '3801%' then 0 else o.accd end) accd,
                       (case when ad.nls like '3801%' then decode(p.dk,1,p.nlsa,p.nlsb) else ad.nls end) nlsd,
                       (case when ad.nls like '3801%' then substr(decode(p.dk,1,p.nlsa,p.nlsb),1,4) else ad.nbs end) nbsd,
                       (case when ak.nls like '3801%' then 0 else o.acck end) acck,
                       (case when ak.nls like '3801%' then decode(p.dk,0,p.nlsa,p.nlsb) else ak.nls end) nlsk,
                       (case when ak.nls like '3801%' then substr(decode(p.dk,0,p.nlsa,p.nlsb),1,4) else ak.nbs end) nbsk,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.kv2, p.kv) else ad.kv end) kv,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.s2, p.s) else o.s end)/100 s,
                     p.vob
                FROM oper p, tts t, accounts ad,   accounts ak,
                     (SELECT /*+ leading(a) */
                             p.fdat, p.REF, p.stmt, p.tt, p.s, p.sq, p.txt,
                             DECODE (p.dk,0,p.acc,z.acc) accd,
                             DECODE (p.dk,1,p.acc,z.acc) acck
                      FROM  accounts a, opldok p, opldok z
                      WHERE p.fdat = any (select fdat from fdat where fdat between Dat1_ and Dat_)
                        and p.sos >= 5
                        and p.acc = a.acc
                        and regexp_like(A.NLS, '^((602)|(605)|(609)|(612)|(630)|(702)|(704)|(707)|(709))')
                        and p.ref = z.ref
                        and p.fdat = z.fdat
                        and p.stmt = z.stmt
                        and p.dk <> z.dk) o
                WHERE p.REF = o.REF
                  and t.tt = o.tt
                  and o.accd = ad.acc
                  and o.acck = ak.acc
                  and p.sos = 5
                  );
 commit;

 -- коректирующие проводки
 insert /*+ APPEND */
 into otcn_f08_history
            (accd,tt,ref,kv,nlsd,s,sq,fdat,nazn,acck,nlsk,userid,tobo,vob)
 select accd,tt,ref,kv,trim(nlsd),s,sq,fdat,nazn,acck,trim(nlsk),isp,'0',vob
        from (SELECT p.userid isp, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos,
                       DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn,
                       o.tt, o.REF, o.sq/100 sq, o.fdat, o.stmt, o.txt,
                       (case when ad.nls like '3801%' then 0 else o.accd end) accd,
                       (case when ad.nls like '3801%' then decode(p.dk,1,p.nlsa,p.nlsb) else ad.nls end) nlsd,
                       (case when ad.nls like '3801%' then substr(decode(p.dk,1,p.nlsa,p.nlsb),1,4) else ad.nbs end) nbsd,
                       (case when ak.nls like '3801%' then 0 else o.acck end) acck,
                       (case when ak.nls like '3801%' then decode(p.dk,0,p.nlsa,p.nlsb) else ak.nls end) nlsk,
                       (case when ak.nls like '3801%' then substr(decode(p.dk,0,p.nlsa,p.nlsb),1,4) else ak.nbs end) nbsk,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.kv2, p.kv) else ad.kv end) kv,
                       (case when ad.nls like '3801%' or ak.nls like '3801%' then decode(p.kv, 980, p.s2, p.s) else o.s end)/100 s,
                     p.vob
                FROM oper p, tts t, accounts ad, accounts ak,
                     (SELECT /*+ leading(a) */
                             p.fdat, p.REF, p.stmt, p.tt, p.s, p.sq, p.txt,
                             DECODE (p.dk,0,p.acc,z.acc) accd,
                             DECODE (p.dk,1,p.acc,z.acc) acck
                      FROM accounts a, opldok p, opldok z
                      WHERE p.fdat = any (select fdat from fdat where fdat between Dat_+1 and Dat_+29)
                        and p.sos >= 5
                        and p.acc = a.acc
                        and regexp_like(A.NLS, '^((602)|(605)|(609)|(612)|(630)|(702)|(704)|(707)|(709))')
                        and p.ref = z.ref
                        and p.fdat = z.fdat
                        and p.stmt = z.stmt
                        and p.dk <> z.dk) o
                WHERE p.REF = o.REF
                  and t.tt = o.tt
                  and o.accd = ad.acc
                  and o.acck = ak.acc
                  and p.sos = 5
                  and p.vob = 96
                  );
 commit;

 update otcn_f08_history a set
 a.accd=(select acc from accounts
         where nls=a.nlsd and kv=decode(substr(a.nlsd,1,1),'6',980,
                                 decode(substr(a.nlsd,1,1),'7',980,a.kv)))
 where a.fdat >= dat1_ and
       (a.accd=0 or a.accd is NULL);

 update otcn_f08_history a set
 a.acck=(select acc from accounts
         where nls=a.nlsk and kv=decode(substr(a.nlsk,1,1),'6',980,
                                 decode(substr(a.nlsk,1,1),'7',980,a.kv)))
 where a.fdat >= dat1_ and
       (a.acck=0 or a.acck is NULL);

---------------------------------------------------------------------
-- при формировании файла за январь месяц из таблицы OTCN_F08_HISTORY
-- удаляем корректирующие проводки за предыдущий год
if to_char(dat_,'MM')='01' then
   delete from otcn_f08_history
   where fdat < Dat_
     and vob=96 ;
end if;
-- удаляем обороты перекрытия 6,7 на 504
if to_char(dat_,'MM') in ('01','12') then
   delete from otcn_f08_history
   where nlsd LIKE '504%' and
         (nlsk LIKE '6%' OR nlsk LIKE '7%');
end if;
if to_char(dat_,'MM') in ('01','12') then
   delete from otcn_f08_history
   where (nlsd LIKE '6%' OR nlsd LIKE '7%') and
         nlsk LIKE '504%';
end if;

-- для проводок по процентам начисленным корректирующими проводками
if to_char(dat_,'MM')='01' then
   delete from otcn_f08_history
   where fdat < Dat_
     and ref in (select a.ref
                 from oper a
                 where a.datd BETWEEN Dat1_ and Dat_ and a.vob=96) ;
end if;

if (to_char(dat_,'MM') not in ('01','02') and mfo_=333368) or mfo_<>333368 then
   delete from otcn_f08_history
   where substr(nlsd,1,4)='3801' and
         regexp_like(nlsk, '^((602)|(605)|(609)|(612)|(630)|(702)|(704)|(707)|(709))');
end if;

if (to_char(dat_,'MM') not in ('01','02') and mfo_=333368) or mfo_<>333368 then
   delete from otcn_f08_history
   where regexp_like(nlsd, '^((602)|(605)|(609)|(612)|(630)|(702)|(704)|(707)|(709))') and
         substr(nlsk,1,4)='3801';
end if;

delete from otcn_fa7_temp;

-- 05/06/2013 убрал условие наполнения OTCN_FA7_TEMP для всех кроме Петрокоммерца
-- будет наполняться для всех
insert into otcn_fa7_temp (r020)
values ('3570');

insert into otcn_fa7_temp (r020)
values ('3578');

----------------------------------------------------------------------
----- обработка остатков
OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs1_, r011_, r013_, k072_,
                    Ostn_, Ostq_, Dos96_, Kos96_, Dosq96_, Kosq96_,
                    Dos99_, Kos99_, Dosq99_, Kosq99_,
                    Doszg_, Koszg_, isp_, tobo_, nms_, tip_, s130_, country_, ob22_,
                    nd_, freq_;
   EXIT WHEN SALDO%NOTFOUND;

   if substr(nbs1_,1,3) = '290' OR nbs1_ in ('2920', '2924', '3648')
   then
      r011_ := '0';
   end if;

   comm_ := 'R011=' || r011_ || '   R013='||r013_;
   nd_:=null;

   --- обороты по перекрытию 6,7 классов на 5040,5041
   IF to_char(Dat_,'MM')='12' and (nls_ like '6%' or nls_ like '7%' or nls_ like '504%') THEN
    SELECT NVL(SUM(decode(dk,0,1,0)*s),0),
                    NVL(SUM(decode(dk,1,1,0)*s),0)
             INTO d_sum_, k_sum_
             FROM opldok
             WHERE fdat  between Dat_  AND Dat_+29 AND
                   acc  = acc_   AND
                   (tt like 'ZG8%'  or tt like 'ZG9%');
      Dos96_:=Dos96_-d_sum_;
      Kos96_:=Kos96_-k_sum_;
   END IF;

   IF Dos99_ > 0 THEN
      BEGIN
        select NVL(sum(s),0)
           into sk_
        from kor_prov
        where vob=99
          and dk=0
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Dos96_ := Dos96_ - sk_;
   END IF;

   IF Kos99_ > 0 THEN
      BEGIN
        select NVL(sum(s),0)
           into sk_
        from kor_prov
        where vob=99
          and dk=1
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Kos96_ := Kos96_ - sk_;
   END IF;

   IF Dosq99_ > 0 THEN
      BEGIN
        select NVL( sum(gl.p_icurval(kv_, s, vdat)), 0)
           into sk_
        from kor_prov
        where vob=99
          and dk=0
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Dosq96_ := Dosq96_ - sk_;
   END IF;

   IF Kosq99_ > 0 THEN
      BEGIN
        select NVL( sum(gl.p_icurval(kv_, s, vdat)), 0)
           into sk_
        from kor_prov
        where vob=99
          and dk=1
          and acc=acc_
          and fdat between Dat_+1 and Dat_+28;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sk_ := 0;
      END;
      Kosq96_ := Kosq96_ - sk_;
   END IF;

   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   if nbs1_ = '3579' then
      r013_ := '0';
   end if;

   IF se_<>0 THEN
      if typ_ > 0 then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;
      comm_ := '';
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      BEGIN
         SELECT DECODE(Trim(s180), NULL, Fs180(acc_,SUBSTR(nbs1_,1,1), dat_), s180)
            INTO s180_
         FROM specparam
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         s180_:='0';
      END ;

      IF nbs1_ in ('1819','2900','2901','2902','2903','2905','2909','3579') and
           (s180_ is NULL OR s180_='0') THEN
         s180_:='1';
      END IF;

      if substr(nbs1_,1,1) in ('6','7') then
         S180_:='1';
      end if;

      if nbs1_ in ('3340','3346','3347','3348') THEN
         S180_:='1';
      end if;

-- с 01.02.2007 добавляется параметр S183
      BEGIN
         SELECT NVL(s183,'0')
         INTO S183_
         FROM kl_s180
         WHERE s180=s180_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         s183_:='0';
      END ;

      if nbs1_ in ('3300','3301','3305','3306','3307','3308','3320',
                   '3326','3327','3328') then
         s183_:='B';
      end if;

      if nbs1_ in ('2805','2809','2924','2510','3519','3550','3551','3552','3559','3570','3578')  and s183_ = '0'
      then
         s183_:='1';
      end if;

      dk_:=IIF_N(se_,0,'1','2','2');

      -- Счет начисленных процентов?
      BEGIN
         SELECT 1 INTO fa7p_
         FROM otcn_fa7_temp
         WHERE r020 = nbs1_ and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         fa7p_ := 0;
      END;

      -- счета начисленных процентов
      IF dat_ < dat_Izm1 and fa7p_ > 0 and se_ < 0
      THEN

         freq_:= NULL;

         if nbs1_ = '3579' then
            if Dat_ <= to_date('30112012','ddmmyyyy') then
               select (-1)*nvl(sum(dos),0)
                  into dos_
               from saldoa
               where acc=acc_ and
                     fdat between (Dat_-31)+1 and Dat_;

               IF kv_ <> 980 THEN
                  dose_:=GL.P_ICURVAL(kv_, dos_, Dat_) ;
               ELSE
                  dose_:=dos_ ;
               END IF;

               if abs(se_) > abs(dose_) then
                  comm_ := comm_ || ' розбивка залишку';

                  IF dose_<>0 THEN
                     dk_:=IIF_N(dose_,0,'1','2','2');
                     r013_:='1';
                     p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
                           k072_, s183_, s130_, country_, TO_CHAR(ABS(dose_)), isp_, nbuc_);
                  END IF;

                  se_ := se_ - dose_;
                  r013_ := '2';
               else
                  if r013_='0' then
                     r013_ := '1';
                     comm_ := comm_ || ' замiна R013';
                  end if;
               end if;
            else
               r013_ := '0';
            end if;
         else
            if (not (322498 IN (mfo_, mfou_)) and nvl(freq_, 400) = 5) or
                  (322498 IN (mfo_, mfou_) and nvl(r013_, '0') = '3') then
               if r013_ in ('0','1', '2') then
                  r013_ := '3';
                  comm_ := comm_ || ' замiна R013';
               end if;
            else
               IF typ_ > 0 THEN
                  nbuc_ := NVL (F_Codobl_Tobo (acc_, typ_), nbuc1_);
               ELSE
                  nbuc_ := nbuc1_;
               END IF;

               p_analiz_r013_new (mfo_,
                              mfou_,
                              dat_,
                              acc_,
                              tip_,
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
                  r013_ := '3';
                  p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
                        k072_, s183_, s130_, country_, TO_CHAR(ABS(o_se_1)), isp_, nbuc_);

                  se_ := se_ - o_se_1;
               END IF;

               -- свыше 30 дней
               IF o_se_2 <> 0
               THEN
                  r013_ := '4';
                  p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
                        k072_, s183_, s130_, country_, TO_CHAR(ABS(o_se_2)), isp_, nbuc_);

                  se_ := se_ - o_se_2;
               END IF;
            END IF;

         end if;
      end if;

      dk_:=IIF_N(se_,0,'1','2','2');
      if se_ <> 0 then
         p_ins(data_, dk_, rnk_, nls_, nbs1_, kv_, r011_, r013_,
               k072_, s183_, s130_, country_, TO_CHAR(ABS(se_)), isp_, nbuc_);
      end if;
   END IF;

END LOOP;
CLOSE SALDO;

update rnbu_trace set kodp = substr(kodp,1,12) || '1' || substr(kodp,14)
where substr(kodp,13,1)='0';

update rnbu_trace set kodp = substr(kodp,1,6) || '42' || substr(kodp,9,10)
where substr(kodp,2,4) in ('3653','3658')
and substr(kodp,7,2)='00'
and substr(kodp,9,1)='1';

update rnbu_trace set kodp = substr(kodp,1,6) || '42' || substr(kodp,9,10)
where substr(kodp,2,3) in ('355','605','606','610','611','704')
and substr(kodp,7,2)='00'
and substr(kodp,9,1)='1';

-- блок для заміни параметру K072 для від'ємних значень показника

for z in ( select kodp, sum(znap)
           from bars.rnbu_trace
           where substr(kodp,2,1) in ('6','7')
           group by kodp
           having sum(znap) < 0
         )
     loop

        for k in ( select r1.*
                   from rnbu_trace r1
                   where r1.kodp = z.kodp
                 )
            loop

               begin
                  select kodp
                     into kodp_
                  from rnbu_trace
                  where znap = ( select max(znap)
                                 from rnbu_trace
                                 where kodp like substr(z.kodp,1,6)||'__'||substr(z.kodp,9)||'%'
                                   and substr(kodp,7,2) <> substr(z.kodp,7,2)
                               )
                    and rownum =1;

                  if k.znap < 0
                  then
                     update rnbu_trace r set r.kodp = substr(z.kodp,1,6) || substr(kodp_,7,2) || substr(z.kodp,9),
                                             r.comm = substr(k.comm || 'заміна K072 з ' || substr(z.kodp,7,2) || ' на ' || substr(kodp_,7,2), 1,200)
                     where r.recid = k.recid;
                  end if;
               exception when no_data_found then
                  null;
               end;

        end loop;
end loop;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------

INSERT INTO tmp_nbu(kodf, datf, kodp, znap, nbuc)
SELECT kodf_, Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
WHERE substr(kodp,2,4) not in ('3500','3600')
GROUP BY kodf_, Dat_, kodp, nbuc;

logger.info ('P_F08_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------
END p_f08_NN;
/
show err;

PROMPT *** Create  grants  P_F08_NN ***
grant EXECUTE                                                                on P_F08_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F08_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
