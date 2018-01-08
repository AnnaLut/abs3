

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DEMAND_OUR_FILIALES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DEMAND_OUR_FILIALES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DEMAND_OUR_FILIALES ("CODE", "NAME", "CITY", "STREET", "MFO", "CLIENT_0", "CLIENT_1", "ABVR_NAME") AS 
  select "CODE","NAME","CITY","STREET","MFO","CLIENT_0","CLIENT_1","ABVR_NAME" from demand_filiales where mfo=to_number(gl.kf)
 ;

PROMPT *** Create  grants  V_DEMAND_OUR_FILIALES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DEMAND_OUR_FILIALES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DEMAND_OUR_FILIALES to DEMAND;
grant SELECT                                                                 on V_DEMAND_OUR_FILIALES to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DEMAND_OUR_FILIALES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_DEMAND_OUR_FILIALES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DEMAND_OUR_FILIALES.sql =========*** 
PROMPT ===================================================================================== 
