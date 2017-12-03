PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PRODUCT.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view V_MBDK_PRODUCT ***

create or replace view v_mbdk_product as
select vidd,
       name,
       tipd,
       (case when t.vidd in (2700,2701,3660,3661) then 1 else 2 end) tipp
from  cc_vidd t
where mbk.check_if_deal_belong_to_mbdk(t.vidd) = 'Y';

grant select on v_mbdk_product to bars_access_defrole;

comment on table  v_mbdk_product is '����: ���� ��������';
comment on column v_mbdk_product.vidd is '��� ���� ��������';
comment on column v_mbdk_product.name is '��� ��������';
comment on column v_mbdk_product.tipd is '��� ���.: 1-���������, 2-���������';
comment on column v_mbdk_product.tipp is '��� ��������: 1-����� , 2-2700,3660 - ��';

PROMPT *** Create  grants  V_MBDK_PRODUCT ***
grant SELECT                                                                 on V_MBDK_PRODUCT  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_PRODUCT.sql =========*** End ***
PROMPT ===================================================================================== 
