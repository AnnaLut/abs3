

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F87SBR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F87SBR ***

CREATE OR REPLACE PROCEDURE BARS.P_F87SBR (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @87 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     : 02/02/2018 (14.11.2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 14.11.2017 - удалил ненужные строки и изменил некоторые блоки формирования
% 09.02.2016 - изменил блок наполнения таблицы REF_KOR
% 04.12.2013 - не включались счета по которым за месяц отсутсвовали
%              Дт и Кт обороты. Если были только коректирующие обороты
%              то они не включались в файл (замечание Луганска)
% 15.09.2012 - формируем в разрезе кодов территорий
% 30.04.2011 - добавил acc,tobo в протокол
% 15.03.2011 - в поле комментарий вносим код TOBO и название счета
% 19.01.2011 до изменений выполненных Квас Л.Т. 18.05.2010 добавлены
%            изменения выполненные ОАВ также 18.05.2010
%            (убран блок заполнения спецпараметров в SPECPARAM_INT)
% 18.05.2010 qwa отбираем только счета, по которым установлены правильно
%            спецпараметры для отбора в 87 файл
%            убрала "старые" хинты
%            OAB убрал блок заполнения спецпараметров в SPECPARAM_INT
% 26.01.2010 убрал присвоение Dat1_='31122008' и в условии отбора оборотов
%            теперь будет условие Dat1_ >= (было Dat1_ > )
% 12.07.2009 убрал ORDER BY для табл. RNBU_TRACE
% 07.07.2009 изменил условие substr(nbs,1,1)='8%' на nbs LIKE '8%'
% 02.07.2009 формируем показатели если p080<>'0000' и 'FFFF'
% 25.03.2009 вместо VIEW V_OB22NU будем использовать V_OB22nu_N
% 19.03.2009 исключил проверку на различие знаков для счетов 8 класса
%            и для счетов 6,7 классов
% 28.02.2009 для Ровно Ощадбанку замiсть звязку ACCC в ACCOUNTS
%            вибираємо рахунки iз VIEW V_OB22NU вiдповiднi поля
%
% изменил 30.01.2009 из переданной Игорем Макаренко от 10.01.2008
% для переменной Dat1_ установил дату '31122008' вместо '30122008'
% изменил 10.01.2008 из переданной Димой Хихлухой версии от 30.01.2007
% версия от 30.01.2007 предыдущая от 12.01.2006, 26.12.2006
% изменил условие отбора корректирующих проводок с 31-12-2005 на 31-12-2006
% для первого месяца должны включаться обороты перекрытия 6,7 классов
% которые проводились 31.12.2006
% добавляется такое условие
% IF to_char(Dat_,'MM')='01' THEN
%   -- временно для проверки
%    Dat1_:=to_date('30122007','DDMMYYYY');
%    Dat1_:=to_date('01' || '01' || to_char(Dat_,'YYYY'),'DDMMYYYY');
% END IF;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   varchar2(2) := '87';
sheme_  varchar2(2) := 'C';
acc_     Number;
acc1_    Number;
acc2_    Number;
accc_    Number;
accc6_   Number;
acc6_    Number;
acc8_    Number;
kol8_    Number;
kol6_7   Number;
sum6_7   Number;
Dosn6_7  Number;
Kosn6_7  Number;
dat1_    Date;
dat2_    Date;
Dose_    DECIMAL(24);
Kose_    DECIMAL(24);
Dosn_    DECIMAL(24);
Kosn_    DECIMAL(24);
Dosn6_   DECIMAL(24);
Kosn6_   DECIMAL(24);
Dosn8_   DECIMAL(24);
Kosn8_   DECIMAL(24);
Dosnk_   DECIMAL(24);
Kosnk_   DECIMAL(24);
Dosnkp_  DECIMAL(24);
Kosnkp_  DECIMAL(24);
se_      DECIMAL(24);
sn_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostn6_   DECIMAL(24);
Ostn8_   DECIMAL(24);
Oste_    DECIMAL(24);
kodp_    Varchar2(11);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv6_     SMALLINT;
Kv8_     SMALLINT;
Vob_     SMALLINT;
Nbs_     Varchar2(4);
Nbs1_    Varchar2(4);
Nbs8_    Varchar2(4);
Nbs6_    Varchar2(4);
nls_     Varchar2(15);
nls6_    Varchar2(15);
nls8_    Varchar2(15);
data_    Date;
data1_   Date;
data6_   Date;
data8_   Date;
zz_      Varchar2(2);
pp_      Varchar2(4);
r020_fa_ Varchar2(4);
dk_      Char(1);
f87_     Number;
f87k_    Number;
userid_  Number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;


comm_    rnbu_trace.comm%TYPE;
typ_    Number;
nbuc1_  VARCHAR2(12);
nbuc_   VARCHAR2(12);

CURSOR SCHETA IS
    SELECT a.acc
    FROM accounts a
    WHERE a.nbs LIKE '8%' AND a.nbs not in ('8605','8625','8999')
    and (exists (select 1 from v_ob22nu_n where accn = a.acc)
        or exists (select 1 from v_ob22nu80 where accn = a.acc));

---Остатки на отчетную дату грн.
CURSOR SaldoASeekOstf IS
   SELECT  a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
           a.tobo, a.nms
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) in
               (select c.acc,max(c.fdat)
                from saldoa c
                where c.fdat <= dat_
                group by c.acc)) a
   WHERE a.kv = 980
     and a.nbs LIKE '8%'
     and a.nbs not in ('8605','8625','8999')
     and (exists (select 1 from v_ob22nu_n where accn=a.acc)
        or exists (select 1 from v_ob22nu80 where accn=a.acc));

---Обороты грн.
CURSOR SaldoASeekOs IS
   SELECT  a.acc, a.nls, a.kv, a.nbs, NVL(SUM(s.dos),0), NVL(SUM(s.kos),0), a.tobo, a.nms
   FROM saldoa s, accounts a
   WHERE s.fdat(+) >= Dat1_
     and s.fdat(+) <= dat_
     and a.acc = s.acc(+)
     and a.kv = 980
     and a.nbs LIKE '8%'
     and a.nbs not in ('8605','8625','8999')
     and (exists (select 1 from v_ob22nu_n where accn = a.acc)
        or exists (select 1 from v_ob22nu80 where accn = a.acc))
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms ;

CURSOR Saldo6_7 IS
   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs
   FROM accounts a, v_ob22nu_n v
   WHERE a.acc = v.acc
     AND v.accn = acc_
     AND a.kv = 980 ;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_,'MM');
Dat2_ := TRUNC(Dat_ + 28);

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);
-------------------------------------------------------------------
---корректирующие проводки
DELETE FROM ref_kor ;

IF to_char(Dat_,'MM') = '12'
THEN
   INSERT INTO REF_KOR (REF, VOB, VDAT)
   SELECT /*+ PARALLEl(o) */
        REF, VOB, VDAT
   FROM OPER o
   WHERE VDAT = any(select /*+ PARALLEL(f) */ max(fdat)
                         from fdat f
                         where fdat BETWEEN ADD_MONTHS (dat_, -2) AND ADD_MONTHS (dat_, 1)
                         group by trunc(fdat, 'mm'))
          AND VOB IN (96, 99)
          and not (((nlsa LIKE '6%' or nlsa LIKE '7%') and
                   (nlsb LIKE '5040%' or nlsb LIKE '5041%')) or
                  ((nlsa LIKE '5040%' or nlsa LIKE '5041%') and
                   (nlsb LIKE '6%' or nlsb LIKE '7%'))) ;
ELSE
   INSERT INTO REF_KOR (REF, VOB, VDAT)
   SELECT /*+ PARALLEl(o) */
        REF, VOB, VDAT
   FROM OPER o
   WHERE VDAT = any(select /*+ PARALLEL(f) */ max(fdat)
                         from fdat f
                         where fdat BETWEEN ADD_MONTHS (dat_, -2) AND ADD_MONTHS (dat_, 1)
                         group by trunc(fdat, 'mm'))
              AND VOB IN (96, 99);
END IF ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p
WHERE o.fdat between Dat1_ AND Dat2_
  AND o.ref = p.ref
  AND o.sos = 5 ;

-- Остатки грн. --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn8_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   SELECT count(*) INTO f87_ FROM sb_p0853 WHERE r020 = nbs_ ;

   IF f87_ > 0 and Ostn8_ <> 0
   THEN

      IF typ_ > 0
      THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      comm_ := '';

      BEGIN
         SELECT NVL(p080,'0000'), NVL(r020_fa,'0000'),  NVL(ob22,'00')
            INTO pp_, r020_fa_, zz_
         FROM specparam_int
         WHERE acc = acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_ := '0000' ;
         r020_fa_ := '0000';
         zz_ := '00';
      END ;

      BEGIN
         SELECT d.acc, SUM(DECODE(d.dk, 0, d.s, 0)),
                       SUM(DECODE(d.dk, 1, d.s, 0))
         INTO acc1_, Dosnk_, Kosnk_
         FROM  kor_prov d
         WHERE d.acc = acc_
           AND d.fdat between Dat_+1 AND Dat2_
           AND d.vob = 96
         GROUP BY d.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosnk_ := 0;
         Kosnk_ := 0;
      END ;
      Ostn8_ := Ostn8_ - Dosnk_ + Kosnk_;

      dk_ := IIF_N(Ostn8_,0,'1','2','2');

      kol6_7 := 0;

      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      IF kol6_7 = 0
      THEN
         IF pp_ not in ('0000','FFFF') and Ostn8_ <> 0
         THEN
            kodp_ := dk_ || pp_ || r020_fa_ || zz_;  --'000000' ;  --- nbs1_='0000',zz_='00'
            znap_ := TO_CHAR(ABS(Ostn8_));
            INSERT INTO rnbu_trace         -- Остатки в номинале валюты
                    (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
            VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
         END IF ;
      END IF ;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- Обороты текущие грн. --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn8_, Kosn8_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   SELECT count(*) INTO f87_ FROM sb_p0853 WHERE r020 = nbs_ ;

   IF f87_ > 0
   THEN

      IF typ_ > 0
      THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      comm_ := '';

      BEGIN
         SELECT NVL(p080,'0000'), NVL(r020_fa,'0000'), NVL(ob22,'00')
            INTO pp_, r020_fa_, zz_
         FROM specparam_int
         WHERE acc = acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_ := '0000' ;
         r020_fa_ := '0000';
         zz_ := '00';
      END ;

      --- корректирующие проводки отчетного месяца
      BEGIN
         SELECT d.acc,
                SUM(DECODE(d.dk, 0, d.s, 0)),
                SUM(DECODE(d.dk, 1, d.s, 0))
         INTO acc1_, Dosnk_, Kosnk_
         FROM  kor_prov d
         WHERE d.acc = acc_
           AND d.fdat between Dat_+1 AND Dat2_
           AND d.vob = 96
         GROUP BY d.acc ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dosnk_ := 0;
         Kosnk_ := 0;
      END ;
      Dosn8_ := Dosn8_ + Dosnk_;
      Kosn8_ := Kosn8_ + Kosnk_;

      kol6_7 := 0;
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      IF kol6_7 = 0
      THEN
         IF pp_ not in ('0000','FFFF') and Kosn8_ > 0
         THEN
            kodp_ := '6' || pp_ || r020_fa_ || zz_;  
            znap_ := TO_CHAR(Kosn8_) ;
            INSERT INTO rnbu_trace     -- Дт. обороты в номинале валюты (грн.+вал.)
                    (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
            VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
         END IF;

         IF pp_ not in ('0000','FFFF') and Dosn8_ > 0
         THEN
            kodp_ := '5' || pp_ || r020_fa_ || zz_;  
            znap_ := TO_CHAR(Dosn8_);
            INSERT INTO rnbu_trace     -- Кр. обороты в номинале валюты (грн.+вал.)
                    (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
            VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
         END IF;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='87' and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '87', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f87sbr;
/
show err;

PROMPT *** Create  grants  P_F87SBR ***
grant EXECUTE                                                                on P_F87SBR        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F87SBR        to RPBN002;
grant EXECUTE                                                                on P_F87SBR        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F87SBR.sql =========*** End *** 
PROMPT ===================================================================================== 
