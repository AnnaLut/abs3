create or replace trigger TIU_CUS
after insert or update on CUSTOMER
for each row
declare
  -- No group customer update allowed
  -- ver. 06/12/2016
  ern          NUMBER := 4;
  err          EXCEPTION;
BEGIN
  
  IF pul.cus_rec.rnk IS NOT NULL
  THEN
    RAISE err;
  END IF;
  
  IF inserting or updating and
     ( :new.tgr <> :old.tgr or
          (:old.tgr is null and :new.tgr is not null) or
          (:old.tgr is not null and :new.tgr is null) or
       :new.custtype <> :old.custtype or
          (:old.custtype is null and :new.custtype is not null) or
          (:old.custtype is not null and :new.custtype is null) or
       :new.country <> :old.country or
          (:old.country is null and :new.country is not null) or
          (:old.country is not null and :new.country is null) or
       :new.nmk <> :old.nmk or
          (:old.nmk is null and :new.nmk is not null) or
          (:old.nmk is not null and :new.nmk is null) or
       :new.nmkv <> :old.nmkv or
          (:old.nmkv is null and :new.nmkv is not null) or
          (:old.nmkv is not null and :new.nmkv is null) or
       :new.nmkk <> :old.nmkk or
          (:old.nmkk is null and :new.nmkk is not null) or
          (:old.nmkk is not null and :new.nmkk is null) or
       :new.codcagent <> :old.codcagent or
          (:old.codcagent is null and :new.codcagent is not null) or
          (:old.codcagent is not null and :new.codcagent is null) or
       :new.prinsider <> :old.prinsider or
          (:old.prinsider is null and :new.prinsider is not null) or
          (:old.prinsider is not null and :new.prinsider is null) or
       :new.okpo <> :old.okpo or
          (:old.okpo is null and :new.okpo is not null) or
          (:old.okpo is not null and :new.okpo is null) or
       :new.adr <> :old.adr or
          (:old.adr is null and :new.adr is not null) or
          (:old.adr is not null and :new.adr is null) or
       :new.sab <> :old.sab or
          (:old.sab is null and :new.sab is not null) or
          (:old.sab is not null and :new.sab is null) or
       :new.taxf <> :old.taxf or
          (:old.taxf is null and :new.taxf is not null) or
          (:old.taxf is not null and :new.taxf is null) or
       :new.c_reg <> :old.c_reg or
          (:old.c_reg is null and :new.c_reg is not null) or
          (:old.c_reg is not null and :new.c_reg is null) or
       :new.c_dst <> :old.c_dst or
          (:old.c_dst is null and :new.c_dst is not null) or
          (:old.c_dst is not null and :new.c_dst is null) or
       :new.rgtax <> :old.rgtax or
          (:old.rgtax is null and :new.rgtax is not null) or
          (:old.rgtax is not null and :new.rgtax is null) or
       :new.datet <> :old.datet or
          (:old.datet is null and :new.datet is not null) or
          (:old.datet is not null and :new.datet is null) or
       :new.adm <> :old.adm or
          (:old.adm is null and :new.adm is not null) or
          (:old.adm is not null and :new.adm is null) or
       :new.datea <> :old.datea or
          (:old.datea is null and :new.datea is not null) or
          (:old.datea is not null and :new.datea is null) or
       :new.stmt <> :old.stmt or
          (:old.stmt is null and :new.stmt is not null) or
          (:old.stmt is not null and :new.stmt is null) or
       :new.date_on <> :old.date_on or
          (:old.date_on is null and :new.date_on is not null) or
          (:old.date_on is not null and :new.date_on is null) or
       :new.date_off <> :old.date_off or
          (:old.date_off is null and :new.date_off is not null) or
          (:old.date_off is not null and :new.date_off is null) or
       :new.notes <> :old.notes or
          (:old.notes is null and :new.notes is not null) or
          (:old.notes is not null and :new.notes is null) or
       :new.notesec <> :old.notesec or
          (:old.notesec is null and :new.notesec is not null) or
          (:old.notesec is not null and :new.notesec is null) or
       :new.crisk <> :old.crisk or
          (:old.crisk is null and :new.crisk is not null) or
          (:old.crisk is not null and :new.crisk is null) or
       :new.pincode <> :old.pincode or
          (:old.pincode is null and :new.pincode is not null) or
          (:old.pincode is not null and :new.pincode is null) or
       :new.nd <> :old.nd or
          (:old.nd is null and :new.nd is not null) or
          (:old.nd is not null and :new.nd is null) or
       :new.rnkp <> :old.rnkp or
          (:old.rnkp is null and :new.rnkp is not null) or
          (:old.rnkp is not null and :new.rnkp is null) or
       :new.ise <> :old.ise or
          (:old.ise is null and :new.ise is not null) or
          (:old.ise is not null and :new.ise is null) or
       :new.fs <> :old.fs or
          (:old.fs is null and :new.fs is not null) or
          (:old.fs is not null and :new.fs is null) or
       :new.oe <> :old.oe or
          (:old.oe is null and :new.oe is not null) or
          (:old.oe is not null and :new.oe is null) or
       :new.ved <> :old.ved or
          (:old.ved is null and :new.ved is not null) or
          (:old.ved is not null and :new.ved is null) or
       :new.sed <> :old.sed or
          (:old.sed is null and :new.sed is not null) or
          (:old.sed is not null and :new.sed is null) or
       :new.k050 <> :old.k050 or
          (:old.k050 is null and :new.k050 is not null) or
          (:old.k050 is not null and :new.k050 is null) or
       :new.lim <> :old.lim or
          (:old.lim is null and :new.lim is not null) or
          (:old.lim is not null and :new.lim is null) or
       :new.nompdv <> :old.nompdv or
          (:old.nompdv is null and :new.nompdv is not null) or
          (:old.nompdv is not null and :new.nompdv is null) or
       :new.bc <> :old.bc or
          (:old.bc is null and :new.bc is not null) or
          (:old.bc is not null and :new.bc is null) or
       :new.mb <> :old.mb or
          (:old.mb is null and :new.mb is not null) or
          (:old.mb is not null and :new.mb is null) or
       :new.rgadm <> :old.rgadm or
          (:old.rgadm is null and :new.rgadm is not null) or
          (:old.rgadm is not null and :new.rgadm is null) or
       :new.tobo <> :old.tobo or
          (:old.tobo is null and :new.tobo is not null) or
          (:old.tobo is not null and :new.tobo is null) or
       :new.branch <> :old.branch or
          (:old.branch is null and :new.branch is not null) or
          (:old.branch is not null and :new.branch is null) or
       :new.nrezid_code <> :old.nrezid_code or
          (:old.nrezid_code is null and :new.nrezid_code is not null) or
          (:old.nrezid_code is not null and :new.nrezid_code is null) or
       :new.isp <> :old.isp or
          (:old.isp is null and :new.isp is not null) or
          (:old.isp is not null and :new.isp is null) )
  THEN

    IF INSERTING
    THEN -- Customer opened
      pul.cus_otm := 1;
    ELSIF UPDATING AND :OLD.date_off IS NULL AND :NEW.date_off IS NULL
    THEN -- Customer changed
      pul.cus_otm := 2;
    ELSIF UPDATING AND :OLD.date_off IS NOT NULL AND :NEW.date_off IS NOT NULL AND USER_NAME = 'BARS'
    THEN -- Customer changed
      pul.cus_otm := 2;
    ELSIF UPDATING AND :OLD.date_off IS NULL AND :NEW.date_off IS NOT NULL
    THEN -- Customer closed
      pul.cus_otm := 3;
    ELSIF UPDATING AND :OLD.date_off IS NOT NULL AND :NEW.date_off IS NULL
    THEN -- "Resurection"
      pul.cus_otm := 0;
    END IF;
    
    pul.cus_rec.KF          := :new.KF;
    pul.cus_rec.RNK         := :new.RNK;
    pul.cus_rec.TGR         := :new.TGR;
    pul.cus_rec.CUSTTYPE    := :new.CUSTTYPE;
    pul.cus_rec.COUNTRY     := :new.COUNTRY;
    pul.cus_rec.NMK         := :new.NMK;
    pul.cus_rec.NMKV        := :new.NMKV;
    pul.cus_rec.NMKK        := :new.NMKK;
    pul.cus_rec.CODCAGENT   := :new.CODCAGENT;
    pul.cus_rec.PRINSIDER   := :new.PRINSIDER;
    pul.cus_rec.OKPO        := :new.OKPO;
    pul.cus_rec.ADR         := :new.ADR;
    pul.cus_rec.SAB         := :new.SAB;
    pul.cus_rec.C_REG       := :new.C_REG;
    pul.cus_rec.C_DST       := :new.C_DST;
    pul.cus_rec.RGTAX       := :new.RGTAX;
    pul.cus_rec.DATET       := :new.DATET;
    pul.cus_rec.ADM         := :new.ADM;
    pul.cus_rec.DATEA       := :new.DATEA;
    pul.cus_rec.STMT        := :new.STMT;
    pul.cus_rec.DATE_ON     := :new.DATE_ON;
    pul.cus_rec.DATE_OFF    := :new.DATE_OFF;
    pul.cus_rec.NOTES       := :new.NOTES;
    pul.cus_rec.NOTESEC     := :new.NOTESEC;
    pul.cus_rec.CRISK       := :new.CRISK;
    pul.cus_rec.PINCODE     := :new.PINCODE;
    pul.cus_rec.ND          := :new.ND;
    pul.cus_rec.RNKP        := :new.RNKP;
    pul.cus_rec.ISE         := :new.ISE;
    pul.cus_rec.FS          := :new.FS;
    pul.cus_rec.OE          := :new.OE;
    pul.cus_rec.VED         := :new.VED;
    pul.cus_rec.SED         := :new.SED;
    pul.cus_rec.LIM         := :new.LIM;
    pul.cus_rec.MB          := :new.MB;
    pul.cus_rec.RGADM       := :new.RGADM;
    pul.cus_rec.BC          := :new.BC;
    pul.cus_rec.BRANCH      := :new.BRANCH;
    pul.cus_rec.TOBO        := :new.TOBO;
    pul.cus_rec.ISP         := :new.ISP;
    pul.cus_rec.TAXF        := :new.TAXF;
    pul.cus_rec.NOMPDV      := :new.NOMPDV;
    pul.cus_rec.K050        := :new.K050;
    pul.cus_rec.NREZID_CODE := :new.NREZID_CODE;

  END IF;

EXCEPTION
   WHEN err THEN
      bars_error.raise_error('CAC', ern);
END tiu_cus;
/

show err
