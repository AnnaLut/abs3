

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F15SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F15SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F15SB (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : otcn.sql
% DESCRIPTION : ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 30.04.2011 (01.03.2011,23.02.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 30.04.2011 - добавил†acc,tobo в протокол
% 01.03.2011 - в поле комментарий вносим код TOBO и название счета%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
sDos_    Number(24);
sKos_    Number(24);
se_      Number(24);
ob22_    Varchar2(2);
vost_    Number(24);
sPCnt_   Number;
sPCnt1_  Varchar2(10);
Kv_      SMALLINT;
Nbs_     Varchar2(4);
Pap_     Number;
Cntr_    Number;
Cntr1_   Varchar2(1);
cust_    SMALLINT;
mfo_     Number;
rnk_     Number;
f03k_    Number;
f03d_    Number;
f03mbk_  Number;
S180_    Varchar2(1);
k081_    Varchar2(1);
k092_    Varchar2(1);
k112_    Varchar2(1);
d_       Varchar2(1);
ddd_     Varchar2(3);
r050_    Varchar2(2);
nls_     Varchar2(15);
data_    Date;
dat1_    Date;
mdate_   Date;
kodp1_   Varchar2(35);
kodp2_   Varchar2(35);
acc_     Number;
acc1_    Number;
s180new_ Varchar2(1);
Sob_     Number;
SobPr_   Number;
userid_  Number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;


--------------------------------------------------------------------------
CURSOR Saldo IS
    SELECT s.acc, s.nls, s.kv, s.pap, a.fdat, s.nbs, s.mdate,
           DECODE(k.s240, ' ',
                               DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , FS180(a.acc), p.s180),
                         NULL, DECODE(p.s180, NULL, FS180(a.acc),
                                              ' ' , Fs180(a.acc), p.s180),
                  k.s240),
           MOD(c.codcagent, 2), c.rnk,
           GL.P_ICURVAL(s.kv,a.dos,Dat_),
           GL.P_ICURVAL(s.kv,a.kos,Dat_),
           GL.P_ICURVAL(s.kv, a.ostf-a.dos+a.kos, Dat_),
           acrn.FPROC(a.acc, Dat_),
---           acr.FPROC(a.acc, Dat_)
           s.tobo, s.nms
    FROM accounts s, saldoa a, customer c, kl_f3_29_int k, specparam p
    WHERE s.acc=a.acc                 AND
          s.acc=p.acc(+)              AND
          s.rnk=c.rnk                 AND
          s.nbs=k.r020                AND
          k.kf='15'                   AND
          a.fdat between Dat1_ AND Dat_ ;

CURSOR BaseL IS
    SELECT a.kodp, b.kodp, SUM(TO_NUMBER(a.znap)),
           SUM(TO_NUMBER(a.znap)*TO_NUMBER(b.znap))
    FROM rnbu_trace a, rnbu_trace b
    WHERE SUBSTR(a.kodp,2)=SUBSTR(b.kodp,2) AND
          (SUBSTR(a.kodp,1,1)='1' or SUBSTR(a.kodp,1,1)='3')  AND
          SUBSTR(b.kodp,1,1)='2'            AND
          a.nls = b.nls                     AND
          a.odate=b.odate                   AND
          TO_NUMBER(b.znap)>=0              AND
          a.userid = userid_                AND
          b.userid = userid_
    GROUP BY a.kodp, b.kodp;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_:=F_OURMFO();

Dat1_ := TRUNC(Dat_, 'MM');
----------------------------------------------------------------------------
OPEN Saldo;
LOOP
    FETCH Saldo INTO acc_, nls_, Kv_, pap_, data_, nbs_, mdate_, S180_,
                     Cntr_, rnk_, sDos_, sKos_, se_, sPCnt_, tobo_, nms_;
    EXIT WHEN Saldo%NOTFOUND;
    f03k_ := 1 ;
    f03d_ := 1 ;
    OB22_:='00';
    comm_ := '';

    IF nbs_='2620' or nbs_='2625' or nbs_='2630' or nbs_='2635' THEN
--- OB22
       BEGIN
          SELECT nvl(ob22,'00') INTO ob22_
          FROM  specparam_int
          WHERE acc(+)=acc_ ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          ob22_:='00';
       END ;
    END IF;

--- IF nbs_ not in ('2600','2605','2620','2625') and sDos_>0 THEN
---    IF sDos_ > 0 AND ((mfo_=300465 and  sPCnt_ >=0) or
---       (mfo_<>300465 and sPCnt_ <> 0)) THEN

------       IF se_ < 0 THEN
------          SELECT count(*) INTO f03k_ FROM kl_f3_29_int
------          WHERE kf='15' AND r020=nbs_ AND r050='11' AND r050=r050_;
------       END IF;

---       IF f03k_>0 THEN
---          IF sPCnt_ = 0 THEN
---             Cntr1_:='X' ;
---          ELSE
---             Cntr1_:= to_char(2-Cntr_) ;
---          END IF;
---          INSERT INTO rnbu_trace         -- ƒб. обороты
---                  (nls, kv, odate, kodp, znap)
---          VALUES  (nls_, Kv_, Dat_, '1' || nbs_ || S180_ ||
---                      SUBSTR(to_char(1000+Kv_),2,3) || OB22_,
---                      TO_CHAR(sDos_));
---          sPCnt1_ := LTRIM(TO_CHAR(ROUND(sPCnt_,4),'990D0000'));

---          INSERT INTO rnbu_trace         -- %% ставка
---                  (nls, kv, odate, kodp, znap)
---          VALUES  (nls_, Kv_, Dat_, '2' || nbs_ || S180_ ||
---                     SUBSTR(to_char(1000+Kv_),2,3) || ob22_, sPCnt1_) ;
---       END IF;
---    END IF;
--- END IF;

 IF (nbs_ in ('2620','2625') and se_>0) OR
    (nbs_ not in ('2600','2605') and sKos_>0) THEN

    IF nbs_='2620' or nbs_='2625' THEN
       vost_:=se_+sDos_-sKos_;
       IF vost_<0 THEN
          sKos_:=sKos_-ABS(vost_);
       END IF;
    END IF;

    --- дл€ —бербанка вычитаем из  т оборотов капитализацию процентов
--- проводки типа ƒт 2628 --->  т 2620, ƒт 2638 --->  т 2630,2635
    IF nbs_ in ('2620','2630','2635') and mfo_=300465  THEN
       vost_:=0;
       BEGIN
          SELECT NVL(SUM(s*100),0) INTO vost_
          FROM provodki
          WHERE fdat=Dat_ and
                ((substr(nlsd,1,4)='2628' and substr(nlsk,1,4)='2620') or
                 (substr(nlsd,1,4)='2638' and substr(nlsk,1,4)='2630') or
                 (substr(nlsd,1,4)='2638' and substr(nlsk,1,4)='2635'))
                 and nlsk=nls_ and kv=kv_ ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          vost_:=0 ;
       END;
       sKos_:=sKos_-vost_;

--- провер€ем признак субсчета (OB22 из specparam_int) и вычитаем такие проводки
       IF ((nbs_='2620' and ob22_ in ('08','09','11','12')) OR
           (nbs_='2630' and ob22_ in ('11','12','13','14')) OR
           (nbs_='2635' and ob22_ in ('13','14','15','16'))) THEN
          vost_:=0;
          BEGIN
             SELECT NVL(SUM(GL.P_ICURVAL(kv_, s*100, Dat_)),0) INTO vost_
             FROM provodki
             WHERE fdat=Dat_ and
                  ((substr(nlsd,1,4)='2620' and substr(nlsk,1,4)='2620') or
                   (substr(nlsd,1,4)='2630' and substr(nlsk,1,4)='2630') or
                   (substr(nlsd,1,4)='2635' and substr(nlsk,1,4)='2635'))
                    and nlsk=nls_ and kv=kv_ ;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             vost_:=0 ;
          END;
          sKos_:=sKos_-vost_;
       END IF;
    END IF;

    IF mfo_=300465 and nbs_='2625' and pap_=1 THEN
       sKos_:=0;
    END IF;

    IF sKos_ > 0 AND ((mfo_=300465 and  sPCnt_ >=0) or
       (mfo_<>300465 and sPCnt_ <> 0)) THEN

       comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
---       IF se_ > 0 THEN
---          SELECT count(*) INTO f03d_ FROM kl_f3_29_int
---         WHERE kf='15' AND r020=nbs_ AND r050='22' AND r050=r050_;
---       END IF;

       IF f03d_>0 THEN
          IF sPCnt_ = 0 THEN
             Cntr1_:='X' ;
             d_:='3';
          ELSE
             Cntr1_:= to_char(2-Cntr_) ;
             d_:='1';
          END IF;
          INSERT INTO rnbu_trace         --  р. обороты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
          VALUES (nls_, Kv_, Data_, d_ || nbs_ || S180_ ||
                  SUBSTR(to_char(1000+Kv_),2,3) || ob22_,
                  TO_CHAR(sKos_), acc_, comm_, tobo_);

          sPCnt1_ := LTRIM(TO_CHAR(ROUND(sPCnt_,4),'990D0000'));

          INSERT INTO rnbu_trace         -- %% ставка
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
          VALUES (nls_, Kv_, Data_, '2' || nbs_ || S180_ ||
                  SUBSTR(to_char(1000+Kv_),2,3) || ob22_, sPCnt1_, acc_, comm_, tobo_);

       END IF;
    END IF;
 END IF;

END LOOP;
CLOSE Saldo;
----------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep WHERE kodf='15' AND datf= Dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO kodp1_, kodp2_, Sob_, SobPr_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('15', Dat_, kodp1_, TO_CHAR(Sob_));

   IF SobPr_/Sob_ <> 0 THEN
      sPCnt1_ :=LTRIM(TO_CHAR(ROUND(SobPr_/Sob_,4),'990D0000')) ;

      INSERT INTO tmp_irep
           (kodf, datf, kodp, znap)
      VALUES
           ('15', Dat_, kodp2_, sPCnt1_);
   END IF;
END LOOP;
CLOSE BaseL;
----------------------------------------------------------------------
END P_F15sb;
/
show err;

PROMPT *** Create  grants  P_F15SB ***
grant EXECUTE                                                                on P_F15SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F15SB         to RPBN002;
grant EXECUTE                                                                on P_F15SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F15SB.sql =========*** End *** =
PROMPT ===================================================================================== 
