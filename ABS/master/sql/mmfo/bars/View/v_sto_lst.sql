prompt create VIEW V_STO_LST
create or replace force view v_sto_lst
as
select
s.ids,
s.rnk,
c.nmk,
s.name,
s.sdat,
s.idg,
s.kf,
s.branch,
s.date_close
from sto_lst s
join customer c on s.rnk = c.rnk and s.kf = c.kf;

grant select on v_sto_lst to bars_access_defrole;

comment on table v_sto_lst is '�������� �� ���������� ������� (���)';
COMMENT ON COLUMN BARS.V_STO_LST.IDS IS '��� ��������';
COMMENT ON COLUMN BARS.V_STO_LST.RNK IS 'RNK ����������';
COMMENT ON COLUMN BARS.V_STO_LST.NMK IS '������������ ������� / ���';
COMMENT ON COLUMN BARS.V_STO_LST.NAME IS '������ �������� / ��������';
COMMENT ON COLUMN BARS.V_STO_LST.SDAT IS '���� ��������';
COMMENT ON COLUMN BARS.V_STO_LST.IDG IS '�� ������';
COMMENT ON COLUMN BARS.V_STO_LST.KF IS '��� �������';
COMMENT ON COLUMN BARS.V_STO_LST.BRANCH IS '����� ��������';
COMMENT ON COLUMN BARS.V_STO_LST.DATE_CLOSE IS '���� �������� ��������';