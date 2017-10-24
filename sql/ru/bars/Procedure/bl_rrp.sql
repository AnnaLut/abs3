

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BL_RRP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BL_RRP ***

  CREATE OR REPLACE PROCEDURE BARS.BL_RRP ( rc IN OUT NUMBER, kv IN NUMBER,
          mfoa_p IN VARCHAR2, mfoa IN VARCHAR2, nlsa IN VARCHAR2,
          mfob_p IN VARCHAR2, mfob IN VARCHAR2, nlsb IN VARCHAR2,
              dk IN NUMBER,  s IN NUMBER,
            id_a IN VARCHAR2 DEFAULT NULL,
            id_b IN VARCHAR2 DEFAULT NULL,
            ref  IN NUMBER   DEFAULT NULL ) IS 
classa NUMBER := 0;
classb NUMBER := 0;
nbsa   VARCHAR2(4);
nbsb   VARCHAR2(4);
erm    VARCHAR2 (80);
ern    CONSTANT POSITIVE := 715;
err    EXCEPTION;
BEGIN
   IF deb.debug THEN
      deb.trace( ern, 'module/0', 'bl_rrp');
      deb.trace( ern, 'kv', kv);
      deb.trace( ern, 'mfoa_p', mfoa_p);
      deb.trace( ern, 'mfoa', mfoa);
      deb.trace( ern, 'nlsa', nlsa);
      deb.trace( ern, 'mfob_p', mfob_p);
      deb.trace( ern, 'mfob', mfob);
      deb.trace( ern, 'nlsb', nlsb);
      deb.trace( ern, 'dk', dk);
      deb.trace( ern, 's', s);
      deb.trace( ern, 'id_a', id_a);
      deb.trace( ern, 'id_b', id_b);
      deb.trace( ern, 'ref',  ref);
   END IF;
   IF  NOT C_OKPO(ID_B,NLSB)  AND MFOA<> GL.KF   AND  MFOB=GL.KF AND  SUBSTR( NLSB,1,4) NOT IN ('3570','2909','3578') THEN 
      rc := 1;
      IF deb.debug THEN
         deb.trace( ern, 'result/0', rc);
      END IF;
      RETURN;
   END IF;
   IF  MFOB=GL.KF AND NLSB LIKE'3904%' THEN 
      rc := 2;
      IF deb.debug THEN
         deb.trace( ern, 'result/1', rc);
      END IF;
      RETURN;
   END IF;
   IF  NLSA LIKE '26009300946424' AND  S  >= 15000000 THEN 
      rc := 6;
      IF deb.debug THEN
         deb.trace( ern, 'result/5', rc);
      END IF;
      RETURN;
   END IF;
   IF  MFOA=311647 AND MFOB<>311647 THEN 
      rc := 10;
      IF deb.debug THEN
         deb.trace( ern, 'result/9', rc);
      END IF;
      RETURN;
   END IF;
   IF  MFOB<>GL.KF  AND KV=980 AND DK=1 AND NLSA NOT LIKE '3720%' THEN 
      rc := 11;
      IF deb.debug THEN
         deb.trace( ern, 'result/10', rc);
      END IF;
      RETURN;
   END IF;
   IF  MFOB<>GL.KF  AND KV= 840 AND DK=1 THEN 
      rc := 12;
      IF deb.debug THEN
         deb.trace( ern, 'result/11', rc);
      END IF;
      RETURN;
   END IF;
   IF  NLSA LIKE '26259000533363' THEN 
      rc := 333;
      IF deb.debug THEN
         deb.trace( ern, 'result/17', rc);
      END IF;
      RETURN;
   END IF;
   IF  NLSB LIKE '26259000533363' THEN 
      rc := 334;
      IF deb.debug THEN
         deb.trace( ern, 'result/18', rc);
      END IF;
      RETURN;
   END IF;
   IF  F_BLK_CODCAGENT(NLSB, KV, 99)=1 THEN 
      rc := 777;
      IF deb.debug THEN
         deb.trace( ern, 'result/19', rc);
      END IF;
      RETURN;
   END IF;
   IF  NLSA LIKE '1600%' AND KV=980 AND MFOA<>GL.KF AND ((NLSB LIKE '2600%') OR (NLSB LIKE '2620%')) THEN 
      rc := 778;
      IF deb.debug THEN
         deb.trace( ern, 'result/20', rc);
      END IF;
      RETURN;
   END IF;
   IF  F_BLK_VAL_CORP(NLSA,NLSB,KV,ID_A,ID_B)=1 AND MFOA<>GL.KF THEN 
      rc := 779;
      IF deb.debug THEN
         deb.trace( ern, 'result/21', rc);
      END IF;
      RETURN;
   END IF;
   IF  MFOB=GL.KF AND KV<>980 AND (NLSB LIKE '2600%' OR NLSB LIKE '2603%' OR NLSB LIKE '2650%') THEN 
      rc := 799;
      IF deb.debug THEN
         deb.trace( ern, 'result/22', rc);
      END IF;
      RETURN;
   END IF;
   rc := 0;
END bl_rrp;
/
show err;

PROMPT *** Create  grants  BL_RRP ***
grant EXECUTE                                                                on BL_RRP          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BL_RRP.sql =========*** End *** ==
PROMPT ===================================================================================== 
