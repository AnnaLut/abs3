

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_OUT_PAYMENTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_OUT_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_OUT_PAYMENTS ("REF", "DK", "TT", "KV", "S", "VDAT", "NAM_A", "NLSA", "MFOA", "NAM_B", "NLSB", "MFOB", "PDAT", "SOS", "CURRVISAGRP", "NEXTVISAGRP", "KF", "BRANCH", "NAZN") AS 
  select "REF","DK","TT","KV","S","VDAT","NAM_A","NLSA","MFOA","NAM_B","NLSB","MFOB","PDAT","SOS","CURRVISAGRP","NEXTVISAGRP","KF","BRANCH","NAZN" from v_cim_all_payments
    where cim_mgr.check_visa_condition(dk, kv, nlsa, nlsb)=1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_OUT_PAYMENTS.sql =========*** End
PROMPT ===================================================================================== 
