

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CUSTOMS_DECL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CIM_CUSTOMS_DECL ***

  CREATE OR REPLACE TRIGGER tbi_cim_customs_decl
before insert on customs_decl
for each row
declare
--  PRAGMA AUTONOMOUS_TRANSACTION; --якщо просто бефоре інстерт і каунт в ньому то мутації не буде 
  l_id number;
  l_n number;
begin
  select count(*) into l_n from customs_decl
              where trunc(sdate)=trunc(:new.sdate) and doc=:new.doc and kv=:new.kv and s=:new.s and kurs=:new.kurs and
                    trunc(allow_dat)=trunc(:new.allow_dat) and cim_id is not null and
                    cnum_cst=:new.cnum_cst and cnum_year=:new.cnum_year and cnum_num=:new.cnum_num;
  if l_n>0 then
    :new.cim_id := null;
  elsif (:new.cim_id is null) then
    select bars_sqnc.get_nextval('s_cim_vmd_id') into l_id from dual;
    :new.cim_id := l_id; :new.cim_boundsum := 0;
  end if;
  select count(*) into l_n from customs_decl
     where  cim_id is not null and cnum_cst=:new.cnum_cst and cnum_year=:new.cnum_year and cnum_num=:new.cnum_num;
  if l_n <= 0 then
    :new.cim_original := 1;
  end if;
--  COMMIT;
end;

/
ALTER TRIGGER BARS.TBI_CIM_CUSTOMS_DECL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CIM_CUSTOMS_DECL.sql =========**
PROMPT ===================================================================================== 
