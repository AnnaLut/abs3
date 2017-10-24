

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_REL_BYDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_REL_BYDATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_REL_BYDATE ("IDUPD", "CHGDATE", "CHGACTION", "DONEBY", "RNK", "REL_ID", "REL_RNK", "REL_INTEXT", "VAGA1", "VAGA2", "TYPE_ID", "POSITION", "FIRST_NAME", "MIDDLE_NAME", "LAST_NAME", "DOCUMENT_TYPE_ID", "DOCUMENT", "TRUST_REGNUM", "TRUST_REGDAT", "BDATE", "EDATE", "NOTARY_NAME", "NOTARY_REGION", "SIGN_PRIVS", "SIGN_ID", "NAME_R") AS 
  select "IDUPD","CHGDATE","CHGACTION","DONEBY","RNK","REL_ID","REL_RNK","REL_INTEXT","VAGA1","VAGA2","TYPE_ID","POSITION","FIRST_NAME","MIDDLE_NAME","LAST_NAME","DOCUMENT_TYPE_ID","DOCUMENT","TRUST_REGNUM","TRUST_REGDAT","BDATE","EDATE","NOTARY_NAME","NOTARY_REGION","SIGN_PRIVS","SIGN_ID","NAME_R"
  from customer_rel_update
 where (rnk,rel_id, rel_rnk, idupd) in
       ( select rnk,rel_id, rel_rnk, max(idupd) idupd
           from customer_rel_update u
          where trunc(chgdate) <= to_date(pul.get_mas_ini_val('DAT'), 'dd/mm/yyyy')
            and chgaction in (1,2)
            and not exists ( select 1 from customer_rel_update
                              where rnk = u.rnk and rel_id = u.rel_id and rel_rnk = u.rel_rnk
                                and chgaction = 3
                                and chgdate > u.chgdate
                                and trunc(chgdate) <= to_date(pul.get_mas_ini_val('DAT'), 'dd/mm/yyyy') )
          group by rnk, rel_id, rel_rnk );



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_REL_BYDATE.sql =========*** 
PROMPT ===================================================================================== 
