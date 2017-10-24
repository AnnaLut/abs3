
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_vp.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_VP ( p_nls VARCHAR2, p_kv   NUMERIC )
RETURN VARCHAR2 IS
 l_3801 varchar2(14);
BEGIN
   begin
    select ltrim(rtrim(g.nls))  into l_3801
    from accounts v, vp_list l, accounts g
    where l.acc3800=v.acc  and l.acc3801=g.acc  and v.kv=p_kv and v.nls=p_nls;
    exception when no_data_found then l_3801:=' ';
   end;
   RETURN l_3801;
END f_vp ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_vp.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 