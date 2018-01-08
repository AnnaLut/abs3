

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_SKRYNKAND_UPDATE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_SKRYNKAND_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_SKRYNKAND_UPDATE 
-- version 1.1 29.11.2016
-- version 1.2 09.12.2016  V.Kharin
after insert or update of nd, n_sk, sos, fio, adres, dat_begin, dat_end, tariff, branch, o_sk, mfok, nlsk, nls, ndoc, docdate, sdoc, rnk or delete ON BARS.SKRYNKA_ND
for each row
declare
            l_otm    SKRYNKA_ND_UPDATE.chgaction%type := 0;
            l_idupd  SKRYNKA_ND_UPDATE.idupd%type;

            l_ND            SKRYNKA_ND_UPDATE.ND%type;
            l_N_SK          SKRYNKA_ND_UPDATE.N_SK%type;
            l_SOS           SKRYNKA_ND_UPDATE.SOS%type;
            l_FIO           SKRYNKA_ND_UPDATE.FIO%type;
            l_DOKUM         SKRYNKA_ND_UPDATE.DOKUM%type;
            l_ISSUED        SKRYNKA_ND_UPDATE.ISSUED%type;
            l_ADRES         SKRYNKA_ND_UPDATE.ADRES%type;
            l_DAT_BEGIN     SKRYNKA_ND_UPDATE.DAT_BEGIN%type;
            l_DAT_END       SKRYNKA_ND_UPDATE.DAT_END%type;
            l_TEL           SKRYNKA_ND_UPDATE.TEL%type;
            l_DOVER         SKRYNKA_ND_UPDATE.DOVER%type;
            l_NMK           SKRYNKA_ND_UPDATE.NMK%type;
            l_DOV_DAT1      SKRYNKA_ND_UPDATE.DOV_DAT1%type;
            l_DOV_DAT2      SKRYNKA_ND_UPDATE.DOV_DAT2%type;
            l_DOV_PASP      SKRYNKA_ND_UPDATE.DOV_PASP%type;
            l_MFOK          SKRYNKA_ND_UPDATE.MFOK%type;
            l_NLSK          SKRYNKA_ND_UPDATE.NLSK%type;
            l_CUSTTYPE      SKRYNKA_ND_UPDATE.CUSTTYPE%type;
            l_O_SK          SKRYNKA_ND_UPDATE.O_SK%type;
            l_ISP_DOV       SKRYNKA_ND_UPDATE.ISP_DOV%type;
            l_NDOV          SKRYNKA_ND_UPDATE.NDOV%type;
            l_NLS           SKRYNKA_ND_UPDATE.NLS%type;
            l_NDOC          SKRYNKA_ND_UPDATE.NDOC%type;
            l_DOCDATE       SKRYNKA_ND_UPDATE.DOCDATE%type;
            l_SDOC          SKRYNKA_ND_UPDATE.SDOC%type;
            l_TARIFF        SKRYNKA_ND_UPDATE.TARIFF%type;
            l_FIO2          SKRYNKA_ND_UPDATE.FIO2%type;
            l_ISSUED2       SKRYNKA_ND_UPDATE.ISSUED2%type;
            l_ADRES2        SKRYNKA_ND_UPDATE.ADRES2%type;
            l_PASP2         SKRYNKA_ND_UPDATE.PASP2%type;
            l_OKPO1         SKRYNKA_ND_UPDATE.OKPO1%type;
            l_OKPO2         SKRYNKA_ND_UPDATE.OKPO2%type;
            l_S_ARENDA      SKRYNKA_ND_UPDATE.S_ARENDA%type;
            l_S_NDS         SKRYNKA_ND_UPDATE.S_NDS%type;
            l_SD            SKRYNKA_ND_UPDATE.SD%type;
            l_KEYCOUNT      SKRYNKA_ND_UPDATE.KEYCOUNT%type;
            l_PRSKIDKA      SKRYNKA_ND_UPDATE.PRSKIDKA%type;
            l_PENY          SKRYNKA_ND_UPDATE.PENY%type;
            l_DATR2         SKRYNKA_ND_UPDATE.DATR2%type;
            l_MR2           SKRYNKA_ND_UPDATE.MR2%type;
            l_MR            SKRYNKA_ND_UPDATE.MR%type;
            l_DATR          SKRYNKA_ND_UPDATE.DATR%type;
            l_ADDND         SKRYNKA_ND_UPDATE.ADDND%type;
            l_AMORT_DATE    SKRYNKA_ND_UPDATE.AMORT_DATE%type;
            l_BRANCH        SKRYNKA_ND_UPDATE.BRANCH%type;
            l_KF            SKRYNKA_ND_UPDATE.KF%type;
            l_RNK           SKRYNKA_ND_UPDATE.RNK%type;

begin
  if deleting then
    l_otm         := 3;
    l_ND           := :old.ND;
    l_N_SK         := :old.N_SK;
    l_SOS          := :old.SOS;
    l_FIO          := :old.FIO;
    l_DOKUM        := :old.DOKUM;
    l_ISSUED       := :old.ISSUED;
    l_ADRES        := :old.ADRES;
    l_DAT_BEGIN    := :old.DAT_BEGIN;
    l_DAT_END      := :old.DAT_END;
    l_TEL          := :old.TEL;
    l_DOVER        := :old.DOVER;
    l_NMK          := :old.NMK;
    l_DOV_DAT1     := :old.DOV_DAT1;
    l_DOV_DAT2     := :old.DOV_DAT2;
    l_DOV_PASP     := :old.DOV_PASP;
    l_MFOK         := :old.MFOK;
    l_NLSK         := :old.NLSK;
    l_CUSTTYPE     := :old.CUSTTYPE;
    l_O_SK         := :old.O_SK;
    l_ISP_DOV      := :old.ISP_DOV;
    l_NDOV         := :old.NDOV;
    l_NLS          := :old.NLS;
    l_NDOC         := :old.NDOC;
    l_DOCDATE      := :old.DOCDATE;
    l_SDOC         := :old.SDOC;
    l_TARIFF       := :old.TARIFF;
    l_FIO2         := :old.FIO2;
    l_ISSUED2      := :old.ISSUED2;
    l_ADRES2       := :old.ADRES2;
    l_PASP2        := :old.PASP2;
    l_OKPO1        := :old.OKPO1;
    l_OKPO2        := :old.OKPO2;
    l_S_ARENDA     := :old.S_ARENDA;
    l_S_NDS        := :old.S_NDS;
    l_SD           := :old.SD;
    l_KEYCOUNT     := :old.KEYCOUNT;
    l_PRSKIDKA     := :old.PRSKIDKA;
    l_PENY         := :old.PENY;
    l_DATR2        := :old.DATR2;
    l_MR2          := :old.MR2;
    l_MR           := :old.MR;
    l_DATR         := :old.DATR;
    l_ADDND        := :old.ADDND;
    l_AMORT_DATE   := :old.AMORT_DATE;
    l_BRANCH       := :old.BRANCH;
    l_KF           := :old.KF;
    l_RNK          := :old.RNK;

  else
    if inserting then
      l_otm := 1;
    elsif UPDATING then
      l_otm := 2;
    end if;
    if l_otm>0 then
                    l_ND           := :new.ND;
                    l_N_SK         := :new.N_SK;
                    l_SOS          := :new.SOS;
                    l_FIO          := :new.FIO;
                    l_DOKUM        := :new.DOKUM;
                    l_ISSUED       := :new.ISSUED;
                    l_ADRES        := :new.ADRES;
                    l_DAT_BEGIN    := :new.DAT_BEGIN;
                    l_DAT_END      := :new.DAT_END;
                    l_TEL          := :new.TEL;
                    l_DOVER        := :new.DOVER;
                    l_NMK          := :new.NMK;
                    l_DOV_DAT1     := :new.DOV_DAT1;
                    l_DOV_DAT2     := :new.DOV_DAT2;
                    l_DOV_PASP     := :new.DOV_PASP;
                    l_MFOK         := :new.MFOK;
                    l_NLSK         := :new.NLSK;
                    l_CUSTTYPE     := :new.CUSTTYPE;
                    l_O_SK         := :new.O_SK;
                    l_ISP_DOV      := :new.ISP_DOV;
                    l_NDOV         := :new.NDOV;
                    l_NLS          := :new.NLS;
                    l_NDOC         := :new.NDOC;
                    l_DOCDATE      := :new.DOCDATE;
                    l_SDOC         := :new.SDOC;
                    l_TARIFF       := :new.TARIFF;
                    l_FIO2         := :new.FIO2;
                    l_ISSUED2      := :new.ISSUED2;
                    l_ADRES2       := :new.ADRES2;
                    l_PASP2        := :new.PASP2;
                    l_OKPO1        := :new.OKPO1;
                    l_OKPO2        := :new.OKPO2;
                    l_S_ARENDA     := :new.S_ARENDA;
                    l_S_NDS        := :new.S_NDS;
                    l_SD           := :new.SD;
                    l_KEYCOUNT     := :new.KEYCOUNT;
                    l_PRSKIDKA     := :new.PRSKIDKA;
                    l_PENY         := :new.PENY;
                    l_DATR2        := :new.DATR2;
                    l_MR2          := :new.MR2;
                    l_MR           := :new.MR;
                    l_DATR         := :new.DATR;
                    l_ADDND        := :new.ADDND;
                    l_AMORT_DATE   := :new.AMORT_DATE;
                    l_BRANCH       := :new.BRANCH;
                    l_KF           := :new.KF;
                    l_RNK          := :new.RNK;

    end if;
  end if;

  if l_otm>0 then
    l_idupd   := bars_sqnc.get_nextval('s_skrynka_nd_update', l_KF);

    insert
    into   SKRYNKA_ND_UPDATE (      ND            ,
                                    N_SK          ,
                                    SOS           ,
                                    FIO           ,
                                    DOKUM         ,
                                    ISSUED        ,
                                    ADRES         ,
                                    DAT_BEGIN     ,
                                    DAT_END       ,
                                    TEL           ,
                                    DOVER         ,
                                    NMK           ,
                                    DOV_DAT1      ,
                                    DOV_DAT2      ,
                                    DOV_PASP      ,
                                    MFOK          ,
                                    NLSK          ,
                                    CUSTTYPE      ,
                                    O_SK          ,
                                    ISP_DOV       ,
                                    NDOV          ,
                                    NLS           ,
                                    NDOC          ,
                                    DOCDATE       ,
                                    SDOC          ,
                                    TARIFF        ,
                                    FIO2          ,
                                    ISSUED2       ,
                                    ADRES2        ,
                                    PASP2         ,
                                    OKPO1         ,
                                    OKPO2         ,
                                    S_ARENDA      ,
                                    S_NDS         ,
                                    SD            ,
                                    KEYCOUNT      ,
                                    PRSKIDKA      ,
                                    PENY          ,
                                    DATR2         ,
                                    MR2           ,
                                    MR            ,
                                    DATR          ,
                                    ADDND         ,
                                    AMORT_DATE    ,
                                    BRANCH        ,
                                    KF            ,
                                    CHGDATE       ,
                                    CHGACTION     ,
                                    DONEBY        ,
                                    IDUPD  		  ,
                                    RNK    )
                     values (   l_ND            ,
                                l_N_SK          ,
                                l_SOS           ,
                                l_FIO           ,
                                l_DOKUM         ,
                                l_ISSUED        ,
                                l_ADRES         ,
                                l_DAT_BEGIN     ,
                                l_DAT_END       ,
                                l_TEL           ,
                                l_DOVER         ,
                                l_NMK           ,
                                l_DOV_DAT1      ,
                                l_DOV_DAT2      ,
                                l_DOV_PASP      ,
                                l_MFOK          ,
                                l_NLSK          ,
                                l_CUSTTYPE      ,
                                l_O_SK          ,
                                l_ISP_DOV       ,
                                l_NDOV          ,
                                l_NLS           ,
                                l_NDOC          ,
                                l_DOCDATE       ,
                                l_SDOC          ,
                                l_TARIFF        ,
                                l_FIO2          ,
                                l_ISSUED2       ,
                                l_ADRES2        ,
                                l_PASP2         ,
                                l_OKPO1         ,
                                l_OKPO2         ,
                                l_S_ARENDA      ,
                                l_S_NDS         ,
                                l_SD            ,
                                l_KEYCOUNT      ,
                                l_PRSKIDKA      ,
                                l_PENY          ,
                                l_DATR2         ,
                                l_MR2           ,
                                l_MR            ,
                                l_DATR          ,
                                l_ADDND         ,
                                l_AMORT_DATE    ,
                                l_BRANCH        ,
                                l_KF        ,
                                sysdate  ,
                                l_otm    ,
                                user_name,
                                l_idupd,
                                l_rnk);
  end if;
end;
/
ALTER TRIGGER BARS.TAIUD_SKRYNKAND_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_SKRYNKAND_UPDATE.sql =========
PROMPT ===================================================================================== 
