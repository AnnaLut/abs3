

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLIMPFILES_STAT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLIMPFILES_STAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLIMPFILES_STAT ("FN", "DAT", "USERID", "BRANCH", "C", "S", "C1", "S1", "C2", "S2") AS 
  select fn, dat, userid, branch, c1+c2 c, s1+s2 s, c1, s1, c2, s2
  from ( select f.fn, f.dat, f.userid, f.branch,
                sum(decode(d.ref,null,0,1)) c1, sum(decode(d.ref,null,0,d.s)) s1,
                sum(decode(d.ref,null,1,0)) c2, sum(decode(d.ref,null,d.s,0)) s2
           from xml_impfiles f, xml_impdocs d
          where f.fn = d.fn
            and f.branch like sys_context('bars_context','user_branch')  || '%'
          group by f.fn, f.dat, f.userid, f.branch );

PROMPT *** Create  grants  V_XMLIMPFILES_STAT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_XMLIMPFILES_STAT to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_XMLIMPFILES_STAT to OPER000;
grant FLASHBACK,SELECT                                                       on V_XMLIMPFILES_STAT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLIMPFILES_STAT.sql =========*** End
PROMPT ===================================================================================== 
