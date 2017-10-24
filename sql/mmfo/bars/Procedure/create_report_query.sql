

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CREATE_REPORT_QUERY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CREATE_REPORT_QUERY ***

  CREATE OR REPLACE PROCEDURE BARS.CREATE_REPORT_QUERY (
  p_rep_id     in reports.id%type,
  p_xml_params in varchar2 )
is
  l_id number;
begin
  l_id := rs.create_report_query(p_rep_id, p_xml_params);
end create_report_query;
/
show err;

PROMPT *** Create  grants  CREATE_REPORT_QUERY ***
grant EXECUTE                                                                on CREATE_REPORT_QUERY to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CREATE_REPORT_QUERY to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CREATE_REPORT_QUERY.sql =========*
PROMPT ===================================================================================== 
