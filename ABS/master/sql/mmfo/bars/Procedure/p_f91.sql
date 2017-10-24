

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F91.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F91 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F91 (dat_ DATE, tp_ number default 0) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования файла #91 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 17.11.2010 (07.10.2010)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  tp_ = 0 - формирование файла отчетности #91, 1 - кат.запрос
%  tp_ = 1 - кат.запрос ""Розшифровка для 91 файлу"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 17.11.2010 внесла изменения для формирование каталогизиролванного отчета
%            по расшифровке для 91 файла
% 07.10.2010 для банка Столица изменил формирование кода 08...........
% 28.09.2010 для банка Столица будем формировать общую сумму остатка
%            по коду ОКПО вместо RNK
% 27.01.2010 для облуправлений СБ берем RNKP вместо RNK
%            для ОПЕРУ СБ и всех остальных банков берем RNK
% 23.10.2009 для Житомир ОБ (311647) код контрагента формуємо так як для
%            МФО 300465
% 24.09.2009 для Луцьк ОБ (303398) код контрагента формуємо так як для
%            МФО 300465
% 17.03.2009 для Рiвне ОБ (333368) код контрагента формуємо так як для
%            МФО 300465
% 28.11.2008 будет выполняться разбивка остатка на неснижаемый с кодом
%            строка S240#1 и остальная сумма с кодом строка S240='1'
% c 04.07.2008 эта версия только для банка КИЕВ (добавлена таблица
%                                                TMP_FILEE8)
% 04.07.2008 для банка УПБ закомментировал блок обработки бал.счетов
%            2625, 2630, 2635 и вычитание данной суммы из общей суммы
%            обязательств по контрагенту
% 14.04.2008 для исключения RNK из обработки по табл.KF91 выполняем
%            в курсорах SALDO, SALDO1, а не при обработке данных из них
% 11.04.2008 для исключения RNK из обработки по табл.KF91 дополнительно
%            проверяем бал счета (должны включаться в данный файл)
% 04.02.2008 так как НБУ не поддерживает заполнение поля F_91 в классифи-
%            каторе KL_R020, а перечень бал.счетов включаемых в файл
%            имеется в KOD_R020, то будем использовать KOD_R020 вместо
%            KL_R020
% 24.05.2007 для СБ берем RNKP вместо RNK (для клиента банка Энергорынок)
% 05.10.2006 формируем в табл.OTCN_LOG следующие данные о кредиторах
%            наименование+ОКРО+бал.счет+валюта+Остаток
% 21.09.2006 по служебной записке Сбербанка от 13.09.2006
%            для бал.счета 2651 S240='1-B', 2652 S240='1-H'
% 08.09.2006 для бал.счетов групп 260, 262 по умолчанию S240='1' (Демарк)
% 24.01.2006 выполнены изменения для Демарка (включаются бал.сч. 8021,8022)
%            бал.сч. 8021 консолидированный 2620, 8022 консолидированный 2625)
% 05.12.2005 выполнены изменения для Сбербанка по служебной записке
%            N 14/2-1542 (доп.условия для "DD"='07' и для кода "L" -
             ознака кредитора)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   VARCHAR2(2) := '91';
nls_     VARCHAR2(15);
nbs_     VARCHAR2(4);
sab_     VARCHAR2(3);
data_    DATE;
kv_      SMALLINT;
dat1_    DATE;
rnk_     NUMBER;
rnk1_    NUMBER;
rnk2_    NUMBER;
acc_     NUMBER;
se_      DECIMAL(24);
Oste_    DECIMAL(24);
s04_     NUMBER;
na_      NUMBER;
pna_     CHAR(2);
nmk_     VARCHAR2(70);
adr_     VARCHAR2(70);
okpo_    VARCHAR2(14);
Kod_a    NUMBER;
Kod_a1   NUMBER;
Cntr_    VARCHAR2(1);
mfo_     NUMBER;  --VARCHAR2(12);
mfou_    NUMBER;
country_ NUMBER;
s180_    VARCHAR2(1);
s240_    VARCHAR2(1);
s242_    VARCHAR2 (1);
x_       VARCHAR2 (1);
dk_      VARCHAR2(2);
f91_     NUMBER;
kol_     NUMBER;
kodp_    VARCHAR2(12);
znap_    VARCHAR2(70);
userid_  NUMBER;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	 number;
datn_    DATE;
mdate_   DATE;
sdate_   DATE;
dc_      NUMBER;
min_sum_ NUMBER;

--Остатки
CURSOR SALDO IS
   SELECT
--         c.rnk,
--      DECODE(f_ourmfo, 300465, c.rnk,
--                       DECODE(mfou_, 300465, DECODE(c.rnkp, NULL, c.rnk, c.rnkp),
--                       c.rnk)) RNK,
      (case mfou_ when 300465 then DECODE(mfou_, mfo_, c.rnk, DECODE(c.rnkp, NULL, c.rnk, c.rnkp))
                  when 380623 then DECODE(trim(c.okpo), '000000000', c.rnk, to_number(trim(c.okpo)))  --DECODE(c.rnkp, NULL, c.rnk, c.rnkp)
                  else c.rnk end) RNK,
      c.codcagent CODCAGENT,
      SUM(a.ostf) OST
   FROM (SELECT s.acc, s.kv, s.fdat, s.nbs, DECODE(s.kv,980,s.ost,s.ostq) OSTF
         FROM otcn_saldo s
         WHERE ((s.nbs NOT IN ('1500','2600','2605','2620','2625','2650','2655') AND
                 s.ost+s.ostq<>0) OR
                (s.nbs IN ('1500','2600','2605','2620','2625','2650','2655') AND
                 s.ost+s.ostq>0))
           and (s.nls,s.kv) not in (SELECT nls,kv
                                    FROM kf91
                                    where substr(nls,1,4) in (select r020
                                                              from kod_r020
                                                              where prem='КБ '
                                                              and a010='91'))
         UNION ALL
         SELECT /*+index(s)*/
 		aa.acc, s.kv, aa.fdat, s.nbs,
                Gl.P_Icurval(s.kv, aa.ostf-aa.dos+aa.kos, Dat_) OSTF
         FROM saldoa aa, accounts s
         WHERE (s.nbs in ('8021','8022') AND aa.ostf-aa.dos+aa.kos>0 AND
                f_ourmfo=353575) AND
               aa.acc=s.acc      AND
               (s.acc,aa.fdat) =
                (SELECT c.acc,MAX(c.fdat)
                 FROM saldoa c
                 WHERE s.acc=c.acc AND c.fdat <= Dat_
                 GROUP BY c.acc) ) a,
         customer c, cust_acc ca
   WHERE a.acc=ca.acc            AND
         c.rnk=ca.rnk
   GROUP BY
--            c.rnk,
--            DECODE(f_ourmfo, 300465, c.rnk,
--                       DECODE(mfou_, 300465, DECODE(c.rnkp, NULL, c.rnk, c.rnkp),
--                       c.rnk)),
      (case mfou_ when 300465 then DECODE(mfou_, mfo_, c.rnk, DECODE(c.rnkp, NULL, c.rnk, c.rnkp))
                  when 380623 then DECODE(trim(c.okpo), '000000000', c.rnk, to_number(trim(c.okpo)))  --DECODE(c.rnkp, NULL, c.rnk, c.rnkp)
                  else c.rnk end),
--            DECODE(mfou_, 300465, DECODE(c.rnkp, NULL, c.rnk, c.rnkp),
--                                     DECODE(f_ourmfo, 303398, DECODE(c.rnkp, NULL, c.rnk, c.rnkp),c.rnk)),
            c.codcagent

--   UNION
--   SELECT to_number(trim(c.idn_podatk)) RNK,
--          5 CODCAGENT,
--          SUM(c.suma+c.proc_nar) OST
--   FROM tmp_fileE8 c
--   WHERE trim(c.ar_vkl) IS NOT NULL
--     AND c.kod_val IS NOT NULL
--     AND SUBSTR(trim(c.ar_vkl), 1, 4) in (select r020
--                                          from kod_r020
--                                          where prem='КБ '
--                                            and a010='91')
--     AND c.suma+c.proc_nar  <> 0
--     GROUP BY trim(c.idn_podatk), 5
   ORDER BY 3 DESC;

CURSOR SALDO1 IS
   SELECT  a.acc, a.nls, a.kv, a.fdat, a.nbs, MOD(c.codcagent,2),
           c.rnk, c.nmk, c.okpo, c.country,
           a.ostf
   FROM (SELECT s.acc, s.nls, s.kv, s.fdat, s.nbs,
                DECODE(s.kv,980,s.ost,s.ostq) OSTF, s.rnk
         FROM otcn_saldo s, customer c
         WHERE s.rnk=c.rnk and
               DECODE(f_ourmfo, 300465, c.rnk,
                      DECODE(mfou_, 380623, DECODE(trim(c.okpo), '000000000', c.rnk, to_number(trim(c.okpo))), --DECODE(c.rnkp, NULL, c.rnk, c.rnkp),
                       DECODE(mfou_, 300465, DECODE(c.rnkp, NULL, c.rnk, c.rnkp),
                       c.rnk)))=rnk_  and
--               DECODE(mfou_, 300465, DECODE(c.rnkp, NULL, c.rnk, c.rnkp),
--                                        DECODE(f_ourmfo, 303398, DECODE(c.rnkp, NULL, c.rnk, c.rnkp),c.rnk))=rnk_ and
		 	   ((s.nbs NOT IN ('1500','2600','2605','2620','2625','2650','2655') AND
                 s.ost+s.ostq<>0) OR
                (s.nbs IN ('1500','2600','2605','2620','2625','2650','2655') AND
                 s.ost+s.ostq>0))
           and (s.nls,s.kv) not in (SELECT nls,kv
                                    FROM kf91
                                    where substr(nls,1,4) in (select r020
                                                              from kod_r020
                                                              where prem='КБ '
                                                              and a010='91'))
         UNION ALL
         SELECT aa.acc, s.nls, s.kv, aa.fdat, s.nbs,
                Gl.P_Icurval(s.kv, aa.ostf-aa.dos+aa.kos, Dat_) OSTF, ca.rnk
         FROM saldoa aa, accounts s, cust_acc ca
         WHERE (s.nbs in ('8021','8022') AND aa.ostf-aa.dos+aa.kos>0 AND
                f_ourmfo=353575) AND
               aa.acc=s.acc      AND
               (s.acc,aa.fdat) =
                (SELECT c.acc,MAX(c.fdat)
                 FROM saldoa c
                 WHERE s.acc=c.acc AND c.fdat <= Dat_
                 GROUP BY c.acc) and
				 aa.acc=ca.acc and
				 ca.rnk=rnk_) a,
         customer c
   WHERE a.rnk=c.rnk ;
--   UNION ALL
--   SELECT c.vkl_num acc, trim(c.ar_vkl) nls, c.kod_val kv, c.data_zakr fdat,
--          substr(trim(c.ar_vkl),1,4) nbs, 3 codcagent,
--          to_number(trim(c.idn_podatk)) rnk, trim(c.pip) nmk,
--          trim(c.idn_podatk) okpo, 804 country,
--          (c.suma+c.proc_nar) ostf
--   FROM tmp_fileE8 c
--   WHERE to_number(trim(c.idn_podatk))=rnk_
--     AND trim(c.ar_vkl) IS NOT NULL
--     AND c.kod_val IS NOT NULL
--     AND SUBSTR (trim(c.ar_vkl), 1, 4) in (select r020
--                                           from kod_r020
--                                           where prem='КБ '
--                                             and a010='91')
--     AND c.suma+c.proc_nar <> 0 ;


CURSOR BaseL IS
    SELECT kodp, SUM(TO_NUMBER(znap))
    FROM rnbu_trace
    WHERE userid=userid_ AND SUBSTR(kodp,1,2) in ('10','20')
    GROUP BY kodp
    ORDER BY SUBSTR(kodp,3,2), SUBSTR(kodp,1,2) ;

CURSOR BaseL1 IS
    SELECT DISTINCT kodp, znap
    FROM rnbu_trace
    WHERE userid=userid_ AND TO_NUMBER(SUBSTR(kodp,1,2))<10
    ORDER BY SUBSTR(kodp,3,2), SUBSTR(kodp,1,2) ;

PROCEDURE p_ins_log (p_mes_ VARCHAR2) IS
   BEGIN
      INSERT INTO otcn_log(kodf, userid, txt) VALUES
                          (kodf_, userid_, p_mes_);
   END;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE UPPER(logname)=UPPER(USER);
userid_ := user_id;
DELETE FROM RNBU_TRACE WHERE userid = userid_;
DELETE FROM otcn_log WHERE userid = userid_ AND kodf = kodf_;

if tp_ = 1 then
    DELETE FROM OTCN_TRACE_91 WHERE isp = userid_ AND odate= dat_;
end if;

-------------------------------------------------------------------
p_ins_log ('Перелiк 20-ти найбiльших кредиторiв банку (файл ''' || kodf_ || ''' за ''' || dat_ || '''):');
p_ins_log('-----------------------------------------------------------------');

mfo_:=F_Ourmfo();

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

SELECT SUBSTR(sab,2,3) INTO sab_
FROM banks
WHERE mfo=mfo_;

na_:=1 ;

if 353575 in (mfo_, mfou_) then
   -- дата конца декады (каледарная(отчетная), без учета выходных )
   datn_ := dat_;
else
   -- фактическая дата конца декады
   dc_ := TO_NUMBER (LTRIM (TO_CHAR (dat_, 'DD'), '0'));

   FOR i IN 1 .. 3
     LOOP
        IF dc_ BETWEEN 10 * (i - 1) + 1 AND 10 * i + Iif (i, 3, 0, 1, 0)
        THEN
           IF i < 3
           THEN
             datn_ :=
                     TO_DATE (LPAD (10 * i, 2, '0') || TO_CHAR (dat_, 'mmyyyy'),
                              'ddmmyyyy'
                              );
           ELSE
              datn_ := LAST_DAY (dat_);
           END IF;
           EXIT;
        END IF;
   END LOOP;
end if;

--sql_acc_ := 'select r020 from kl_r020 where prem=''КБ '' and f_91=''1''';
-- вместо классификатора KL_R020 будем использовать KOD_R020
sql_acc_ := 'select r020 from kod_r020 where prem=''КБ '' and a010=''91'' ';

ret_ := f_pop_otcn(Dat_, 2, sql_acc_);

OPEN SALDO;
LOOP
   FETCH SALDO INTO rnk_, Kod_a, Oste_ ;
   EXIT WHEN SALDO%NOTFOUND;
   kol_:=0;

   IF na_ < 21 THEN

      s04_:=0 ;
      f91_:=0 ;

-- 04.07.2008 по просьбе Корецкой исключаем данный блок из обработки ---------
--      IF mfo_=300205 THEN
--- вычисляем сумму остатков по б/с 2625,2630,2635 по обрабатываемому клиенту
--         BEGIN
--            SELECT ABS(NVL(SUM(Gl.P_Icurval( s.kv, s.ost, s.fdat)),0))
--               INTO s04_
--            FROM   sal s, cust_acc ca, customer c
--            WHERE s.nbs IN ('2625','2630','2635')
--              AND s.acc=ca.acc
--              AND ca.rnk=c.rnk
--              AND c.rnk=rnk_
--              AND s.fdat=(SELECT MAX(fdat) FROM fdat WHERE
--                    fdat<=Dat_) ;
--         EXCEPTION WHEN NO_DATA_FOUND THEN
--             s04_:=0;
--         END ;
--      END IF;

--      IF s04_<>0 THEN
--         f91_:=1;
--      END IF;
-- 04.07.2008 ----------------------------------------------------------------

--      IF f91_=0 THEN
--         SELECT COUNT(*)
--            INTO f91_
--         FROM kf91
--         WHERE rnk=rnk_
--           and substr(nls,1,4) in (select r020
--                                   from kod_r020
--                                   where prem='КБ '
--                                     and a010='91');
--      END IF;

      IF f91_=0 THEN

         rnk2_ := 0;

         OPEN SALDO1;
         LOOP
            FETCH SALDO1 INTO acc_, nls_, kv_, data_, nbs_, Cntr_, rnk1_, nmk_,
                              okpo_, country_, se_ ;
            EXIT WHEN SALDO1%NOTFOUND;

            Kod_a1:=0;

--            SELECT COUNT(*) INTO f91_ FROM kf91 WHERE nls=nls_ AND kv=kv_ ;

            IF Oste_<>0 AND f91_=0 THEN
               dk_:=Iif_N(se_,0,'10','20','20');

               min_sum_ := 0;
               BEGIN
                  -- депозиты ФЛ
                  IF 300120 in (mfo_, mfou_) then
                     SELECT GL.P_ICURVAL(v.kv, v.min_summ*100, Dat_)
                        INTO min_sum_
                     FROM dpt_deposit c, dpt_vidd v
                     WHERE c.acc = acc_
                       AND c.vidd = v.vidd
                       AND (lower(v.type_name) like '%рост%' or
                            lower(v.type_name) like '%сбер%' or
                            lower(v.type_name) like '%ощад%' or
                            lower(v.type_name) like '%раст%' )
                       AND ROWNUM = 1;
                  END IF;

                  IF 300175 in (mfo_, mfou_) then
                     SELECT ABS(GL.P_ICURVAL(a.kv, a.lim, Dat_))
                        INTO min_sum_
                     FROM accounts a
                     WHERE a.acc = acc_;
                  END IF;

                  IF mfo_ = 300465 then
                     SELECT GL.P_ICURVAL(v.kv, v.min_summ*100, Dat_)
                        INTO min_sum_
                     FROM dpt_deposit c, dpt_vidd v
                     WHERE c.acc = acc_
                       AND c.vidd = v.vidd
                       AND v.vidd in (272, 338)  --lower(v.type_name) like '%комб_нований%'
                       AND ROWNUM = 1;
                  END IF;
                  IF 300120 not in (mfo_, mfou_) AND
                     300175 not in (mfo_, mfou_) AND
                     300465 not in (mfo_, mfou_)
                  THEN
                     SELECT 0
                        INTO min_sum_
                     FROM dpt_deposit c, dpt_vidd v
                     WHERE c.acc = acc_
                       AND c.vidd = v.vidd
                       AND ROWNUM = 1;
                  END IF;
               EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                  BEGIN
                     SELECT GL.P_ICURVAL(v.kv, a.min_sum, Dat_)
                        INTO min_sum_
                     FROM dpu_deal a, dpu_vidd v
                     WHERE a.acc = acc_
                       AND a.vidd=v.vidd
                       AND a.dpu_id IN (SELECT MAX (dpu_id)
                                        FROM dpu_deal
                                        WHERE acc = acc_);
                  EXCEPTION
                            WHEN NO_DATA_FOUND THEN
                     min_sum_ := 0;
                  END;
               END;

               s242_ := '0';
               IF mfo_ = 322498 THEN
                  BEGIN
                     -- до 20.11.2008 брали дату окончания деп.дог.(a.dat_end)
                     -- а начиная с 20.11.2008 будем брать дату возврата суммы
                     -- (a.datv) она на один день больше даты окончания
                     SELECT a.dat_begin, a.datv, '0',  --a.dat_end, '0',
                            '0'                --NVL(p.s180,'0'), NVL(p.s240,'0')
                        INTO sdate_, mdate_, s180_,
                            s240_
                     FROM dpu_deal a, specparam p
                     WHERE a.acc = acc_
                       AND a.dpu_id IN (SELECT MAX (dpu_id)
                                        FROM dpu_deal
                                        WHERE acc = acc_)
                       AND a.acc = p.acc(+);

                     ret_ := Fs_180_242 (nbs_, acc_, datn_, mdate_, sdate_, x_, s242_);

                  EXCEPTION
                            WHEN NO_DATA_FOUND
                  THEN
                     s242_ :='0';
                  END;
               END IF;

               BEGIN
                  SELECT DECODE(S240, NULL, Fs240(Dat_, acc_), S240)
                     INTO s240_
                  FROM specparam
                  WHERE acc=acc_ ;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  s240_:='1' ;
               END ;

               -- для клиентов из СБОНа
               if rnk1_ > 999999 then
                  s240_ := NVL(f_srok(dat_,data_,2),'0');
               end if;

               IF s240_='0' THEN
                  s240_:='1';
               END IF;

               IF mfo_ in (300465, 353575) and
                     substr(nbs_,1,3) in ('260','262') and s240_<>'1' THEN
                  s240_:='1';
               END IF;

               IF mfou_ in (300465) and nbs_ in ('2610','2630') and
                  s240_='9' THEN
                  s240_:='8';
               END IF;

-- 21.09.2006 по служебной записке от 13.09.2006
               IF mfou_ in (300465) and nbs_='2651' and
                     s240_ in ('C','D','E','F','G','H') THEN
                  s240_:='B';
               END IF;

               IF mfo_=353575 and nbs_='8021' THEN
                  nbs_:='2620';
               END IF;

               IF mfo_=353575 and nbs_='8022' THEN
                  nbs_:='2625';
               END IF;

               if mfo_=322498 and s242_<>'0' and s240_ <> s242_ then
                  s240_ := s242_;
               end if;

               if mfo_=380623 then
                  rnk2_ := rnk1_;
               end if;

               if mfo_=380623 and nbs_ = '2600' and rnk2_ = 0 then
                  rnk2_ := rnk1_;
               end if;


               kodp_:= dk_ || SUBSTR(TO_CHAR(100+na_), 2, 2) || nbs_ ||
                       SUBSTR( TO_CHAR(1000+kv_), 2, 3) || s240_  ;

               -- добавлено 30.10.2008 для разбивки залишку
               -- на суму незнижувального залишку i
               -- рiзницi залишку на рахунку мiнус незнижувальний залишок
               IF dat_>=to_date('30102008','ddmmyyyy') and min_sum_ <> 0
                  and se_ - min_sum_ > 0 then

                  INSERT INTO rnbu_trace
                           (nls, kv, odate, kodp,znap, rnk)
                    VALUES (rnk_, kv_, data_, kodp_,
                            TO_CHAR (ABS (min_sum_)), rnk_ );

                  kol_:=1;

                  p_ins_log(LPAD(TO_CHAR(na_),2,'0')||'=' || rnk1_ ||
                            '=' || nmk_ ||
                            '=' || okpo_ || '=' || nbs_ || '=' ||
                            to_char(kv_) || '=' || TO_CHAR(ABS(min_sum_)) );

                  se_ := se_ - min_sum_;
                  kodp_ := substr(kodp_,1,11) || '1' ;
               END IF;

               znap_:= TO_CHAR(ABS(se_)) ;
               INSERT INTO rnbu_trace         --Залишок в нацвалютi
                                (nls, kv, odate, kodp, znap, rnk) VALUES
                                (rnk_, kv_, data_, kodp_, znap_, rnk_);

               kol_:=1;

               p_ins_log(LPAD(TO_CHAR(na_),2,'0')||'=' || rnk1_ ||
                         '=' || nmk_ ||
                         '=' || okpo_ || '=' || nbs_ || '=' ||
                         to_char(kv_) || '=' || TO_CHAR(ABS(se_)) );

               IF mfou_ in (300465) and substr(nbs_,1,3) in ('262','263') THEN
                  kod_a := 5;
               END IF;

               IF mfou_ in (300465) and
                  (nbs_ in ('1500','2600','2601','2602','2603','2604','2605',
                  '2606','3660') or
                   substr(nbs_,1,2) in ('16','25','27') or
                   substr(nbs_,1,3) in ('261','265','330')) THEN
                  kod_a1 := 3;
               END IF;
            END IF;
         END LOOP;
         CLOSE SALDO1;

---       kodp_:= '05' || SUBSTR(to_char(100+na_),2,2) || '00000000' ;
---       znap_:=SUBSTR(to_char(10000000000+to_number(okpo_)),2,10);
---       INSERT INTO rnbu_trace         -- Iдентифiкацiйний код
---                        (nls, kv, odate, kodp, znap) VALUES
---                        (rnk_, 980, dat_, kodp_, znap_);

         kodp_:= '06' || SUBSTR(TO_CHAR(100+na_),2,2) || '00000000' ;
         znap_:=SUBSTR(TO_CHAR(1000+country_),2,3);
         INSERT INTO rnbu_trace         -- Код краiни кредитора
                          (nls, kv, odate, kodp, znap, rnk) VALUES
                          (rnk_, 980, dat_, kodp_, znap_, rnk_);

         kodp_:= '07' || SUBSTR(TO_CHAR(100+na_),2,2) || '00000000' ;
         znap_:='1';

         IF mfou_ not in (300465) and Kod_a IN (5,6) THEN    ---Cntr_=5 or Cntr_=6 THEN
            znap_:='0';
         END IF;

         IF mfou_ in (300465) and Kod_a IN (5,6) AND Kod_a1=0 THEN    ---Cntr_=5 or Cntr_=6 THEN
            znap_:='0';
         END IF;

         IF mfou_ in (300465) AND Kod_a1=3 THEN
            znap_:='1';
         END IF;

         INSERT INTO rnbu_trace         -- Ознака особи кредитора
                          (nls, kv, odate, kodp, znap, rnk) VALUES
                          (rnk_, 980, dat_, kodp_, znap_, rnk_);

         kodp_:= '08' || SUBSTR(TO_CHAR(100+na_),2,2) || '00000000' ;

         IF mfou_ in (300465) THEN
            znap_:=SUBSTR(Trim(mfo_),2,4)||SUBSTR(TO_CHAR(1000000+rnk_),2,6);
         ELSE
            if mfou_ = 380623 then
               znap_:=sab_||LPAD(TO_CHAR(rnk2_),7,'0');
            else
               znap_:=sab_||LPAD(TO_CHAR(rnk_),7,'0');
            end if;
         END IF;

         INSERT INTO rnbu_trace         -- Наименование клиента
                          (nls, kv, odate, kodp, znap, rnk) VALUES
                          (rnk_, 980, dat_, kodp_, znap_, rnk_);  --to_char(rnk_));   ---nmk_

---       kodp_:= '09' || SUBSTR(to_char(100+na_),2,2) || '00000000';
---       INSERT INTO rnbu_trace         -- Резидентность клиента
---                        (nls, kv, odate, kodp, znap) VALUES
---                        (rnk_, 980, dat_, kodp_, TO_CHAR(2-Cntr_)) ;
         kol_:=1;
      END IF;
   else
   	   exit;
   END IF;

   IF kol_<>0 THEN
--      p_ins_log(LPAD(TO_CHAR(na_),2,'0')||' назва=' || nmk_ ||
--                ' okpo=' || okpo_ || ' бал.счет=' || nbs_||
--                ' Залишок='||oste_);
--      p_ins_log(LPAD(TO_CHAR(na_),2,'0')||'=' || nmk_ ||
--                '=' || okpo_ || '=' || nbs_ || '='||oste_);

--      p_ins_log(LPAD(TO_CHAR(na_),2,'0')||'. rnk='||TO_CHAR(rnk_) ||
--                ' okpo=' || okpo_ || ' назва=' || nmk_);
      na_:= na_+1 ;
   END IF;
END LOOP;
CLOSE SALDO;
if tp_ = 0 then
    ---------------------------------------------------
    DELETE FROM tmp_nbu WHERE kodf=kodf_ AND datf=Dat_ ;
    ---------------------------------------------------
    OPEN BaseL1;
    LOOP
       FETCH BaseL1 INTO  kodp_, znap_;
       EXIT WHEN BaseL1%NOTFOUND;
       INSERT INTO tmp_nbu
            (kodf, datf, kodp, znap)
       VALUES
            (kodf_, Dat_, kodp_, znap_);
    END LOOP;
    CLOSE BaseL1;

    OPEN BaseL;
    LOOP
       FETCH BaseL INTO  kodp_, znap_;
       EXIT WHEN BaseL%NOTFOUND;
       INSERT INTO tmp_nbu
            (kodf, datf, kodp, znap)
       VALUES
            (kodf_, Dat_, kodp_, znap_);
    END LOOP;

    CLOSE BaseL;
else
    insert into OTCN_TRACE_91(RECID, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
    select RECID, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
    from rnbu_trace;
end if;
----------------------------------------
END P_F91;
/
show err;

PROMPT *** Create  grants  P_F91 ***
grant EXECUTE                                                                on P_F91           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F91           to RPBN002;
grant EXECUTE                                                                on P_F91           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F91.sql =========*** End *** ===
PROMPT ===================================================================================== 
