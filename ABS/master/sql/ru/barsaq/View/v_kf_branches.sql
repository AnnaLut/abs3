

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_KF_BRANCHES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KF_BRANCHES ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_KF_BRANCHES ("KF", "BRANCH", "NAME", "DATE_OPENED", "DATE_CLOSED", "B040", "DESCRIPTION") AS 
  select substr(branch,2,6) kf,branch,name,date_opened,date_closed,b040,description
    from bars.branch where branch<>'/';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_KF_BRANCHES.sql =========*** End **
PROMPT ===================================================================================== 
