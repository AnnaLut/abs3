prompt view V_STO_GRP_UI
create or replace force view v_sto_grp_ui as
select idg, name, tobo, kf
from sto_grp;

grant select on v_sto_grp_ui to bars_access_defrole;

comment on table v_sto_grp_ui is '������ ���������� �������� (���)';
comment on column v_sto_grp_ui.idg is '�� ������';
comment on column v_sto_grp_ui.name is '�������� ������';
comment on column v_sto_grp_ui.tobo is '�����, ��� ������� �������� ������';
comment on column v_sto_grp_ui.kf is '��� �������';
