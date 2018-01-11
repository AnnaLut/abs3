

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OTDUSER2.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OTDUSER2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OTDUSER2 ("DEPT_ID", "DEPT_NAME", "UPR_ID", "UPR_NAME", "OTD_ID", "OTD_NAME", "SECT_ID", "SECT_NAME", "USERID", "FIO") AS 
  SELECT b2.idlh,
            b3.namel,
            b2.idlm,
            b4.namel,
            b2.idls_d,
            b5.namel,
            b2.idls_s,
            b6.namel,
            b1.idu,
            s.fio
       FROM b_schedule_subdiv_user b1,
            b_schedule_subdivision b2,
            b_schedule_levhigh b3,
            b_schedule_levmdl b4,
            b_schedule_levsml_d b5,
            b_schedule_levsml_s b6,
            staff$base s,
            dba_users d
      WHERE     d.account_status = 'OPEN'
            AND s.bax = 1
            AND 
           b1   .idu = s.id
            AND UPPER (d.username) = UPPER (s.logname)
            AND b1.idd = b2.idd(+)
            AND b2.idlh = b3.idl(+)
            AND b2.idlm = b4.idl(+)
            AND b2.idls_d = b5.idl(+)
            AND b2.idls_s = b6.idl(+)
   ORDER BY 1,
            3,
            5,
            7,
            9;

PROMPT *** Create  grants  V_OTDUSER2 ***
grant SELECT                                                                 on V_OTDUSER2      to BARSREADER_ROLE;
grant SELECT                                                                 on V_OTDUSER2      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OTDUSER2.sql =========*** End *** ===
PROMPT ===================================================================================== 
