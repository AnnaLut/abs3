

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FD7_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FD7_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FD7_NN (Dat_ DATE,
                                      sheme_ varchar2 default 'G',
                                      tipost_ varchar2 default 'S') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #D7 для КБ (универсальная)
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2007.  All Rights Reserved.
% VERSION     : 02.02.2007
% 24.01.2006 для Хмельницкой Укоопспилки МФО=315568 не изменяем код валюты
%            на 980 по счетам тех.переоценки 3500 или 3600 (у них такие)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
           tipost_ - тип остатков 6 и 7 классов
                     'S'-с учетом проводок перекрытия на 5040(5041)
                     'R'- без учета проводок перекрытия на 5040(5041)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='D7';
typ_     number;
rnk_     Number;
acc_     Number;
nbs_     Varchar2(4);
kv_      SMALLINT;
nls_     Varchar2(15);
mfo_     Varchar2(12);
nbuc1_   Varchar2(20);
nbuc_    Varchar2(20);
data_    Date;
re_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dose_    DECIMAL(24);
dk_      Varchar2(2);
kodp_    Varchar2(10);
znap_    Varchar2(30);
userid_  Number;
dig_     number;
b_       Varchar2(30);
flag_    number;
--pr_      number;
tips_    Varchar2(3);
tsql_    varchar2(1000);
sql_acc_ varchar2(2000):='';
ret_	 number;

CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.nbs, s.fdat, NVL(MOD(cc.codcagent,2),1),
          NVL(s.ost,0), NVL(s.ostq,0), a.tip, cc.rnk
   FROM otcn_saldo s, otcn_acc a, customer cc
   WHERE s.acc = a.acc              and
	 a.rnk = cc.rnk;
------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM(znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp, nbuc
    ORDER BY kodp ;
-----------------------------------------------------------------------------
procedure p_ins(p_dat_ date, p_tp_ varchar2, p_nls_ varchar2,p_nbs_ varchar2,
  		p_kv_ smallint, p_rez_ varchar2, p_znap_ varchar2) IS
                kod_ varchar2(10);

begin
   if length(trim(p_tp_))=1 then
      IF p_kv_=980 THEN
         kod_:='0' ;
      ELSE
         kod_:='1' ;
      END IF ;
   else
      kod_:= '';
   end if;

   kod_:= p_tp_ || kod_ || p_nbs_ || lpad(p_kv_,3,'0') || p_rez_ ;

   if length(trim(p_tp_))>1 then
      flag_ := f_is_est(p_nls_, p_kv_);
      IF flag_=1 and mfo_<>315568 THEN
         kod_:= p_tp_ || p_nbs_ || '980' || p_rez_ ;
      END IF;
   end if;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, nbuc)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, nbuc_);
end;
-----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_:=F_OURMFO();

------------------------------------------------------------------------
--- специфика банка "Ажио"  (c 11.03.2005 для всех банков)
   tsql_ := 'begin '||
   'IF dat_next_u(:d,1) = bankdate '||
   'AND to_char(:d,''MM'') <> to_char(bankdate,''MM'')  THEN '||
   'delete from tmp_customer; '||
   'insert into tmp_customer '||
   'select RNK, CUSTTYPE, COUNTRY, NMK, CODCAGENT, PRINSIDER, '||
   'OKPO, C_REG, C_DST, DATE_ON, DATE_OFF, CRISK, '||
   'ISE, FS, OE, VED, SED, MB '||
   'from customer; '||
   'END IF; '||
   'end; ';

   execute immediate tsql_ using dat_;
------------------------------------------------------------------------
-- определение начальных параметров (код области или МФО или подразделение)
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

--- удаление информации из табл. otcn_saldo
--- наполнение счетов (в том числе счетов тех.переоценки) и
--- их остатков (номиналы+эквиваленты)
---DELETE FROM OTCN_SALDO WHERE odate=Dat_;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_SALDO';

sql_acc_ := 'select r020 from kl_r020 where prem=''КБ '' and f_01=''1''';

ret_ := f_pop_otcn(Dat_, 1, sql_acc_);

--- формирование протокола в табл. RBNU_TRACE
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, nbs_, data_, re_, Ostn_, Ostq_,
                    tips_, rnk_ ;
   EXIT WHEN SALDO%NOTFOUND;

   if sheme_ = 'G' and (tips_<>'T00' and tips_<>'T0D') and typ_>0 then
      nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
   else
      nbuc_ := nbuc1_;
   end if;

   if tipost_='R' then
      BEGIN
         SELECT NVL(SUM(p.s*decode(p.dk,0,-1,1,1,0)),0) INTO Dose_
         FROM oper o, opldok p
         WHERE o.ref  = p.ref  AND
               p.fdat = dat_   AND
               o.sos  = 5      AND
               p.acc  = acc_   AND
               (o.tt  like  'ZG%' or
               ((substr(o.nlsa,1,1) in ('6','7') and
                 substr(o.nlsb,1,4) in ('5040','5041')) or
                (substr(o.nlsa,1,4) in ('5040','5041') and
                substr(o.nlsb,1,1) in ('6','7'))));
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dose_:=0;
      END;
      Ostn_:=Ostn_-Dose_;
   end if;

   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, nls_, nbs_, kv_, to_char(2-re_), TO_CHAR(ABS(Ostn_)));
   END IF;

   IF Ostq_<>0 THEN
      dk_:=IIF_N(Ostq_,0,'1','2','2')||'0';
      p_ins(data_, dk_, nls_, nbs_, kv_, to_char(2-re_), TO_CHAR(ABS(Ostq_)));
   END IF;

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu WHERE kodf=kodf_ AND datf= Dat_;
---------------------------------------------------
--- формирование файла в табл. TMP_NBU
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   if substr(kodp_,7,3)='980' or substr(kodp_,2,1)<>'1' then
      b_:=znap_;
   else
      dig_:=f_ret_dig(to_number(substr(kodp_,7,3)));
      b_:=TO_CHAR(ROUND(TO_NUMBER(znap_)/dig_,0));
   end if;

   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (kodf_, Dat_, kodp_, b_, nbuc_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_fd7_NN;
 
/
show err;

PROMPT *** Create  grants  P_FD7_NN ***
grant EXECUTE                                                                on P_FD7_NN        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FD7_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
