

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_NB758.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_NB758 ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_NB758 
  after insert or update ON BARS.OPERW  for each row
 WHEN (
new.tag like 'NB758'
      ) begin
   PUL.Set_Mas_Ini( 'NB758', nvl(:new.value, '0'), 'dop rek' );
end ;
/
ALTER TRIGGER BARS.TAI_OPERW_NB758 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_NB758.sql =========*** End
PROMPT ===================================================================================== 
