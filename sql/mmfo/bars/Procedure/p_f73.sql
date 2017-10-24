

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F73.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F73 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F73 (Dat_ DATE )  IS

nls_    varchar2(15);
nlsk_   varchar2(15);
data_   date;
kv_     number;
ref_    number;
prf_    number;
dat1_   Date;
dig_    number;
bsu_    number;
sum1_   number;
sum0_   number;
buf_    Number;
sn_     DECIMAL(24) ;
kodp_   varchar2(10);
znap_   varchar2(30);
VVV     varchar2(3) ;
d020_   varchar2(3) ;
d020_1  varchar2(3) ;
d020_2  varchar2(3) ;
a_      varchar2(20);
b_      varchar2(20);
mfo_    Number;
userid_ Number;

CURSOR tval IS
SELECT  o.nlsa, o.kv, o.vdat, SUM(o.s*o.dk), SUM(o.s*(1-o.dk))
FROM oper o, tts t
WHERE o.sos=5                   AND
      o.tt=t.tt                 AND
      t.flv=1                   AND
      o.vdat>Dat1_              AND
      o.vdat<=Dat_              AND
      o.kv <>980                AND
      o.kv2 =980                AND
      substr(o.nlsa,1,4)='1002' AND        --'а<ютRRбм_--ы_ Rп_рации пR касс_
      substr(o.nlsb,1,4)='1002'
GROUP BY o.nlsa, o.kv, o.vdat ;

--- _бRрRты д<я фаc<а #73
---CURSOR OPL_DOK IS
---   SELECT a.nls, a.kv, c.fdat, substr(k.value,1,3), SUM(c.s)
---   FROM accounts a, opldok c, operw k
---   WHERE a.acc =c.acc                    AND
---         c.dk=0                       AND
---         a.kv<>980                       AND
---         c.sos=5                         AND
---         c.fdat> Dat1_                   AND
---         c.fdat<=Dat_                    AND
---         c.ref=k.ref                     AND
---         (k.tag='D020' or k.tag='D#73')  AND
---         substr(a.nls,1,3)='100'
---   GROUP BY a.nls, a.kv, c.fdat, k.value ;

CURSOR OPL_DOK IS
   SELECT o.ref, o.nlsd, o.kv, o.fdat, NVL(substr(a1.value,1,3),'000'),
          o.s*100, o.nlsk
   FROM  provodki o, operw a1
   WHERE  o.kv<>980                                  and
          ((to_number(substr(o.nlsd,1,4))<1007       and
           to_number(substr(o.nlsk,1,4))<>1007)      or
           (to_number(substr(o.nlsk,1,4))<1007       and
           to_number(substr(o.nlsd,1,4))<>1007))     and
           o.fdat > Dat1_                            and
           o.fdat <= Dat_                            and
           a1.tag ='D#73'                            and
           a1.ref=o.ref                              and
           o.tt not in
           (SELECT substr(tag,-3) FROM op_rules WHERE tag LIKE '73%')
UNION ALL
   SELECT o.ref, o.nlsd, o.kv, o.fdat, NVL(substr(a2.value,1,3),'000'),
          o.s*100, o.nlsk
   FROM  provodki o, operw a2
   WHERE  o.kv<>980                                  and
          ((to_number(substr(o.nlsd,1,4))<1007       and
           to_number(substr(o.nlsk,1,4))<>1007)      or
           (to_number(substr(o.nlsk,1,4))<1007       and
           to_number(substr(o.nlsd,1,4))<>1007))     and
           o.fdat > Dat1_                            and
           o.fdat <= Dat_                            and
           substr(a2.tag,1,2)='73'                   and
           substr(a2.tag,3,3)=o.tt                   and
           a2.ref=o.ref                              and
           o.tt not in (select tt from op_rules where tag='D#73' ) ;

CURSOR BaseL IS
    SELECT kodp, SUM(TO_NUMBER(znap))
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp
    ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
mfo_:=F_OURMFO();
Dat1_:= TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));

--- убра< вўбRрку пR пRкупк_/прRдаж_ ва<юты т.к. в Rп_рациях
--- пR пRкупк_/прRдаж_ ва<юты в-_с_-ы пRстRя--ы_ кRды 250 и 350
---  16.05.2001

---OPEN tval;
---LOOP
---FETCH tval INTO nls_, kv_, data_, sum1_, sum0_ ;
---EXIT WHEN tval%NOTFOUND;

---   VVV:=substr((1000+kv_) || '' ,2,3) ;
---   IF sum1_>0  THEN --_Rкупка ва<юты
---      a_:='250' || VVV ;
---      b_:=TO_CHAR(sum1_) ;
---      INSERT INTO rnbu_trace (nls, kv, odate,kodp, znap) VALUES
---                             (nls_, kv_, data_, a_, b_) ;
---   END IF;
---   IF sum0_>0  THEN --_рRдажа ва<юты
---      a_:='350' || VVV ;
---      b_:=TO_CHAR(sum0_) ;
---      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                             (nls_, kv_, data_, a_, b_) ;
---   END IF;
---END LOOP;
---CLOSE tval;

-----------------------------------------------------------------------
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO ref_, nls_, kv_, data_, d020_, sn_, nlsk_ ;
   EXIT WHEN OPL_DOK%NOTFOUND;
   prf_:=0;
---   IF to_number(D020_1)<>0 THEN
---      d020_:=d020_1 ;
---   ELSIF to_number(D020_2)<>0 THEN
---         d020_:= d020_2 ;
---   ELSE
---      d020_:='000' ;
---   END IF;
   if d020_<>'000' then
      begin
         buf_ := to_number(d020_);
      exception when others then
         if sqlcode=-6502 then
            raise_application_error(-20001,'Помилка: введений D020 не числове значення (ref='||ref_||', d020='''||d020_||''')');
         else
            raise_application_error(-20002,'Помилка: '||sqlerrm);
         end if;
      end;
   end if;
-------------------------------------------------------------------------------
--- 05.07.2003 изменение кодов 250 на коды 261, 262, 263
--- для новых правил формирования

   IF sn_>0 and (substr(nls_,1,4)='1001' and substr(nlsk_,1,4)='3800') and d020_='250' THEN
      kodp_:= '261' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
   IF sn_>0 and (substr(nls_,1,4)='1002' and substr(nlsk_,1,4)='3800') and d020_='250' THEN
      kodp_:= '262' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
   IF sn_>0 and (substr(nls_,1,4)='1003' and substr(nlsk_,1,4)='3800') and d020_='250' THEN
      kodp_:= '262' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
-------------------------------------------------------------------------------
   IF sn_>0 and (substr(nls_,1,4) in ('1001','1002') and
      substr(nlsk_,1,4)='3800') and d020_='000' THEN
      kodp_:= '261' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
   IF sn_>0 and (substr(nls_,1,4)='1003' and substr(nlsk_,1,4)='3800') and d020_='000' THEN
      kodp_:= '262' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
-------------------------------------------------------------------------------
--- 05.07.2003 изменение кодов 350 на коды 361, 362, 363
--- для новых правил формирования

   IF sn_>0 and substr(nls_,1,4)='3800' and
      substr(nlsk_,1,4) in ('1001','1002') and d020_='350' THEN
      kodp_:= '361' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
   IF sn_>0 and (substr(nls_,1,4)='3800' and substr(nlsk_,1,4)='1003') and d020_='350' THEN
      kodp_:= '362' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
-------------------------------------------------------------------------------
   IF sn_>0 and substr(nls_,1,4)='3800' and substr(nlsk_,1,4) in ('1001','1002') and
      d020_='000' THEN
      kodp_:= '361' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;
   IF sn_>0 and (substr(nls_,1,4)='3800' and substr(nlsk_,1,4)='1003') and d020_='000' THEN
      kodp_:= '362' || SUBSTR(to_char(1000+kv_),2,3) ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
      prf_:=1;
   END IF;

---   IF sn_>0 and (substr(nls_,1,4)='1002' and substr(nlsk_,1,4)='1007') and d020_='000' THEN
---      kodp_:= '280' || SUBSTR(to_char(1000+kv_),2,3) ;
---      znap_:= TO_CHAR(SN_) ;
---      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                             (nlsk_, kv_, data_, kodp_, znap_);
---      kodp_:= '380' || SUBSTR(to_char(1000+kv_),2,3) ;
---      znap_:= TO_CHAR(SN_) ;
---      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                             (nls_, kv_, data_, kodp_, znap_);
---      prf_:=1;
---   END IF;

---   IF sn_>0 and (substr(nls_,1,4)='1007' and substr(nlsk_,1,4)='1002') and d020_='000' THEN
---      kodp_:= '380' || SUBSTR(to_char(1000+kv_),2,3) ;
---      znap_:= TO_CHAR(SN_) ;
---      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                             (nls_, kv_, data_, kodp_, znap_);
---      kodp_:= '280' || SUBSTR(to_char(1000+kv_),2,3) ;
---      znap_:= TO_CHAR(SN_) ;
---      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                             (nlsk_, kv_, data_, kodp_, znap_);
---      prf_:=1;
---   END IF;

   IF sn_>0 and d020_='000' and prf_=0 and (substr(nls_,1,3)='100' and
      (substr(nlsk_,1,4)<>'3800' and substr(nlsk_,1,4)<>'1007')) THEN
      IF d020_<>'280' and d020_<>'380' THEN
         kodp_:= d020_ || SUBSTR(to_char(1000+kv_),2,3) ;
         znap_:= TO_CHAR(SN_) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
         prf_:=1;
      END IF;
   END IF;

   IF sn_>0 and d020_='000' and prf_=0 and ((substr(nls_,1,4)<>'3800' and
      substr(nls_,1,4)<>'1007') and substr(nlsk_,1,3)='100') THEN
      IF d020_<>'280' and d020_<>'380' THEN
         kodp_:= d020_ || SUBSTR(to_char(1000+kv_),2,3) ;
         znap_:= TO_CHAR(SN_) ;
         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
         prf_:=1;
      END IF;
   END IF;

   IF SN_>0 and prf_=0 THEN
      IF substr(nls_,1,3)='100' and to_number(d020_) < 300 THEN
         IF d020_<>'280' THEN
            kodp_:= d020_ || SUBSTR(to_char(1000+kv_),2,3) ;
            znap_:= TO_CHAR(SN_) ;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                   (nls_, kv_, data_, kodp_, znap_);
         END IF;
      END IF;

      IF substr(nlsk_,1,3)='100' and to_number(d020_) > 300 THEN
         IF d020_<>'380' THEN
            kodp_:= d020_ || SUBSTR(to_char(1000+kv_),2,3) ;
            znap_:= TO_CHAR(SN_) ;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                   (nlsk_, kv_, data_, kodp_, znap_);
         END IF;
      END IF;

      IF substr(nls_,1,3)='100' and to_number(d020_) > 300  THEN

         if substr(nlsk_,1,4)='3800' and d020_ in ('361','362','363') then
            d020_:=to_char(to_number(d020_)-100);
         end if;

         IF mfo_=300465 and d020_='310' THEN
---            kodp_:= '280' || SUBSTR(to_char(1000+kv_),2,3) ;
            kodp_:= '270' || SUBSTR(to_char(1000+kv_),2,3) ;
         END IF ;
         if to_number(d020_)>300 then
            d020_:='200';
         end if;
         IF d020_<>'280' and d020_<>'380' THEN
            znap_:= TO_CHAR(SN_) ;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                   (nlsk_, kv_, data_, kodp_, znap_);
         END IF;
      END IF ;

      IF substr(nlsk_,1,3)='100' and to_number(d020_) < 300  THEN
         IF d020_<>'280' THEN
            if substr(nls_,1,4)='3800' and d020_ in ('261','262','263') then
               d020_:=to_char(to_number(d020_)+100);
            end if;
            if to_number(d020_)<300 then
               d020_:='300';
            end if;
            kodp_:= d020_ || SUBSTR(to_char(1000+kv_),2,3) ;
            znap_:= TO_CHAR(SN_) ;
            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                   (nlsk_, kv_, data_, kodp_, znap_);
         END IF;
      END IF ;

---     IF substr(nls_,1,3)='100' and substr(nlsk_,1,3)='100' and
---        to_number(d020_)<>0 and to_number(d020_) >300  THEN
---        kodp_:= to_char(to_number(d020_)-100) || SUBSTR(to_char(1000+kv_),2,3) ;
---        znap_:= TO_CHAR(SN_) ;
---        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                                (nlsk_, kv_, data_, kodp_, znap_);
---     END IF ;

---     IF substr(nls_,1,3)='100' and substr(nlsk_,1,3)='100' and
---        to_number(d020_)<>0 and to_number(d020_)<300   THEN
---        kodp_:= to_char(to_number(d020_)+100) || SUBSTR(to_char(1000+kv_),2,3) ;
---        znap_:= TO_CHAR(SN_) ;
---        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                                (nlsk_, kv_, data_, kodp_, znap_);
---     END IF;

---     IF substr(nls_,1,3)='100' and substr(nlsk_,1,3)<>'100' and
---        to_number(d020_)<>0 and to_number(d020_) >300  THEN
---        kodp_:= to_char(to_number(d020_)-100) || SUBSTR(to_char(1000+kv_),2,3) ;
---        znap_:= TO_CHAR(SN_) ;
---        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                                (nls_, kv_, data_, kodp_, znap_);
---     END IF ;

---     IF substr(nlsk_,1,3)='100' and substr(nls_,1,3)<>'100' and
---        to_number(d020_)<>0 and to_number(d020_)<300  THEN
---        kodp_:= to_char(to_number(d020_)+100) || SUBSTR(to_char(1000+kv_),2,3) ;
---        znap_:= TO_CHAR(SN_) ;
---        INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
---                               (nlsk_, kv_, data_, kodp_, znap_);
---     END IF;

   END IF;
END LOOP;
CLOSE OPL_DOK;
---------------------------------------------------
DELETE FROM tmp_nbu where kodf='73' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('73', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;

---INSERT INTO tmp_nbu (kodf,datf,kodp,znap) VALUES ('73',dat_,'370'||VVV,'0');

for i in (select r020, ddd from kl_f3_29 where kf='73' order by ddd)
loop
   BEGIN
      IF to_number(i.r020)<>0 THEN
         INSERT INTO tmp_nbu (kodf, datf, kodp, znap) VALUES
                             ('73', dat_, i.ddd || '000', i.r020);
      END IF;
   END;
end loop;
-----------------------------------------------------------------------------
p_ch_file73('73',dat_,userid_);
-----------------------------------------------------------------------------
END p_f73;
/
show err;

PROMPT *** Create  grants  P_F73 ***
grant EXECUTE                                                                on P_F73           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F73           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F73.sql =========*** End *** ===
PROMPT ===================================================================================== 
