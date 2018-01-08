

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_ADD_AGREEMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_ADD_AGREEMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_ADD_AGREEMENTS ("ID", "DEAL_ID", "BRANCH", "BRANCH_NAME", "STAFF_ID", "STAFF_FIO", "STAFF_LOGNAME", "CRT_DATE", "SER", "NUM", "SDATE", "COMM") AS 
  SELECT aa.id AS id,
            aa.deal_id,
            aa.branch,
            b.name AS branch_name,
            aa.staff_id,
            s.fio AS staff_fio,
            s.logname AS staff_logname,
            aa.crt_date,
            aa.ser,
            aa.num,
            aa.sdate,
            ins_pack.get_addagr_comm (aa.id) AS comm
       FROM ins_add_agreements aa, branch b, staff$base s
      WHERE aa.branch = b.branch AND aa.staff_id = s.id
   ORDER BY aa.deal_id, aa.sdate;

PROMPT *** Create  grants  V_INS_ADD_AGREEMENTS ***
grant SELECT                                                                 on V_INS_ADD_AGREEMENTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_ADD_AGREEMENTS.sql =========*** E
PROMPT ===================================================================================== 
