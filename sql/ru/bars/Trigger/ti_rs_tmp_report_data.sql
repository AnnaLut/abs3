

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_RS_TMP_REPORT_DATA.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_RS_TMP_REPORT_DATA ***

  CREATE OR REPLACE TRIGGER BARS.TI_RS_TMP_REPORT_DATA 
  before insert on rs_tmp_report_data
  for each row
begin
  :new.session_id := rs.current_session_id;
  select bars.s_rs_tmp_report_data.nextval into :new.id from dual;
end;
/
ALTER TRIGGER BARS.TI_RS_TMP_REPORT_DATA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_RS_TMP_REPORT_DATA.sql =========*
PROMPT ===================================================================================== 
