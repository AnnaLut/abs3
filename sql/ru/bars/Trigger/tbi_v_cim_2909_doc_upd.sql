

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_2909_DOC_UPD.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_V_CIM_2909_DOC_UPD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_V_CIM_2909_DOC_UPD 
instead of update on v_cim_2909_doc
for each row
declare
  n1 number;
begin
  if :new.kod_n != :old.kod_n or :old.kod_n is null then
    update cim_1pb_ru_doc set kod_n_ru=:new.kod_n, changed=1 where ref_ca=:new.ref_ca;
  end if;
  if :new.ref != :old.ref or :old.ref is null then
    update cim_1pb_ru_doc set ref_ru=:new.ref where ref_ca=:new.ref_ca;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_V_CIM_2909_DOC_UPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_2909_DOC_UPD.sql =========
PROMPT ===================================================================================== 
