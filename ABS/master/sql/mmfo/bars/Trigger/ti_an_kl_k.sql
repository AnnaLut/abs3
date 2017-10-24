

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_AN_KL_K.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_AN_KL_K ***

  CREATE OR REPLACE TRIGGER BARS.TI_AN_KL_K 
 BEFORE INSERT  ON an_kl_k
 FOR EACH ROW
declare
    DAT1_ date;
BEGIN
  DAT1_:=to_date(:NEW.YYYYMM||'01', 'YYYYMMDD');

  select to_date( substr(:NEW.YYYYMM,1,4)||'1231', 'YYYYMMDD' ) -
         to_date( substr(:NEW.YYYYMM,1,4)||'0101', 'YYYYMMDD' ) +1,
         last_day(DAT1_) - DAT1_ + 1
  into :NEW.D360, :NEW.D30
  from dual;

END ti_an_kl_k;




/
ALTER TRIGGER BARS.TI_AN_KL_K ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_AN_KL_K.sql =========*** End *** 
PROMPT ===================================================================================== 
