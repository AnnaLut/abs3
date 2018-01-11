

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLKLBTTS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLKLBTTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLKLBTTS ("TT", "NAME", "DK", "NLSM", "NLSK", "NLSA", "NLSB", "KV", "KVK", "MFOB", "NLSS", "FLC", "FLI", "FLV", "FLR", "S", "FLAGS", "RANG", "SK", "NAZN") AS 
  select  TT,NAME,DK,
  bars_xmlklb_ref.tt_func2param(nlsm) nlsm,
  bars_xmlklb_ref.tt_func2param(nlsk) nlsk,
  bars_xmlklb_ref.tt_func2param(nlsa) nlsa,
  bars_xmlklb_ref.tt_func2param(nlsb) nlsb,
  KV, KVK,
  MFOB,
  NLSS,
  FLC,FLI,FLV,FLR,S,FLAGS,RANG, SK, nazn
from tts
where tt in (select tt from op_rules where tag = 'ISOFF')
 ;

PROMPT *** Create  grants  V_XMLKLBTTS ***
grant SELECT                                                                 on V_XMLKLBTTS     to BARSREADER_ROLE;
grant SELECT                                                                 on V_XMLKLBTTS     to KLBX;
grant SELECT                                                                 on V_XMLKLBTTS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_XMLKLBTTS     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLKLBTTS.sql =========*** End *** ==
PROMPT ===================================================================================== 
