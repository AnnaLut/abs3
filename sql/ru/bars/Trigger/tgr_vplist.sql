

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_VPLIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_VPLIST ***

  CREATE OR REPLACE TRIGGER BARS.TGR_VPLIST 
       INSTEAD OF UPDATE
       ON V_VPLIST REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    ACC6204_ INT;  ACC_rrR_ INT;  ACC_rrS_ INT;  nTmp_ int;
BEGIN

   --1)
   BEGIN
     SELECT ACC                 INTO ACC6204_   FROM ACCOUNTS
     WHERE DAZS IS NULL AND NLS=:NEW.NLS6204 AND KV=GL.BASEVAL;
   exception when NO_DATA_FOUND THEN ACC6204_:= :OLD.ACC6204;
   end ;

   --2-3)
   BEGIN
     SELECT ACC                 INTO ACC_RRR_   FROM ACCOUNTS
     WHERE DAZS IS NULL AND NLS=:NEW.NLS_RRR AND KV=GL.BASEVAL;
   exception when NO_DATA_FOUND THEN ACC_RRR_:= :OLD.ACC_RRR;
   end ;

   --4)
   BEGIN
     SELECT ACC                 INTO ACC_RRS_   FROM ACCOUNTS
     WHERE DAZS IS NULL AND NLS=:NEW.NLS_RRS AND KV=GL.BASEVAL;
   exception when NO_DATA_FOUND THEN ACC_RRR_:= :OLD.ACC_RRR;
   end ;

   UPDATE VP_LIST SET ACC6204 = ACC6204_,
                      ACC_rrR = ACC_rrR_,
                      ACC_rrD = ACC_rrR_,
                      ACC_rrS = ACC_rrS_
    WHERE ACC3800 = :OLD.ACC3800;
--    nTmp_:= SQL%rowcount;

END tgr_VPLIST;
/
ALTER TRIGGER BARS.TGR_VPLIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_VPLIST.sql =========*** End *** 
PROMPT ===================================================================================== 
