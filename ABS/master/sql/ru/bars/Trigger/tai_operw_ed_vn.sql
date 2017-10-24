

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_ED_VN.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_OPERW_ED_VN ***

  CREATE OR REPLACE TRIGGER BARS.TAI_OPERW_ED_VN 
  after insert or update on operw  for each row
 WHEN ( new.tag like 'ED_VN') begin
   PUL.Set_Mas_Ini( 'ED_VN', nvl(:new.value, '0'), 'dop rek' );
end ;
/
ALTER TRIGGER BARS.TAI_OPERW_ED_VN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_OPERW_ED_VN.sql =========*** End
PROMPT ===================================================================================== 
