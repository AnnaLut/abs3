prompt view V_BILL_REPORT_PARAM_VALUES
create or replace force view V_BILL_REPORT_PARAM_VALUES
as
select 
t.kf,
t.param_id,
t.value_id,
t.value
from bill_report_param_value t;

grant select on v_bill_report_param_values to bars_access_defrole;