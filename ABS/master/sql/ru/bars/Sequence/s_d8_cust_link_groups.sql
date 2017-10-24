

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_D8_CUST_LINK_GROUPS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_D8_CUST_LINK_GROUPS ***

   CREATE SEQUENCE  BARS.S_D8_CUST_LINK_GROUPS  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 244081 CACHE 20 NOORDER  NOCYCLE ;

PROMPT *** Create  grants  S_D8_CUST_LINK_GROUPS ***
grant SELECT                                                                 on S_D8_CUST_LINK_GROUPS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_D8_CUST_LINK_GROUPS.sql =========
PROMPT ===================================================================================== 
