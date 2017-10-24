

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F26A.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F26A ***

  CREATE OR REPLACE PROCEDURE BARS.P_F26A (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирование файла #S6 для КБ
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 07/10/2016 (05/09/2016, 01/07/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 05/09/2016 - убрал блок по разшифровке бал.счетов 3041, 3351 
 01/07/2016 - для банков нерезидентов код банка выбираем из ALT_BIC
              таблицы CUSTBANK
 28/04/2016 - будет выполняться расшифровка в разрезе контрагентов 
              бал.счетов 3041, 3351
 01/04/2016 - будут включаться бал.счета '9202','9210','9212','3041','3351'
 10/01/2014 - включаются 1525,1526 только с R013=(1,2,3,4,5,6,7)
 03/01/2014 - включаются 1525,1526 только с R013=(1,2,3,4,5,9)
 23/09/2013 - новый вариант от  (14.01.2008)
 23/09/2013 - Обухова Татьяна включаются 3640 только с R013=(4,5,6)
 01/10/2009 - Овчарук А используем KOD_R020 вместо KL_R020
 21/09/2009 - Обухова Татьяна включаются 3540 только с R013=9
 14/01/2008 - ОАВ добавил бал.счета 1513,1514,1515,1516,1525,1529,
                                    1613,1615,1616,1617,1622,1624,1626,1627
 13/12/2006 - OAB добавил бал.счет 1522
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_     Number;
nbs_     Varchar2(4);
nbs_o    Varchar2(4);
nls_     Varchar2(15);
data_    Date;
kv_      SMALLINT;
dk_      Varchar2(2);
se_      DECIMAL(24);
sn_      DECIMAL(24);
sump_    DECIMAL(24);
mfo_     Varchar2(12);
glb_     Number;
kb_      Varchar2(11);
rb_      Varchar2(4);
invk_    Varchar2(1);
nb_      Char(54);
kk_      Varchar2(8);
kodp_    Varchar2(35);
kodp1_   Varchar2(35);
znap_    Varchar2(70);
znap1_   Varchar2(70);
f26_     SMALLINT;
cs_      Number;
agent_   Number;
r1518_   Number;
r1528_   Number;
nbu_     SMALLINT;
r013_    Varchar2(1);
r013s_   Varchar2(1);
prem_    Char(3);
userid_  Number;

--- Остатки
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, c.country, c.codcagent,
          cb.mfo, NVL(rc.glb,0), cb.alt_bic, NVL(cb.rating,' '),
          LTRIM(RTRIM(substr(c.nmk,1,54))), a.ostf-a.dos+a.kos,
          NVL(trim(sp.r013),'0')
---       GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,                      --- AND
---                s.kv <> 980) a,               --- с 01.01.2002 все валюты
        customer c, cust_acc ca, custbank cb, kl_k040 l, kod_r020 k,  -- kl_r020 k
        rcukru rc, specparam sp
   WHERE a.nbs=k.r020                 AND
         k.a010='26'                  AND
         trim(k.prem)='КБ'            AND
         --k.d_open <=dat_              AND
         (k.d_close is null OR
          k.d_close > Dat_)           AND
         a.acc = sp.acc(+)            AND
         a.acc=ca.acc                 AND
         ca.rnk=c.rnk                 AND
         c.rnk=cb.rnk                 AND
         cb.mfo=rc.mfo(+)             AND
         c.country=TO_NUMBER(l.k040)  AND
         a.nbs in ('1520','1521','1522','1523','1524','1525','1526','1527',
                   '1528','1529','1581','1582',
                   '1610','1612','1613','1615','1616','1617','1618','1621',
                   '1622','1623','1624','1625','1626','1627','1628',
                   '9100','9200','9202','9210','9212','3041','3351',
                   '3540', --T 21.09.2009
                   '3640'  -- OAB 23.09.2013
                   ) ;
---         MOD(c.codcagent,2)=0 ;
---         l.k042 <> '9' ;
--   GROUP BY a.nbs, c.country, a.kv ;

CURSOR BaseL IS
    SELECT kodp, znap
    FROM rnbu_trace
    WHERE userid=userid_
    ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'truncate table rnbu_trace';
-------------------------------------------------------------------
sump_:=0 ;
znap1_:='0' ;
kodp1_:='0' ;

OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, data_, nbs_, cs_, agent_, mfo_,
                    glb_, kb_, rb_, nb_, sn_, r013s_ ;
   EXIT WHEN SALDO%NOTFOUND;

   r1518_:=0;
   r1528_:=0;
   r013_:='0';

   IF nbs_ = '1500' then
      r013_ := '1';
   END IF;

   IF nbs_ in ('1518','1528') THEN
      if r013s_ in ('5','7') then
         r013_ := '1';
      end if;
      if r013s_ in ('6','8') then
         r013_ := '2';
      end if;
   END IF;

   IF nbs_ in ('1518','1528') THEN
      BEGIN
         select substr(a.nls,1,4)
            into nbs_o
         from int_accn i, accounts a
         where i.acra = acc_
           and i.acc = a.acc
           and rownum = 1 ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         nbs_o := null;
      END;

      if nbs_o in ('1510','1512') then
         r013_ := '1';
      end if;

      if nbs_o in ('1511','1513','1514','1515','1516','1517') then
         r013_ := '2';
      end if;

      if nbs_o in ('1520','1521','1523') then
         r013_ := '1';
      end if;

      if nbs_o in ('1522','1524','1525','1526','1527') then
         r013_ := '2';
      end if;

   END IF;

   IF nbs_ not in ('1518','1528','1525','1526','3540','3640','9100') THEN
      r013_:='0';
   END IF;

   IF nbs_ in ('3540','3640') THEN --T 21.09.2009  для 3540  OAB 23.09.2013 для 3640
      r013_:=r013s_;
   END IF;

   IF Dat_>=to_date('31102008','ddmmyyyy') and nbs_ in ('1525','1526') and
      r013s_='4' then
      r013_:='4';
   END IF;

   IF Dat_>=to_date('31102008','ddmmyyyy') and nbs_ in ('1525','1526') and
      r013s_<>'4' then
      r013_:='1';
   END IF;

   IF Dat_>=to_date('10012014','ddmmyyyy') and nbs_ in ('1525','1526') then
      if r013s_ in ('2','3','5','7') then
         r013_:='1';
      elsif r013s_ = '1' then
         r013_:='2';
      elsif r013s_ = '4' then
         r013_:='4';
      elsif r013s_ = '6' then
         r013_:='9';
      else
         null;
      end if;
   END IF;

   -- для 3540 T 21.09.2009
   --для 3640  OAB 23.09.2013
   IF SN_<>0 and
      ( nbs_ not in ('1525','1526','3540','3640') or
        (nbs_ in ('1525','1526') and r013_ in ('1','2','3','4','5','6','7')) or
        (nbs_ in ('3540','3640') and r013_ in ('4','5','6'))
      )
   THEN

      IF Dat_ >= to_date('30092013','ddmmyyyy') and nbs_ in ('3540','3640') and
         r013s_ in ('4','5','6')
      THEN
         r013_:='9';
      END IF;

      IF kv_<> 980 THEN
         se_:=GL.P_ICURVAL(kv_, sn_, Dat_) ;
      ELSE
         se_:=sn_ ;
      END IF;
      IF MOD(agent_,2)=0 THEN
         IF kb_ IS NULL OR kb_=' ' THEN
            kb_:='0000000000' ;
         ELSE
            kb_:=SUBSTR(TO_CHAR(10000000000+TO_NUMBER(kb_)),2,10) ;
         END IF;
      ELSE
         IF mfo_ IS NULL OR mfo_=' ' THEN
            kb_:='0000000000' ;
         ELSE
            if dat_ < to_date('09072010','ddmmyyyy') then
               kb_:=lpad(mfo_,10,'0') ;
            else
               kb_:=lpad(glb_,10,'0') ;
            end if;
         END IF;
      END IF;

      dk_:=IIF_N(se_,0,'10','20','20');

      kodp_:= dk_ || SUBSTR(to_char(1000+cs_),2,3) || kb_ || nbs_ ||
              SUBSTR(to_char(1000+kv_),2,3) || r013_ ;
      znap_:= TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);

      IF kv_<> 980 THEN
         dk_:=IIF_N(sn_,0,'11','21','21');
         kodp_:= dk_ || SUBSTR(to_char(1000+cs_),2,3) || kb_ || nbs_ ||
                 SUBSTR(to_char(1000+kv_),2,3) || r013_ ;
         znap_:= TO_CHAR(ABS(sn_)) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;

      IF substr(rb_,1,1)='A' or substr(rb_,1,1)='T' or substr(rb_,1,1)='F' THEN
         invk_:='1';
      ELSE
         invk_:='2';
      END IF;

      kodp_:= '97' || SUBSTR(to_char(1000+cs_),2,3) || kb_ || '00000000' ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, invk_);

      kodp_:= '98' || SUBSTR(to_char(1000+cs_),2,3) || kb_ || '00000000' ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, nb_);
---      IF rb_ <> ' ' THEN
---         rb_:=rb_ || 'A' ;   --- ч _ї_--R .яфR<-Ї_ї  _cўр-_ ця-тя ўятрї Rц я.Rї
---      END IF ;

      kodp_:= '99' || SUBSTR(to_char(1000+cs_),2,3) || kb_ || '00000000' ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, rb_);
   END IF;
END LOOP;
CLOSE SALDO;
-------------------------------------------------------------------------
-- 05/09/2016 убираем блок по расшифровке т.к. для данных бал.счетов
-- будут открыты новые контрагенты резиденты и нерезиденты 
-- для ГОУ блок для расшировки бал.счетов 3041, 3351
/*
delete from rnbu_trace 
where (nls like '3041%' or nls like '3351%');

swap_otcn ( Dat_ );

for k in ( select t.ACC, t.NLS, t.KV, t.SK RNK, 
                  sum(t.ost) OST, t.mfo, t.nlsk, t.namk,
                  c.country, r.glb, r.nb, cb.alt_bic, NVL(cb.rating,' ') rating
           from TMP_VPKLB t, customer c, rcukru r, custbank cb
           where t.sk = c.rnk
             and t.mfo = r.mfo (+)
             and c.rnk = cb.rnk (+)
           group by t.ACC, t.NLS, t.KV, t.SK, 
                    t.mfo, t.nlsk, t.namk,
                    c.country, r.glb, r.nb, cb.alt_bic, NVL(cb.rating,' ')
         )
 
   loop

      if k.ost <> 0 then
         dk_:=IIF_N(k.ost,0,'10','20','20');
         if k.country <> '804'
         then 
            kb_ := LPAD (k.alt_bic, 10, '0');
            nb_ := substr(k.namk, 1, 60);
         else 
            kb_ := LPAD (k.glb, 10, '0');
            nb_ := substr(k.nb, 1, 60);
         end if;

         kodp_:= dk_ || LPAD(to_char(k.country),3,'0') || kb_ || substr(k.nls,1,4) ||
                 LPAD(to_char(k.kv),3,'0') || '0' ;
         znap_:= TO_CHAR(ABS(k.ost)) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (k.nls, k.kv, dat_, kodp_, znap_);

         -- инвестиционный класс только для банков нерезидентов
         invk_:='2';

         kodp_:= '97' || LPAD(to_char(k.country),3,'0') || kb_ || '00000000' ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (k.nls, k.kv, dat_, kodp_, invk_);

         kodp_:= '98' || LPAD(to_char(k.country),3,'0') || kb_ || '00000000' ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (k.nls, k.kv, dat_, kodp_, nb_);

         kodp_:= '99' || LPAD(to_char(k.country),3,'0') || kb_ || '00000000' ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (k.nls, k.kv, dat_, kodp_, k.rating);

      end if;

   end loop;   */
-------------------------------------------------------------------------

---------------------------------------------------
DELETE FROM tmp_nbu where kodf='S6' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   IF kodp1_='0' THEN
      kodp1_:=kodp_ ;
   END IF ;
   IF kodp1_ <> kodp_ THEN
      IF TO_NUMBER(SUBSTR(kodp1_,1,2))<97 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                      VALUES ('S6', Dat_, kodp1_, TO_CHAR(sump_));
      END IF ;

      IF TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                      VALUES ('S6', Dat_, kodp1_, LTRIM(RTRIM(znap1_)));
      END IF ;

      sump_:=0 ;
      znap1_:=' ' ;
      kodp1_:=kodp_ ;

   END IF ;
   IF kodp1_=kodp_ AND TO_NUMBER(SUBSTR(kodp1_,1,2))<97 THEN
      sump_:=sump_+TO_NUMBER(znap_) ;
   END IF ;
   IF kodp1_=kodp_ AND TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
      znap1_:=znap_ ;
   END IF ;

END LOOP;
CLOSE BaseL;
IF kodp1_ IS NOT NULL  AND  TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
   INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                VALUES ('S6', Dat_, kodp1_, znap1_);
END IF ;
---------------------------------------------------
END p_f26a;
/
show err;

PROMPT *** Create  grants  P_F26A ***
grant EXECUTE                                                                on P_F26A          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F26A          to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F26A.sql =========*** End *** ==
PROMPT ===================================================================================== 
