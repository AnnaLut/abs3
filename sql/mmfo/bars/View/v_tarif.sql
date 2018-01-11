

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TARIF.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TARIF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TARIF ("KOD", "KV", "NAME", "TAR", "PR", "SMIN", "KV_SMIN", "SMAX", "KV_SMAX", "TIP", "DAT_BEGIN", "DAT_END") AS 
  SELECT a.kod,
          a.kv,
          a.name,
          a.tar,
          a.pr,
          a.smin,
          a.kv_smin,
          a.smax,
          a.kv_smax,
          a.tip,
          a.dat_begin,
          a.dat_end
     FROM tarif a
     where a.kf =case when sys_context('bars_context','user_mfo') is null then '300465' else sys_context('bars_context','user_mfo') end;

PROMPT *** Create  grants  V_TARIF ***
grant SELECT                                                                 on V_TARIF         to BARSREADER_ROLE;
grant SELECT                                                                 on V_TARIF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TARIF         to CUST001;
grant SELECT                                                                 on V_TARIF         to START1;
grant SELECT                                                                 on V_TARIF         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TARIF         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TARIF.sql =========*** End *** ======
PROMPT ===================================================================================== 
