prompt fill bill_report_param
insert /*+ ignore_row_on_dupkey_index(BILL_REPORT_PARAM XPK_BILL_REPORT_PARAM) */ into bill_report_param (param_id, report_id, param_code, param_name, param_type, nullable)
values (1, 1, 'extract_number_id', 'Номер витягу', 'NUMBER', 0);

insert /*+ ignore_row_on_dupkey_index(BILL_REPORT_PARAM XPK_BILL_REPORT_PARAM)*/ into bill_report_param (param_id, report_id, param_code, param_name, param_type, nullable)
values (2, 2, 'extract_number_id', 'Номер витягу', 'NUMBER', 0);

commit;