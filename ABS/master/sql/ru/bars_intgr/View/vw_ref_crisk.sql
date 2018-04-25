prompt view/vw_ref_crisk.sql
create or replace force view bars_intgr.vw_ref_crisk as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											CRISK, 
											c.NAME, 
											REZ, 
											REZ2, 
											REZ3, 
											REZ4, 
											REZ5 
from bars.CRISK c;

comment on table BARS_INTGR.VW_REF_CRISK is '��������� �����';
comment on column BARS_INTGR.VW_REF_CRISK.CRISK is '��������� �����';
comment on column BARS_INTGR.VW_REF_CRISK.NAME is '������������';
comment on column BARS_INTGR.VW_REF_CRISK.REZ is '����������� �������������� ���������� �������� � ��.���. ��� �������� ������� ���������� �������� �������';
comment on column BARS_INTGR.VW_REF_CRISK.REZ2 is '����������� �������������� ���������� �������� � ��.���. ��� �������� �� ������� ���������� �������� �������';
comment on column BARS_INTGR.VW_REF_CRISK.REZ3 is '������� �������������� ��� �������� �������� � ������� ���� ����������� �������� ������� ';
comment on column BARS_INTGR.VW_REF_CRISK.REZ4 is '������� �������������� ��� �������� ���������� ��������';
