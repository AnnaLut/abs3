create or replace view v_nbu_credit_insurance as
select "KF","NUMB","BRANCH","NMK","OKPO","TYPEZP","ZALLAST","ZABDAY","RATE","SUM","TAR","STRSUM","RANGE","NLS","KV","RNK","ND","PID",
case STATE when 0 then '�����������' when 1 then '��������� ������' when 2 then '��������� � ��������' end "STATE",
"MESSAGE" 
from NBU_CREDIT_INSURANCE;
comment on table V_NBU_CREDIT_INSURANCE is '����� ������������ ����������� ������� ���';
comment on column V_NBU_CREDIT_INSURANCE.KF is '��';
comment on column V_NBU_CREDIT_INSURANCE.NUMB is '��/�';
comment on column V_NBU_CREDIT_INSURANCE.BRANCH is '������� ���������, ����';
comment on column V_NBU_CREDIT_INSURANCE.NMK is 'ϲ� �볺���';
comment on column V_NBU_CREDIT_INSURANCE.OKPO is '��� �볺���';
comment on column V_NBU_CREDIT_INSURANCE.TYPEZP is '��� �������� (��������, �������, ��������)';
comment on column V_NBU_CREDIT_INSURANCE.ZALLAST is '������� �� ������� ���� ������ � ���. ���.';
comment on column V_NBU_CREDIT_INSURANCE.ZABDAY is '������������� �������� ������������� �� ������ �����, ���.';
comment on column V_NBU_CREDIT_INSURANCE.RATE is 'г��� ��������� ������,%';
comment on column V_NBU_CREDIT_INSURANCE.SUM is '�������� ����, ���.';
comment on column V_NBU_CREDIT_INSURANCE.TAR is '��������� ��������� �����, %';
comment on column V_NBU_CREDIT_INSURANCE.STRSUM is '��������� ����� �� ������ �����, ���.          (�.7 � �.8)';
comment on column V_NBU_CREDIT_INSURANCE.RANGE is '� �������
930,75-6167';
comment on column V_NBU_CREDIT_INSURANCE.NLS is '�������� ������� �볺��� �� ���� ����������� ��';
comment on column V_NBU_CREDIT_INSURANCE.KV is '������ �������';
comment on column V_NBU_CREDIT_INSURANCE.RNK is '��� ';
comment on column V_NBU_CREDIT_INSURANCE.ND is '�������� ��������';
comment on column V_NBU_CREDIT_INSURANCE.PID is 'ID ������������ ������';
comment on column V_NBU_CREDIT_INSURANCE.STATE is '�������: 0-�����������, 1 - ��������� ������, 2 - ��������� � ��������';
comment on column V_NBU_CREDIT_INSURANCE.MESSAGE is '�������';

grant SELECT on v_nbu_credit_insurance to BARS_ACCESS_DEFROLE;
