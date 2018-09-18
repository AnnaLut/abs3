

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_CONS_PERSON_FO.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_CONS_PERSON_FO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBU_CONS_PERSON_FO ("REPORT_ID", "SESSION_CREATION_TIME", "SESSION_ACTIVITY_TIME", "REQUEST_ID", "RNK", "LASTNAME", "FIRSTNAME", "MIDDLENAME", "ISREZ", "INN", "BIRTHDAY", "COUNTRYCODNEREZ", "K060", "PERSON_CODE", "STATUS", "STATUS_MESSAGE", "KF", "K020", "CODDOCUM", "ISKR", "CODREGION", "AREA", "ZIP", "CITY", "STREETADDRESS", "HOUSENO", "ADRKORP", "FLATNO") AS 
  select "REPORT_ID","SESSION_CREATION_TIME","SESSION_ACTIVITY_TIME","REQUEST_ID","RNK","LASTNAME","FIRSTNAME","MIDDLENAME","ISREZ","INN","BIRTHDAY","COUNTRYCODNEREZ","K060","PERSON_CODE","STATUS","STATUS_MESSAGE","KF","K020","CODDOCUM","ISKR","CODREGION","AREA","ZIP","CITY","STREETADDRESS","HOUSENO","ADRKORP","FLATNO" from nbu_gateway.v_consolidated_person_fo
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_CONS_PERSON_FO.sql =========*** E
PROMPT ===================================================================================== 
