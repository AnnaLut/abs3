

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OW_IIC_MSGCODE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OW_IIC_MSGCODE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OW_IIC_MSGCODE ("TT", "MFOA", "NLSA", "MSGCODE","NBS","OB22") AS 
  select tt, mfoa, nlsa, msgcode,nbs,ob22 from OW_IIC_MSGCODE;

PROMPT *** Create  grants  V_OW_IIC_MSGCODE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OW_IIC_MSGCODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_OW_IIC_MSGCODE to START1;
grant SELECT                                                                 on V_OW_IIC_MSGCODE to UPLD;
grant FLASHBACK,SELECT                                                       on V_OW_IIC_MSGCODE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OW_IIC_MSGCODE.sql =========*** End *
PROMPT ===================================================================================== 
