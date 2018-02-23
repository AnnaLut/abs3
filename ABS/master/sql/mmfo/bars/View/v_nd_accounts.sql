create or replace force view V_ND_ACCOUNTS
( ND
, ACC
, NLS
, NLSALT
, KV
, KF
, NBS
, NBS2
, DAOS
, DAPP
, ISP
, RNK
, NMS
, LIM
, OSTB
, OSTC
, OSTF
, OSTQ
, OSTX
, DOS
, KOS
, DOSQ
, KOSQ
, PAP
, TIP
, VID
, TRCN
, MDATE
, DAZS
, SEC
, ACCC
, BLKD
, BLKK
, POS
, SECI
, SECO
, GRP
, TOBO
, LCV
, DIG
, OST
, DENOM
, BRANCH
, OB22
, FIO
)
as
  select n.ND
       , a.ACC
       , a.NLS
       , a.NLSALT
       , a.KV
       , a.KF
       , a.NBS
       , a.NBS2
       , a.DAOS
       , a.DAPP
       , a.ISP
       , a.RNK
       , a.NMS
       , a.LIM
       , a.OSTB
       , s.OST OSTC
       , a.OSTF
       , a.OSTQ
       , a.OSTX
       , s.DOS
       , s.KOS
       , a.DOSQ
       , a.KOSQ
       , a.PAP
       , a.TIP
       , a.VID
       , a.TRCN
       , a.MDATE
       , a.DAZS
       , a.SEC
       , a.ACCC
       , a.BLKD
       , a.BLKK
       , a.POS
       , a.SECI
       , a.SECO
       , a.GRP
       , a.TOBO
       , v.LCV
       , v.DIG
       , ( S.OST + S.DOS - S.KOS ) OST
       , v.DENOM
       , a.BRANCH
       , a.OB22
       , u.FIO
    from ACCOUNTS a
    join ND_ACC n
      on ( n.ACC = a.ACC )
    join TABVAL$GLOBAL v
      on ( v.KV = a.KV )
    left
    join SAL_BRANCH s
      on ( s.ACC = a.ACC and s.FDAT = GL.BD )
    join STAFF$BASE u
      on ( u.ID = a.ISP )
  union
  select CP.ND
       , A.ACC
       , A.NLS
       , A.NLSALT
       , A.KV
       , A.KF
       , A.NBS
       , A.NBS2
       , A.DAOS
       , A.DAPP
       , A.ISP
       , A.RNK
       , A.NMS
       , A.LIM
       , A.OSTB
       , S.OST OSTC
       , A.OSTF
       , A.OSTQ
       , A.OSTX
       , S.DOS
       , S.KOS
       , A.DOSQ
       , A.KOSQ
       , A.PAP
       , A.TIP
       , A.VID
       , A.TRCN
       , A.MDATE
       , A.DAZS
       , A.SEC
       , A.ACCC
       , A.BLKD
       , A.BLKK
       , A.POS
       , A.SECI
       , A.SECO
       , A.GRP
       , A.TOBO
       , V.LCV
       , V.DIG
       , ( S.OST + S.DOS - S.KOS ) OST
       , V.DENOM
       , A.BRANCH
       , A.OB22
       , u.FIO
    from ACCOUNTS A
    join CC_ACCP CP
      on ( cp.ACC = A.ACC )
    join TABVAL$GLOBAL v
      on ( v.KV = a.KV )
    left
    join SAL_BRANCH s
      on ( s.ACC = a.ACC and s.FDAT = GL.BD )
    join STAFF$BASE u
      on ( u.ID = a.ISP )
;

show errors;

GRANT SELECT ON BARS.V_ND_ACCOUNTS TO BARSREADER_ROLE;
GRANT SELECT ON BARS.V_ND_ACCOUNTS TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_ND_ACCOUNTS TO WR_ALL_RIGHTS;
