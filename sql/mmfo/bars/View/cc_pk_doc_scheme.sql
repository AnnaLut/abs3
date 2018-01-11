

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_PK_DOC_SCHEME.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_PK_DOC_SCHEME ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_PK_DOC_SCHEME ("ND", "ID", "NAME", "PRINT_ON_BLANK", "TEMPLATE") AS 
  select d.ND, s."ID",s."NAME",s."PRINT_ON_BLANK",s."TEMPLATE"
from DOC_SCHEME s, CC_DEAL d
where s.ID in (select ID from DOC_ROOT where VIDD = d.VIDD)
 ;

PROMPT *** Create  grants  CC_PK_DOC_SCHEME ***
grant SELECT                                                                 on CC_PK_DOC_SCHEME to BARSREADER_ROLE;
grant SELECT                                                                 on CC_PK_DOC_SCHEME to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PK_DOC_SCHEME to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_PK_DOC_SCHEME.sql =========*** End *
PROMPT ===================================================================================== 
