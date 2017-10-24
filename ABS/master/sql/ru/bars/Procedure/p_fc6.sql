

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FC6.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FC6 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FC6 (Dat_ DATE )  IS

nls_     Varchar2(15);
nlsk_    Varchar2(15);
nls_kas  Varchar2(15);
r013_    Varchar2(1);
rn_pova_ Number;
adr_pova_ Varchar2(70);
nam_a_    Varchar2(70);
adr_a_    Varchar2(70);
kb_      Varchar2(3);
okpo_    Varchar2(14);
data_    Date;
kv1_     Number;
kv_      Number;
prf_     Number;
dat1_    Date;
sn_      DECIMAL(24) ;
kodp_    Varchar2(10);
znap_    Varchar2(70);
VVV      Varchar2(3) ;
d020_    Varchar2(3) ;
d020_1   Varchar2(3) ;
d020_2   Varchar2(3) ;
nnn_     Number;
mfo_     Varchar2(12);
userid_  Number;

--- счета пунктов обмена валюты на агент.условиях ПОВ-А
CURSOR POV_A IS
   SELECT distinct trim(rn_pov_a), trim(adr_pov_a), trim(okpo_a), trim(nam_a), trim(adr_a), trim(to_char(kb))
   FROM KL_POV_a
   WHERE nls is not NULL and substr(nls,1,4)='1003' and kv is not null and
         kv<>980 ;

--- проводки за месяц
CURSOR OPL_DOK IS
   SELECT o.nlsd, o.kv, o.fdat, NVL(substr(a1.value,1,3),'000'),
          o.nlsk, SUM(o.s*100)
   FROM  provodki o, operw a1, kl_pov_a s
   WHERE  (to_number(substr(o.nlsd,1,4))<1007 or
           to_number(substr(o.nlsk,1,4))<1007)       and
           o.fdat > Dat1_                            and
           o.fdat <= Dat_                            and
           a1.tag(+) ='D#73'                         and
           a1.ref(+)=o.ref                           and
           (o.nlsd=s.nls or o.nlsk=s.nls)            and
           o.kv=s.kv                                 and
           s.rn_pov_a=rn_pova_
   GROUP BY o.nlsd, o.kv, o.fdat, NVL(substr(a1.value,1,3),'000'),
            o.nlsk
UNION ALL
   SELECT o.nlsd, o.kv, o.fdat, NVL(substr(a2.value,1,3),'000'),
          o.nlsk, SUM(o.s*100)
   FROM  provodki o, operw a2, kl_pov_a s
   WHERE  (to_number(substr(o.nlsd,1,4))<1007 or
           to_number(substr(o.nlsk,1,4))<1007)       and
           o.fdat > Dat1_                            and
           o.fdat <= Dat_                            and
           substr(a2.tag,1,2)='73'                   and
           substr(a2.tag,3,3)=o.tt                   and
           a2.ref=o.ref                              and
           (o.nlsd=s.nls or o.nlsk=s.nls)            and
            o.kv=s.kv                                and
            s.rn_pov_a=rn_pova_
   GROUP BY o.nlsd, o.kv, o.fdat, NVL(substr(a2.value,1,3),'000'),
            o.nlsk ;

CURSOR BaseL IS
    SELECT kodp, znap
    FROM rnbu_trace
    WHERE userid=userid_  and substr(kodp,1,2) not in ('71','72')
    ORDER BY kodp;

CURSOR BaseL1 IS
    SELECT kodp, SUM(to_number(znap))
    FROM rnbu_trace
    WHERE userid=userid_ and substr(kodp,1,2) in ('71','72')
    GROUP BY kodp
    ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
---mfo_:=F_OURMFO();
Dat1_:= TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
nnn_:=0;

OPEN POV_A;
LOOP
   FETCH POV_A INTO rn_pova_, adr_pova_, okpo_, nam_a_, adr_a_, kb_ ;
   EXIT WHEN POV_A%NOTFOUND;

   nnn_:=nnn_+1;

   kodp_:='20'||SUBSTR(to_char(10000+nnn_),2,4)||'000';
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                          (nls_kas, kv1_, Dat_, kodp_, kb_);

   kodp_:='31'||SUBSTR(to_char(10000+nnn_),2,4)||'000';
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                          (nls_kas, kv1_, Dat_, kodp_, to_char(rn_pova_));

   kodp_:='32'||SUBSTR(to_char(10000+nnn_),2,4)||'000';
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                          (nls_kas, kv1_, Dat_, kodp_, adr_pova_);

   kodp_:='51'||SUBSTR(to_char(10000+nnn_),2,4)||'000';
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                          (nls_kas, kv1_, Dat_, kodp_, okpo_);

   kodp_:='52'||SUBSTR(to_char(10000+nnn_),2,4)||'000';
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                          (nls_kas, kv1_, Dat_, kodp_, nam_a_);

   kodp_:='53'||SUBSTR(to_char(10000+nnn_),2,4)||'000';
   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                          (nls_kas, kv_, Dat_, kodp_, adr_a_);

   OPEN OPL_DOK;
   LOOP
      FETCH OPL_DOK INTO nls_, kv_, data_, d020_, nlsk_, sn_ ;
      EXIT WHEN OPL_DOK%NOTFOUND;
      prf_:=0;
-------------------------------------------------------------------------------
--- 05.07.2003 изменение кодов 250 на коды 261, 262, 263
--- для новых правил формирования

      IF (substr(nls_,1,4)='1003' and substr(nlsk_,1,4)='3800') and d020_='263' THEN ---sn_>0 and
         kodp_:= '71'||SUBSTR(to_char(10000+nnn_),2,4)||SUBSTR(to_char(1000+kv_),2,3) ;
         znap_:= sn_; ---TO_CHAR(SN_) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
         prf_:=1;
      END IF;
      IF (substr(nls_,1,4)='1003' and substr(nlsk_,1,4)='3800') and d020_='000' THEN ---sn_>0 and
         kodp_:= '71'||SUBSTR(to_char(10000+nnn_),2,4)||SUBSTR(to_char(1000+kv_),2,3) ;
         znap_:= sn_; ---TO_CHAR(SN_) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
         prf_:=1;
      END IF;
-------------------------------------------------------------------------------
      IF (substr(nls_,1,4)='3800' and substr(nlsk_,1,4)='1003') and d020_='363' THEN ---sn_>0 and
         kodp_:= '72'||SUBSTR(to_char(10000+nnn_),2,4)||SUBSTR(to_char(1000+kv_),2,3) ;
         znap_:= sn_; --- TO_CHAR(SN_) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nlsk_, kv_, data_, kodp_, znap_);
         prf_:=1;
      END IF;
      IF (substr(nls_,1,4)='3800' and substr(nlsk_,1,4)='1003') and d020_='000' THEN ---sn_>0 and
         kodp_:= '72'||SUBSTR(to_char(10000+nnn_),2,4)||SUBSTR(to_char(1000+kv_),2,3) ;
         znap_:= sn_ ; ---TO_CHAR(SN_) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nlsk_, kv_, data_, kodp_, znap_);
         prf_:=1;
      END IF;

   END LOOP;
   CLOSE OPL_DOK;

END LOOP;
CLOSE POV_A;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='C6' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('C6', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
---------------------------------------------------
OPEN BaseL1;
LOOP
   FETCH BaseL1 INTO  kodp_, znap_;
   EXIT WHEN BaseL1%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('C6', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL1;
-----------------------------------------------------------------------------
END p_fc6;
/
show err;

PROMPT *** Create  grants  P_FC6 ***
grant EXECUTE                                                                on P_FC6           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FC6.sql =========*** End *** ===
PROMPT ===================================================================================== 
