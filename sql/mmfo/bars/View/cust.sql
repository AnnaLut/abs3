

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CUST.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view CUST ***

  CREATE OR REPLACE FORCE VIEW BARS.CUST ("RNK", "ISE", "FS", "OE", "SED", "VED") AS 
  SELECT RNK,ISE,FS,OE,SED,VED FROM CUSTOMER;

PROMPT *** Create  grants  CUST ***
grant SELECT                                                                 on CUST            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUST            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CUST.sql =========*** End *** =========
PROMPT ===================================================================================== 
