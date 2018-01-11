

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLIMPDOCS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLIMPDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLIMPDOCS ("FN", "DAT", "IMPREF", "REF", "MFOA", "NLSA", "ID_A", "NAM_A", "MFOB", "NLSB", "ID_B", "NAM_B", "S", "S2", "KV", "KV2", "DK", "ND", "TT", "SK", "NAZN", "DATD", "DATP", "VDAT", "VOB", "ERRCODE", "ERRMSG", "STATUS", "TXTSTATUS", "D_REC", "BIS", "USERID", "FIO") AS 
  select
 f.FN, f.DAT, IMPREF, ref, MFOA, NLSA, ID_A, NAM_A, MFOB, NLSB,
 ID_B, NAM_B, S, S2, KV, KV2, DK, ND, TT, SK, NAZN, DATD, DATP,
 VDAT, VOB, ERRCODE, ERRMSG, d.status, descript, D_REC, BIS, f.userid, fio
from xml_impdocs d, xml_impfiles f,  xml_impstatus s, staff$base t
where d.fn = f.fn and d.dat = f.dat and f.userid = t.id
      and s.status = d.status
 ;

PROMPT *** Create  grants  V_XMLIMPDOCS ***
grant SELECT                                                                 on V_XMLIMPDOCS    to BARSREADER_ROLE;
grant SELECT                                                                 on V_XMLIMPDOCS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XMLIMPDOCS    to OPER000;
grant SELECT                                                                 on V_XMLIMPDOCS    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_XMLIMPDOCS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLIMPDOCS.sql =========*** End *** =
PROMPT ===================================================================================== 
