

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_REPORT_ROW.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_RNBU_REPORT_ROW ***

  CREATE OR REPLACE TRIGGER BARS.TBI_RNBU_REPORT_ROW 
  BEFORE INSERT ON "BARS"."RNBU_REPORT_ROW"
  REFERENCING FOR EACH ROW
  begin
	select s_rnbu_report_row.nextval
	into :new.row_id from dual;
end;



/
ALTER TRIGGER BARS.TBI_RNBU_REPORT_ROW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_REPORT_ROW.sql =========***
PROMPT ===================================================================================== 
