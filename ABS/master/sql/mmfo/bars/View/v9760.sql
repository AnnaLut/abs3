

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V9760.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V9760 ***

  CREATE OR REPLACE FORCE VIEW BARS.V9760 ("BB", "BRANCH", "S01", "S03", "S04", "S05", "S06", "S07", "S08", "S09", "S10", "S11", "S12", "S13", "S14", "S15", "S16", "S17", "S18", "S19", "S20", "S21", "S22", "S23", "SSS") AS 
  SELECT  '' BB, a.branch,
  -sum (decode ( s.ob22, '01', a.ostc,0 ) )/100 S01,
  -sum (decode ( s.ob22, '03', a.ostc,0 ) )/100 S03,
  -sum (decode ( s.ob22, '04', a.ostc,0 ) )/100 S04,
  -sum (decode ( s.ob22, '05', a.ostc,0 ) )/100 S05,
  -sum (decode ( s.ob22, '06', a.ostc,0 ) )/100 S06,
  -sum (decode ( s.ob22, '07', a.ostc,0 ) )/100 S07,
  -sum (decode ( s.ob22, '08', a.ostc,0 ) )/100 S08,
  -sum (decode ( s.ob22, '09', a.ostc,0 ) )/100 S09,
  -sum (decode ( s.ob22, '10', a.ostc,0 ) )/100 S10,
  -sum (decode ( s.ob22, '11', a.ostc,0 ) )/100 S11,
  -sum (decode ( s.ob22, '12', a.ostc,0 ) )/100 S12,
  -sum (decode ( s.ob22, '13', a.ostc,0 ) )/100 S13,
  -sum (decode ( s.ob22, '14', a.ostc,0 ) )/100 S14,
  -sum (decode ( s.ob22, '15', a.ostc,0 ) )/100 S15,
  -sum (decode ( s.ob22, '16', a.ostc,0 ) )/100 S16,
  -sum (decode ( s.ob22, '17', a.ostc,0 ) )/100 S17,
  -sum (decode ( s.ob22, '18', a.ostc,0 ) )/100 S18,
  -sum (decode ( s.ob22, '19', a.ostc,0 ) )/100 S19,
  -sum (decode ( s.ob22, '20', a.ostc,0 ) )/100 S20,
  -sum (decode ( s.ob22, '21', a.ostc,0 ) )/100 S21,
  -sum (decode ( s.ob22, '22', a.ostc,0 ) )/100 S22,
  -sum (decode ( s.ob22, '23', a.ostc,0 ) )/100 S23,   -sum ( a.ostc )/100 SSS
from v_gl a , specparam_int s
where  a.nbs='9760' and a.kv=980 and a.acc=s.acc (+) and a.ostc<>0
group by a.branch
union all
SELECT  '**' BB, substr(a.branch,  1,15) branch,
  -sum (decode ( s.ob22, '01', a.ostc,0 ) )/100 S01,
  -sum (decode ( s.ob22, '03', a.ostc,0 ) )/100 S03,
  -sum (decode ( s.ob22, '04', a.ostc,0 ) )/100 S04,
  -sum (decode ( s.ob22, '05', a.ostc,0 ) )/100 S05,
  -sum (decode ( s.ob22, '06', a.ostc,0 ) )/100 S06,
  -sum (decode ( s.ob22, '07', a.ostc,0 ) )/100 S07,
  -sum (decode ( s.ob22, '08', a.ostc,0 ) )/100 S08,
  -sum (decode ( s.ob22, '09', a.ostc,0 ) )/100 S09,
  -sum (decode ( s.ob22, '10', a.ostc,0 ) )/100 S10,
  -sum (decode ( s.ob22, '11', a.ostc,0 ) )/100 S11,
  -sum (decode ( s.ob22, '12', a.ostc,0 ) )/100 S12,
  -sum (decode ( s.ob22, '13', a.ostc,0 ) )/100 S13,
  -sum (decode ( s.ob22, '14', a.ostc,0 ) )/100 S14,
  -sum (decode ( s.ob22, '15', a.ostc,0 ) )/100 S15,
  -sum (decode ( s.ob22, '16', a.ostc,0 ) )/100 S16,
  -sum (decode ( s.ob22, '17', a.ostc,0 ) )/100 S17,
  -sum (decode ( s.ob22, '18', a.ostc,0 ) )/100 S18,
  -sum (decode ( s.ob22, '19', a.ostc,0 ) )/100 S19,
  -sum (decode ( s.ob22, '20', a.ostc,0 ) )/100 S20,
  -sum (decode ( s.ob22, '21', a.ostc,0 ) )/100 S21,
  -sum (decode ( s.ob22, '22', a.ostc,0 ) )/100 S22,
  -sum (decode ( s.ob22, '23', a.ostc,0 ) )/100 S23,   -sum ( a.ostc )/100 SSS
from v_gl a , specparam_int s
where a.nbs='9760' and a.kv=980 and a.acc=s.acc (+) and a.ostc<>0
  and length (sys_context('bars_context','user_branch')) <= 15
group by substr(a.branch,1,15)
having  sum ( a.ostc ) is not null
union all
SELECT '* ' BB, substr( sys_context('bars_context','user_branch'),  1,15) branch,
  -sum (decode ( s.ob22, '01', a.ostc,0 ) )/100 S01,
  -sum (decode ( s.ob22, '03', a.ostc,0 ) )/100 S03,
  -sum (decode ( s.ob22, '04', a.ostc,0 ) )/100 S04,
  -sum (decode ( s.ob22, '05', a.ostc,0 ) )/100 S05,
  -sum (decode ( s.ob22, '06', a.ostc,0 ) )/100 S06,
  -sum (decode ( s.ob22, '07', a.ostc,0 ) )/100 S07,
  -sum (decode ( s.ob22, '08', a.ostc,0 ) )/100 S08,
  -sum (decode ( s.ob22, '09', a.ostc,0 ) )/100 S09,
  -sum (decode ( s.ob22, '10', a.ostc,0 ) )/100 S10,
  -sum (decode ( s.ob22, '11', a.ostc,0 ) )/100 S11,
  -sum (decode ( s.ob22, '12', a.ostc,0 ) )/100 S12,
  -sum (decode ( s.ob22, '13', a.ostc,0 ) )/100 S13,
  -sum (decode ( s.ob22, '14', a.ostc,0 ) )/100 S14,
  -sum (decode ( s.ob22, '15', a.ostc,0 ) )/100 S15,
  -sum (decode ( s.ob22, '16', a.ostc,0 ) )/100 S16,
  -sum (decode ( s.ob22, '17', a.ostc,0 ) )/100 S17,
  -sum (decode ( s.ob22, '18', a.ostc,0 ) )/100 S18,
  -sum (decode ( s.ob22, '19', a.ostc,0 ) )/100 S19,
  -sum (decode ( s.ob22, '20', a.ostc,0 ) )/100 S20,
  -sum (decode ( s.ob22, '21', a.ostc,0 ) )/100 S21,
  -sum (decode ( s.ob22, '22', a.ostc,0 ) )/100 S22,
  -sum (decode ( s.ob22, '23', a.ostc,0 ) )/100 S23,  -sum ( a.ostc )/100 SSS
from v_gl a , specparam_int s
where a.nbs='9760' and a.kv=980 and a.acc=s.acc (+)
  and length (sys_context('bars_context','user_branch')) <= 8
having  sum ( a.ostc ) is not null;

PROMPT *** Create  grants  V9760 ***
grant SELECT                                                                 on V9760           to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on V9760           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V9760           to SALGL;
grant SELECT                                                                 on V9760           to UPLD;
grant FLASHBACK,SELECT                                                       on V9760           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V9760.sql =========*** End *** ========
PROMPT ===================================================================================== 
