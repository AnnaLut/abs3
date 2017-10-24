

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/K2P.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure K2P ***

  CREATE OR REPLACE PROCEDURE BARS.K2P ( ID_ int, NPAR_ int ) IS
tmp_     varchar2(30) ;
c        number       ;
er       number       ;
ACC9_    int          ;
NLS9_    varchar2(15) ;
ACC_     int          ;
PR_      int          ;
OCH_     int          ;
REF_     int          ;
FDAT_    date         ;
SD_      int          ;
S_       int          ;
CURSOR c98 IS
  SELECT A9.acc, A9.NLS, A2.ACC  FROM ACCOUNTS A9, ACCOUNTS A2
  WHERE A9.ISP=ID_    AND
        A9.NBS='9803' AND  A9.KV=980   AND A9.OSTC<0 AND
        A2.NBS='2600' AND  A2.KV=980   AND A2.OSTC>0 AND
        SUBSTR(A9.NLS,6,9)=SUBSTR(A2.NLS,6,9) AND
        A2.blkd=0;
CURSOR c0 IS
  SELECT nvl(v.PROC_KP,0)*100, v.n_vp,  o.ref,
          min(o.fdat),   max(o.s),    sum(decode(o.dk,0,o.s,-o.s))
  FROM oper p,  opldok o,  operw w,  vid_pl v
  WHERE O.ACC=ACC9_   AND
        O.SOS=5       AND
        p.ref = o.ref AND
        p.tt  = 'K2A' AND
        p.ref = w.ref AND
       (o.tt ='K2B' and o.dk=0 or o.tt='K2O' and o.dk=1 ) AND
        w.tag='VIDPL' AND
        w.value=to_char(v.kod)
  GROUP BY v.PROC_KP, v.n_vp, o.ref
  HAVING sum(decode(o.dk,0,o.s,-o.s)) <> 0  ;
BEGIN
   delete from k2tmp where isp=ID_;   OPEN c98;
   LOOP
      FETCH c98 INTO ACC9_,NLS9_,ACC_;   EXIT WHEN c98%NOTFOUND;   OPEN c0;
      LOOP
         <<M2>> FETCH c0 into PR_,OCH_,REF_,FDAT_,SD_,S_ ;
                EXIT WHEN c0%NOTFOUND;
           If NPAR_<4 and  PR_ <=0  THEN  GOTO M2;  end if;
           INSERT INTO k2tmp
                  (isp,ACC9, NLS9, PR, OCH, ACC, REF, FDAT, SD, S)
           VALUES (id_,ACC9_,NLS9_,PR_,OCH_,ACC_,REF_,FDAT_,SD_,S_);
      END LOOP;
      close c0;
   END LOOP;
   close c98;
END K2p;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/K2P.sql =========*** End *** =====
PROMPT ===================================================================================== 
