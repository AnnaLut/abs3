set serveroutput on size unlimited

prompt -- ======================================================
prompt -- trigger TIU_CUSA
prompt -- ======================================================

create or replace trigger TIU_CUSA
after insert or update on CUSTOMER
declare
 /**
  <b>TIU_CUSA</b>  - тригер історизації змін в табл. CUSTOMER
  
  %version 1.0 (21/09/2016)
  %usage   Історизація змін в даних табл. CUSTOMER
  */
  l_idupd         customer_update.idupd%type;
  l_doneby        customer_update.doneby%type;
  l_chgdate       customer_update.chgdate%type;
  l_local_bdate   customer_update.effectdate%type;
  l_global_bdate  customer_update.global_bdate%type;
BEGIN

  IF kl.cus_rec.rnk IS NOT NULL
  THEN

    l_idupd        := bars_sqnc.get_nextval('S_CUSTOMER_UPDATE',kl.cus_rec.KF);
    l_doneby       := user_name;
    l_chgdate      := sysdate;
    l_global_bdate := glb_bankdate;
    l_local_bdate  := nvl(gl.bd, l_global_bdate);

    insert 
      into CUSTOMER_UPDATE
      ( KF
      , RNK        , TGR
      , CUSTTYPE   , COUNTRY
      , NMK        , NMKV
      , NMKK       , CODCAGENT
      , PRINSIDER  , OKPO
      , ADR        , SAB
      , C_REG      , C_DST
      , RGTAX      , DATET
      , ADM        , DATEA
      , STMT       , DATE_ON
      , DATE_OFF   , NOTES
      , NOTESEC    , CRISK
      , PINCODE    , ND
      , RNKP       , ISE
      , FS         , OE
      , VED        , SED
      , LIM        , MB
      , RGADM      , BC
      , BRANCH     , TOBO
      , ISP        , TAXF
      , NOMPDV     , K050
      , NREZID_CODE
      , IDUPD,       DONEBY
      , CHGDATE,     CHGACTION
      , EFFECTDATE , GLOBAL_BDATE )
    VALUES
      ( kl.cus_rec.KF
      , kl.cus_rec.RNK      , kl.cus_rec.TGR
      , kl.cus_rec.CUSTTYPE , kl.cus_rec.COUNTRY
      , kl.cus_rec.NMK      , kl.cus_rec.NMKV
      , kl.cus_rec.NMKK     , kl.cus_rec.CODCAGENT
      , kl.cus_rec.PRINSIDER, kl.cus_rec.OKPO
      , kl.cus_rec.ADR      , kl.cus_rec.SAB
      , kl.cus_rec.C_REG    , kl.cus_rec.C_DST
      , kl.cus_rec.RGTAX    , kl.cus_rec.DATET
      , kl.cus_rec.ADM      , kl.cus_rec.DATEA
      , kl.cus_rec.STMT     , kl.cus_rec.DATE_ON
      , kl.cus_rec.DATE_OFF , kl.cus_rec.NOTES
      , kl.cus_rec.NOTESEC  , kl.cus_rec.CRISK
      , kl.cus_rec.PINCODE  , kl.cus_rec.ND
      , kl.cus_rec.RNKP     , kl.cus_rec.ISE
      , kl.cus_rec.FS       , kl.cus_rec.OE
      , kl.cus_rec.VED      , kl.cus_rec.SED
      , kl.cus_rec.LIM      , kl.cus_rec.MB
      , kl.cus_rec.RGADM    , kl.cus_rec.BC
      , kl.cus_rec.BRANCH   , kl.cus_rec.TOBO
      , kl.cus_rec.ISP      , kl.cus_rec.TAXF
      , kl.cus_rec.NOMPDV   , kl.cus_rec.K050
      , kl.cus_rec.NREZID_CODE
      , l_idupd              , l_doneby
      , l_chgdate            , kl.cus_otm
      , l_local_bdate        , l_global_bdate
      );

  END IF;

END tiu_cusa;
/

show err
