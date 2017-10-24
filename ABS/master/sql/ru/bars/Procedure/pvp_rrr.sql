

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PVP_RRR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PVP_RRR ***

  CREATE OR REPLACE PROCEDURE BARS.PVP_RRR ( dat_ IN DATE DEFAULT NULL)
   IS
/*
   14-01-2010 Sta. ������ ����.�� ��� ������� �� ������� PVP.
    Finis/����.����.�i����� ��� ���.3800090310/840
    (��������� ���������)

   ���������, ������� ������ ��� �� ��  ���������� ���.��� !

   �� ������ ����� vp_list.acc6204  - �  GL.p_pvp
   ���������� ���� vp_list.acc_RRR  -    RU_p_pvp - ��.����
   �����, ����� ��������� RU_p_pvp, - ������ �� �������
*/


PROCEDURE RU_p_pvp ( kv_ NUMBER DEFAULT NULL, dat_  DATE DEFAULT NULL) IS

fdat_    DATE;
acc3801_ NUMBER;       -- sch EKV VAL POZ
acc_RRR_ NUMBER;       -- sch PER VAL POZ
s1_      DECIMAL(24);  -- VAL POZ tek kurs
s2_      DECIMAL(24);  -- na sch EKV VAL POZ
dk_      INTEGER;
ref_     INTEGER;
name_    VARCHAR2(70);  -- PVP Transaction name
nam_a_   VARCHAR2(70);
nam_b_   VARCHAR2(70);
nls3801_ VARCHAR2(15);   -- sch EKV VAL POZ
nls3800_ VARCHAR2(15);   -- sch VAL POZ
nls6204_ VARCHAR2(15);   -- sch PER VAL POZ


CURSOR c0 IS
SELECT v.acc3801,v.acc_RRR,  a.nls,
       SUM( gl.p_icurval(a.kv, s.ostf-s.dos+s.kos, gl.bDATE ))
FROM accounts a, saldoa s, vp_list v
WHERE a.acc=v.acc3800 AND a.acc=s.acc AND
 (a.acc,s.fdat) = (SELECT c.acc,MAX(c.fdat) FROM saldoa c
                   WHERE c.acc=a.acc AND c.fdat<=gl.bDATE GROUP BY c.acc)
  AND (a.kv=kv_ OR kv_ is NULL)
GROUP BY v.acc3801,v.acc_RRR, a.nls
ORDER BY 1, 2;

ern         CONSTANT POSITIVE := 205;
err         EXCEPTION;
erm         VARCHAR2(80);

BEGIN

fdat_ := NVL(dat_,gl.bDATE);

BEGIN
   SELECT name INTO name_ FROM tts WHERE tt='PVP';
EXCEPTION  WHEN NO_DATA_FOUND THEN name_ := 'NO_DATA_FOUND tts.TT=PVP';
END;


FOR d IN ( SELECT gl.bDATE fdat FROM dual
     UNION SELECT fdat          FROM fdat WHERE fdat >= fdat_
           GROUP BY fdat ORDER BY 1 )
LOOP
   gl.bDATE := d.fdat;

   OPEN c0;
   LOOP <<MET>>

      FETCH c0 INTO acc3801_,acc_RRR_,nls3800_, s1_;
      EXIT WHEN c0%NOTFOUND;

      IF acc3801_ IS NULL OR acc_RRR_ IS NULL THEN  GOTO MET;   END IF;

      BEGIN
         SELECT s.ostf-s.dos+s.kos INTO s2_
         FROM accounts a,saldoa s
         WHERE a.acc = acc3801_ AND a.acc=s.acc AND  (s.acc,s.fdat) =
               (SELECT c.acc,MAX(c.fdat) FROM saldoa c
                WHERE c.acc=a.acc AND c.fdat<=gl.bDATE GROUP BY c.acc );
      EXCEPTION  WHEN NO_DATA_FOUND THEN s2_ := 0;
      END;

      s2_ := s1_ + s2_;
      IF s2_ = 0 THEN  GOTO MET;                     END IF;  -- est ravenstvo
      IF s2_ > 0 THEN  dk_ := 0;  ELSE    dk_ := 1;  END IF;

      BEGIN
         SELECT nls,nms INTO nls3801_,nam_a_  FROM accounts WHERE acc=acc3801_;
      EXCEPTION  WHEN NO_DATA_FOUND THEN nam_a_ := 'NO_DATA_FOUND 3801';
      END;

      BEGIN
         SELECT nls,nms INTO nls6204_,nam_b_ FROM accounts WHERE acc=acc_RRR_;
      EXCEPTION WHEN NO_DATA_FOUND THEN nam_b_ := 'NO_DATA_FOUND 6204/2';
      END;

      gl.ref (ref_);
      INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,userid,
                      nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,nazn)
      VALUES  (ref_,'PVP',6,ref_,1-dk_,SYSDATE,gl.bDATE,gl.bDATE,gl.aUID,
       SUBSTR(nam_a_,1,38),nls3801_,gl.aMFO,
       SUBSTR(nam_b_,1,38),nls6204_,gl.aMFO,gl.baseval,ABS(s2_),
       'Finis/����.����.�i����� ��� ���.'||nls3800_ ||'/'||kv_);

      gl.pay2( NULL,ref_,gl.bDATE,'PVP',gl.baseval,  dk_,acc3801_,ABS(s2_),0,1,name_);
      gl.pay2( NULL,ref_,gl.bDATE,'PVP',gl.baseval,1-dk_,acc_RRR_,ABS(s2_),0,0,name_);
      gl.pay2( 2,   ref_,gl.bDATE);

   END LOOP;
   CLOSE c0;

END LOOP;

gl.param;

EXCEPTION WHEN err    THEN gl.param;
               raise_application_error(-(20000+ern),'\'||erm,TRUE);
          WHEN OTHERS THEN gl.param;
               raise_application_error(-(20000+ern),SQLERRM,TRUE);
END RU_p_pvp;
------------------------------------

begin
  for k  in (select kv from tabval where d_close is null)
  loop
     RU_p_pvp ( k.kv, dat_ ) ;
  end loop;

end PVP_RRR;
/
show err;

PROMPT *** Create  grants  PVP_RRR ***
grant EXECUTE                                                                on PVP_RRR         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PVP_RRR         to TECH005;
grant EXECUTE                                                                on PVP_RRR         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PVP_RRR.sql =========*** End *** =
PROMPT ===================================================================================== 
