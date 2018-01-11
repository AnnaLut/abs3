

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_REZFONDSUM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_REZFONDSUM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_REZFONDSUM ("NLS", "KV", "ACC", "ID", "CUSTTYPE", "S080", "REZOLD", "REZOLDQ", "REZIN", "REZINQ", "DEL1", "DELQ1", "REZOUT", "REZOUTQ", "SZ", "SZQ", "DEL2", "DELQ2", "DELQ3") AS 
  SELECT s_fond, kv, acc, ID, custtype, s080, rezold, rezoldq, rezin, rezinq,
          rezin - rezold del1, rezinq - rezoldq delq1, rezout, rezoutq, sz,
          szq, sz - rezout del2, szq - rezout delq2,
          rezinq - gl.p_icurval (kv, rezin, rez.prevdate ()) delq3
     FROM (WITH f AS
                (SELECT s.s_fond, a.kv, a.acc, s.ID, s.custtype, s.s080
                   FROM srezerv s, accounts a
                  WHERE s.s_fond = a.nls(+) AND s.s_fond IS NOT NULL
                 UNION
                 SELECT s.s_fondnr, a.kv, a.acc, s.ID, s.custtype, s.s080
                   FROM srezerv s, accounts a
                  WHERE s.s_fondnr = a.nls(+) AND s.s_fondnr IS NOT NULL),
                u AS
                (SELECT ID
                   FROM staff
                  WHERE UPPER (logname) = UPPER (USER))
           SELECT   f.s_fond, f.kv, f.acc, i.NAME ID, cu.NAME custtype,
                    c.NAME s080, rez.ostc96 (f.acc, rez.prevdate ()) rezold,
                    gl.p_icurval (f.kv,
                                  rez.ostc96 (f.acc, rez.prevdate ()),
                                  rez.prevdate ()
                                 ) rezoldq,
                    rez.ostc96 (f.acc, rez.curdate () - 1) rezin,
                    gl.p_icurval (f.kv,
                                  rez.ostc96 (f.acc, rez.curdate () - 1),
                                  rez.curdate ()
                                 ) rezinq,
                    rez.ostc96 (f.acc, rez.curdate ()) rezout,
                    gl.p_icurval (f.kv,
                                  rez.ostc96 (f.acc, rez.curdate ()),
                                  rez.curdate ()
                                 ) rezoutq,
                    SUM (t.sz) sz,
                    gl.p_icurval (f.kv, SUM (t.sz), rez.curdate ()) szq
               FROM f, u, tmp_rez_risk t,
                    (select crisk, name from crisk
                     union
                     select '9','просрочені та сумнівні доході'
                     from dual
                     where not exists (select null from crisk where crisk = '9')  ) c,
                    custtype cu, srez_id i
              WHERE t.idr = f.ID
                AND t.custtype = f.custtype
                AND t.s080 = f.s080
                AND t.kv = f.kv
                AND t.ID = u.ID
                AND t.dat = rez.curdate ()
                AND t.s080 = c.crisk
                AND t.custtype = cu.custtype
                AND t.idr = i.ID
           GROUP BY f.s_fond,
                    f.kv,
                    f.acc,
                    i.NAME,
                    cu.NAME,
                    c.NAME,
                    rez.ostc96 (f.acc, rez.prevdate ()),
                    gl.p_icurval (f.kv,
                                  rez.ostc96 (f.acc, rez.prevdate ()),
                                  rez.prevdate ()
                                 ),
                    rez.ostc96 (f.acc, rez.curdate () - 1),
                    gl.p_icurval (f.kv,
                                  rez.ostc96 (f.acc, rez.curdate () - 1),
                                  rez.curdate () - 1
                                 ),
                    rez.ostc96 (f.acc, rez.curdate ()),
                    gl.p_icurval (f.kv,
                                  rez.ostc96 (f.acc, rez.curdate ()),
                                  rez.curdate ()
                                 ))
 ;

PROMPT *** Create  grants  V_REZFONDSUM ***
grant SELECT                                                                 on V_REZFONDSUM    to BARSREADER_ROLE;
grant SELECT                                                                 on V_REZFONDSUM    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_REZFONDSUM    to RCC_DEAL;
grant SELECT                                                                 on V_REZFONDSUM    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_REZFONDSUM    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_REZFONDSUM.sql =========*** End *** =
PROMPT ===================================================================================== 
