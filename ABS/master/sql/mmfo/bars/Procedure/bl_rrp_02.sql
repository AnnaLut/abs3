

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_02.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BL_RRP_02 ***

  CREATE OR REPLACE PROCEDURE BARS.BL_RRP_02 ( rc IN OUT NUMBER, kv IN NUMBER, 
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
IF MFOB=324805 AND (NLSB  LIKE  '260313011626' OR NLSB  LIKE  '260323001626') THEN 
rc:=24; 
RETURN; 
END IF; 
IF NLSB  LIKE  '1600%'  OR NLSA  LIKE  '1600%' THEN 
rc:=31; 
RETURN; 
END IF; 
IF MFOB=324805 AND  NLSB  LIKE  '2603____617847'   AND ID_B='00131400' THEN 
rc:=32; 
RETURN; 
END IF; 
IF MFOB=324805 AND  NLSB  LIKE  '260363001770' THEN 
rc:=33; 
RETURN; 
END IF; 
IF MFOB=324805 AND  NLSB  LIKE  '26006301110001' THEN 
rc:=35; 
RETURN; 
END IF; 
IF MFOB=324805 AND NLSB  LIKE  '26002300212313' THEN 
rc:=39; 
RETURN; 
END IF; 
IF F_BLK_VAL_CORP(NLSA,NLSB,KV,ID_A,ID_B)=1 AND MFOA<>GL.KF THEN 
rc:=779; 
RETURN; 
END IF; 
rc:=0; 
END bl_rrp_02;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_02.sql =========*** End ***
PROMPT ===================================================================================== 
