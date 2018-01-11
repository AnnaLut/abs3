

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_SIGNATORY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_SIGNATORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_SIGNATORY ("ID", "FULL_NM_NOM", "FULL_NM_GEN", "SHORT_NM_NOM", "POSITION_PRSN_NOM", "DIVISION_PRSN_GEN", "POSITION_PRSN_GEN", "DOC_NM_GEN", "NOTARY_NM_GEN", "NOTARY_TP_GEN", "ATTORNEY_DT", "ATTORNEY_NUM", "NOTARIAL_DISTRICT_GEN", "ACTIVE_F", "BRANCH", "KF") AS 
  SELECT ID,
            FULL_NM_NOM,
            FULL_NM_GEN,
            SHORT_NM_NOM,
            POSITION_PRSN_NOM,
            DIVISION_PRSN_GEN,
            POSITION_PRSN_GEN,
            DOC_NM_GEN,
            NOTARY_NM_GEN,
            NOTARY_TP_GEN,
            ATTORNEY_DT,
            ATTORNEY_NUM,
            NOTARIAL_DISTRICT_GEN,
            ACTIVE_F,
            BRANCH,
			KF
       FROM RKO_SIGNATORY
      WHERE    (    LENGTH (SYS_CONTEXT ('bars_context', 'user_branch')) = 8
                AND BRANCH LIKE
                       SYS_CONTEXT ('bars_context', 'user_branch_mask'))
            OR (    LENGTH (SYS_CONTEXT ('bars_context', 'user_branch')) > 8
                AND BRANCH IN (SYS_CONTEXT ('bars_context', 'user_branch'),
                               SUBSTR (
                                  SYS_CONTEXT ('bars_context', 'user_branch'),
                                  1,
                                  8)))
   ORDER BY branch, full_nm_nom;

PROMPT *** Create  grants  V_RKO_SIGNATORY ***
grant SELECT                                                                 on V_RKO_SIGNATORY to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_SIGNATORY to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_SIGNATORY to START1;
grant SELECT                                                                 on V_RKO_SIGNATORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_SIGNATORY.sql =========*** End **
PROMPT ===================================================================================== 
