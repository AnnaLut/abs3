

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ACCP_PROD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ACCP_PROD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ACCP_PROD 
BEFORE INSERT
ON BARS.CC_ACCP REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   TIP_     ACCOUNTS.TIP%TYPE;
   BRANCH_A ACCOUNTS.BRANCH%TYPE;
   RNK_A    ACCOUNTS.RNK%TYPE;
   NBS_     ACCOUNTS.NBS%TYPE;
   BRANCH_D CC_DEAL.BRANCH%TYPE;
   PROD_    CC_DEAL.PROD%TYPE;
   RNK_D    CC_DEAL.RNK%TYPE;
   OB22_    VARCHAR2(8);
   MPAWN_   PAWN_ACC.MPAWN%TYPE;

BEGIN
  -- автоматическая простановка ОВ22 для новых счетов
   BEGIN

      SELECT A.TIP, A.BRANCH , A.RNK ,A.NBS ,I.OB22
        INTO TIP_ ,  BRANCH_A, RNK_A , NBS_ ,OB22_
        FROM ACCOUNTS A,SPECPARAM_INT I
       WHERE A.ACC=:NEW.ACC AND A.ACC=I.ACC(+);

     IF OB22_ IS NOT NULL THEN RETURN; END IF;

      SELECT PROD,BRANCH,  RNK
        INTO PROD_, BRANCH_D, RNK_D
        FROM CC_DEAL D, ND_ACC N
       WHERE D.ND=N.ND AND N.ACC =:NEW.ACCS AND ROWNUM=1;



--      If RNK_D <> RNK_A then RETURN ; end if;
      ---------------------------------------
--      If BRANCH_A<>BRANCH_D then
--         update accounts set tobo=BRANCH_D where acc=:NEW.acc;
--      end if;
      ---------------------------------------

         SELECT DECODE(SUBSTR(NBS_,1,3),'903',S903,'950',S950,'952',(S952))
           INTO OB22_
           FROM CCK_OB22 WHERE NBS||OB22 =PROD_;

       IF LENGTH(OB22_) > 2 THEN

          SELECT MAX(DECODE(MPAWN,1,1,2,4,3,7,1)) INTO MPAWN_ FROM PAWN_ACC WHERE ACC=:NEW.ACC;
          IF MPAWN_ IS NULL THEN MPAWN_:=1; END IF;

          OB22_:=SUBSTR(OB22_,MPAWN_,2);
       END IF;

   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
   END;
   ----------------
   IF OB22_ IS NOT NULL THEN
      UPDATE SPECPARAM_INT SET OB22=NVL(OB22,OB22_) WHERE ACC=:NEW.ACC;
      IF SQL%ROWCOUNT = 0 THEN
         INSERT INTO SPECPARAM_INT (ACC,OB22) VALUES (:NEW.ACC,OB22_);
      END IF;
   END IF;
END TBI_ACCP_PROD;
/
ALTER TRIGGER BARS.TBI_ACCP_PROD DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ACCP_PROD.sql =========*** End *
PROMPT ===================================================================================== 
