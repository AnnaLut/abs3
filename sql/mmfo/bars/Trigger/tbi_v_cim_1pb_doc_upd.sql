

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_1PB_DOC_UPD.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_V_CIM_1PB_DOC_UPD ***

  CREATE OR REPLACE TRIGGER BARS.TBI_V_CIM_1PB_DOC_UPD 
instead of update ON BARS.V_CIM_1PB_DOC for each row
declare
  n1 number :=0;
  l_kod_n varchar2(12);
  l_mfo varchar2(6);
  l_changed_ru number(1);
  l_changed number(1);
  l_ref_ru number;
   
  l_s number;
  l_kv number;
  l_nlsb varchar2(15);
  l_nazn_ru varchar2(160);
  l_cl_type varchar2(1);
  l_cl_ipn varchar2(14);
  l_cl_name varchar2(38);
  l_kod_n_ru varchar2(12);
begin
  l_mfo:=f_ourmfo(); l_changed_ru:=null; l_changed:=null;
  if l_mfo=:old.kf then
    select count(*), max(value) into n1, l_kod_n from operw where tag='KOD_N' and ref=:new.ref_ru and kf=l_mfo;
    if not ( :old.ref_ru<>:new.ref_ru or :old.ref_ru is null and :new.ref_ru is not null ) 
       and ( ( l_kod_n is null and :new.kod_n_ru is not null ) or l_kod_n<>:new.kod_n_ru ) then
      if n1=0 then
        insert into operw (ref, tag, value, kf) values (:new.ref_ru, 'KOD_N', :new.kod_n_ru, l_mfo);
      else
        update operw set value=:new.kod_n_ru where tag='KOD_N' and ref=:new.ref_ru and kf=l_mfo;
      end if;
      l_changed_ru:=1; --1 - змінено kod_n_ru
    end if;
  end if; n1:=0;
  if l_mfo='300465' then
    select count(*), max(value) into n1, l_kod_n from operw where tag='KOD_N' and ref=:new.ref_ca and kf='300465';
    if ( l_kod_n is null and :new.kod_n_ca is not null ) or l_kod_n<>:new.kod_n_ca then
      if n1=0 then
        insert into operw (ref, tag, value, kf) values (:new.ref_ca, 'KOD_N', :new.kod_n_ca, '300465');
      else
        update operw set value=:new.kod_n_ca where tag='KOD_N' and ref=:new.ref_ca and kf='300465';
      end if; 
      l_changed:=2; --2 - змінено kod_n_ca
    end if;
  end if;
  
  if l_mfo=:old.kf and ( :old.ref_ru<>:new.ref_ru or :old.ref_ru is null and :new.ref_ru is not null or l_changed_ru=1 ) 
     or l_mfo='300465' and ( :new.md<>:old.md or :new.md is not null and :old.md is null or l_changed=2 ) then
    update cim_1pb_ru_doc set changed=case when l_mfo='300465' and l_changed=2 then 2 else changed end,
                                   md=case when l_mfo<>'300465' then md when :new.md='1' then '1' else null end,
                           changed_ru=case when l_changed_ru=1 then 1 else changed_ru end, 
                             kod_n_ca=case when l_mfo='300465' and l_changed=2 then :new.kod_n_ca else kod_n_ca end,
                             kod_n_ru=case when l_changed_ru=1 then :new.kod_n_ru else kod_n_ru end
     where ref_ca=:new.ref_ca;
    if l_mfo=:old.kf and ( :old.ref_ru<>:new.ref_ru or :old.ref_ru is null and :new.ref_ru is not null) then
      select count(*), max(s), max(kv), max(nlsb), max(nazn) into n1, l_s, l_kv, l_nlsb, l_nazn_ru from oper where ref=:new.ref_ru and kf=l_mfo;
      if n1=1 and l_kv=:old.kv and l_s=:old.s then
        select decode(c.custtype, 2, 'U', 3, CASE WHEN c.sed = '91' THEN 'S' ELSE 'F' END),
               c.okpo, DECODE (c.custtype, 2, c.nmkk, '') into l_cl_type, l_cl_ipn, l_cl_name
          from accounts a join customer c on c.rnk=a.rnk and a.kf=l_mfo
         where a.nls=l_nlsb and a.kv=l_kv and a.kf=l_mfo;
        select value into l_kod_n_ru from operw where tag='KOD_N' and ref=:new.ref_ru and kf=l_mfo;         
        update cim_1pb_ru_doc set ref_ru=:new.ref_ru, changed_ru=2, nlsb=l_nlsb, nazn_ru=l_nazn_ru, cl_type=l_cl_type, cl_ipn=l_cl_ipn, cl_name=l_cl_name, 
                                  kod_n_ru=case when l_kod_n_ru is not null then l_kod_n_ru else null end   
         where ref_ca=:new.ref_ca;
      end if;
    end if;   
  end if;     
end;
/
ALTER TRIGGER BARS.TBI_V_CIM_1PB_DOC_UPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_V_CIM_1PB_DOC_UPD.sql =========*
PROMPT ===================================================================================== 
