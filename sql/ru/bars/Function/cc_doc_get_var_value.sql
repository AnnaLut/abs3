
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_doc_get_var_value.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_DOC_GET_VAR_VALUE 
  (p_tag      doc_attr.id%type,
   p_dealnum  number,
   p_agrmnum  number)
RETURN varchar2
IS
  l_title       varchar2(60) := 'cc_doc_get_var_value: ';
  l_sqlquery    doc_attr.ssql%type;
  l_opencursor  integer;
  l_result      varchar2(6000);
  l_r           integer;
BEGIN
  bars_audit.trace('%s tag = %s, deal_num = %s, agrm_num = %s', l_title,
                   p_tag, to_char(p_dealnum), to_char(p_agrmnum));

  SELECT trim(ssql) INTO l_sqlquery FROM doc_attr WHERE id = p_tag;
  bars_audit.trace('%s sql query = %s', l_title, l_sqlquery);

  IF l_sqlquery IS NULL OR LENGTH(l_sqlquery) = 0 THEN
     RETURN NULL;
  END IF;

  l_opencursor := dbms_sql.open_cursor;
  bars_audit.trace('%s l_opencursor = %s', l_title, to_char(l_opencursor));

  dbms_sql.parse(l_opencursor, l_sqlquery, dbms_sql.native);
  bars_audit.trace('%s dbms_sql.parse done', l_title);

  BEGIN
    dbms_sql.bind_variable(l_opencursor, 'ND', p_dealnum);
    bars_audit.trace('%s bind variable <ND> filled with %s', l_title, to_char(p_dealnum));
  EXCEPTION
    WHEN OTHERS THEN NULL;
  END;

  BEGIN
    dbms_sql.bind_variable(l_opencursor, 'ADDS', p_agrmnum);
    bars_audit.trace('%s bind variable <ADDS> filled with %s', l_title, to_char(p_agrmnum));
  EXCEPTION
    WHEN OTHERS THEN NULL;
  END;

  dbms_sql.define_column(l_opencursor, 1, l_result, 6000);
  bars_audit.trace('%s define_column done, l_result = %s', l_title, l_result);

  l_r := dbms_sql.execute_and_fetch(l_opencursor);
  bars_audit.trace('%s execute_and_fetch done', l_title);

  dbms_sql.column_value(l_opencursor, 1,  l_result);
  bars_audit.trace('%s l_result = %s', l_title, l_result);

  dbms_sql.close_cursor(l_opencursor);
  bars_audit.trace('%s close_cursor done', l_title);

  bars_audit.trace('%s return value = %s', l_title, l_result);

  RETURN l_result;
END;
/
 show err;
 
PROMPT *** Create  grants  CC_DOC_GET_VAR_VALUE ***
grant EXECUTE                                                                on CC_DOC_GET_VAR_VALUE to ABS_ADMIN;
grant EXECUTE                                                                on CC_DOC_GET_VAR_VALUE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_DOC_GET_VAR_VALUE to DPT_ADMIN;
grant EXECUTE                                                                on CC_DOC_GET_VAR_VALUE to START1;
grant EXECUTE                                                                on CC_DOC_GET_VAR_VALUE to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_doc_get_var_value.sql =========*
 PROMPT ===================================================================================== 
 