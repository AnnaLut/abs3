

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_NB540.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_NB540 ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_NB540 
  after insert or update on operw  for each row
    WHEN ( new.tag like 'NB540') begin
   PUL.Set_Mas_Ini( 'NB540', nvl(:new.value, '0'), 'dop rek' );
end ;


/
ALTER TRIGGER BARS.TAI_OPERW_NB540 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_NB540.sql =========*** End
PROMPT ===================================================================================== 
