
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_id_ddb.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_ID_DDB (
                               p_id   in number ) return number
is
begin
  RETURN p_id;
  --  if (sys_context('bars_context', 'db_id') is null) then
  --      return p_id;
  --  else
  --      return p_id * 1000 + to_number(sys_context('bars_context', 'db_id'));
  --  end if;

end get_id_ddb; 
/
 show err;
 
PROMPT *** Create  grants  GET_ID_DDB ***
grant EXECUTE                                                                on GET_ID_DDB      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_ID_DDB      to DPT_ROLE;
grant EXECUTE                                                                on GET_ID_DDB      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_id_ddb.sql =========*** End ***
 PROMPT ===================================================================================== 
 