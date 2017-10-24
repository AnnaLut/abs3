

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_RELATION_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_RELATION_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_RELATION_DATA ("RNK", "REL_INTEXT", "REL_RNK", "REL_ID", "DATASET_ID", "VAGA1", "VAGA2", "TYPE_ID", "TYPE_NAME", "POSITION", "POSITION_R", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "DOCUMENT_TYPE_ID", "DOCUMENT_TYPE_NAME", "DOCUMENT", "TRUST_REGNUM", "TRUST_REGDAT", "BDATE_SIMPLE", "EDATE_SIMPLE", "BDATE_VAGA", "EDATE_VAGA", "BDATE_TRUSTEE", "EDATE_TRUSTEE", "NOTARY_NAME", "NOTARY_REGION", "SIGN_PRIVS", "SIGN_ID", "SIGN_DATA", "NAME_R") AS 
  SELECT "RNK",
            "REL_INTEXT",
            "REL_RNK",
            "REL_ID",
            "DATASET_ID",
            "VAGA1",
            "VAGA2",
            "TYPE_ID",
            "TYPE_NAME",
            "POSITION",
            "POSITION_R",
            "FIRST_NAME",
            "MIDDLE_NAME",
            "LAST_NAME",
            "DOCUMENT_TYPE_ID",
            "DOCUMENT_TYPE_NAME",
            "DOCUMENT",
            "TRUST_REGNUM",
            "TRUST_REGDAT",
            "BDATE_SIMPLE",
            "EDATE_SIMPLE",
            "BDATE_VAGA",
            "EDATE_VAGA",
            "BDATE_TRUSTEE",
            "EDATE_TRUSTEE",
            "NOTARY_NAME",
            "NOTARY_REGION",
            "SIGN_PRIVS",
            "SIGN_ID",
            "SIGN_DATA",
            "NAME_R"
       FROM (SELECT crt.rnk,
                    crt.rel_intext,
                    crt.rel_rnk,
                    crt.rel_id,
                    crt.dataset_id,
                    NULL AS vaga1,
                    NULL AS vaga2,
                    NULL AS type_id,
                    NULL AS type_name,
                    NULL AS position,
                    NULL AS position_r,
                    NULL AS first_name,
                    NULL AS middle_name,
                    NULL AS last_name,
                    NULL AS document_type_id,
                    NULL AS document_type_name,
                    NULL AS document,
                    NULL AS trust_regnum,
                    NULL AS trust_regdat,
                    cr.bdate AS bdate_simple,
                    cr.edate AS edate_simple,
                    NULL AS bdate_vaga,
                    NULL AS edate_vaga,
                    NULL AS bdate_trustee,
                    NULL AS edate_trustee,
                    NULL AS notary_name,
                    NULL AS notary_region,
                    NULL AS sign_privs,
                    NULL AS sign_id,
                    NULL AS sign_data,
                    NULL AS name_r
               FROM v_cust_relation_types crt, customer_rel cr
              WHERE     crt.rnk = cr.rnk
                    AND crt.rel_intext = cr.rel_intext
                    AND crt.rel_rnk = cr.rel_rnk
                    AND crt.rel_id = cr.rel_id
                    AND crt.relid_selected = 1
                    AND crt.dataset_id = 'SIMPLE'
             UNION ALL
             SELECT crt.rnk,
                    crt.rel_intext,
                    crt.rel_rnk,
                    crt.rel_id,
                    crt.dataset_id,
                    cr.vaga1,
                    cr.vaga2,
                    NULL AS type_id,
                    NULL AS type_name,
                    NULL AS position,
                    NULL AS position_r,
                    NULL AS first_name,
                    NULL AS middle_name,
                    NULL AS last_name,
                    NULL AS document_type_id,
                    NULL AS document_type_name,
                    NULL AS document,
                    NULL AS trust_regnum,
                    NULL AS trust_regdat,
                    NULL AS bdate_simple,
                    NULL AS edate_simple,
                    cr.bdate AS bdate_vaga,
                    cr.edate AS edate_vaga,
                    NULL AS bdate_trustee,
                    NULL AS edate_trustee,
                    NULL AS notary_name,
                    NULL AS notary_region,
                    NULL AS sign_privs,
                    NULL AS sign_id,
                    NULL AS sign_data,
                    NULL AS name_r
               FROM v_cust_relation_types crt, customer_rel cr
              WHERE     crt.rnk = cr.rnk
                    AND crt.rel_intext = cr.rel_intext
                    AND crt.rel_rnk = cr.rel_rnk
                    AND crt.rel_id = cr.rel_id
                    AND crt.relid_selected = 1
                    AND crt.dataset_id = 'VAGA'
             UNION ALL
             SELECT crt.rnk,
                    crt.rel_intext,
                    crt.rel_rnk,
                    crt.rel_id,
                    crt.dataset_id,
                    NULL AS vaga1,
                    NULL AS vaga2,
                    cr.type_id,
                    tt.name AS type_name,
                    cr.position,
                    cr.position_r,
                    cr.first_name,
                    cr.middle_name,
                    cr.last_name,
                    cr.document_type_id,
                    tdt.name AS document_type_name,
                    cr.document,
                    cr.trust_regnum,
                    cr.trust_regdat,
                    NULL AS bdate_simple,
                    NULL AS edate_simple,
                    NULL AS bdate_vaga,
                    NULL AS edate_vaga,
                    cr.bdate AS bdate_trustee,
                    cr.edate AS edate_trustee,
                    cr.notary_name,
                    cr.notary_region,
                    cr.sign_privs,
                    cr.sign_id,
                    bd.bin_data AS sign_data,
                    cr.name_r
               FROM v_cust_relation_types crt,
                    customer_rel cr,
                    trustee_type tt,
                    trustee_document_type tdt,
                    customer_bin_data bd
              WHERE     crt.rnk = cr.rnk
                    AND crt.rel_intext = cr.rel_intext
                    AND crt.rel_rnk = cr.rel_rnk
                    AND crt.rel_id = cr.rel_id
                    AND crt.relid_selected = 1
                    AND crt.dataset_id = 'TRUSTEE'
                    AND cr.type_id = tt.id(+)
                    AND cr.document_type_id = tdt.id(+)
                    AND cr.sign_id = bd.id(+))
   ORDER BY rnk,
            rel_intext,
            rel_rnk,
            rel_id;

PROMPT *** Create  grants  V_CUST_RELATION_DATA ***
grant SELECT                                                                 on V_CUST_RELATION_DATA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_RELATION_DATA.sql =========*** E
PROMPT ===================================================================================== 
