

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W_LIM1_EXT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W_LIM1_EXT ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W_LIM1_EXT ("ND", "GRF", "FDAT", "OTM", "SN", "LIM2", "SUMG", "SUMO", "SUMK", "SUMP1", "SUMP", "VST", "DOS", "KOS", "OST", "SUMO1", "DELO", "VLIM") AS 
  select ND,
       GRF,
       FDAT,
       OTM,
       SN,
       LIM2,
       SUMG,
       SUMO,
       SUMK,
       SUMP1,
       SUMP,
       VST,
       DOS,
       KOS,
       OST,
       (SUMO + SUMP1) SUMO1,
       OST - LIM2 DELO,
       LIM2 + SUMG VLIM
  from (SELECT to_number(pul.GET('ND')) ND,
               decode(F.fdat, P.fdat, 1, 0) GRF, --n
               F.FDAT,
               p.OTM,
               nvl(p.not_sn, 0) SN,
               p.NOT_9129,
               P.lim2 / 100 LIM2,
               nvl(P.sumg, 0) / 100 SUMG,
               nvl(P.sumo, 0) / 100 SUMO,
               Nvl(P.sumK, 0) / 100 SUMK,
               Nvl(P.sumP1, 0) / 100 SUMP1,
               (nvl(P.sumO, 0) - nvl(P.sumG, 0) - nvl(P.sumK, 0)) / 100 SUMP,
               case
                 when f.fdat <= gl.bd then
                  -fost(f.acc, f.fdat - 1) / 100
                 else
                  null
               end VST,
               case
                 when f.fdat <= gl.bd then
                  -fost(f.acc, f.fdat) / 100
                 else
                  null
               end OST,
               case
                 when f.fdat <= gl.bd then
                  fdos(f.acc, f.fdat, f.fdat) / 100
                 else
                  null
               end DOS,
               case
                 when f.fdat <= gl.bd then
                  fkos(f.acc, f.fdat, f.fdat) / 100
                 else
                  null
               end KOS
          FROM (select fdat, acc
                  from cc_LIM
                 where nd = pul.GET('ND')
                union
                select fdat, acc
                  from saldoa
                 where acc = pul.GET('ACC8')) F,
               (select fdat,
                       lim2,
                       sumg,
                       sumo,
                       sumk,
                       otm,
                       not_sn,
                       NVL(not_9129, 0) not_9129,
                       0 sump1
                  from cc_lim
                 where nd = pul.GET('ND')) P
         WHERE F.fdat = P.fdat(+)) x
 ORDER BY fdat
;

PROMPT *** Create  grants  CC_W_LIM1_EXT ***
grant SELECT                                                                 on CC_W_LIM1_EXT   to BARSREADER_ROLE;
grant SELECT                                                                 on CC_W_LIM1_EXT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_W_LIM1_EXT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W_LIM1_EXT.sql =========*** End *** 
PROMPT ===================================================================================== 
