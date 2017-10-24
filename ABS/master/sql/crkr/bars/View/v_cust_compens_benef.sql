CREATE OR REPLACE VIEW v_cust_compens_benef AS
SELECT cc.rnk,
          cp.id,
          cp.kkname,
          cb.code,
          cb.fiob,
          tt.name,
          cb.fulladdressb,
          cb.icodb,
          cb.doctypeb,
          cb.docserialb,
          cb.docnumberb,
          cb.docorgb,
          cb.docdateb,
          cb.clientbdateb,
          se.name sex,
          cb.clientphoneb,
          cb.idb,
          cb.percent,
          cb.eddr_id,
          cb.regdate
     FROM compen_clients cc
          JOIN compen_portfolio cp ON cc.rnk = cp.rnk
          JOIN compen_benef cb
             ON cp.id = cb.id_compen AND cb.removedate IS NULL
          LEFT JOIN country tt ON cb.countryb = tt.country
          LEFT JOIN sex se ON TO_NUMBER (cb.clientsexb) = se.id;

  GRANT SELECT ON v_cust_compens_benef TO BARS_ACCESS_DEFROLE;