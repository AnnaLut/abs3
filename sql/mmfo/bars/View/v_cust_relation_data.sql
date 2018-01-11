

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_RELATION_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_RELATION_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_RELATION_DATA ("RNK", "REL_INTEXT", "REL_RNK", "REL_ID", "DATASET_ID", "VAGA1", "VAGA2", "TYPE_ID", "TYPE_NAME", "POSITION", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "DOCUMENT_TYPE_ID", "DOCUMENT_TYPE_NAME", "DOCUMENT", "TRUST_REGNUM", "TRUST_REGDAT", "BDATE_SIMPLE", "EDATE_SIMPLE", "BDATE_VAGA", "EDATE_VAGA", "BDATE_TRUSTEE", "EDATE_TRUSTEE", "NOTARY_NAME", "NOTARY_REGION", "SIGN_PRIVS", "SIGN_ID", "SIGN_DATA", "NAME_R", "POSITION_R") AS 
  select "RNK","REL_INTEXT","REL_RNK","REL_ID","DATASET_ID","VAGA1","VAGA2","TYPE_ID","TYPE_NAME","POSITION","FIRST_NAME","MIDDLE_NAME","LAST_NAME","DOCUMENT_TYPE_ID","DOCUMENT_TYPE_NAME","DOCUMENT","TRUST_REGNUM","TRUST_REGDAT","BDATE_SIMPLE","EDATE_SIMPLE","BDATE_VAGA","EDATE_VAGA","BDATE_TRUSTEE","EDATE_TRUSTEE","NOTARY_NAME","NOTARY_REGION","SIGN_PRIVS","SIGN_ID","SIGN_DATA","NAME_R", "POSITION_R"
  from (select crt.rnk,
               crt.rel_intext,
               crt.rel_rnk,
               crt.rel_id,
               crt.dataset_id,
               null           as vaga1,
               null           as vaga2,
               null           as type_id,
               null           as type_name,
               null           as position,
               null           as first_name,
               null           as middle_name,
               null           as last_name,
               null           as document_type_id,
               null           as document_type_name,
               null           as document,
               null           as trust_regnum,
               null           as trust_regdat,
               cr.bdate as bdate_simple,
               cr.edate as edate_simple,
               null as bdate_vaga,
               null as edate_vaga,
               null as bdate_trustee,
               null as edate_trustee,
               null           as notary_name,
               null           as notary_region,
               null           as sign_privs,
               null           as sign_id,
               null           as sign_data,
               null           as name_r,
               null           as position_r
          from v_cust_relation_types crt, customer_rel cr
         where crt.rnk = cr.rnk
           and crt.rel_intext = cr.rel_intext
           and crt.rel_rnk = cr.rel_rnk
           and crt.rel_id = cr.rel_id
           and crt.relid_selected = 1
           and crt.dataset_id = 'SIMPLE'
        union all
        select crt.rnk,
               crt.rel_intext,
               crt.rel_rnk,
               crt.rel_id,
               crt.dataset_id,
               cr.vaga1,
               cr.vaga2,
               null           as type_id,
               null           as type_name,
               null           as position,
               null           as first_name,
               null           as middle_name,
               null           as last_name,
               null           as document_type_id,
               null           as document_type_name,
               null           as document,
               null           as trust_regnum,
               null           as trust_regdat,
               null as bdate_simple,
               null as edate_simple,
               cr.bdate as bdate_vaga,
               cr.edate as edate_vaga,
               null as bdate_trustee,
               null as edate_trustee,
               null           as notary_name,
               null           as notary_region,
               null           as sign_privs,
               null           as sign_id,
               null           as sign_data,
               null           as name_r,
               null           as position_r
          from v_cust_relation_types crt, customer_rel cr
         where crt.rnk = cr.rnk
           and crt.rel_intext = cr.rel_intext
           and crt.rel_rnk = cr.rel_rnk
           and crt.rel_id = cr.rel_id
           and crt.relid_selected = 1
           and crt.dataset_id = 'VAGA'
        union all
        select crt.rnk,
               crt.rel_intext,
               crt.rel_rnk,
               crt.rel_id,
               crt.dataset_id,
               null                as vaga1,
               null                as vaga2,
               cr.type_id,
               tt.name             as type_name,
               cr.position,
               cr.first_name,
               cr.middle_name,
               cr.last_name,
               cr.document_type_id,
               tdt.name            as document_type_name,
               cr.document,
               cr.trust_regnum,
               cr.trust_regdat,
               null as bdate_simple,
               null as edate_simple,
               null as bdate_vaga,
               null as edate_vaga,
               cr.bdate as bdate_trustee,
               cr.edate as edate_trustee,
               cr.notary_name,
               cr.notary_region,
               cr.sign_privs,
               cr.sign_id,
               bd.bin_data         as sign_data,
               cr.name_r,
               cr.POSITION_R
          from v_cust_relation_types crt,
               customer_rel          cr,
               trustee_type          tt,
               trustee_document_type tdt,
               customer_bin_data     bd
         where crt.rnk = cr.rnk
           and crt.rel_intext = cr.rel_intext
           and crt.rel_rnk = cr.rel_rnk
           and crt.rel_id = cr.rel_id
           and crt.relid_selected = 1
           and crt.dataset_id = 'TRUSTEE'
           and cr.type_id = tt.id(+)
           and cr.document_type_id = tdt.id(+)
           and cr.sign_id = bd.id(+))
 order by rnk, rel_intext, rel_rnk, rel_id
;

PROMPT *** Create  grants  V_CUST_RELATION_DATA ***
grant SELECT                                                                 on V_CUST_RELATION_DATA to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_RELATION_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_RELATION_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_RELATION_DATA.sql =========*** E
PROMPT ===================================================================================== 
