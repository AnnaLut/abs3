CREATE OR REPLACE VIEW V_CUSTOMER_CRKR AS
SELECT c.rnk,
          c.nmk name,
          c.okpo inn,
          P.SEX id_sex,
          s.name sex,
          p.bday birth_date,
           (SELECT rezid
                  FROM codcagent
                 WHERE codcagent = c.codcagent) id_rezid,
          CASE (SELECT rezid
                  FROM codcagent
                 WHERE codcagent = c.codcagent)
             WHEN 1 THEN 'Резидент'
             ELSE 'Нерезидент'
          END
             rezid,
             p.passp id_doc_type,
          (SELECT name
             FROM passp
            WHERE p.passp = passp)
             doc_type,
	  c.country,
          p.ser,
          p.numdoc,
          p.pdate date_of_issue,
          p.organ,
          p.eddr_id,
          p.actual_date,
          p.bplace,
          p.teld tel,
          p.cellphone tel_mob,
          c.branch,
          c.notes,
          c.date_on date_registry,
          a.zip,
          a.domain,
          a.region,
          a.locality,
          a.address,
          cc.dbcode,
          cc.mfo,
          cc.nls,
          cc.okpo,
          nvl(cc.secondary,0) secondary,
          cc.date_val_reg,
          (select count(*) from compen_oper o, compen_portfolio p
           where o.oper_type in (5,6,17) and o.state > 0 and o.rnk = c.rnk
             and o.rnk = p.rnk) edit
     FROM customer c,
          person p,
          sex s,
          (SELECT rnk,
                  zip,
                  domain,
                  region,
                  locality,
                  address
             FROM customer_address) a,
          compen_clients cc
    WHERE c.rnk = p.rnk AND nvl(p.sex,0) = s.id AND c.rnk = a.rnk AND c.rnk = cc.rnk
    and (substr(c.branch,2,6) = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') = '300465' )
    and cc.open_cl is not null;

  GRANT SELECT ON V_CUSTOMER_CRKR TO BARS_ACCESS_DEFROLE;