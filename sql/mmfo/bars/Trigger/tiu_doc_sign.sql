

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DOC_SIGN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DOC_SIGN ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DOC_SIGN 
AFTER INSERT OR UPDATE OF id_o, sign ON BARS.ARC_RRP FOR EACH ROW
DECLARE
    ern          CONSTANT POSITIVE := 101;    -- Trigger err code
    err          EXCEPTION;
    erm          VARCHAR2(80);
BEGIN
  INSERT INTO arc_sign(seq,sign_time,rec,ref,sign_key,sign)
  VALUES(s_arc_sign.nextval,SYSDATE,:new.rec,:new.ref,:new.id_o,:new.sign);
END tiu_doc_sign;


/
ALTER TRIGGER BARS.TIU_DOC_SIGN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DOC_SIGN.sql =========*** End **
PROMPT ===================================================================================== 
