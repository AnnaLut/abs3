PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PDFO.sql =========*** Run *** =======
PROMPT ===================================================================================== 

CREATE OR REPLACE FORCE VIEW BARS.V_PDFO
( BRANCH,
  NLS6,
  T6,
  Z6,
  ACC6,
  O6,
  NLS5,
  T5,
  Z5,
  ACC5,
  O5,
  V,
  V100,
  P,
  P100,
  MFOB,
  NLSB,
  NAMB,
  ID_B
) AS
SELECT A6.BRANCH,
       A6.NLS NLS6,
       A6.OSTB / 100 T6,
       A6.Z / 100 Z6,
       A6.ACC ACC6,
       A6.OB22 O6,
       A5.NLS NLS5,
       -A5.OSTB / 100 T5,
       A5.Z / 100 Z5,
       A5.ACC ACC5,
       A5.OB22 O5,
       LEAST( A6.Z, A5.Z ) / 100 V,
       LEAST( A6.Z, A5.Z ) V100,
       GREATEST( A6.Z - A5.Z, 0 ) / 100 P,
       GREATEST( A6.Z - A5.Z, 0 ) P100,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = 'PDFOMFO'), 1, 06 ) MFOB,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = DECODE( A6.OB22, '36', 'PDFOVZB', 'PDFONLS')), 1, 14) NLSB,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = 'PDFONAM'), 1, 38 ) NAMB,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = 'PDFOID' ), 1, 08 ) ID_B
  FROM ( SELECT a.ACC,
                a.BRANCH,
                a.NLS,
                a.OB22,
                a.OSTB,
                LEAST (NVL (b.OST + b.CRKOS - b.CRDOS, a.OSTC), a.OSTB) Z
           FROM V_GL a
           LEFT
           JOIN AGG_MONBALS b
             ON ( b.KF   = a.KF  and
                  b.ACC  = a.ACC and
                  b.FDAT = trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' )
                )
          WHERE a.KV = 980
            AND a.NBS = '3622'
            AND a.OB22 IN ('36','37')
            AND a.DAOS <= trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' )
            --AND LNNVL( DAZS <= trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' ) )
            AND DAZS is null --COBUMMFO-9741

       ) A6
     , ( SELECT a.ACC,
                a.BRANCH,
                a.NLS,
                a.OB22,
                a.OSTB,
                LEAST (-NVL (b.OST + b.CRKOS - b.CRDOS, a.OSTC), -a.OSTB) Z
           FROM V_GL a
           LEFT
           JOIN AGG_MONBALS b
             ON ( b.KF   = a.KF  and
                  b.ACC  = a.ACC and
                  b.FDAT = trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' )
                )
          WHERE a.KV = 980
            AND a.NBS = '3522'
            AND a.OB22 IN ('29', '30')
            AND a.DAOS <= trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' )
            --AND LNNVL( DAZS <= trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' ) )
            AND DAZS is null --COBUMMFO-9741
       ) A5
 WHERE A6.BRANCH = A5.BRANCH
   AND ( A6.OB22 = '36' AND A5.OB22 = '30' OR A6.OB22 = '37' AND A5.OB22 = '29' )
 UNION ALL
SELECT A6.BRANCH,
       A6.NLS NLS6,
       A6.OSTB / 100 T6,
       A6.Z / 100 Z6,
       A6.ACC ACC6,
       A6.OB22 O6,
       '' NLS5,
       0 T5,
       0 Z5,
       TO_NUMBER (NULL) ACC5,
       '' O5,
       0 V,
       0 V100,
       A6.Z / 100 P,
       A6.Z P100,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = 'PDFOMFO'), 1, 06 ) MFOB,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = 'PDFOVZB'), 1, 14 ) NLSB,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = 'PDFONAM'), 1, 38 ) NAMB,
       SUBSTR( (SELECT VAL FROM BRANCH_PARAMETERS WHERE BRANCH = A6.BRANCH AND TAG = 'PDFOID' ), 1, 08 ) ID_B
  FROM ( SELECT a.ACC,
                a.BRANCH,
                a.NLS,
                a.OB22,
                a.OSTB,
                LEAST( NVL( b.OST + b.CRKOS - b.CRDOS, a.OSTC ), a.OSTB ) Z
           FROM V_GL a
           LEFT
           JOIN AGG_MONBALS b
             ON ( b.KF   = a.KF  and
                  b.ACC  = a.ACC and
                  b.FDAT = trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' )
                )
          WHERE a.KV   = 980
            AND a.NBS  = '3622'
            AND a.OB22 = '38'
            AND a.DAOS <= trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' )
            --AND LNNVL( DAZS <= trunc( nvl( to_date( PUL.GET('WDAT'), 'dd.mm.yyyy' ), SYSDATE ), 'MM' ) )
            AND DAZS is null --COBUMMFO-9741
       ) A6;

show errors;

GRANT SELECT ON BARS.V_PDFO TO BARSREADER_ROLE;
GRANT SELECT ON BARS.V_PDFO TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_PDFO TO START1;
