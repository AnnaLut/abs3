prompt create view bars_intgr.vw_ref_doc_scheme
create or replace force view bars_intgr.vw_ref_doc_scheme
as
select  cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
        t.id,
        t.name,
        t.print_on_blank,
        t.template,
        t.header,
        t.footer,
        t.header_ex,
        t.d_close,
        t.fr,
        t.file_name
from bars.doc_scheme t;

comment on table bars_intgr.vw_ref_doc_scheme is '������� ��� �����';
comment on column bars_intgr.vw_ref_doc_scheme.ID is '������������� �������';
comment on column bars_intgr.vw_ref_doc_scheme.NAME is '�������� �������';
comment on column bars_intgr.vw_ref_doc_scheme.PRINT_ON_BLANK is '������� ������ �������� �� ������';
comment on column bars_intgr.vw_ref_doc_scheme.TEMPLATE is '������';
comment on column bars_intgr.vw_ref_doc_scheme.HEADER is '������ ����������';
comment on column bars_intgr.vw_ref_doc_scheme.FOOTER is '����� ����������';
comment on column bars_intgr.vw_ref_doc_scheme.HEADER_EX is '������ ���������� ����������';
comment on column bars_intgr.vw_ref_doc_scheme.D_CLOSE is '���� ��������';
comment on column bars_intgr.vw_ref_doc_scheme.FR is '';
comment on column bars_intgr.vw_ref_doc_scheme.FILE_NAME is '��� ����� ������� �� ����� TEMPLATE.RPT';