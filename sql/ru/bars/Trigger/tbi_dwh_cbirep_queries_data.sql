

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DWH_CBIREP_QUERIES_DATA.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DWH_CBIREP_QUERIES_DATA ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DWH_CBIREP_QUERIES_DATA 
before insert on bars.dwh_cbirep_queries_data for each row
begin
   if (:new.id is null)then
      select s_dwh_cbirep_queries_data.nextval into :new.id from dual;
   end if;
end  tbi_dwh_cbirep_queries_data;
/
ALTER TRIGGER BARS.TBI_DWH_CBIREP_QUERIES_DATA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DWH_CBIREP_QUERIES_DATA.sql ====
PROMPT ===================================================================================== 
