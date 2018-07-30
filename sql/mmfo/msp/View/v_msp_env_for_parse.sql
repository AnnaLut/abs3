PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_env_for_parse.sql =========*** Run *** =
PROMPT ===================================================================================== 

create or replace view v_msp_env_for_parse as
select "ID","ID_MSP_ENV","CODE","SENDER","RECIPIENT","PARTNUMBER","PARTTOTAL","ECP","DATA","DATA_DECODE","STATE","COMM","CREATE_DATE"
    from msp_envelopes
   where state = -1;
/

comment on table msp.v_msp_env_for_parse is '������ ����� �������� �� ��� (��� �������� TOSS)';
comment on column msp.v_msp_env_for_parse.id is '� ������ = id msp.msp_requests act_type =1';
comment on column msp.v_msp_env_for_parse.id_msp_env is '�������� ��� ������ � ���';
comment on column msp.v_msp_env_for_parse.code is '��� ������ �� ���';
comment on column msp.v_msp_env_for_parse.sender is '³�������� ������';
comment on column msp.v_msp_env_for_parse.recipient is '��������� ������';
comment on column msp.v_msp_env_for_parse.partnumber is '���������� ����� ������� ��������';
comment on column msp.v_msp_env_for_parse.parttotal is '�������� �-�� ������ ��������';
comment on column msp.v_msp_env_for_parse.ecp is '���, ���� ��� ���������� � ���';
comment on column msp.v_msp_env_for_parse.data is '������������ �������';
comment on column msp.v_msp_env_for_parse.data_decode is '������������� ������� (base64)';
comment on column msp.v_msp_env_for_parse.state is '���� ��������';
comment on column msp.v_msp_env_for_parse.comm is '�������� ������� ��������';
comment on column msp.v_msp_env_for_parse.create_date is '���� ��������� ��������';


grant select on v_msp_env_for_parse to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_env_for_parse.sql =========*** End *** =
PROMPT ===================================================================================== 
