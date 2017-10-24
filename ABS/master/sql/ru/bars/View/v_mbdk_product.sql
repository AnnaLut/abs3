create or replace view v_mbdk_product as
select vidd,
       name,
       tipd
from  cc_vidd t
where mbk.check_if_deal_belong_to_mbdk(t.vidd) = 'Y';

grant select on v_mbdk_product to bars_access_defrole;

comment on table  v_mbdk_product is '����: ���� ��������';
comment on column v_mbdk_product.vidd is '��� ���� ��������';
comment on column v_mbdk_product.name is '��� ��������';
comment on column v_mbdk_product.tipd is '��� ���.: 1-���������, 2-���������';

