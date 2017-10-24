
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_doc_attr.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DOC_ATTR (
    v_param varchar2,
    v_nd    number,
    v_adds number default 0
    ) return varchar2 is
begin
 bars_audit.info(v_param ||','|| v_nd||','|| v_adds);
     return BARS.CC_DOC_GET_VAR_VALUE( v_param, v_nd, v_adds);
  exception when no_data_found then raise;
                 when others then
                    logger.error('f_doc_attr:::v_param='||v_param||',err='||sqlerrm);
                    raise;
end f_doc_attr;
/
 show err;
 
PROMPT *** Create  grants  F_DOC_ATTR ***
grant EXECUTE                                                                on F_DOC_ATTR      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DOC_ATTR      to CC_DOC;
grant EXECUTE                                                                on F_DOC_ATTR      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_DOC_ATTR      to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_doc_attr.sql =========*** End ***
 PROMPT ===================================================================================== 
 