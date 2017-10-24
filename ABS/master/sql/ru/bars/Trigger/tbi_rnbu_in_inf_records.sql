

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_IN_INF_RECORDS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_RNBU_IN_INF_RECORDS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_RNBU_IN_INF_RECORDS 
before insert on rnbu_in_inf_records for each row
declare bars number;
begin
 select s_rnbu_in_inf_records.nextval
 into bars from dual;
        :new.record_id := bars;
end;
/
ALTER TRIGGER BARS.TBI_RNBU_IN_INF_RECORDS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_IN_INF_RECORDS.sql ========
PROMPT ===================================================================================== 
