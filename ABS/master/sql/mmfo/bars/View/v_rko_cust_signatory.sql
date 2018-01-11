

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_CUST_SIGNATORY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_CUST_SIGNATORY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_CUST_SIGNATORY ("RW_NUM", "RNK", "REL_INTEXT", "POSITION", "POSITION_R", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "NAME_R", "DOC_TP_ID", "DOC_TP", "TRUST_REGNUM", "TRUST_REGDAT") AS 
  SELECT rw_num,
          rnk,
          rel_intext,
          position,
          position_r,
          first_name,
          middle_name,
          last_name,
          name_r,
		  doc_tp_id,
          doc_tp,
          trust_regnum,
              trust_regdat
     FROM (SELECT ROW_NUMBER () OVER (PARTITION BY rnk ORDER BY RNK)
                     AS rw_num,
                  r.rnk,
                  r.rel_intext,
                  r.position,
                  r.position_r,
                  r.first_name,
                  r.middle_name,
                  r.last_name,
                  r.name_r,
				  r.document_type_id doc_tp_id,
                  DECODE (r.document_type_id,
                          1, 'статуту',
                          2, 'довіреності',
                          3, r.document)
                     doc_tp,
                     trust_regnum,
                     trust_regdat                                              --r.*
             FROM customer_rel r
            WHERE REL_ID = 20 AND SIGN_PRIVS = 1         -- and BDATE <= gl.bd
                                                --   and EDATE >= gl.bd
          )
    WHERE rw_num <= 3;

PROMPT *** Create  grants  V_RKO_CUST_SIGNATORY ***
grant SELECT                                                                 on V_RKO_CUST_SIGNATORY to BARSREADER_ROLE;
grant SELECT                                                                 on V_RKO_CUST_SIGNATORY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RKO_CUST_SIGNATORY to START1;
grant SELECT                                                                 on V_RKO_CUST_SIGNATORY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_CUST_SIGNATORY.sql =========*** E
PROMPT ===================================================================================== 
