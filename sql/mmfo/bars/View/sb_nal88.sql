

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SB_NAL88.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view SB_NAL88 ***

  CREATE OR REPLACE FORCE VIEW BARS.SB_NAL88 ("FDAT", "P080", "NLS1", "S1", "NLS2", "S2", "NMS2", "OB22", "NLS3", "S3") AS 
  SELECT D.FDAT, S1.P080, A1.NLS ,FOST(A1.ACC,D.FDAT),
       A2.NLS, FOST(A2.ACC,D.FDAT), A2.NMS,S3.OB22,A3.NLS,FOST(A3.ACC,D.FDAT)
FROM SPECPARAM_INT S1, ACCOUNTS A1,ACCOUNTS A2,
     SPECPARAM_INT S3, ACCOUNTS A3, FDAT D
WHERE S1.ACC=A1.ACC AND A1.ACC=A2.ACCC  AND A2.ACC=A3.ACCC AND
      A3.ACC=S3.ACC AND A1.ACCC IS NULL AND A1.KV=980      AND
      A2.KV=980     AND A3.KV=980       AND SUBSTR(A1.NLS,1,1)='8'
UNION ALL SELECT  D.FDAT,S1.P080,A1.NLS, FOST(A1.ACC,D.FDAT),
        A2.NLS, FOST(A2.ACC,D.FDAT), A2.NMS,'', '', 0
FROM SPECPARAM_INT S1, ACCOUNTS A1, ACCOUNTS A2, FDAT D
WHERE S1.ACC=A1.ACC AND A1.ACC=A2.ACCC AND A1.KV=980  AND
      SUBSTR(A1.NLS,1,1)='8' AND           A2.KV=980  AND
      A1.ACCC IS NULL AND SUBSTR(A2.NLS,1,1)='8'      AND  A2.ACC not in
       (select ACCC from accounts where accc is not null)
UNION ALL SELECT D.FDAT,'','',0,A2.NLS,FOST(A2.ACC,D.FDAT), A2.NMS,'', '', 0
FROM  FDAT D, ACCOUNTS A2
WHERE A2.nbs NOT IN (8020,8011,8001,8030) AND
      A2.ACCC is null AND A2.KV=980 AND LENGTH(A2.NLS)>=8 AND
      SUBSTR(A2.NLS,1,1)='8' and a2.dazs is null AND
      A2.acc not in (select ACCC from accounts  where accc is not null)
 ;

PROMPT *** Create  grants  SB_NAL88 ***
grant SELECT                                                                 on SB_NAL88        to BARSREADER_ROLE;
grant SELECT                                                                 on SB_NAL88        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SB_NAL88        to NALOG;
grant SELECT                                                                 on SB_NAL88        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SB_NAL88        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SB_NAL88.sql =========*** End *** =====
PROMPT ===================================================================================== 
