create or replace view bars.v_cl_payments_auto as
select tcp.ref from bars.tmp_cl_payment tcp where tcp.is_auto_pay = 1 and tcp.is_payed = 0;

grant select on bars.v_cl_payments_auto to bars_access_defrole;
