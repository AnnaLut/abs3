CREATE OR REPLACE FUNCTION f_get_tab_compare_json (p_object_id in number, p_report_id in number, p_data_type_id in number, p_kf in varchar)
RETURN t_compare_json_tab /*PIPELINED*/  AS
  l_tab  t_compare_json_tab := t_compare_json_tab();
  l_json clob;
  l_reporting_date date;
  l_reporting_time date;
BEGIN
  FOR i IN 0 .. 1 LOOP
    l_tab.extend;
    l_json :=nbu_object_utl.get_object_json(p_object_id => p_object_id, p_report_id => p_report_id-i);
    
    if l_json is not null then
      begin
      select t.reporting_date, t.reporting_time
       into  l_reporting_date, l_reporting_time
       from NBU_CORE_DATA_REQUEST t
       where t.id = (select nbu_core_service.get_request_id_for_report(p_report_id-i,
                                                                 (select t.data_type_code
                                                                    from nbu_core_data_request_type t
                                                                   where t.id = case p_data_type_id when  1 then 1   --отслеживаем отправку только по основным типам
                                                                                                    when  2 then 6
                                                                                                    when  3 then 14
                                                                                                    when  4 then 15 end),
                                                                 p_kf)
                 from dual);              
      exception when no_data_found then
       l_reporting_date:=null;
       l_reporting_time:=null;
    end;
    end if;
    l_tab(l_tab.last) := t_compare_json(i,p_report_id, p_object_id,  l_json, l_reporting_date, l_reporting_time);
    --PIPE ROW( t_compare_json(i,p_report_id, p_object_id,  l_json));
  END LOOP;
  RETURN l_tab;
END;
/
