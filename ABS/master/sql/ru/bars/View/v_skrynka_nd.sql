

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SKRYNKA_ND.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SKRYNKA_ND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SKRYNKA_ND ("ND", "N_SK", "SOS", "FIO", "DOKUM", "ISSUED", "ADRES", "DAT_BEGIN", "DAT_END", "TEL", "DOVER", "NMK", "DOV_DAT1", "DOV_DAT2", "MFOK", "NLSK", "CUSTTYPE", "ISP_DOV", "NDOV", "NLS", "NDOC", "DOCDATE", "SDOC", "TARIFF", "FIO2", "ISSUED2", "ADRES2", "PASP2", "OKPO1", "OKPO2", "S_ARENDA", "S_NDS", "PENY", "PRSKIDKA", "DATR2", "MR2", "MR", "DATR", "ADDND", "KEYCOUNT", "SD") AS 
  select ND,N_SK,SOS,FIO,DOKUM,ISSUED,ADRES,DAT_BEGIN,DAT_END,TEL,DOVER,NMK,DOV_DAT1,DOV_DAT2,
      MFOK,NLSK,CUSTTYPE,ISP_DOV,NDOV,NLS,NDOC,DOCDATE,SDOC,TARIFF,FIO2,ISSUED2,ADRES2,PASP2,
      OKPO1,OKPO2,S_ARENDA,S_NDS,PENY,PRSKIDKA,DATR2,MR2,MR,DATR,ADDND,KEYCOUNT,SD
from skrynka_nd
union all
select ND,N_SK,SOS,FIO,DOKUM,ISSUED,ADRES,DAT_BEGIN,DAT_END,TEL,DOVER,NMK,DOV_DAT1,DOV_DAT2,
      MFOK,NLSK,CUSTTYPE,ISP_DOV,NDOV,NLS,NDOC,DOCDATE,SDOC,TARIFF,FIO2,ISSUED2,ADRES2,PASP2,
      OKPO1,OKPO2,S_ARENDA,S_NDS,PENY,PRSKIDKA,DATR2,MR2,MR,DATR,ADDND,KEYCOUNT,SD
from skrynka_nd_arc;

PROMPT *** Create  grants  V_SKRYNKA_ND ***
grant SELECT                                                                 on V_SKRYNKA_ND    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SKRYNKA_ND    to DEP_SKRN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SKRYNKA_ND    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SKRYNKA_ND.sql =========*** End *** =
PROMPT ===================================================================================== 
