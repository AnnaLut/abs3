

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Trigger/TAU_OPER_ZAY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_ZAY ***

  CREATE OR REPLACE TRIGGER BARSAQ.TAU_OPER_ZAY 
after update of sos ON BARS.OPER
for each row
 WHEN (
old.sos!=5 and new.sos=5 and new.tt  = 'GOD'
      ) declare
  l_id ZAYAVKA.ID%TYPE;      
begin

begin
select id into l_id 
    from zayavka 
 where ref_sps = :new.ref;
 exception when no_data_found then 
 raise_application_error(-20000, '�� ������������ REF_SPS � ������� ZAYAVKA!');
end;

bars_zay.p_reqest_set_refsps(
   l_id, 
  :new.ref);
  
end tau_oper_zay;
/
ALTER TRIGGER BARSAQ.TAU_OPER_ZAY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Trigger/TAU_OPER_ZAY.sql =========*** End **
PROMPT ===================================================================================== 
