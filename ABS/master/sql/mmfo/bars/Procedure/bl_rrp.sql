

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
IF MFOA=302076 AND NLSA=26000300367830 THEN 
rc:=3000; 
RETURN; 
END IF; 
IF SUBSTR(NLSB,1,4)='2541' AND MFOB IN (324786,384986,324333,384577,324805,324742,399142,324935,384436,324021, 384674,384919,384522,384652,384492,384760) THEN 
rc:=86; 
RETURN; 
END IF; 
IF MFOA_P=300001 AND MFOB=324805 THEN 
rc:=99; 
RETURN; 
END IF; 
IF F_BLK_CODCAGENT(NLSB, KV, 99)=1 AND MFOB=GL.KF AND NLSB<>'260043011161' THEN 
rc:=777; 
RETURN; 
END IF; 
IF NLSA LIKE '1600%' AND KV=980 AND MFOA<>GL.KF AND NLSB LIKE '2600%' AND MFOB=GL.KF THEN 
rc:=778; 
RETURN; 
END IF; 
IF MFOA = 324805 AND MFOB_P = 300001 THEN 
rc:=91; 
RETURN; 
END IF; 
IF MFOB=300465 AND NLSB IN (29067003) THEN 
rc:=72; 
RETURN; 
END IF; 
IF MFOA  <> 300465
AND SUBSTR(NLSA,1,4)='1600'
AND MFOB=300465
AND NLSB IN (26032301861,26030303861,26031302861,26037306861, 26038305861,26038305861, 26039304861,26031301862, 26032301162)
AND KV=980 THEN 
rc:=11; 
RETURN; 
END IF; 
IF MFOB=300465 AND KV<>980 AND (NLSB LIKE '2600%' OR NLSB LIKE '2603%' OR NLSB LIKE '2650%') THEN 
rc:=58; 
RETURN; 
END IF; 
IF MFOB=300465 AND NLSB=191992 AND KV<>980 THEN 
rc:=55; 
RETURN; 
END IF; 
IF MFOB=300465 AND NLSB LIKE '3720%' AND KV<>980 THEN 
rc:=56; 
RETURN; 
END IF; 
IF  MFOB  = 300465 AND  NLSB  = 26509301822 THEN 
rc:=54; 
RETURN; 
END IF; 
IF MFOA  <> 300465  AND SUBSTR(NLSA,1,4)='1600'  AND MFOB=300465 AND SUBSTR(NLSB,1,4) = '2600' AND KV=980 THEN 
rc:=7; 
RETURN; 
END IF; 
IF MFOA <>300465 AND MFOB=300465 AND DK=1 AND  
((SUBSTR(NLSB,1,4)='1600' AND KV=980) OR 
(SUBSTR(NLSB,1,4)='1500' AND KV<>980)) 
 THEN 
rc:=8; 
RETURN; 
END IF; 
IF NOT C_OKPO(ID_B,NLSB) AND MFOB = 300465 AND SUBSTR(NLSB,1,2)='26'  AND NOT ( SUBSTR(NLSB,1,4)='2625' AND S < 100000 ) THEN 
rc:=3; 
RETURN; 
END IF; 
IF SUBSTR(NLSA,1,4)='3901' OR SUBSTR(NLSB,1,4)='3901' THEN 
rc:=5; 
RETURN; 
END IF; 
IF (NLSB  LIKE '3929%' AND NLSB  <> 39291900) OR (NLSB  = 39291900 AND DK=1) THEN 
rc:=48; 
RETURN; 
END IF; 
IF SUBSTR(NLSA,1,4)='3900' OR SUBSTR(NLSB,1,4)='3900' THEN 
rc:=9; 
RETURN; 
END IF; 
IF MFOB=300465 AND NLSB IN (2906401201,2906601203) THEN 
rc:=64; 
RETURN; 
END IF; 
IF MFOB=300465 AND NLSB=37200001 THEN 
rc:=10; 
RETURN; 
END IF; 
rc:=0; 
END bl_rrp;
/
show err;

PROMPT *** Create  grants  BL_RRP ***
grant EXECUTE                                                                on BL_RRP          to BARS014;
grant EXECUTE                                                                on BL_RRP          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BL_RRP          to BARS_CONNECT;
grant EXECUTE                                                                on BL_RRP          to START1;
grant EXECUTE                                                                on BL_RRP          to TOSS;
grant EXECUTE                                                                on BL_RRP          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BL_RRP.sql =========*** End *** ==
PROMPT ===================================================================================== 
