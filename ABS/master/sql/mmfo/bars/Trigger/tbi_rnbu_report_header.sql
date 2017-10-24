

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_REPORT_HEADER.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_RNBU_REPORT_HEADER ***

  CREATE OR REPLACE TRIGGER BARS.TBI_RNBU_REPORT_HEADER 
  BEFORE INSERT ON "BARS"."RNBU_REPORT_HEADER"
  REFERENCING FOR EACH ROW
  begin
	select s_rnbu_report_header.nextval
	into :new.header_id from dual;
end;



/
ALTER TRIGGER BARS.TBI_RNBU_REPORT_HEADER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_REPORT_HEADER.sql =========
PROMPT ===================================================================================== 
