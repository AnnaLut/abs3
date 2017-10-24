

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_DOC_SIGN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_DOC_SIGN ***

  CREATE OR REPLACE TRIGGER BARS.TAU_DOC_SIGN 
  AFTER UPDATE OF ID_O, SIGN ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
BEGIN
  INSERT INTO arc_sign(seq,sign_time,rec,ref,sign_key,sign)
  VALUES(s_arc_sign.nextval,SYSDATE,:old.rec,:old.ref,:old.id_o,:old.sign);
END tau_doc_sign;


/
ALTER TRIGGER BARS.TAU_DOC_SIGN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_DOC_SIGN.sql =========*** End **
PROMPT ===================================================================================== 
