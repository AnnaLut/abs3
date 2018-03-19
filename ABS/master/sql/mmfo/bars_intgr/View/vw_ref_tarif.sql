prompt view/vw_ref_tarif.sql
create or replace force view bars_intgr.vw_ref_tarif as
select KOD, 
KV, 
t.NAME, 
TAR, 
PR, 
SMIN, 
SMAX, 
TIP, 
NBS, 
OB22, 
KF as MFO, 
PDV, 
RAZOVA, 
DAT_BEGIN, 
DAT_END, 
KV_SMIN, 
KV_SMAX 
from bars.TARIF t;

comment on table BARS_INTGR.VW_REF_TARIF is '������ � ��������';
comment on column BARS_INTGR.VW_REF_TARIF.KOD is '��� ������/��������';
comment on column BARS_INTGR.VW_REF_TARIF.KV is '��� ������� ������ ������';
comment on column BARS_INTGR.VW_REF_TARIF.NAME is '������������ ������/��������';
comment on column BARS_INTGR.VW_REF_TARIF.TAR is '����� �� 1 ��������';
comment on column BARS_INTGR.VW_REF_TARIF.PR is '% �� ����� ���������';
comment on column BARS_INTGR.VW_REF_TARIF.SMIN is '����������� ����� ������';
comment on column BARS_INTGR.VW_REF_TARIF.SMAX is '������������ ����� ������';
comment on column BARS_INTGR.VW_REF_TARIF.TIP is '��� ���������� ����� 0 - ��������, 1 - ���������.���.�� ������� ��� (+��������)';
comment on column BARS_INTGR.VW_REF_TARIF.NBS is '���������� �� ��� �� ��� �� �������� ����� ������';
comment on column BARS_INTGR.VW_REF_TARIF.OB22 is '���������� ob22 ��� �� ��� �� �������� ����� ������';
comment on column BARS_INTGR.VW_REF_TARIF.PDV is '������� ��� (1-� ���)';
comment on column BARS_INTGR.VW_REF_TARIF.RAZOVA is '������� ������ ���i�i� (1-������)';
comment on column BARS_INTGR.VW_REF_TARIF.DAT_BEGIN is '���� ������ �������� ������';
comment on column BARS_INTGR.VW_REF_TARIF.DAT_END is '���� ��������� �������� ������';
comment on column BARS_INTGR.VW_REF_TARIF.KV_SMIN is '������ ����������� ��������� �����';
comment on column BARS_INTGR.VW_REF_TARIF.KV_SMAX is '������ ������������� ��������� �����';
