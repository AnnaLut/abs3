

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NU_OB22_FUNU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NU_OB22_FUNU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NU_OB22_FUNU ("OTM", "NLSN_D", "KSN_D", "NLSN_K", "KSN_K", "FDAT", "REF", "STMT", "S", "NLSD", "NLSK", "NAZN") AS 
  select otm,
         nlsn_d, ksn_d,
         nlsn_k, ksn_k,
         fdat, ref, stmt, s,
         nlsd, nlsk, nazn
    from nu_ob22_funu
   where id_user = user_id
     and otm = 0;

PROMPT *** Create  grants  V_NU_OB22_FUNU ***
grant SELECT                                                                 on V_NU_OB22_FUNU  to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on V_NU_OB22_FUNU  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NU_OB22_FUNU  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NU_OB22_FUNU.sql =========*** End ***
PROMPT ===================================================================================== 
