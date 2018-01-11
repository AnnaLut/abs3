

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_OB22.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_OB22 ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_OB22 ("VIDD", "SCOD", "VIDD_NAME", "KV", "NBS_DEP", "OB22_DEP", "NBS_INT", "OB22_INT", "NBS_AMR", "OB22_AMR", "NBS_EXP", "OB22_EXP", "NBS_RED", "OB22_RED") AS 
  SELECT v.vidd, v.deposit_cod, v.type_name, kv,
          v.bsd,  p.ob22_dep,
          v.bsn,  p.ob22ie,
          v.bsa,  p.ob22am,
          decode( SUBStr(v.bsd,1,3), '263', '7041', '332', '7052', '7040') as nbs_exp, p.ob22d7,
          decode( p.ob22k7, null, null, decode(newnbs.get_state, 0, '6399', '6350')) as nbs_red, p.ob22k7
     FROM dpt_vidd v,
          (SELECT vidd,
                  MIN (DECODE (tag, 'DPT_OB22', SUBSTR (val, 1, 2), '') ) as ob22_dep,
                  MIN (DECODE (tag, 'INT_OB22', SUBSTR (val, 1, 2), '') ) as ob22ie,
                  MIN (DECODE (tag, 'DB7_OB22', SUBSTR (val, 1, 2), '') ) as ob22d7,
                  MIN (DECODE (tag, 'KR7_OB22', SUBSTR (val, 1, 2), '') ) as ob22k7,
                  MIN (DECODE (tag, 'AMR_OB22', SUBSTR (val, 1, 2), '') ) as ob22am
               FROM dpt_vidd_params
              WHERE tag IN ('DPT_OB22', 'INT_OB22', 'DB7_OB22', 'KR7_OB22', 'AMR_OB22')
              GROUP BY vidd) p
    WHERE v.type_name NOT LIKE '#%'
      AND v.vidd = p.vidd(+);

PROMPT *** Create  grants  DPT_OB22 ***
grant SELECT                                                                 on DPT_OB22        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_OB22        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_OB22        to DPT_ADMIN;
grant SELECT                                                                 on DPT_OB22        to SALGL;
grant SELECT                                                                 on DPT_OB22        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_OB22        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_OB22        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_OB22.sql =========*** End *** =====
PROMPT ===================================================================================== 
