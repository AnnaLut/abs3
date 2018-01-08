

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINT4VIDD.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_CHGINT4VIDD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_CHGINT4VIDD ("DPTTYPE_ID", "DPTTYPE_CODE", "DPTTYPE_NAME", "AGRTYPE_ID", "AGRTYPE_NAME") AS 
  select v.vidd, v.type_cod, v.type_name, f.id, f.name
  from dpt_vidd_flags f, dpt_vidd_scheme s, dpt_vidd v
 where f.id != 1
   and f.id = s.flags
   and s.vidd = v.vidd
   and f.activity = 1
   and f.request_typecode = 'AGRMNT_CHGINT'
 ;

PROMPT *** Create  grants  V_DPT_CHGINT4VIDD ***
grant SELECT                                                                 on V_DPT_CHGINT4VIDD to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_CHGINT4VIDD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_CHGINT4VIDD to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_CHGINT4VIDD to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_CHGINT4VIDD to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_CHGINT4VIDD.sql =========*** End 
PROMPT ===================================================================================== 
