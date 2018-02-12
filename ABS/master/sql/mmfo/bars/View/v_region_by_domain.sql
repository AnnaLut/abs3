create or replace view v_region_by_domain as
select count(*) ncount,  a.domain ,AR.REGION_ID, AR.REGION_NAME
from  CUSTOMER_ADDRESS a
     join customer       c    on c.rnk        = a.rnk
left join REGIONS_MATCH RM    on RM.DOMAIN    = a.domain
left join ADR_REGIONS   AR    on AR.REGION_ID = RM.REGION_ID
where a.country=804
  and c.date_off is null
  and a.region_id is null
group by a.domain,AR.REGION_ID,  AR.REGION_NAME
order by count(*) desc, a.domain;

comment on column V_REGION_BY_DOMAIN.NCOUNT is 'ʳ������ ������� �������';
comment on column V_REGION_BY_DOMAIN.DOMAIN is '������� (������� ��������)';
comment on column V_REGION_BY_DOMAIN.REGION_NAME is '������� (���������� ��������)';

GRANT SELECT ON v_region_by_domain TO BARS_ACCESS_DEFROLE;
