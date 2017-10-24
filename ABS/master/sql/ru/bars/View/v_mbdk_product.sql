create or replace view v_mbdk_product as
select vidd,
       name,
       tipd
from  cc_vidd t
where mbk.check_if_deal_belong_to_mbdk(t.vidd) = 'Y';

grant select on v_mbdk_product to bars_access_defrole;

comment on table  v_mbdk_product is 'МБДК: види договорів';
comment on column v_mbdk_product.vidd is 'Код виду договору';
comment on column v_mbdk_product.name is 'Вид договору';
comment on column v_mbdk_product.tipd is 'Тип дог.: 1-розміщення, 2-залучення';

