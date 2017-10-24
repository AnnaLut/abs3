

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CIG_SEX.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_CIG_SEX ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_CIG_SEX ("RNK", "B_CHG", "NMK", "BDAY", "OKPO", "SEX_OLD", "SEX") AS 
  select  c.rnk, 0 b_chg,c.nmk,c.bday, c.okpo,sex sex_old,
          (case when  c.okpo=c.okpo10 then  mod(to_number(substr(c.okpo,9,1))+1,2)+1 else  null end ) sex
from
  (
    select c.rnk, c.nmk , p.bday ,p.sex ,v_okpo10(c.okpo,p.bday)okpo10 ,c.okpo
      from customer c, person p
     where p.rnk=c.rnk and c.date_off is null and nvl(p.sex,0) not in (1,2)
           and exists (select 1 from accounts a where (A.NLS like '22%' or a.nls like '2625%') and a.ostc<0 and a.dazs is null and a.rnk=c.rnk)
) c;

PROMPT *** Create  grants  V_CUSTOMER_CIG_SEX ***
grant SELECT,UPDATE                                                          on V_CUSTOMER_CIG_SEX to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_CIG_SEX to CIG_LOADER;
grant SELECT,UPDATE                                                          on V_CUSTOMER_CIG_SEX to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CIG_SEX.sql =========*** End
PROMPT ===================================================================================== 
