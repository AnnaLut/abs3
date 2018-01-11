

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_13.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BL_RRP_13 ***

  CREATE OR REPLACE PROCEDURE BARS.BL_RRP_13 ( rc IN OUT NUMBER, kv IN NUMBER, 
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
IF NOT C_OKPO(ID_B,NLSB)  AND MFOA<> GL.KF  AND MFOB=GL.KF AND SUBSTR( NLSB,1,4) NOT IN ('2625','3570','2909','3578','3579','3739') AND DK=1 THEN 
rc:=1; 
RETURN; 
END IF; 
IF (TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))
+(TO_NUMBER(TO_CHAR(SYSDATE,'MI')) /60) )>22.40
AND MFOB <> GL.KF THEN 
rc:=8; 
RETURN; 
END IF; 
IF MFOA<>GL.KF  AND  (NLSB LIKE '2603%9060'  OR  NLSB LIKE '2603%11660')  AND  F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=26; 
RETURN; 
END IF; 
IF  MFOA  = 300465 AND  DK=0 AND  MFOB = GL.KF AND  SUBSTR(NLSB, 1,4) IN ('2909','3904','3906')  AND  (UPPER(NAZN) NOT  LIKE '%—œ»—¿ÕÕﬂ%') THEN 
rc:=46; 
RETURN; 
END IF; 
IF F_BLK_CODCAGENT(NLSB, KV, 99)=1 THEN 
rc:=777; 
RETURN; 
END IF; 
IF NLSA LIKE '1600%' AND KV=980 AND MFOA<>GL.KF AND NLSB LIKE '2600%' THEN 
rc:=778; 
RETURN; 
END IF; 
IF F_BLK_VAL_CORP(NLSA,NLSB,KV,ID_A,ID_B)=1 AND MFOA<>GL.KF THEN 
rc:=779; 
RETURN; 
END IF; 
IF MFOB=GL.KF AND KV<>980 AND (NLSB LIKE '2600%' OR NLSB LIKE '2603%' OR NLSB LIKE '2650%') THEN 
rc:=799; 
RETURN; 
END IF; 
rc:=0; 
END bl_rrp_13;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_13.sql =========*** End ***
PROMPT ===================================================================================== 
