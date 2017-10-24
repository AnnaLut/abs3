
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_int_buf_hex.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_INT_BUF_HEX (p_ref integer) return varchar2
is
    p_key varchar2( 8) := null;
    p_result_msg  varchar2(4000 );
    l_hexbuf         varchar2(4000 );
    l_buf              varchar2(4000 );
begin
    select id_o  into p_key  from oper  where ref= p_ref;
    CHK.MAKE_INT_DOCBUF (p_ref, l_buf);
    l_hexbuf := rawtohex(utl_raw .cast_to_raw( l_buf));
    return l_hexbuf ;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_int_buf_hex.sql =========*** En
 PROMPT ===================================================================================== 
 