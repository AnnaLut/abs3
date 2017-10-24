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

  IF pul.cus_rec.rnk IS NOT NULL
  THEN

    l_idupd        := s_customer_update.nextval;
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
      ( pul.cus_rec.KF       ,
        pul.cus_rec.RNK      , pul.cus_rec.TGR      ,
        pul.cus_rec.CUSTTYPE , pul.cus_rec.COUNTRY  ,
        pul.cus_rec.NMK      , pul.cus_rec.NMKV     ,
        pul.cus_rec.NMKK     , pul.cus_rec.CODCAGENT,
        pul.cus_rec.PRINSIDER, pul.cus_rec.OKPO     ,
        pul.cus_rec.ADR      , pul.cus_rec.SAB      ,
        pul.cus_rec.C_REG    , pul.cus_rec.C_DST    ,
        pul.cus_rec.RGTAX    , pul.cus_rec.DATET    ,
        pul.cus_rec.ADM      , pul.cus_rec.DATEA    ,
        pul.cus_rec.STMT     , pul.cus_rec.DATE_ON  ,
        pul.cus_rec.DATE_OFF , pul.cus_rec.NOTES    ,
        pul.cus_rec.NOTESEC  , pul.cus_rec.CRISK    ,
        pul.cus_rec.PINCODE  , pul.cus_rec.ND       ,
        pul.cus_rec.RNKP     , pul.cus_rec.ISE      ,
        pul.cus_rec.FS       , pul.cus_rec.OE       ,
        pul.cus_rec.VED      , pul.cus_rec.SED      ,
        pul.cus_rec.LIM      , pul.cus_rec.MB       ,
        pul.cus_rec.RGADM    , pul.cus_rec.BC       ,
        pul.cus_rec.BRANCH   , pul.cus_rec.TOBO     ,
        pul.cus_rec.ISP      , pul.cus_rec.TAXF     ,
        pul.cus_rec.NOMPDV   , pul.cus_rec.K050     ,
        pul.cus_rec.NREZID_CODE,
        l_idupd              , l_doneby             ,
        l_chgdate            , pul.cus_otm          ,
        l_local_bdate        , l_global_bdate      );

  END IF;
  
END tiu_cusa;
/

show err
