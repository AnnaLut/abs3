create or replace view v_settlement_by_locality as
select count(*) ncount,ARG.REGION_ID, ARG.REGION_NAME, ADA.AREA_ID, ADA.AREA_NAME,  a.locality,AR.SETTLEMENT_ID,AR.SETTLEMENT_NAME
from  CUSTOMER_ADDRESS a
     join customer c on c.rnk=a.rnk
left JOIN ADR_REGIONS      ARG    ON ARG.REGION_ID = A.REGION_ID
left JOIN ADR_AREAS        ADA    ON ADA.AREA_ID   = A.AREA_ID
left join SETTLEMENTS_MATCH RM    on RM.LOCALITY    = a.locality and rm.region=a.region_id
left join Adr_Settlements   AR    on AR.SETTLEMENT_ID = RM.SETTLEMENTS_ID
where a.country=804
  and c.date_off is null
  and a.address is not null
  and a.settlement_id is null
  and a.region_id is not null
group by  ARG.REGION_ID, ARG.REGION_NAME, ADA.AREA_ID, ADA.AREA_NAME,  a.locality,AR.SETTLEMENT_ID,AR.SETTLEMENT_NAME
order by count(*) desc,ARG.REGION_NAME, ADA.AREA_NAME, a.locality;

comment on column V_SETTLEMENT_BY_LOCALITY.NCOUNT is 'Кількість подібних значень';
comment on column V_SETTLEMENT_BY_LOCALITY.REGION_NAME is 'Область (поточне значення)';
comment on column V_SETTLEMENT_BY_LOCALITY.AREA_NAME is 'Район (поточне значення)';
comment on column V_SETTLEMENT_BY_LOCALITY.LOCALITY is 'Населенийй пункт (поточне значення)';
comment on column V_SETTLEMENT_BY_LOCALITY.SETTLEMENT_NAME is 'Населенийй пункт (призначене значення)';

GRANT SELECT ON v_settlement_by_locality TO BARS_ACCESS_DEFROLE;
