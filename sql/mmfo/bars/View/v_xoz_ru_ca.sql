CREATE OR REPLACE FORCE VIEW BARS.V_XOZ_RU_CA AS
   SELECT z.SOS            REC    ,    
          a.KF             MFOA   ,   
          a.nls            NLSA   ,   
          a.Nms            NAM_A  ,  
          x.S/100          S      ,      
          null             D_REC  ,  
          (select nazn from oper where ref = z.REF1)   NAZN ,   
          x.ref1           REF1   ,   
          Z.REFD           REFD_RU,
          a.OB22           OB22   ,   
          r.id             RU     ,     
          r.name           NAME   ,   
          a.nbs ||a.ob22   PROD   ,
          z.REF2_CA,
          z.REF2_KF,
          x.FDAT   ,
          z.DATZ
     FROM XOZ_DEB_ZAP Z, accounts a, xoz_ref X, regions R
     where z.REF1 = x.REF1 and z.stmt1 = x.stmt1 and z.KF = x.KF
       and x.acc  = a.acc  and a.KF    = x.KF 
       and z.kf   = r.KF and z.sos != 2;



GRANT SELECT ON BARS.V_XOZ_RU_CA TO BARS_ACCESS_DEFROLE;
