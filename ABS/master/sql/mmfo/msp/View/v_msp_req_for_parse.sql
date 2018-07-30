PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_req_for_parse.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view v_msp_req_for_parse as
select ID,REQ_xml,STATE, act_type, create_date
    from msp_requests mr
   where mr.state = -1
     and mr.act_type = 1;
/

comment on table v_msp_req_for_parse is '��� ������ �� ��� (payment_data)';
comment on column v_msp_req_for_parse.id is 'id ������';
comment on column v_msp_req_for_parse.req_xml is 'XML ������';
comment on column v_msp_req_for_parse.state is '���� ������ (msp_request_state)';
comment on column v_msp_req_for_parse.act_type is '1 - msp_const.req_PAYMENT_DATA - ��� ������� ���� (�������), 2 - �� ���������������, 3 - msp_const.req_DATA_STATE - ����� �� ���� ���������� �����, 4 - msp_const.req_VALIDATION_STATE - ����� �� ��������� �������� ������ (��������� 1), 5 - msp_const.req_PAYMENT_STATE - ����� �� ��������� 2 (���� ������ ������ � �������)';
comment on column v_msp_req_for_parse.create_date is '���� ��������� ������';
   
grant select on v_msp_req_for_parse to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_req_for_parse.sql =========*** End *** =
PROMPT ===================================================================================== 
