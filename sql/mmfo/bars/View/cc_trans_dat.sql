

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_TRANS_DAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_TRANS_DAT ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_TRANS_DAT ("KF", "NPP", "REF", "FDAT", "SV", "SZ", "SR", "D_PLAN", "D_FAKT", "REFP", "COMM", "ACC", "NLS", "KV", "RNK", "ND") AS 
  select u1.KF
     , u1.NPP
     , u1.REF
     , u1.FDAT
     , u1.SV / 100 as SV
     , u1.SZ / 100 as SZ
     , ( u1.SV - u1.SZ ) / 100 as SR
     , u1.D_PLAN
     , u1.D_FAKT
     , u1.REFP
     , u1.COMM
     , ac.ACC
     , ac.NLS
     , ac.KV
     , ac.RNK
     , na.ND
  from CC_TRANS_UPDATE u1 
  join ( SELECT max(t1.IDUPD) as IDUPD  
           FROM CC_TRANS_UPDATE t1
           JOIN ( select nvl(to_date(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'),GL.BD() ) as RPT_DT
                    from dual
                ) dt
             on ( dt.RPT_DT >= t1.FDAT and dt.RPT_DT >= t1.EFFECTDATE and lnnvl( dt.RPT_DT < t1.D_FAKT ) )
          GROUP BY t1.NPP  
       ) u2
    on ( u2.IDUPD = u1.IDUPD )
  join ACCOUNTS ac
    on ( ac.ACC = u1.ACC )
  join ND_ACC na
    on ( na.ACC = u1.ACC )
 where CHGACTION <> 'D';

PROMPT *** Create  grants  CC_TRANS_DAT ***
grant SELECT                                                                 on CC_TRANS_DAT    to BARSREADER_ROLE;
grant SELECT                                                                 on CC_TRANS_DAT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TRANS_DAT    to RCC_DEAL;
grant SELECT                                                                 on CC_TRANS_DAT    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_TRANS_DAT.sql =========*** End *** =
PROMPT ===================================================================================== 
