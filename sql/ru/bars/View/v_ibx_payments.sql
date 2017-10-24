-- IBOX
-- tvSukhov 28/08/2013
-- ������ �������� ��� ����� �������� � IBOX

create or replace view v_ibx_payments as
select substr(ir.type_id, 1, 99) as typi,
       ir.ext_ref as iref,
       ir.ext_date as idat,
       ir.ext_source,
       ir.deal_id as ccid,
       ir.summ/100 as isum,
       ir.abs_ref as aref,
       ir.kwt as ikwt,
       substr(if.file_name, 1, 99) as nfil,
       if.file_date as ofil,
       if.total_count as kfil,
       if.total_sum as sfil,
       if.loaded as dfil
  from ibx_recs ir, ibx_files if
 where ir.type_id = if.type_id(+)
   and ir.file_name = if.file_name(+)
 order by ir.ext_ref desc;

comment on table v_ibx_payments is '������ �������� ��� ����� �������� � IBOX';
comment on column v_ibx_payments.typi is '��� ����������';
comment on column v_ibx_payments.iref is '���. ��. � IBOX';
comment on column v_ibx_payments.idat is '����/����� � IBOX';
comment on column v_ibx_payments.ccid is '� ��';
comment on column v_ibx_payments.isum is '����� � �����';
comment on column v_ibx_payments.aref is '���. ��. � ��C';
comment on column v_ibx_payments.ikwt is '���: 1 - OK, 0 - ERR, Null - �� ���';
comment on column v_ibx_payments.nfil is '��� �����';
comment on column v_ibx_payments.ofil is '���� �����';
comment on column v_ibx_payments.kfil is '����� �������';
comment on column v_ibx_payments.sfil is '����� �����';
comment on column v_ibx_payments.dfil is '����/����� ��������';

grant select on v_ibx_payments to bars_access_defrole;
