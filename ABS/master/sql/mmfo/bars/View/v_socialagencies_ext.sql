

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCIALAGENCIES_EXT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCIALAGENCIES_EXT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCIALAGENCIES_EXT ("AGENCY_ID", "AGENCY_TYPE", "AGENCY_NAME", "AGENCY_BRANCH", "AGENCY_BRANCHNAME", "CONTRACT_NUMBER", "CONTRACT_DATE", "CONTRACT_CLOSED", "AGENCY_ADDRESS", "AGENCY_PHONE", "DETAILS") AS 
  select a.agency_id, a.type_id, substr(a.name,1,70), a.branch, b.name,
       a.contract, a.date_on, a.date_off,
       substr(a.address, 1, 70), substr(a.phone, 1, 70), substr(a.details, 1, 70)
  from social_agency a, branch b
 where a.branch     = b.branch
   and a.date_off is null
   and (a.BRANCH IN (
            select b.branch
                from branch b, (
                            SELECT CHILD_BRANCH || '%' branch
                            FROM DPT_FILE_SUBST
                            WHERE PARENT_BRANCH = sys_context('bars_context','user_branch')
                        ) sub
                WHERE b.BRANCH like sub.branch
             union
             select branch
             from branch
             where branch = sys_context('bars_context','user_branch')
             )
	   )
 ;

PROMPT *** Create  grants  V_SOCIALAGENCIES_EXT ***
grant SELECT                                                                 on V_SOCIALAGENCIES_EXT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOCIALAGENCIES_EXT to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALAGENCIES_EXT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCIALAGENCIES_EXT.sql =========*** E
PROMPT ===================================================================================== 
