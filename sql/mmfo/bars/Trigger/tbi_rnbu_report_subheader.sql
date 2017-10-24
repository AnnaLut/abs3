

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_REPORT_SUBHEADER.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_RNBU_REPORT_SUBHEADER ***

  CREATE OR REPLACE TRIGGER BARS.TBI_RNBU_REPORT_SUBHEADER 
  BEFORE INSERT ON "BARS"."RNBU_REPORT_SUBHEADER"
  REFERENCING FOR EACH ROW
  begin
	select s_rnbu_report_subheader.nextval
	into :new.subheader_id from dual;
end;



/
ALTER TRIGGER BARS.TBI_RNBU_REPORT_SUBHEADER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_REPORT_SUBHEADER.sql ======
PROMPT ===================================================================================== 
