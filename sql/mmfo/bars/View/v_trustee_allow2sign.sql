

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TRUSTEE_ALLOW2SIGN.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TRUSTEE_ALLOW2SIGN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TRUSTEE_ALLOW2SIGN ("ID", "RNK", "FIO", "POSITION", "DOCUMENT") AS 
  SELECT t.id, t.rnk, t.fio, t.position, d.name||' '||t.document
  FROM trustee t, trustee_document_type d
 WHERE t.sign_privs = 1 AND t.document_type_id = d.id

 ;

PROMPT *** Create  grants  V_TRUSTEE_ALLOW2SIGN ***
grant SELECT                                                                 on V_TRUSTEE_ALLOW2SIGN to BARSREADER_ROLE;
grant SELECT                                                                 on V_TRUSTEE_ALLOW2SIGN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TRUSTEE_ALLOW2SIGN to CUST001;
grant SELECT                                                                 on V_TRUSTEE_ALLOW2SIGN to DPT_ROLE;
grant SELECT                                                                 on V_TRUSTEE_ALLOW2SIGN to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TRUSTEE_ALLOW2SIGN to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TRUSTEE_ALLOW2SIGN.sql =========*** E
PROMPT ===================================================================================== 
