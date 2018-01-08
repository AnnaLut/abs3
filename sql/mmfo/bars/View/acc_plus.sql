

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_PLUS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_PLUS ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_PLUS ("KV", "NBS", "OSTB", "TIP") AS 
  SELECT kv, nbs, gl.p_icurval( kv,ostB,gl.bd ), tip FROM ACCOUNTS
UNION ALL
SELECT kv,NBS,OSTB, tip FROM ACC_PLUS1;

PROMPT *** Create  grants  ACC_PLUS ***
grant SELECT                                                                 on ACC_PLUS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_PLUS        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_PLUS.sql =========*** End *** =====
PROMPT ===================================================================================== 
