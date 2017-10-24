
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_id_rel.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ID_REL (p_rel_intext_db int,
                                     p_rel_rnk_db    int,
                                     p_MFO           varchar2)
RETURN int
IS
  l_id  int;
begin
  begin
    select id
    into   l_id
    from   cust_rnk_db_id
    where  rel_intext_db=p_rel_intext_db and
           rel_rnk_db=p_rel_rnk_db       and
           mfo=p_MFO;
  exception when no_data_found then
    l_id := bars_sqnc.get_nextval('S_CUSTOMEREXTERN');
  end;
  return l_id;
end f_id_rel;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_id_rel.sql =========*** End *** =
 PROMPT ===================================================================================== 
 