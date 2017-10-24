

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/View/V_NU_OB22_FUNU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NU_OB22_FUNU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NU_OB22_FUNU (OTM, NLSN_D, KSN_D, NLSN_K, KSN_K, FDAT, REF, STMT, S, NLSD, NLSK, NAZN) AS 
  select otm,
         nlsn_d, ksn_d,
         nlsn_k, ksn_k,
         fdat, ref, stmt, s,
         nlsd, nlsk, nazn
    from nu_ob22_funu 
   where id_user = user_id 
     and nvl(otm,0) = 0;

PROMPT *** Create  grants  V_NU_OB22_FUNU ***
grant UPDATE,DELETE,select                                                          on V_NU_OB22_FUNU  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/View/V_NU_OB22_FUNU.sql =========*** End ***
PROMPT ===================================================================================== 
