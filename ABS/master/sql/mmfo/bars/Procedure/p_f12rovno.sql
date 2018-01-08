

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F12ROVNO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F12ROVNO ***

  CREATE OR REPLACE PROCEDURE BARS.P_F12ROVNO (Datn_ DATE, Dat_ DATE,
                                      sheme_ VARCHAR2 DEFAULT 'G',
                                      p_kodf_ VARCHAR2 DEFAULT '12')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла #12 для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 04.03.2009 (21.12.2007,24.11.2006, предыдущая 02.11.2006,
                            11.01.2006,27.10.2006)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Datn_ - начальная дата
               Dat_ -  конечная дата
               sheme_ - схема формирования
04.03.2008 будем формировать за заданный период
18.02.2009 в RNBU_TRACE1 в поле ACC заносим ACC счета кассы
21.12.2007 Доп.параметры SK_P, SK_V будем обрабатывать для всех банков
           если имеются данные доп.реквизиты в операциях
           (ранее было только для УПБ, пожелало ОПЕРУ СБ)
24.11.2006 Для банка УПБ (МФО=300205) выполнена спецобработка символов
           кассплана т.к. при вводе существует 2 доп.реквизита SK_P, SK_V
           и их можно вводить в одном документе.
02.11.2006 Для отбора бал.счетов использовалось условие tip='KAS'
           добавил tip='KAS and NBS in ('1001','1002','1003','1004') and
           kv=980. (была проблема в Укоопспилке Львова. Для бал.счета 1003
           и различных валют(кроме 980) установили тип счета 'KAS').
25.09.2006 для проводок вида
Дт 1001,1002,1003,1004  Кт 1001 и DK=1 меняем символа кассплана с 66 на 39
для счетов Дт
Дт 1001,1002,1003,1004  Кт 1001 и DK=0 меняем символа кассплана с 39 на 66
для счетов Дт
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    VARCHAR2(2):='12';
typ_ NUMBER;

nls_     VARCHAR2(15);
nls1_    VARCHAR2(15);
data_    DATE;
kv_      SMALLINT;
kodp_    VARCHAR2(10);
znap_    VARCHAR2(30);
sk_      SMALLINT;
t_sk_    SMALLINT;  -- з TTS
sk1_     SMALLINT;
sk2_     SMALLINT;
s_       DECIMAL(24);
nbu_     SMALLINT;
ref_     NUMBER;
userid_  NUMBER;
kol_sk_  NUMBER :=0;
tt_      Varchar2(3);  -- з OPLDOK
o_tt_    Varchar2(3);  -- з OPER
dat1_    DATE;        -- дата начала декады !!!
dc_      INTEGER;
dk_      NUMBER;
dk1_     NUMBER;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
acc_     NUMBER;

CURSOR OPERA IS
   SELECT  s.acc, s.nls, o.nlsa, o.kv, o.dk, p.FDAT, p.REF,
           DECODE(p.TT, o.TT, o.SK, t.SK), t.sk, p.dk, p.tt, o.tt, p.s
   FROM OPER o, OPLDOK p, ACCOUNTS s, TTS t
   WHERE p.acc=s.acc             AND
         s.tip='KAS'             AND
         s.nbs in ('1001','1002','1003','1004') AND
         s.kv=980                AND
         p.FDAT BETWEEN Dat1_ AND Dat_ AND
         o.REF=p.REF             AND
         p.SOS=5                 AND
         p.TT=t.TT ;

-- исходящие остатки
CURSOR SALDO IS
   SELECT  o.acc, o.nls, o.kv, sa.FDAT, sa.ostf-sa.dos+sa.kos
   FROM SALDOA sa, ACCOUNTS o
   WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
                  FROM  SALDOA bb
                  WHERE o.acc = bb.acc AND bb.FDAT  <= Dat_) ;

-- входящие остатки
CURSOR SALDO2 IS
   SELECT  o.acc, o.nls, o.kv, sa.FDAT, sa.ostf-sa.dos+sa.kos
   FROM SALDOA sa, ACCOUNTS o
   WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
                  FROM  SALDOA bb
                  WHERE o.acc = bb.acc AND bb.FDAT  < Dat1_) ;

CURSOR BaseL IS
   SELECT kodp,nbuc, SUM (znap)
   FROM RNBU_TRACE1
   where userid = userid_
   GROUP BY kodp,nbuc
   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
--EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE1';

delete 
FROM RNBU_TRACE1
where USERID = userid_;
-------------------------------------------------------------------
nbu_:= Isnbubank();

select count(*) into kol_sk_
from op_rules
where trim(tag) in ('SK_P','SK_V');

-- определение начальных параметров
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

dat1_ := Datn_;  

OPEN OPERA;
LOOP
   FETCH OPERA INTO acc_, nls1_, nls_, kv_, dk_, data_, ref_, sk_,
                    t_sk_, dk1_, tt_, o_tt_, s_ ;
   EXIT WHEN OPERA%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

-- для банка УПБ и ОПЕРУ СБ в кассовых операциях по 980 и типов проводок
--  Дт 1001-1004 Кт 1001-1004 имеется два доп.реквизита символов кассплана
-- символ кассплана SK_P (приход) и SK_V (расход)
--   IF f_ourmfo() in (300205, 300465) THEN
-- для всех банков !!! если имеются доп.реквизиты SK_P, SK_V в операциях
   IF kol_sk_ > 0 THEN
      sk2_:=sk_;  ---null;

      if tt_ = o_tt_ then        -- основна операцiя
      -- все одно прiоритет доп.реквiзитiв SK_P, SK_V
         begin
            select to_number(substr(value,1,2)) into sk1_
            from operw
            where ref=ref_ and
                  trim(tag)=DECODE(dk1_,0,'SK_P','SK_V');
         exception when others then
            sk1_:=0;
         end;
         if sk1_ is not NULL and sk1_<>0 then
            sk2_:=sk1_;
         else
            NULL;
         end if;
      else                          -- зв'язана операцiя
         sk2_:=t_sk_;               -- ! прiоритет СКП з карточки зв'язаної операцiї?
         if sk2_ is NULL then
            begin
               select to_number(substr(value,1,2)) into sk2_
               from operw
               where ref=ref_ and trim(tag)='SK';
            exception when others then
               sk2_:=0;
            end;
         end if;
      end if;
      sk_:=sk2_;
      if sk2_ is NULL then
         sk_:=0;
      end if;
   ELSE
      IF sk_ IS NULL THEN
         BEGIN
            SELECT TO_NUMBER(SUBSTR(value,1,2)) INTO sk_
            FROM OPERW
            WHERE REF=ref_ AND
                  trim(tag)='SK';
         EXCEPTION WHEN OTHERS THEN
            sk_:=0;
         END;
      END IF ;
      -- для проводок вида Дт 1001  Кт 1001,1002,1003,1004 или
      -- Дт 1001,1002,1003,1004  Кт 1001
      IF substr(nls_,1,4) in ('1001','1002','1003','1004') and nls_=nls1_ and
         dk_=1 and sk_=66 THEN
         sk_:='39';
      END IF;

      IF substr(nls_,1,4) in ('1001','1002','1003','1004') and nls_=nls1_ and
         dk_=0 and sk_=39 THEN
         sk_:='66';
      END IF;
   END IF;


   IF s_<>0 THEN
      kodp_:= LPAD(TO_CHAR(sk_),2,'0');
      znap_:= TO_CHAR(s_) ;

      INSERT INTO RNBU_TRACE1 (fdat, nls, kv, odate, kodp, znap, nbuc, acc, userid) VALUES
                              (data_, nls_, kv_, data_, kodp_, znap_, nbuc_, acc_, userid_);
   END IF;
END LOOP;
CLOSE OPERA;

-- исходящие остатки
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_,nls_, kv_, data_, s_ ;
   EXIT WHEN SALDO%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF s_ <> 0 THEN
      IF nbu_ = 1 THEN
         kodp_:= '69';
      ELSE
         kodp_:= '70';
      END IF;

      znap_:= TO_CHAR(ABS(s_));
      INSERT INTO RNBU_TRACE1 (fdat, nls, kv, odate, kodp, znap, nbuc, acc, userid) VALUES
                              (data_, nls_, kv_, data_, kodp_, znap_, nbuc_, acc_, userid_);
   END IF;
END LOOP;
CLOSE SALDO;

-- входящие остатки
OPEN SALDO2;
LOOP
   FETCH SALDO2 INTO acc_,nls_, kv_, data_, s_ ;
   EXIT WHEN SALDO2%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF s_ <> 0  THEN
      IF nbu_ = 1 THEN
         kodp_:= '34';
      ELSE
         kodp_:= '35';
      END IF;

      znap_:= TO_CHAR(ABS(s_)) ;
      INSERT INTO RNBU_TRACE1 (fdat, nls, kv, odate, kodp, znap, nbuc, acc, userid) VALUES
                              (data_, nls_, kv_, data_, kodp_, znap_, nbuc_, acc_, userid_);
   END IF;

END LOOP;
CLOSE SALDO2;

commit;
----------------------------------------
END P_F12rovno;
/
show err;

PROMPT *** Create  grants  P_F12ROVNO ***
grant EXECUTE                                                                on P_F12ROVNO      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F12ROVNO      to RPBN002;
grant EXECUTE                                                                on P_F12ROVNO      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F12ROVNO.sql =========*** End **
PROMPT ===================================================================================== 
