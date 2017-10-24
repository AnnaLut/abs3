

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TD_SKRYNKA_ND.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_SKRYNKA_ND ***

  CREATE OR REPLACE TRIGGER BARS.TD_SKRYNKA_ND 
   after delete
   ON skrynka_nd
   FOR EACH ROW
DECLARE
BEGIN
   insert into skrynka_nd_arc ( ND,N_SK,SOS,FIO,DOKUM,ISSUED,ADRES,DAT_BEGIN,DAT_END,TEL,DOVER,NMK,DOV_DAT1,DOV_DAT2,
      MFOK,NLSK,CUSTTYPE,ISP_DOV,NDOV,NLS,NDOC,DOCDATE,SDOC,TARIFF,FIO2,ISSUED2,ADRES2,PASP2,
      OKPO1,OKPO2,S_ARENDA,S_NDS,PENY,PRSKIDKA,DATR2,MR2,MR,DATR,ADDND,KEYCOUNT,SD,RNK)
   values (  :OLD.ND,:OLD.N_SK,:OLD.SOS,:OLD.FIO,:OLD.DOKUM,:OLD.ISSUED,:OLD.ADRES,:OLD.DAT_BEGIN,:OLD.DAT_END,:OLD.TEL,:OLD.DOVER,
      :OLD.NMK,:OLD.DOV_DAT1,:OLD.DOV_DAT2,:OLD.MFOK,:OLD.NLSK,:OLD.CUSTTYPE,:OLD.ISP_DOV,:OLD.NDOV,:OLD.NLS,:OLD.NDOC,:OLD.DOCDATE,
      :OLD.SDOC,:OLD.TARIFF,:OLD.FIO2,:OLD.ISSUED2,:OLD.ADRES2,:OLD.PASP2,:OLD.OKPO1,:OLD.OKPO2,:OLD.S_ARENDA,:OLD.S_NDS,:OLD.PENY,
      :OLD.PRSKIDKA,:OLD.DATR2,:OLD.MR2,:OLD.MR,:OLD.DATR,:OLD.ADDND,:OLD.KEYCOUNT,:OLD.SD,:OLD.RNK);
END;
/
ALTER TRIGGER BARS.TD_SKRYNKA_ND ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TD_SKRYNKA_ND.sql =========*** End *
PROMPT ===================================================================================== 
