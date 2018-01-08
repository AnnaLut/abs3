

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLIMPDREC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLIMPDREC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLIMPDREC ("TAG", "NAME") AS 
  select tag, name
 from op_field
 where  fmt is null
        and not regexp_like(trim(tag) ,'(D)[0-9]{1,2}')
        and not regexp_like(trim(tag) ,'(C|Ï)[0-9]{1,2}$')
        and tag not in ('!','+','-','?', 'Ï', 'C','1', 'D' )
        and tag not like 'TTOF%'
 ;

PROMPT *** Create  grants  V_XMLIMPDREC ***
grant SELECT                                                                 on V_XMLIMPDREC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XMLIMPDREC    to OPER000;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_XMLIMPDREC    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLIMPDREC.sql =========*** End *** =
PROMPT ===================================================================================== 
