

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_DOC_GET_VAR_VALUE2.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_DOC_GET_VAR_VALUE2 ***

  CREATE OR REPLACE PROCEDURE BARS.CC_DOC_GET_VAR_VALUE2 (
  p_tag         doc_attr.id%type,
  p_dealnum     number,
  p_agrmnum     number,
  p_value1  out varchar2,
  p_value2  out varchar2,
  p_value3  out varchar2 )
is
  l_value varchar2(6000);
begin
  l_value  := cc_doc_get_var_value(p_tag, p_dealnum, p_agrmnum);
  p_value1 := substr(l_value, 1, 2000);
  p_value2 := substr(l_value, 2001, 2000);
  p_value3 := substr(l_value, 4001, 2000);
end cc_doc_get_var_value2;
/
show err;

PROMPT *** Create  grants  CC_DOC_GET_VAR_VALUE2 ***
grant EXECUTE                                                                on CC_DOC_GET_VAR_VALUE2 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_DOC_GET_VAR_VALUE2 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_DOC_GET_VAR_VALUE2.sql ========
PROMPT ===================================================================================== 
