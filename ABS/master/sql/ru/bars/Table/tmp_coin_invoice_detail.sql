begin
execute immediate 'drop table tmp_coin_invoice_detail';
  exception
   when others then
      if sqlcode != -942 then
         raise;
      end if;
end;
/
create table tmp_coin_invoice_detail
(
  rn number(38), 
  nd varchar2(64),     
  code varchar2(11),
  name varchar2(256),
  metal varchar2(128),
  nominal number(38),
  cnt number(38),
  nominal_price number(38),
  unit_price_vat number(38),
  unit_price number(38),
  nominal_sum number(38),
  userid number(38)
)
TABLESPACE BRSSMLD;
/
comment on table tmp_coin_invoice_detail is '����� ��������� ��� �������������� �����';
comment on column tmp_coin_invoice_detail.rn  is '����� �����';
comment on column tmp_coin_invoice_detail.nd  is '����� ��������';
comment on column tmp_coin_invoice_detail.code is '���';
comment on column tmp_coin_invoice_detail.name is '�����';
comment on column tmp_coin_invoice_detail.metal is '�����';
comment on column tmp_coin_invoice_detail.nominal is '�������� ������';
comment on column tmp_coin_invoice_detail.cnt is 'ʳ������';
comment on column tmp_coin_invoice_detail.nominal_price is '���� �� ��������';
comment on column tmp_coin_invoice_detail.unit_price_vat is '���� �� �������� � ���';
comment on column tmp_coin_invoice_detail.unit_price is 'ֳ�� �� 1 �� ��� ��� �� ���';
comment on column tmp_coin_invoice_detail.nominal_sum is '���� ��� ��� �� ���';
/
grant select, insert, update, delete on tmp_coin_invoice_detail to bars_access_defrole;
/