create or replace force view v_bill_reports_parameterized
as
select
r.report_id ,
r.report_name,
r.frx_file_name,
r.description,
p.param_id,
p.param_code,
p.param_name,
p.param_type,
p.nullable,
r.active
from bill_report r
left join bill_report_param p on r.report_id = p.report_id;

grant select on v_bill_reports_parameterized to bars_access_defrole;