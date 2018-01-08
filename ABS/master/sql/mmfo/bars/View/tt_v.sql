

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TT_V.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view TT_V ***

  CREATE OR REPLACE FORCE VIEW BARS.TT_V ("TT", "NAME", "DK", "NLSM", "KV", "NLSK", "KVK", "NLSS", "NLSA", "NLSB", "MFOB", "FLC", "FLI", "FLV", "FLR", "FL_0", "FL_3", "FL_9", "FL_12", "FL_35", "FL_37", "FL_46", "FL_49", "FL_50", "FL_59", "FL_60", "S", "S2", "SK", "PROC", "S3800", "S6201", "S7201", "RANG", "TTAP", "DK_D", "VOB", "NBS", "DK_PS", "ID", "IDCHK", "PRIORITY", "F_BIG_AMOUNT", "TAG", "OPT", "USED4INPUT", "ORD", "VAL") AS 
  select t.TT,t.NAME, t.DK,t.NLSM,t.KV,t.NLSK,t.KVK,t.NLSS,
  t.NLSA,t.NLSB,t.MFOB,t.FLC,t.FLI,t.FLV,t.FLR,
  SUBSTR(t.FLAGS, 1,1),SUBSTR(t.FLAGS, 4,1),SUBSTR(t.FLAGS,10,1),
  SUBSTR(t.FLAGS,13,1),SUBSTR(t.FLAGS,36,1),SUBSTR(t.FLAGS,39,1),
  SUBSTR(t.FLAGS,47,1),SUBSTR(t.FLAGS,50,1),SUBSTR(t.FLAGS,51,1),
  SUBSTR(t.FLAGS,60,1),SUBSTR(t.FLAGS,61,1),
  t.S,t.S2,t.SK,t.PROC,t.S3800,t.S6201,t.S7201,t.RANG,
  a.TTAP,a.DK,v.VOB,p.NBS,p.DK,s.ID,c.IDCHK,c.PRIORITY,c.F_BIG_AMOUNT,
  r.TAG,r.OPT,r.USED4INPUT,r.ORD,r.VAL
from tts T,ttsap A,tts_vob V,ps_tts P, staff_tts S,CHKLIST_TTS C, OP_RULES R
where t.tt=a.tt (+) and      t.tt=v.tt (+) and      t.tt=p.tt (+) and
      t.tt=s.tt (+) and      t.tt=c.tt (+) and      t.tt=r.tt (+)

 ;

PROMPT *** Create  grants  TT_V ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TT_V            to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on TT_V            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TT_V            to SALGL;
grant SELECT                                                                 on TT_V            to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TT_V            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TT_V.sql =========*** End *** =========
PROMPT ===================================================================================== 
