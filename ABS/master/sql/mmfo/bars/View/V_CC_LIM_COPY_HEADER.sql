

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_LIM_COPY_HEADER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_LIM_COPY_HEADER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CC_LIM_COPY_HEADER ("ID", "ND", "OPER_DATE", "FIO", "COMMENTS") AS 
  SELECT t.id, t.nd, t.oper_date, t1.fio, t.comments
  FROM cc_lim_copy_header t
  JOIN staff$base t1
    ON t.userid = t1.id;

PROMPT *** Create  grants  V_CC_LIM_COPY_HEADER ***
grant SELECT                                                                 on V_CC_LIM_COPY_HEADER to BARSREADER_ROLE;
grant SELECT                                                                 on V_CC_LIM_COPY_HEADER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CC_LIM_COPY_HEADER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_LIM_COPY_HEADER.sql =========*** E
PROMPT ===================================================================================== 
