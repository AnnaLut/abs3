

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FB8.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FB8 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FB8 (Dat_ DATE, add_sql_ in varchar2 default null)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #B8 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 09/02/2012 (08.11.2011)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
09.02.2012 приведение в соответствие В8 и инвентаризации
08.11.2011 в поле комментарий вносим код TOBO и название счета
22.07.2011 в поле COMM (комментарий) добавил наименование счета
05.07.2011 не выбирался s370 из SPECPARAM (поправила)
04.04.2011 для Ровно СБ будем расчитывать параметр R013.
04/02/2011 для бал.сч. 2607,2627,3570 будет выполняться расчет параметра S270
03/02/2011 для 1590,1592,2400 параметр S370 всегда будет '0'
           добавил бал.сч. 2607,2627,3570 в блок обработки счетов начисленных
           процентов substr(nbs_,4,1)='8' т.к. они включаются в файл
05/09/2010 убрала ссылку на s370 из SPECPARAM
03/09/2010 убрала замены параметра S270 '08' на'07'
03/09/2010 убрала замены параметра S270 '08' на'07'
30/08/2010 ввела фукцию расчета парамеьра S370
04.08.2010 сумма оборотов для счетов просроченных процентов от 31 до 60 дней
           накапливалась не в эквиваленте а в номинале. Исправлено.
03.08.2010 если заполнен параметр S270(!='00') то не определялся номер
           договора из кредитного портфеля для данного ACC счета
30.07.2010 с 01.08.2010 изменена структура показателя файла (добавлен пара-
           метр S370). Добавлено формирование данного параметра.
04.03.2010 Неправильно берется идентификатор пользователя, который формировал
           резерв (нужно брать из tmp_rez_protokol)
17.09.2009 Доработка для Сбербанка Ровно: если на счете не заполнен параметр
           S270, то его нужно рассчитать (тоже самое будет в расчете резервов)
09.09.2009 1) изменение расчета параметра S270 (ввела функцию как в F8)
           2) прирасчете остатка в валюте на предыдущие даты для определения
           когда он возник, эквивалент считался по курсу на пред. дату.
           Из-за большой разницы курсов неправильно формировался разрез
           по параметру R013.
           3) для Демарка S270 - для просрочки менять 8 на 7 НЕ НУЖНО !
09.04.2009 для счетов просроченных процентов не формировался параметр R013='1'
           если R013='0' при остатке на счете звiтна дата-31 больше остатка
           на счете на отчетную дату
08.04.2009 некоторые изменения вычиселния параметра S270
27.03.2009 изменил условие "c.sdate < Dat_" на
           "Dat_ between c.sdate and c.wdate".
26.03.2009 будем определять параметр S270 следующим образом:
           - если нет счета просрочки (2067,2077,2087,2207,2217 ...)
             то S270='01'
           - если есть счет просрочки то от отчетной даты определяем дату
             того Дт оборота, который будет превышать или равняться остатку
             на счете просрочки и определяем разницу дат (отчетная дата
             минус дата оборота)
11.02.2009 для счетов начисленных процентов 2068,2078,2208 ...
           будем формировать S270='01'
10.02.2009 для СБ (300465) будут включаться все счета 1590,1592,2400
           с различными R013 для остальных с R013='3'.
           Для 2209,3578,3579 будет определяться S270 от MAX даты
           начисления
05.02.2009 при формировании файла не включался бал.счет 1592(R013='3').
           Добавлено.
04.02.2009 изменил алгоритм разбивки остатка счетов просроченных %% по
           параметру R013.
03.02.2009 для счетов начисленных процентов не формировался код остатка
           первый символ в показателе. Исправлено.
30.01.2009 добавляется формирование параметра S270 код строку погашення
           основного боргу
01.02.2008 так как НБУ не поддерживает заполнение поля F_B8 в классифи-
           каторе KL_R020, а перечень бал.счетов включаемых в файл
           имеется в KOD_R020, то будем использовать KOD_R020 вместо
           KL_R020
12.02.2008 выполняется разбивка остатка по параметру R013
           (R013='1' остаток до 31 дня и R013='2' больше 31 дня)
           если в таблице PARAMS имеется строка PAR='RZPRR013'
           и VAL=0 или данная строка отсутствует в табл. PARAMS
           в остальных случаях используем спецпараметр счета R013 из
           SPECPARAM.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_     varchar2(2):='B8';
flag_     number;
typ_      number;
acc_      number;
acc1_     number;
acc_p     number;
nbs_      varchar2(4);
nbs1_     varchar2(4);
nls_      varchar2(15);
rnk_      Number;
isp_      Number;
data_     date;
dat1_     date;
dat2_     date;
wdate_    date;
wdate1_   date;
wdate2_   date;
kv_       SMALLINT;
Ost_      NUMBER;
Ostn_     DECIMAL(24);
Ostq_     DECIMAL(24);
Dos96_    DECIMAL(24);
Dosq96_   DECIMAL(24);
Kos96_    DECIMAL(24);
Kosq96_   DECIMAL(24);
se_       DECIMAL(24);
ost_p     DECIMAL(24);
Dos_      DECIMAL(24);
dk_       char(1);
kodp_     varchar2(20);
znap_     varchar2(30);
r013_     char(1);
s270_     varchar2(2);
s270_r    varchar2(2) := '00';
s270_p    varchar2(2);
s_        char(1);
r_        char(1);
userid_   number;
userid_r  number;
dat_r     date;
nms_      otcn_acc.nms%TYPE;
comm_     varchar2(500);
mfo_      NUMBER;
mfou_     NUMBER;
nbuc1_    varchar2(12);
nbuc_     varchar2(12);
DatN_     date;
sql_acc_  varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_      number;
sr013_    number;
sr013_60  number;
rzprr013_ number;
nd1_      number;
s370_     varchar2(1);
s370_r    varchar2(1) := '0';
s370_p    varchar2(1);
tobo_     accounts.tobo%TYPE;

nd_        NUMBER;
-- ДО 30 ДНЕЙ
o_r013_1   VARCHAR2 (1);
o_se_1     DECIMAL (24);
o_comm_1   rnbu_trace.comm%TYPE;
-- ПОСЛЕ 30 ДНЕЙ
o_r013_2   VARCHAR2 (1);
o_se_2     DECIMAL (24);
o_comm_2   rnbu_trace.comm%TYPE;
ob22_      varchar2 (1) := '0';
zamena_08_07_p boolean := true;


CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs,
          NVL(trim(cc.r013),'0'), NVL(trim(cc.s270),'00'),
          NVL(trim(cc.s370),'0'),
          s.ost, s.ostq, s.dos96, s.kos96, s.dosq96, s.kosq96, a.isp, a.tobo, a.nms
   FROM  otcn_saldo s, specparam cc, otcn_acc a
   WHERE s.acc=a.acc
     and s.acc=cc.acc(+) ;

CURSOR BaseL IS
    SELECT kodp,nbuc,SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp,nbuc;
-----------------------------------------------------------------------------
--- процедура формирования протокола
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_rnk_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_kv_ smallint, p_r013_ varchar2,
                p_s270_ varchar2, p_s370_ varchar2, p_znap_ varchar2,
                p_isp_ number) IS
                kod_ varchar2(11);

begin

   s370_r := p_s370_;

   if to_number(p_znap_) <> 0 then
      if Dat_ >= to_date('30012009','ddmmyyyy') then
            kod_:= p_tp_ || p_nbs_ || p_r013_ || p_s270_ || s370_r;
      else
         kod_:= p_tp_ || p_nbs_ || p_r013_ ;
      end if;

      INSERT INTO rnbu_trace
              (nls, kv, odate, kodp, znap, nbuc, rnk, isp, comm, nd, acc)
      VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, '0', rnk_, isp_, substr(comm_,1,200), nd_, acc_ );
   end if;

end;
-----------------------------------
procedure p_dbms(put_ in varchar2) is
begin
       dbms_output.put_line(put_);
end;

----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
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

-- вместо классификатора KL_R020 будем использовать KOD_R020
if add_sql_ is null then
    sql_acc_ := 'select r020 from kod_r020 where prem=''КБ '' and a010=''B8'' and d_close is null ';

    ret_ := f_pop_otcn(Dat_, 2, sql_acc_);
else --- для отладки
    sql_acc_ := 'select * from accounts where '||add_sql_;
    ret_ := f_pop_otcn_n(Dat_, 2, sql_acc_);
end if;

ob22_ := NVL(trim(getglobaloption('OB22')),'0');

BEGIN
   SELECT TO_NUMBER (NVL (val, '0'))
      INTO rzprr013_
   FROM params
   WHERE par = 'RZPRR013';
EXCEPTION WHEN NO_DATA_FOUND THEN
   rzprr013_ := '0';
END;

BEGIN
  SELECT userid, dat
    INTO userid_r, dat_r
    FROM rez_protocol
   WHERE dat = dat_;
exception
    when no_data_found then
        begin
            select p.id, p.dat
            INTO userid_r, dat_r
            from rez_form p
            where p.dat = dat_ and
                  p.DAT_FORM =  (select max(DAT_FORM)
                                 from rez_form
                                 where dat = dat_);

    exception
        when no_data_found then
            userid_r := userid_;
            dat_r := dat_;
            rez.rez_risk (userid_, dat_);
    end;
end;

-- Демарк утверждает, что для просрочки менять S270=08 на 07 НЕ НУЖНО !
if mfou_=353575 or
   ob22_ <> '0' -- для Ровно тоже не нужно
then
   zamena_08_07_p := false;
end if;
----------------------------------------------------------------------
----- обработка остатков
OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, acc_, nls_, kv_, data_, nbs_, r013_, s270_, s370_,
                    Ostn_, Ostq_, Dos96_, Kos96_, Dosq96_, Kosq96_, isp_, tobo_, nms_ ;
   EXIT WHEN SALDO%NOTFOUND;

   if typ_>0 then  --sheme_ = 'G' and (tips_<>'T00' and tips_<>'T0D') and typ_>0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;


   IF kv_ <> 980 THEN
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   comm_ := '';
   s270_r := '00'; -- просто обнуляем
   s270_p := '00'; -- просто обнуляем
   nd_ := null;

   comm_ := substr(comm_||tobo_||'  '||nms_||'  '||'R013='||r013_||' S270='||s270_||' S370='||s370_,1,200);

   if se_ <> 0 then
       s270_r := nvl(trim(f_get_rez_specparam( 's270', acc_, dat_r, userid_r)),'00');
       comm_ := comm_||' S270r1='||s270_r;

       if s270_r <> s270_ and s270_r <> '00' then
          s270_ := s270_r;
       end if;

       s370_r := nvl(trim(f_get_rez_specparam( 's370', acc_, dat_r, userid_r)),'0');
       comm_ := comm_||' S370r1='||s370_r;

       if s370_r <> s370_ and s370_r <> '0' then
          s370_ := s370_r;
       end if;

       -- для рахункiв нарахованих доходiв та прострочених нарахованих доходiв
       if dat_>=to_date('30012009','ddmmyyyy') and
          (substr(nbs_,4,1) in ('8','9') or nbs_ in ('2607','2627','3570')) and s270_='00'
       then
          s270_r := f_get_s270(dat_, s270_, acc_, nd_);
          comm_ := SUBSTR(comm_||' S270r='||s270_r,1,200);
       end if;

       if dat_>=to_date('30012009','ddmmyyyy') and
          substr(nbs_,4,1) in ('8','9') and trim(s270_) != '00' then

          begin
             SELECT MAX (p.nd)
                into nd_
             FROM nd_acc a, cc_deal p
             WHERE a.acc = acc_
               and a.nd = p.nd
               and p.sdate <= dat_;
          exception
              when no_data_found then
             nd_ := null;
          end;
       end if;

       -- т.к. счета начисленных %% занесены в портфель, а остальные нет
       -- то параметр S370 для них не заполняется по максимальному значению
       -- счета просроченных %%
       if mfo_ = 300465 then
          nd_ := null;
       end if;

       s370_ := f_get_s370(dat_, s370_, acc_, nd_);
       comm_ := comm_||' S370r2='||s370_;

       dk_ := iif_n (se_, 0, '1', '2', '2');

       -- счета начисленных процентов по межбанку
       if dat_>=to_date('30012009','ddmmyyyy') and nbs_ in ('1518','1528') then
          BEGIN
             select a.nbs
                into nbs1_
             from accounts a, int_accn i
             where i.acra=acc_
               and i.acc=a.acc
               and i.ID=0
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

       comm_ := SUBSTR(comm_ || ' R013(1)=' || r013_,1,200) ;

       -- счета начисленных процентов
       IF dat_>=to_date('30012009','ddmmyyyy') and
          (substr(nbs_,4,1) = '8' OR nbs_ in ('2607','2627','3570')) THEN
          if mfo_ not in (300465) then
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

             -- т.к. счета начисленных %% занесены в портфель, а остальные нет
             -- то параметр S370 для них не заполняется по максимальному значению
             -- счета просроченных %%
             if mfo_ = 300465 then
                nd_ := null;
             end if;

             -- до 30 дней
             IF o_se_1 <> 0
             THEN
                if s270_ not in ('01','07','08') and s270_r in ('01','07','08') then
                   s270_ := s270_r;
                end if;

                IF dat_ >= TO_DATE ('30012009', 'ddmmyyyy')
                THEN
                   IF dat_ > TO_DATE('30062010','ddmmyyyy')
                   THEN
                      kodp_ := dk_ || nbs_ || o_r013_1 || s270_ || s370_;
                   else
                      kodp_ := dk_ || nbs_ || o_r013_1 || s270_;
                   END IF;
                ELSE
                   kodp_ := dk_ || nbs_ || o_r013_1;
                END IF;

                znap_ := TO_CHAR (ABS (o_se_1));

                INSERT INTO rnbu_trace
                            (nls, kv, odate, kodp, znap, nbuc, rnk, isp,
                             comm, nd, acc
                            )
                     VALUES (nls_, kv_, data_, kodp_, znap_, '0', rnk_, isp_,
                             SUBSTR(comm_ || o_comm_1,1,200), nd_, acc_
                            );
             END IF;

             -- свыше 30 дней
             IF o_se_2 <> 0
             THEN
                if s270_ not in ('01','07','08') and s270_r in ('01','07','08') then
                   s270_ := s270_r;
                end if;

                IF dat_ >= TO_DATE ('30012009', 'ddmmyyyy')
                THEN
                   IF dat_ > TO_DATE('30062010','ddmmyyyy')
                   THEN
                      kodp_ := dk_ || nbs_ || o_r013_2 || s270_ || s370_;
                   else
                      kodp_ := dk_ || nbs_ || o_r013_2 || s270_;
                   END IF;
                ELSE
                   kodp_ := dk_ || nbs_ || o_r013_2;
                END IF;

                znap_ := TO_CHAR (ABS (o_se_2));

                INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, rnk, isp,
                            comm, nd, acc
                            )
                     VALUES (nls_, kv_, data_, kodp_, znap_, '0', rnk_, isp_,
                             SUBSTR(comm_ || o_comm_2,1,200), nd_, acc_
                            );
             END IF;
          else
             if se_ <> 0 then
                if /*ob22_='0' and*/ s270_ not in ('01','07','08') and s270_r in ('01','07','08') then
                   s270_ := s270_r;
                end if;

                IF dat_ >= TO_DATE ('30012009', 'ddmmyyyy')
                THEN
                   IF dat_ > TO_DATE('30062010','ddmmyyyy')
                   THEN
                      kodp_ := dk_ || nbs_ || r013_ || s270_ || s370_;
                   else
                      kodp_ := dk_ || nbs_ || r013_ || s270_;
                   END IF;
                ELSE
                   kodp_ := dk_ || nbs_ || r013_;
                END IF;

                znap_ := TO_CHAR (ABS (se_));

                INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp, znap, nbuc, rnk, isp,
                            comm, nd, acc
                            )
                     VALUES (nls_, kv_, data_, kodp_, znap_, '0', rnk_, isp_,
                             substr(comm_,1,200), nd_, acc_
                            );
             end if;

          end if;

       END IF;

       -- рахунки прострочених нарахованих доходiв
       if substr(nbs_,4,1) = '9' then
          if mfou_ = 353575 then -- у банка Демарк не считают резервы автоматически, но разбивать остаток нужно
             flag_ := 1;
          else
              if userid_r is not null then
                  select count(*)
                     into flag_
                  from tmp_rez_risk
                  where dat=Dat_
                    and id=userid_r
                    and acc=acc_;
              else
                  flag_ := 1;
              end if;
          end if;

          if rzprr013_ = '0' then
             sr013_:=gl.p_icurval(kv_,otcn_pkg.f_GET_R013(acc_,dat_),dat_);
             comm_ := substr(comm_ ||' сума залишку ='||to_char(ABS(se_)) ||
                      ' сума залишку зв.дата-31 ='||to_char(ABS(sr013_)),1,200);
          else
             sr013_:=0;
          end if;

          ost_ := 0;

          -- вычисляем сумму Дт оборотов с dat_-60 до dat_-31 (29 дней)
          SELECT NVL (SUM (o.s), 0)
             INTO ost_
          FROM opldok o, oper p, ref_back r
          WHERE o.acc = acc_
            AND o.fdat > dat_ - 60
            AND o.fdat <= dat_ - 31
            AND o.sos = 5
            AND o.dk = 0
            AND p.REF = o.REF
            and p.REF = r.ref(+)
            --исключаем операцию СТОРНО
            and o.tt <> 'BAK'
            --исключаем проводку которая была СТОРНИРОВАНА, если дата сторнирования меньше отчетной
            and nvl(r.dt,to_date('01014000','ddmmyyyy')) >  dat_ ;

          ost_ := gl.p_icurval(kv_, ost_, Dat_);

          p_dbms('sr013='||to_char(sr013_));

          IF r013_ in ('0','1') and se_ <> 0 and sr013_ < 0 and
             abs(sr013_)<abs(se_)
          THEN
             if s270_='00' and s270_r in ('01','07','08') then
                s270_ := s270_r;
             end if;

             -- виконуємо розбивку по R013 при наявностi в TMP_REZ_RISK
             if flag_ > 0 then
                dk_:=IIF_N(se_,0,'1','2','2');
                dat1_ := dat_ - 29;

                sr013_60 := se_ + (abs(se_)-abs(sr013_)) + ost_;

                if se_<>0 and sr013_60 <> 0 and sr013_60 < 0 and
                   abs(sr013_60) < abs(sr013_)
                THEN
                   comm_ := comm_ || ' сума залишку зв.дата-(32-60) ='||to_char(ABS(sr013_60));
                   s270_p := s270_;

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, s370_, TO_CHAR(abs(sr013_60)), isp_);
                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, s370_, TO_CHAR(abs(sr013_)-abs(sr013_60)), isp_);

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, s370_, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
                end if;

                if ABS(sr013_)-ABS(sr013_60)=0 and sr013_60<>0 and sr013_60<0 then
                   s270_p := s270_;

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, s370_, TO_CHAR(abs(sr013_)), isp_);

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, s370_, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
                end if;

                if ABS(sr013_)-ABS(sr013_60)<0 and sr013_60<>0 and sr013_60<0 then
                   s270_p := s270_;

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, s370_, TO_CHAR(abs(sr013_)), isp_);

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, s370_, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
                end if;

                if sr013_60 >= 0 then
                   s270_p := s270_;

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, s370_, TO_CHAR(abs(sr013_)), isp_);

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '1', s270_p, s370_, TO_CHAR(abs(se_)-abs(sr013_)), isp_);
                end if;
             else
                p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, r013_, s270_, s370_, TO_CHAR(abs(se_)), isp_);
             end if;
          elsif se_<>0 THEN
             dk_:=IIF_N(se_,0,'1','2','2');

             if s270_ in ('01','07','08') then
                s270_p := s270_;
             end if;

             if s270_ = '00' and s270_r in ('01','07','08') then
                s270_p := s270_r;
             end if;

             if r013_ in ('0','1','2') and ABS(se_)=ABS(sr013_) and sr013_<>0 and
                sr013_ < 0
             then
                dat1_ := dat_ - 29;

                sr013_60 := se_ + (abs(se_)-abs(sr013_)) + ost_;

                if se_<>0 and sr013_60 < 0 and abs(sr013_60) < abs(sr013_) THEN
                   comm_ := substr(comm_ || ' сума залишку зв.дата-(32-60) ='||to_char(ABS(sr013_60)),1,200);

                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, s370_, TO_CHAR(abs(sr013_60)), isp_);
                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, s370_, TO_CHAR(abs(sr013_)-abs(sr013_60)), isp_);
                end if;

                if se_<>0 and sr013_60 < 0 and abs(sr013_60) > abs(sr013_) THEN
                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, s370_, TO_CHAR(abs(sr013_)), isp_);
                end if;

                if se_<>0 and sr013_60 < 0 and abs(sr013_60) = abs(sr013_) THEN
                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '3', s270_p, s370_, TO_CHAR(abs(sr013_)), isp_);
                end if;

                if se_<>0 and sr013_60 >= 0 THEN
                   p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, '2', s270_p, s370_, TO_CHAR(abs(sr013_)), isp_);
                end if;
             else
                if r013_ = '0' then
                   r013_ := '1';
                end if;
                p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, r013_, s270_p, s370_, TO_CHAR(ABS(se_)), isp_);
             end if;

          END IF;
       end if;

       if dat_>=to_date('30012009','ddmmyyyy') then
          if nbs_ in ('1590','1592','2400') then
             dk_:=IIF_N(se_,0,'1','2','2');
             p_ins(data_, dk_, rnk_, nls_, nbs_, kv_, r013_, s270_, '0', TO_CHAR(ABS(se_)), isp_);
          end if;
       end if;
   end if;
END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
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
----------------------------------------
END p_fb8;
/
show err;

PROMPT *** Create  grants  P_FB8 ***
grant EXECUTE                                                                on P_FB8           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FB8           to RCC_DEAL;
grant EXECUTE                                                                on P_FB8           to RPBN002;
grant EXECUTE                                                                on P_FB8           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FB8.sql =========*** End *** ===
PROMPT ===================================================================================== 
