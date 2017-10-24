

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CUST_INSIDER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CUST_INSIDER ***

  CREATE OR REPLACE PROCEDURE BARS.CUST_INSIDER (p_rnk in customer.rnk%type)
is
 
begin
  null;


end cust_insider;
/
show err;

PROMPT *** Create  grants  CUST_INSIDER ***
grant EXECUTE                                                                on CUST_INSIDER    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CUST_INSIDER.sql =========*** End 
PROMPT ===================================================================================== 
