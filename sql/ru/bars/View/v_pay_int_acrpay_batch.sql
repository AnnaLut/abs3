create or replace view v_pay_int_acrpay_batch as
select * from pay_int_acrpay_batch order by create_date desc;
/
GRANT SELECT ON v_pay_int_acrpay_batch TO BARS_ACCESS_DEFROLE;