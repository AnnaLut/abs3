begin
execute immediate 'drop table tmp_coin_invoice';
  exception
   when others then
      if sqlcode != -942 then
         raise;
      end if;
end;
/
create  table tmp_coin_invoice
(
  type_id number(1),
  nd varchar2(64),       
  dat date,
  reason varchar2(256),
  bailee varchar2(128),
  proxy varchar2(128),
  total_count number(38),
  total_nominal number(38),
  total_sum number(38),
  total_without_vat number(38),
  vat_percent number(38),
  vat_sum number(38),
  total_nominal_price number(38),
  total_with_vat number(38),
  userid number(38),
  ref number(38)
)
TABLESPACE BRSSMLD;
/
comment on table tmp_coin_invoice is '������� ��� �������������� �����';
comment on column tmp_coin_invoice.type_id  is '��� �������� (0 - ��������/ 1 - �������)';
comment on column tmp_coin_invoice.nd is '����� ��������';
comment on column tmp_coin_invoice.dat is '���� ��������';
comment on column tmp_coin_invoice.reason is 'ϳ������';
comment on column tmp_coin_invoice.bailee is '�����';
comment on column tmp_coin_invoice.proxy is '���������';
comment on column tmp_coin_invoice.total_count is '������';
comment on column tmp_coin_invoice.total_nominal is '������ �� ��������';
comment on column tmp_coin_invoice.total_sum is '�������� ����';
comment on column tmp_coin_invoice.total_without_vat is '����� ��� ���';
comment on column tmp_coin_invoice.vat_percent is '% ���';
comment on column tmp_coin_invoice.vat_sum is '���� ���';
comment on column tmp_coin_invoice.total_nominal_price is '��������� �������';
comment on column tmp_coin_invoice.total_with_vat is '����� � ��� �� ������';
/
grant select, insert, update, delete on tmp_coin_invoice to bars_access_defrole;
/