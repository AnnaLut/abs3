

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/K2.sql =========*** Run *** ===========
PROMPT ===================================================================================== 


PROMPT *** Create  view K2 ***

  CREATE OR REPLACE FORCE VIEW BARS.K2 ("TT", "ISP", "REF", "ND", "NLSA", "MFOB", "NLSB", "SD", "KOD", "NAME", "OCH", "S", "FDAT1", "FDAT2") AS 
  SELECT p.tt, p.userid, p.ref, p.nd, p.nlsa, p.mfob, p.nlsb, p.s,v.kod,
       v.VID_PL, v.n_vp, sum(decode(o.dk,0,o.s,-o.s)), min(o.fdat),
       max(o.fdat)
FROM oper p, opldok o, operw w, vid_pl v
WHERE p.ref = o.ref AND p.tt  = 'K2A' AND p.ref=w.ref AND (o.tt ='K2B' and
      o.dk=0 or o.tt='K2O' and o.dk=1) AND w.tag='VIDPL' AND
      w.value=to_char(v.kod) AND O.SOS=5
GROUP BY p.tt, p.userid, p.ref, p.nd, p.nlsa, p.mfob, p.nlsb, p.s, v.kod,
      v.VID_PL, v.n_vp
HAVING sum(decode(o.dk,0,o.s,-o.s))<>0
UNION ALL
SELECT p.tt, p.userid, p.ref, p.nd, p.nlsa, p.mfob, p.nlsb, p.s, v.kod,
       v.VID_PL, v.n_vp, sum(decode(o.dk,0,o.s,-o.s)), min(o.fdat),
       max(o.fdat)
FROM oper p, opldok o, operw w, vid_pl v
WHERE p.ref = o.ref AND p.tt  = 'K2Q' AND p.ref=w.ref AND (o.tt ='K2B' and
      o.dk=0 or o.tt='K2O' and o.dk=1) AND w.tag='VIDPL' AND
      w.value=to_char(v.kod) AND O.SOS=5
GROUP BY p.tt, p.userid, p.ref, p.nd, p.nlsa, p.mfob, p.nlsb, p.s, v.kod,
      v.VID_PL, v.n_vp
HAVING sum(decode(o.dk,0,o.s,-o.s))<>0;

PROMPT *** Create  grants  K2 ***
grant SELECT                                                                 on K2              to BARSREADER_ROLE;
grant SELECT                                                                 on K2              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on K2              to START1;
grant SELECT                                                                 on K2              to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/K2.sql =========*** End *** ===========
PROMPT ===================================================================================== 
