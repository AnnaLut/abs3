

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_FILEP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_FILEP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_FILEP ("FILE_NAME", "FILE_DATE", "DOC_REF", "DOC_TT", "DOC_KV", "DOC_SUM", "DOC_NLSA", "DOC_NAMA", "DOC_NLSB", "DOC_NAMB") AS 
  SELECT   p.f_n, p.f_d, o.REF, o.tt, o.kv, o.s/100, DECODE (o.dk, 0, o.nlsb, o.nlsa),
            DECODE (o.dk, 0, o.nam_b, o.nam_a),
            DECODE (o.dk, 0, o.nlsa, o.nlsb),
            DECODE (o.dk, 0, o.nam_a, o.nam_b)
       FROM oper o, pkk_que p
      WHERE o.REF = p.REF AND p.sos > 0
   ORDER BY p.f_n 
 ;

PROMPT *** Create  grants  V_OBPC_FILEP ***
grant SELECT                                                                 on V_OBPC_FILEP    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_FILEP    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_FILEP    to OBPC;
grant SELECT                                                                 on V_OBPC_FILEP    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_FILEP    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_FILEP.sql =========*** End *** =
PROMPT ===================================================================================== 
