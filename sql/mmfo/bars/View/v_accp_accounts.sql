CREATE OR REPLACE VIEW v_accp_accounts
AS
   SELECT o.name,
          o.ddog,
          o.ndog,
          o.okpo,
          a.mfo,
          a.nls,
          (select text from ACCP_SCOPE where id = o.scope_dog) scope_dog,
          (select text from ACCP_ORDER_FEE where id =o.order_fee) order_fee,
          o.amount_fee,
          o.fee_type_id,
          o.fee_by_tarif,
          o.fee_mfo,
          o.fee_nls,
          o.fee_okpo,
          a.check_on
     FROM accp_orgs o, accp_accounts a  
    WHERE o.okpo = a.okpo(+);
 
GRANT DELETE, INSERT, SELECT, UPDATE ON v_accp_accounts TO BARS_ACCESS_DEFROLE;  