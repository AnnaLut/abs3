

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_OVER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_ACC_OVER ***

  CREATE OR REPLACE TRIGGER BARS.TIU_ACC_OVER 
BEFORE INSERT OR DELETE ON acc_over FOR EACH ROW
DECLARE
   nDO    NUMBER;
   nND    NUMBER;
   nU     NUMBER;
   dP     DATE;
   ndc    VARCHAR2(30);
   userid number;
BEGIN

 userid := gl.aUID;

 IF INSERTING THEN

   nND:=0;
   OVR.check_ovr(:NEW.ACC, nND,ndc );

   IF nND = 0 THEN

     SELECT S_CC_DEAL.NEXTVAL INTO nDO FROM DUAL;
     :NEW.ND := nDO;

---- OVR.p_oversob( :NEW.ACC,:NEW.ND,null,1,0,null );

   ELSE
     :NEW.ND := nND;
     :NEW.NDOC:=ndc ;
   END IF;

 END IF;

END tiu_acc_over;
/
ALTER TRIGGER BARS.TIU_ACC_OVER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_ACC_OVER.sql =========*** End **
PROMPT ===================================================================================== 
