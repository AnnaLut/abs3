

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_1PB_DOC_UPD.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_V_CIM_1PB_DOC_UPD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_V_CIM_1PB_DOC_UPD 
instead of update on v_cim_1PB_doc
for each row
declare
  n1 number :=0;
  l_kod_n varchar2(12);
begin
update cim_1pb_ru_doc set md=to_char(:new.md) where ref_ca=:new.ref_ca;
  select count(*), max(value) into n1, l_kod_n from operw where tag='KOD_N' and ref=:new.ref_ca;
  if (l_kod_n is null and :new.kod_n_ca is not null) or l_kod_n<>:new.kod_n_ca then
    if n1=0 then
      insert into operw (ref, tag, value, kf) values (:new.ref_ca, 'KOD_N', :new.kod_n_ca, f_ourmfo);
    else
      update operw set value=:new.kod_n_ca where tag='KOD_N' and ref=:new.ref_ca;
    end if;
    update cim_1pb_ru_doc set changed=2, md=null where ref_ca=:new.ref_ca;
  elsif :new.md is not null then
    update cim_1pb_ru_doc set md=to_char(:new.md) where ref_ca=:new.ref_ca;
  end if;
end;


/
ALTER TRIGGER BARS.TBI_V_CIM_1PB_DOC_UPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_1PB_DOC_UPD.sql =========*
PROMPT ===================================================================================== 
