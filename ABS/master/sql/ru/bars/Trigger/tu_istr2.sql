

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ISTR2.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ISTR2 ***

  CREATE OR REPLACE TRIGGER BARS.TU_ISTR2 
BEFORE UPDATE OF blk ON BARS.ARC_RRP FOR EACH ROW
 WHEN ( old.blk = 131313 AND new.blk = 0 AND new.bis IN (0,1) ) DECLARE
  ern CONSTANT POSITIVE := 13; -- Trigger err code
  err EXCEPTION;
  erm VARCHAR2(80);
BEGIN
  ----- Check to see if traped via business rules------

  PUL.Set_Mas_Ini( 'SEP_NAZN', upper  (:OLD.NAZN), 'Назн.пл в ARC_RRP' );
  PUL.Set_Mas_Ini( 'SEP_KV'  , to_char(:OLD.KV  ), 'Вал в ARC_RRP'     );
  PUL.Set_Mas_Ini( 'SEP_NLSB',         :OLD.NLSB , 'Сч.Б в ARC_RRP'    );
  PUL.Set_Mas_Ini( 'SEP_DK'  , to_char(:OLD.DK  ), 'ДК в ARC_RRP'      );

  sep.dyn_bl_rrp(
     :NEW.blk, :OLD.kv, '', :OLD.mfoa, :OLD.nlsa, '', :OLD.mfob, :OLD.nlsb,
     :OLD.dk, :OLD.s, :OLD.id_a, :OLD.id_b, :OLD.ref);

exception when err then
  raise_application_error(-(20000+ern),'\'||erm,TRUE);
END;
/
ALTER TRIGGER BARS.TU_ISTR2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ISTR2.sql =========*** End *** ==
PROMPT ===================================================================================== 
