

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_SETNAZN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_SETNAZN ***

  CREATE OR REPLACE PROCEDURE BARS.CP_SETNAZN (p_ref IN oper.ref%type, p_nazn IN oper.nazn%type)
is
begin
 if p_ref is not null and p_nazn is not null
 then
  begin
   update oper
      set nazn = p_nazn
     where ref = p_ref;
  exception when others then raise;
  end;
 end if;
end cp_setnazn;
/
show err;

PROMPT *** Create  grants  CP_SETNAZN ***
grant DEBUG,EXECUTE                                                          on CP_SETNAZN      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_SETNAZN.sql =========*** End **
PROMPT ===================================================================================== 
