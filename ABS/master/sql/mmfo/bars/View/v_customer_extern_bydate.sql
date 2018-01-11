

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_EXTERN_BYDATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_EXTERN_BYDATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_EXTERN_BYDATE ("IDUPD", "CHGACTION", "EFFECTDATE", "CHGDATE", "DONEBY", "ID", "NAME", "DOC_TYPE", "DOC_SERIAL", "DOC_NUMBER", "DOC_DATE", "DOC_ISSUER", "BIRTHDAY", "BIRTHPLACE", "SEX", "ADR", "TEL", "EMAIL", "CUSTTYPE", "OKPO", "COUNTRY", "REGION", "FS", "VED", "SED", "ISE", "NOTES") AS 
  select "IDUPD","CHGACTION","EFFECTDATE","CHGDATE","DONEBY","ID","NAME","DOC_TYPE","DOC_SERIAL","DOC_NUMBER","DOC_DATE","DOC_ISSUER","BIRTHDAY","BIRTHPLACE","SEX","ADR","TEL","EMAIL","CUSTTYPE","OKPO","COUNTRY","REGION","FS","VED","SED","ISE","NOTES"
  from customer_extern_update
 where (id, idupd) in ( select id, max(idupd)
                          from customer_extern_update u
                         where trunc(chgdate) <= to_date(pul.get_mas_ini_val('DAT'), 'dd/mm/yyyy')
                           and chgaction in ('I','U')
                         group by id );

PROMPT *** Create  grants  V_CUSTOMER_EXTERN_BYDATE ***
grant SELECT                                                                 on V_CUSTOMER_EXTERN_BYDATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_EXTERN_BYDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_EXTERN_BYDATE.sql =========*
PROMPT ===================================================================================== 
