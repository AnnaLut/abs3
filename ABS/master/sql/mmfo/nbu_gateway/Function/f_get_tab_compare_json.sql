CREATE OR REPLACE FUNCTION f_get_tab_compare_json (p_object_id in number, p_report_id in number)
RETURN t_compare_json_tab /*PIPELINED*/  AS
  l_tab  t_compare_json_tab := t_compare_json_tab();
  l_json clob;
BEGIN
  FOR i IN 0 .. 1 LOOP
    l_tab.extend;
    l_json :=nbu_object_utl.get_object_json(p_object_id => p_object_id, p_report_id => p_report_id-i);
    l_tab(l_tab.last) := t_compare_json(i,p_report_id, p_object_id,  l_json);
    --PIPE ROW( t_compare_json(i,p_report_id, p_object_id,  l_json));
  END LOOP;
  RETURN l_tab;
END;
/
grant execute on f_get_tab_compare_json to bars_access_defrole;