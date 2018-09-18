

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_CONS_PERSON_UO.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_CONS_PERSON_UO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBU_CONS_PERSON_UO ("REPORT_ID", "SESSION_CREATION_TIME", "SESSION_ACTIVITY_TIME", "REQUEST_ID", "RNK", "NAMEUR", "ISREZ", "CODEDRPOU", "REGISTRYDAY", "NUMBERREGISTRY", "K110", "EC_YEAR", "COUNTRYCODNEREZ", "ISMEMBER", "ISCONTROLLER", "ISPARTNER", "ISAUDIT", "K060", "COMPANY_CODE", "DEFAULT_COMPANY_KF", "DEFAULT_COMPANY_ID", "COMPANY_OBJECT_ID", "STATUS", "STATUS_MESSAGE", "KF", "K020", "CODDOCUM", "ISKR", "CORE_CUSTOMER_KF", "CORE_CUSTOMER_ID", "ID") AS 
  select "REPORT_ID","SESSION_CREATION_TIME","SESSION_ACTIVITY_TIME","REQUEST_ID","RNK","NAMEUR","ISREZ","CODEDRPOU","REGISTRYDAY","NUMBERREGISTRY","K110","EC_YEAR","COUNTRYCODNEREZ","ISMEMBER","ISCONTROLLER","ISPARTNER","ISAUDIT","K060","COMPANY_CODE","DEFAULT_COMPANY_KF","DEFAULT_COMPANY_ID","COMPANY_OBJECT_ID","STATUS","STATUS_MESSAGE","KF","K020","CODDOCUM","ISKR","CORE_CUSTOMER_KF","CORE_CUSTOMER_ID","ID" from nbu_gateway.v_consolidated_person_uo
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_CONS_PERSON_UO.sql =========*** E
PROMPT ===================================================================================== 
