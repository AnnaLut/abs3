

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V2_CP_TAG.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V2_CP_TAG ***

  CREATE OR REPLACE FORCE VIEW BARS.V2_CP_TAG ("TAG", "NAME") AS 
  select tag, name from cp_tag where id=2;

PROMPT *** Create  grants  V2_CP_TAG ***
grant SELECT                                                                 on V2_CP_TAG       to BARSREADER_ROLE;
grant SELECT                                                                 on V2_CP_TAG       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V2_CP_TAG       to START1;
grant SELECT                                                                 on V2_CP_TAG       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V2_CP_TAG.sql =========*** End *** ====
PROMPT ===================================================================================== 
