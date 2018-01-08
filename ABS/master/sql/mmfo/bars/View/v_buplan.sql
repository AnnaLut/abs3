

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BUPLAN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BUPLAN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BUPLAN ("ID", "NAMEU", "BRANCH", "NAMEB", "KOEF_PLAN", "SP4", "ST1", "ST2", "ST3", "ST4", "SB1") AS 
  SELECT
 u.ID,u.NAME,b.branch,b.NAME,u.KOEF_PLAN, s.sp4,s.st1,s.st2,s.st3,s.st4,s.sb1
FROM bu1 u,
    (SELECT branch, NAME  FROM branch WHERE LENGTH (branch) IN (8, 15) ) b,
    (SELECT p.ID, p.branch,
        SUM(DECODE(pdat,TO_DATE ('01.10.'||d.yp, 'dd.mm.yyyy'), p.sp,0) ) sp4,
        SUM(DECODE(pdat,TO_DATE ('01.01.'||d.yt, 'dd.mm.yyyy'), p.sp,0) ) st1,
        SUM(DECODE(pdat,TO_DATE ('01.04.'||d.yt, 'dd.mm.yyyy'), p.sp,0) ) st2,
        SUM(DECODE(pdat,TO_DATE ('01.07.'||d.yt, 'dd.mm.yyyy'), p.sp,0) ) st3,
        SUM(DECODE(pdat,TO_DATE ('01.10.'||d.yt, 'dd.mm.yyyy'), p.sp,0) ) st4,
        SUM(DECODE(pdat,TO_DATE ('01.01.'||d.yb, 'dd.mm.yyyy'), p.sp,0) ) sb1
     FROM bu_plan p,
        (SELECT TO_CHAR (ADD_MONTHS (SYSDATE, -12), 'yyyy') yp,
                TO_CHAR (            SYSDATE,       'yyyy') yt,
                TO_CHAR (ADD_MONTHS (SYSDATE,  12), 'yyyy') yb
         FROM DUAL) d
     GROUP BY p.ID, p.branch
     ) s
WHERE u.ID = s.ID(+) AND b.branch = s.branch;

PROMPT *** Create  grants  V_BUPLAN ***
grant SELECT,UPDATE                                                          on V_BUPLAN        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_BUPLAN        to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BUPLAN.sql =========*** End *** =====
PROMPT ===================================================================================== 
