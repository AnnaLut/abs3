

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ACC_PLUS1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view ACC_PLUS1 ***

  CREATE OR REPLACE FORCE VIEW BARS.ACC_PLUS1 ("KV", "NBS", "OSTB", "TIP", "NPP") AS 
  select KV, NBS, gl.p_icurval(KQ,SS,gl.bd )*100, TIP, npp
FROM
(SELECT kvd KV, KVD KQ, substr(deb,1,4) NBS, -s SS, 'ODB' TIP, 1 npp FROM IGRA
  UNION  ALL
 SELECT kvd, KVD, '3800', s, 'VP ',2 FROM IGRA  WHERE kvd<>kvk and kvd<>980
  UNION  ALL
 SELECT 980, KVK, '3801', s1,'ODB',3 FROM IGRA  WHERE kvd<>kvk and kvd= 980
  UNION  ALL
 SELECT kvk, kvk, '3800',-s1,'VP ',4 FROM IGRA  WHERE kvd<>kvk and kvk<>980
  UNION  ALL
 SELECT 980, kvd, '3801',-s,'ODB',5 FROM IGRA  WHERE kvd<>kvk and kvk= 980
  UNION  ALL
 SELECT nvl(kvk,kvd),nvl(kvk,kvd),SUBSTR(KRD,1,4),
        Decode(nvl(kvk,kvd),kvd,s,nvl(s1,s)),'ODB' ,6
 FROM   IGRA
  UNION ALL
 SELECT 980,kvd,'3801',-s,'ODB' ,7 FROM IGRA
 WHERE kvd<>kvk and kvd<>980 and kvk<>980
  UNION ALL
 SELECT 980,kvk,'3801',s1,'ODB',8 FROM IGRA
 WHERE kvd<>kvk and kvd<>980 and kvk<>980
  UNION ALL
 SELECT 980,980,'6204',
        (gl.p_icurval(kvd,s,gl.bd)-gl.p_icurval(kvk,s1,gl.bd)),'ODB',9
 FROM IGRA WHERE kvd<>kvk
 ) ;

PROMPT *** Create  grants  ACC_PLUS1 ***
grant SELECT                                                                 on ACC_PLUS1       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_PLUS1       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ACC_PLUS1.sql =========*** End *** ====
PROMPT ===================================================================================== 
