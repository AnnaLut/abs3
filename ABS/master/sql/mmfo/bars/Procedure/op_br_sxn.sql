

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_BR_SXN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_BR_SXN ***

  CREATE OR REPLACE PROCEDURE BARS.OP_BR_SXN (p_mode int) is
begin
  tuda;
  for k in (select * from not_nls98)
  loop
     OP_BR_SX1  (k.BRANCH, k.NBSOB22 ) ;
  end loop;
end OP_BR_SXN;
/
show err;

PROMPT *** Create  grants  OP_BR_SXN ***
grant EXECUTE                                                                on OP_BR_SXN       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_BR_SXN       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_BR_SXN.sql =========*** End ***
PROMPT ===================================================================================== 
