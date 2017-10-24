

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F92.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F92 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F92 (Dat_ DATE )  IS  --( _sDate VARCHAR(10))

nls_     varchar2(15);
data_    date;
kv_      SMALLINT;
s35      DECIMAL(24);
s70      DECIMAL(24);
kodp_    varchar2(10);
znap_    varchar2(30);
sk_      SMALLINT;
sk2_     SMALLINT;
s_       DECIMAL(24);
nbu_     SMALLINT;
ref_     Number;
userid_  Number;

--Обороты
---CURSOR OPERA IS
---select o.nlsa, o.kv, p.fdat,
---       decode( p.tt,o.tt,o.sk,t.sk), p.s
---from opldok p, oper o, tts t, accounts a    ---kl_d010 k
---where o.ref=p.ref and t.tt=p.tt and a.acc=p.acc and a.tip='KAS' and
---p.fdat=Dat_ and p.dk=0 and decode( p.tt,o.tt,o.sk,t.sk)<40

---union all

---select o.nlsa, o.kv, p.fdat,
---       decode( p.tt,o.tt,o.sk,t.sk), p.s
---from opldok p, oper o, tts t, accounts a     ---kl_d010 k
---where o.ref=p.ref and t.tt=p.tt and a.acc=p.acc and a.tip='KAS' and
---p.fdat=Dat_ and p.dk=1 and decode( p.tt,o.tt,o.sk,t.sk)>39
--- and o.sk=TO_NUMBER(k.d010)  AND k.f_12='1' ;

---union all
---select o.nlsa, o.kv, p.fdat,
---       decode( p.dk,0,39,66), p.s
---from opldok p, oper o, tts t, accounts a
---where o.ref=p.ref and t.tt=p.tt and a.acc=p.acc and a.tip='KAS' and
---p.fdat=Dat_ and (
---decode( p.tt,o.tt,o.sk,t.sk) is null or
---       p.dk=1 and decode( p.tt,o.tt,o.sk,t.sk)<40 or
---      p.dk=0 and decode( p.tt,o.tt,o.sk,t.sk)>39 ) ;

CURSOR OPERA IS
   SELECT  o.nlsa, o.kv, p.fdat, p.ref,
           decode(p.tt, o.tt, o.sk, t.sk), p.s
   FROM OPER o, OPLDOK p, ACCOUNTS s, tts t   --- KL_D010 k
   WHERE p.acc=s.acc             AND
         s.tip='KAS'             AND
         p.fdat=Dat_             AND
         o.ref=p.ref             AND
         p.sos=5                 AND
         p.tt=t.tt ;
---         o.sk=TO_NUMBER(k.d010)  AND
---         k.f_12='1' ;

--Остатки
CURSOR SALDO IS
   SELECT  o.nls, o.kv, sa.fdat, sa.ostf, sa.ostf+sa.kos-sa.dos
   FROM saldoa sa, accounts o
   WHERE o.tip='KAS'    AND
         o.acc=sa.acc   AND
         sa.fdat  IN ( SELECT max ( bb.fdat )
                  FROM  saldoa bb
                  WHERE o.acc = bb.acc AND bb.fdat  <= Dat_) ;

CURSOR BaseL IS
   SELECT kodp, SUM (znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp
   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
nbu_:= IsNBUBank();

OPEN OPERA;
LOOP
   FETCH OPERA INTO nls_, kv_, data_, ref_, sk_, s_ ;
   EXIT WHEN OPERA%NOTFOUND;
   if sk_ is not null then
      begin
         select to_number(substr(value,1,2)) into sk2_
         from operw where ref=ref_ and tag='SK';
         exception when no_data_found then
         sk2_:= NULL;
      end;
      if sk2_ is not null then
         sk_:=sk2_ ;
      end if;
   end if;

   IF sk_ is null THEN
      begin
         select to_number(substr(value,1,2))  into sk_
         from operw where ref=ref_ and tag='SK';
         exception when others then sk_:=0;
      end;
   END IF ;

   IF s_<>0 THEN
      kodp_:= iif_N(sk_,10,'0','','') || TO_CHAR(sk_);
      znap_:= TO_CHAR(s_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE OPERA;

OPEN SALDO;
LOOP
   FETCH SALDO INTO nls_, kv_, data_, s35, s70 ;
   EXIT WHEN SALDO%NOTFOUND;
   IF data_=Dat_ THEN
      s_ := s35 ;
   ELSE
      s_ := s70 ;
   END IF ;
   IF (s35 <> 0 OR s70 <> 0) THEN
      IF nbu_ = 1 THEN
         kodp_:= '34';
      ELSE
         kodp_:= '35';
      END IF;
      znap_:= TO_CHAR(ABS(s_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
   IF s70 <> 0 THEN
      IF nbu_ = 1 THEN
         kodp_:= '69';
      ELSE
         kodp_:= '70';
      END IF;
      znap_:= ABS(s70) || '' ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);
   END IF;
END LOOP;
CLOSE SALDO;
---------------------------------------------------
DELETE FROM tmp_nbu where datf=Dat_ and kodf='92' ;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('92', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_f92;
/
show err;

PROMPT *** Create  grants  P_F92 ***
grant EXECUTE                                                                on P_F92           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F92           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F92.sql =========*** End *** ===
PROMPT ===================================================================================== 
