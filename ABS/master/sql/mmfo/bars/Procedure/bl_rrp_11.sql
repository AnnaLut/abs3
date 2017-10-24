

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_11.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BL_RRP_11 ***

  CREATE OR REPLACE PROCEDURE BARS.BL_RRP_11 ( rc IN OUT NUMBER, kv IN NUMBER, 
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
IF NLSB LIKE '2603%'  AND ID_B IN ('00131305','23243188','21721494','32402870') AND F_BIZNESPR_NAZN(NAZN)>0 THEN 
rc:=25; 
RETURN; 
END IF; 
IF  NLSB ='26038301201'  AND  S  >= '1000' THEN 
rc:=27; 
RETURN; 
END IF; 
rc:=0; 
END bl_rrp_11;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BL_RRP_11.sql =========*** End ***
PROMPT ===================================================================================== 
