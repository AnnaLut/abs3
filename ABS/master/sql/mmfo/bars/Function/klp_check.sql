
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/klp_check.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KLP_CHECK (id_ int) return number
is
  v_  int;
begin
  select v.sid
  into   v_
  from   v$session v,
         tmp_klp_c k
  where  v.schemaname='BARS'            and
         upper(v.program)='KLOP_SBB.EXE' and
         v.status<>'KILLED'              and
         k.id=id_                        and
         k.sid=v.sid;
  return v_;
exception when no_data_found then
  return 0;
end klp_check;
/
 show err;
 
PROMPT *** Create  grants  KLP_CHECK ***
grant EXECUTE                                                                on KLP_CHECK       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KLP_CHECK       to TECH_MOM1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/klp_check.sql =========*** End *** 
 PROMPT ===================================================================================== 
 