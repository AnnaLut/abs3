CREATE OR REPLACE FORCE VIEW BARS.V_CL_PAYMENTS_AUTO
AS
   SELECT tcp.REF
     FROM tmp_cl_payment tcp, oper o
    WHERE     tcp.is_auto_pay = 1
          AND tcp.is_payed = 0
          AND o.REF = tcp.REF
          AND o.sos not in (-1, -2, 5);


grant select on bars.v_cl_payments_auto to bars_access_defrole;
