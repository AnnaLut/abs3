

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_06.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BL_RRP_06 ***

  CREATE OR REPLACE PROCEDURE BARS.BL_RRP_06 ( rc IN OUT NUMBER, kv IN NUMBER, 
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
IF NOT C_OKPO(ID_B,NLSB)  AND MFOA<> GL.KF   AND  MFOB=GL.KF AND  SUBSTR( NLSB,1,4) NOT IN ('3570','2909','3578') THEN 
rc:=1; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%1560' OR NLSB LIKE '2603%1561') AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=26; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%1563' OR NLSB LIKE '2603%1564') AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=27; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%1565') AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=28; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%1566') AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=29; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%283' OR NLSB LIKE '2603%1290') AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=34; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%1292' OR NLSB LIKE '2603%1293' OR NLSB LIKE '2603%1372' OR NLSB LIKE '2603%1531')  AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=65; 
RETURN; 
END IF; 
IF (NLSB LIKE '260393011300'  OR  NLSB LIKE '2603%1490')  AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=66; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%1616' OR NLSB LIKE '2603%1630')  AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=67; 
RETURN; 
END IF; 
IF (NLSB LIKE '2603%1294' OR NLSB LIKE '2603%1295' OR NLSB LIKE '2603%1297' OR NLSB LIKE '2603%1291' OR NLSB LIKE '2603%1296') AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=90; 
RETURN; 
END IF; 
IF  MFOB  = 824026 THEN 
rc:=112; 
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
END bl_rrp_06;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_06.sql =========*** End ***
PROMPT ===================================================================================== 