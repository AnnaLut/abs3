

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_AGG_PROTOCOLS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_AGG_PROTOCOLS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_AGG_PROTOCOLS ("REPORT_DATE", "KF", "VERSION_ID", "REPORT_CODE", "NBUC", "FIELD_CODE", "FIELD_VALUE", "ERROR_MSG", "ADJ_IND") AS 
  SELECT "REPORT_DATE",
          "KF",
          "VERSION_ID",
          "REPORT_CODE",
          "NBUC",
          "FIELD_CODE",
          "FIELD_VALUE",
          "ERROR_MSG",
          "ADJ_IND"
     FROM NBUR_AGG_PROTOCOLS_ARCH;

PROMPT *** Create  grants  V_NBUR_AGG_PROTOCOLS ***
grant SELECT                                                                 on V_NBUR_AGG_PROTOCOLS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_AGG_PROTOCOLS to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_AGG_PROTOCOLS.sql =========*** E
PROMPT ===================================================================================== 
