

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_TAMOZHDOC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_TAMOZHDOC ***

  CREATE OR REPLACE TRIGGER BARS.TBD_TAMOZHDOC 
  BEFORE DELETE ON "BARS"."TAMOZHDOC"
  REFERENCING FOR EACH ROW
  begin

  update customs_decl set idt = null where idt = :OLD.idt;

end;



/
ALTER TRIGGER BARS.TBD_TAMOZHDOC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_TAMOZHDOC.sql =========*** End *
PROMPT ===================================================================================== 
