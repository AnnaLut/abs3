CREATE OR REPLACE FORCE VIEW V_COMPENS (ID, FIO, DOCSERIAL, DOCNUMBER, ICOD, KKNAME, NSC, LCV, REGISTRYDATE, DATO, DATN, ACCR_PERC, ACCEPT_PERC, SUM, VYP, OST, STATUS, PSSWD, BRANCH, STATUS_NAME) AS 
  select cp.id, cp.fio, cp.docserial, cp.docnumber, cp.icod, cp.kkname,
         cp.nsc, tv.lcv, cp.registrydate, cp.dato, cp.datn, null accr_perc,
         null accept_perc, cp.sum /100 sum, null vyp, cp.ost/100 ost, cp.status, null psswd, cp.branch,
         s.status_name
    from compen_portfolio cp
    join tabval tv on cp.kv = tv.kv 
    join compen_portfolio_status s on cp.status = s.status_id
    where cp.rnk is null;

  GRANT SELECT ON V_COMPENS TO BARS_ACCESS_DEFROLE;
  GRANT SELECT ON V_COMPENS TO START1;
  GRANT SELECT ON V_COMPENS TO WR_ALL_RIGHTS;