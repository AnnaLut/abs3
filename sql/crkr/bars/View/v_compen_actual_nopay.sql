CREATE OR REPLACE FORCE VIEW BARS.V_COMPEN_ACTUAL_NOPAY (ID, FIO_PORTFOLIO, FIO_CLIENT, DOCTYPE, DOCSERIAL, DOCNUMBER, MFO, BRANCH, ACT) AS 
  select cp.id, cp.fio fio_portfolio, cc.fio fio_client, cp.doctype, cp.docserial, cp.docnumber, cc.mfo, cp.branchact branch, case when cp.rnk is not null then 'Актуалізований' else 'Неактуалізований' end act
  from compen_portfolio cp,
       compen_clients cc,
       compen_oper o
 WHERE cp.rnk is not null
   and cp.id = o.compen_id and o.oper_type = 5 and o.state = 0
   and cp.rnk = cc.rnk
   with read only
;
   COMMENT ON TABLE BARS.V_COMPEN_ACTUAL_NOPAY  IS 'Список актуалізованих нових рахунків';
  GRANT UPDATE ON BARS.V_COMPEN_ACTUAL_NOPAY TO BARS_ACCESS_DEFROLE;
  GRANT SELECT ON BARS.V_COMPEN_ACTUAL_NOPAY TO BARS_ACCESS_DEFROLE;
  GRANT INSERT ON BARS.V_COMPEN_ACTUAL_NOPAY TO BARS_ACCESS_DEFROLE;
  GRANT DELETE ON BARS.V_COMPEN_ACTUAL_NOPAY TO BARS_ACCESS_DEFROLE;