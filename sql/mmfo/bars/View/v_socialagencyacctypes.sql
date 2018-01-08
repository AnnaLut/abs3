

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCIALAGENCYACCTYPES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCIALAGENCYACCTYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCIALAGENCYACCTYPES ("AGENCY_TYPEID", "AGENCY_TYPENAME", "ACCOUNT_TYPEID", "ACCOUNT_TYPENAME", "ACCOUNT_MASKID", "ACCOUNT_MASKNAME", "ACCOUNT_NAME") AS 
  SELECT g.type_id,
         g.type_name,
         a.acctype,
         case a.acctype
           when 'D' then 'Рахунок дебіт.заборг.'
           when 'K' then 'Рахунок кредіт.заборг.(поточн.)'
           when 'C' then 'Рахунок кредіт.заборг.(картк.)'
           when 'M' then 'Рахунок коміс.доходів'
         end,
         a.accmask,
         p.NAME,
         a.accname
    FROM social_agency_acctypes a
   INNER JOIN social_agency_type g on (g.type_id = a.agntype)
   INNER JOIN ps p on (p.nbs = a.accmask);

PROMPT *** Create  grants  V_SOCIALAGENCYACCTYPES ***
grant SELECT                                                                 on V_SOCIALAGENCYACCTYPES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALAGENCYACCTYPES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SOCIALAGENCYACCTYPES to DPT_ROLE;
grant SELECT                                                                 on V_SOCIALAGENCYACCTYPES to START1;
grant SELECT                                                                 on V_SOCIALAGENCYACCTYPES to UPLD;
grant SELECT                                                                 on V_SOCIALAGENCYACCTYPES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCIALAGENCYACCTYPES.sql =========***
PROMPT ===================================================================================== 
