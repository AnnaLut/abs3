

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3_CP_TAG.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V3_CP_TAG ***

  CREATE OR REPLACE FORCE VIEW BARS.V3_CP_TAG ("TAG", "NAME", "DICT_NAME") AS 
  select tag, name, dict_name from cp_tag where id=3;

PROMPT *** Create  grants  V3_CP_TAG ***
grant SELECT                                                                 on V3_CP_TAG       to BARSREADER_ROLE;
grant SELECT                                                                 on V3_CP_TAG       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3_CP_TAG       to START1;
grant SELECT                                                                 on V3_CP_TAG       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3_CP_TAG.sql =========*** End *** ====
PROMPT ===================================================================================== 
