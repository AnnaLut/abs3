

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_V23PAWN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_V23PAWN ***

  CREATE OR REPLACE TRIGGER BARS.TAU_V23PAWN INSTEAD OF UPDATE
  ON BARS.V23_PAWN REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
BEGIN
  update cc_pawn23ADD set  DAY_IMP = :new.DAY_IMP, SUM_IMP = :new.SUM_IMP, PROC_IMP = :new.PROC_IMP, EF      = :new.EF     ,
                           ATR     = :new.ATR    , HCC_M   = :new.HCC_m  , KL_351   = :new.KL_351  , KPZ_351 = :new.KPZ_351
  where pawn = :old.pawn;

  if SQL%rowcount = 0 then
     if :new.DAY_IMP is not null or :new.DAY_IMP is not null or :new.PROC_IMP is not null or :new.EF      is not null or
        :new.ATR     is not null or :new.HCC_m   is not null or :new.KL_351   is not null or :new.KPZ_351 is not null then
        insert into cc_pawn23ADD (     DAY_IMP,     SUM_IMP,     PROC_IMP,     EF,     ATR,     HCC_M,     pawn,     KL_351,     KPZ_351)
                          values (:new.DAY_IMP,:new.SUM_IMP,:new.PROC_IMP,:new.EF,:new.ATR,:new.HCC_m,:old.pawn,:new.KL_351,:new.KPZ_351);
     end if;
  end if;
end TAU_V23PAWN;
/
ALTER TRIGGER BARS.TAU_V23PAWN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_V23PAWN.sql =========*** End ***
PROMPT ===================================================================================== 
