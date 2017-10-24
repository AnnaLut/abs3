CREATE OR REPLACE VIEW V_CUSTOMER_COMPENS AS
SELECT t.id,
          t.fio,
          t.kkname,
          t.nsc,
          tv.lcv,
          t.registrydate,
          t.dato,
          t.datn,
          NULL accr_perc,
          NULL accept_perc,
          t.SUM / 100 SUM,
          NULL vyp,
          t.ost / 100 ost,
          t.status,
          NULL psswd,
          rnk,
          reason_change_status,
          (select s.status_name from compen_portfolio_status s where s.status_id = t.status) status_name
     FROM compen_portfolio t JOIN tabval tv ON t.kv = tv.kv
    WHERE rnk IS NOT NULL
      AND (substr(t.branchact,2,6) = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') = '300465');

  GRANT SELECT ON v_customer_compens TO BARS_ACCESS_DEFROLE;