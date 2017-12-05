

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_888.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_888 ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_888 
  BEFORE INSERT OR UPDATE ON "BARS"."OPER"
  REFERENCING FOR EACH ROW
    WHEN (
NEW.NLSA LIKE '888%' OR  NEW.NLSB LIKE '888%'
      ) DECLARE
    NLSA_ VARCHAR2(14);
    NLSB_ VARCHAR2(14);
    NLS_ VARCHAR2(14);
  BEGIN
   NLSA_:=:NEW.NLSA;
   NLSB_:=:NEW.NLSB;

   IF TRIM(SUBSTR(NLSA_,1,4)) = '8881' THEN NLSA_ :='220568881';
   ELSIF TRIM(SUBSTR(NLSA_,1,4)) = '8882' THEN NLSA_ :='263508882';
   ELSIF TRIM(SUBSTR(NLSA_,1,4)) = '8886' THEN NLSA_ :='220848886';
   ELSIF TRIM(SUBSTR(NLSA_,1,4)) = '8887' THEN NLSA_ :='263888887';
   ELSIF TRIM(SUBSTR(NLSB_,1,4)) = '8881' THEN NLSB_ :='220568881';
   ELSIF TRIM(SUBSTR(NLSB_,1,4)) = '8882' THEN NLSB_ :='263508882';
   ELSIF TRIM(SUBSTR(NLSB_,1,4)) = '8886' THEN NLSB_ :='220848886';
   ELSIF TRIM(SUBSTR(NLSB_,1,4)) = '8887' THEN NLSB_ :='263888887';
   END IF;

   :NEW.NLSA:=NLSA_;
   :NEW.NLSB:=NLSB_;



END;


/
ALTER TRIGGER BARS.TU_OPER_888 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_888.sql =========*** End ***
PROMPT ===================================================================================== 
