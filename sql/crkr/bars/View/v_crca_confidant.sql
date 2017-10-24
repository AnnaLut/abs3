CREATE OR REPLACE FORCE VIEW BARS.v_crca_confidant (ID_COMPEN, IDB, CODE, FIOB, COUNTRYB, FULLADDRESSB, ICODB, DOCTYPEB, DOCSERIALB, DOCNUMBERB, DOCORGB, DOCDATEB, CLIENTBDATEB, CLIENTSEXB, CLIENTPHONEB) AS 
  select id_compen,
          idb,
          code,
          fiob,
          countryb,
          fulladdressb,
          icodb,
          doctypeb,
          docserialb,
          docnumberb,
          docorgb,
          docdateb,
          clientbdateb,
          clientsexb,
          clientphoneb
     from compen_benef cb
    where code = 'D' and cb.removedate is null
;
  GRANT SELECT ON BARS.V_CRCA_CONFIDANT TO BARS_ACCESS_DEFROLE;