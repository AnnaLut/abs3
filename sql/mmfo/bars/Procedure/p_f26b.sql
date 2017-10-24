

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F26B.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F26B ***

  CREATE OR REPLACE PROCEDURE BARS.P_F26B (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  DESCRIPTION :	Процедура формирование файла #S7 для КБ
  COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.

  VERSION     : 20/02/2017 (01/11/2016, 07/10/2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 20/02/2017 - для бал.счета 1502 будет формироваться различные значения
              кода показателя "P" (1 или 2) 
              (R013='1' то P='1', R013 in '2','9') то P='2')                               
 26/10/2016 - для счетов 1500 анализ спецпараметров связанных с "обтяженнями" 
 07/10/2016 - для бал.счета 1500 будет формироваться различные значения 
              кода показателя "P" (1 или 2) 
 01/04/2016 - будут исключаться бал.счета '9202','9210','9212','3041','3351'
 03/01/2014 - убрал мусор и изменил некоторые условия как в P_F26new
 23/09/2013 - новый вариант от  (14.01.2008)
 23/09/2013 - OAB добавил для исключения бал.счет 3640 
 13/12/2006 - OAB добавил для исключения бал.счет 1522  
 10/08/2008 - ОАВ добавил для исключения бал.счета 
               1513,1514,1515,1516,1525,1529,
               1613,1615,1616,1617,1622,1624,1626,1627
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_     Number;
l_acc    number;
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
cs_      Number;
agent_   Number;
r1518_   Number;
r1528_   Number;
r013_    Varchar2(1);
r013s_   Varchar2(1);
userid_  Number;

l_znak       smallint;
l_o_sum      number;
l_o_kv       number;
l_se         number;
l_sn         number;

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
        customer c, cust_acc ca, custbank cb, kl_k040 l, rcukru rc, specparam sp
   WHERE a.nbs in (select k.r020
                   from kod_r020 k
                   where trim(k.prem)='КБ' and
                         k.a010 = '26' AND
                         k.d_open <=dat_ and
                         (k.d_close is null or k.d_close>dat_)) and
         a.acc=sp.acc(+)              AND
         a.acc=ca.acc                 AND
         ca.rnk=c.rnk                 AND
         c.rnk=cb.rnk                 AND
         cb.mfo=rc.mfo(+)             AND
         c.country=TO_NUMBER(l.k040)  AND
         a.nbs not in ('1520','1521','1522','1523','1524','1525','1526','1527',
                       '1528','1529','1581','1582',
                       '1610','1612','1613','1615','1616','1617','1618','1621',
                       '1622','1623','1624','1625','1626','1627','1628','9200',
                       '9202','9210','9212','3041','3351',
                       '3540',  --T 21.09.2009
                       '3640'   -- OAB 23.09.2013
                       ) ;

CURSOR BaseL IS
    SELECT kodp, znap
    FROM rnbu_trace
    WHERE userid=userid_
    ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
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

   IF nbs_ = '1502' THEN
      if r013s_ = '1' then
         r013_ := '1';
      end if;
      if r013s_ in ('2','9') then
         r013_ := '2';
      end if;
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


      if nbs_o in ('1500','1510','1512') then
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

   IF nbs_ not in ('1502','1518','1528','1525','1526','3540','3640','9100') THEN
      r013_:='0';
   END IF;

   IF SN_<>0 THEN
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
            --kb_:=SUBSTR(TO_CHAR(10000000000+TO_NUMBER(mfo_)),2,10) ;
         END IF;
      END IF;

      if nbs_ = '1500' then

        if se_ <0 then
          l_o_sum :=0;
          l_o_kv  :=0;

          begin
              select   acc, sum(lie_sum), sum(lie_val)
                into l_acc, l_o_sum,      l_o_kv
                from ( select acc, nvl(to_number(value),0) lie_sum, 0 lie_val
                         from accountsw
                        where acc = acc_
                          and tag = 'LIE_SUM'
                       union
                       select acc, 0 lie_sum, nvl(to_number(value),0) lie_val
                         from accountsw
                        where acc = acc_
                          and tag = 'LIE_VAL' )
               group by acc;

          exception
             when others  then l_o_sum :=0;
                               l_o_kv  :=0;
          end;

          if l_o_sum !=0  then

             l_znak :=  IIF_N(se_,0,-1,1,1);
             se_ := abs(se_);
             sn_ := abs(sn_);

             if l_o_kv = kv_  or l_o_kv =0  then

                l_se := least(se_,gl.p_icurval(kv_,l_o_sum,dat_));
                l_sn := least(sn_,l_o_sum);
             else

                l_se := least(se_,gl.p_icurval(l_o_kv,l_o_sum,dat_));
                l_sn := least(sn_,gl.p_ncurval(kv_,l_se,dat_));
             end if;

             dk_:=IIF_N(l_znak*se_,0,'10','20','20');
             kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                            LPAD(to_char(kv_),3,'0') || '2' ;
             znap_:= TO_CHAR(ABS(l_se)) ;

             INSERT INTO rnbu_trace
                      (nls, kv, odate, kodp, znap, acc)
               VALUES (nls_, kv_, data_, kodp_, znap_, acc_);

             if kv_ != 980  then

                dk_:=IIF_N(l_znak*se_,0,'11','21','21');
                kodp_:= dk_ || LPAD(to_char(cs_),3,'0') || kb_ || nbs_ ||
                               LPAD(to_char(kv_),3,'0') || '2' ;
                znap_:= TO_CHAR(ABS(l_sn)) ;

                INSERT INTO rnbu_trace
                         (nls, kv, odate, kodp, znap, acc)
                  VALUES (nls_, kv_, data_, kodp_, znap_, acc_);

             end if;

             se_ := l_znak *greatest(least(se_, l_se),0);
             sn_ := l_znak *greatest(least(sn_, l_sn),0);

          end if;

        end if;

        r013_ := '1';
      end if;

      dk_:=IIF_N(se_,0,'10','20','20');
         if nbs_ = '1500'  and  dk_='20'  then
            r013_ := '0';
         end if;

      kodp_:= dk_ || SUBSTR(to_char(1000+cs_),2,3) || kb_ || nbs_ ||
              SUBSTR(to_char(1000+kv_),2,3) || r013_ ;
      znap_:= TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);

      IF kv_<> 980 THEN
         dk_:=IIF_N(sn_,0,'11','21','21');
         if nbs_ = '1500'  and  dk_='21'  then
            r013_ := '0';
         end if;

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
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='S7' and datf= dat_;
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
                      VALUES ('S7', Dat_, kodp1_, TO_CHAR(sump_));
      END IF ;

      IF TO_NUMBER(SUBSTR(kodp1_,1,2))>96 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap)
                      VALUES ('S7', Dat_, kodp1_, LTRIM(RTRIM(znap1_)));
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
                VALUES ('S7', Dat_, kodp1_, znap1_);
END IF ;
---------------------------------------------------
END p_f26b;
/
show err;

PROMPT *** Create  grants  P_F26B ***
grant EXECUTE                                                                on P_F26B          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F26B.sql =========*** End *** ==
PROMPT ===================================================================================== 
