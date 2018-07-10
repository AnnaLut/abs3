

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRANCH_ACCESS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRANCH_ACCESS ***

begin
bpa.disable_policies('V_BRANCH_ACCESS');
end;
/
commit;
CREATE OR REPLACE VIEW V_BRANCH_ACCESS AS
SELECT "BRANCH",
          "NAME",
          "B040",
          "DESCRIPTION",
          "IDPDR",
          "DATE_OPENED",
          "DATE_CLOSED",
          "DELETED",
          "SAB"
     FROM branch
where branch like sys_context('bars_context','user_branch_mask') or branch  like  (select branch||'%' from staff$base where id =sys_context('bars_global','user_id'));

PROMPT *** Create  grants  V_BRANCH_ACCESS ***
grant SELECT                                                                 on V_BRANCH_ACCESS to BARSREADER_ROLE;
grant SELECT                                                                 on V_BRANCH_ACCESS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BRANCH_ACCESS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRANCH_ACCESS.sql =========*** End **
PROMPT ===================================================================================== 
