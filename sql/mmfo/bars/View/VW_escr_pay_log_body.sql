CREATE OR REPLACE VIEW VW_escr_pay_log_body AS
select id_log ,-- �� ��������  
deal_id,--��� ��
err_code,--��� ������� �� ����������
et.description err_desc, --�������
comments -- ��������
from escr_pay_log_body lb,escr_errors_types et
where lb.err_code=et.id;
grant
  select on VW_escr_pay_log_body to BARS_ACCESS_DEFROLE;
