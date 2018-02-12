create or replace view v_region_by_region as
select count(*) ncount, ARG.REGION_ID,  ARG.REGION_NAME,a.region,AR.AREA_ID, AR.AREA_NAME
FROM  CUSTOMER_ADDRESS A
     JOIN CUSTOMER       C    ON C.RNK=A.RNK
left JOIN ADR_REGIONS  ARG    ON ARG.REGION_ID = A.REGION_ID
LEFT JOIN AREAS_MATCH   RM    ON RM.REGION     = A.REGION and rm.domain =a.region_id
LEFT JOIN ADR_AREAS     AR    ON AR.AREA_ID = RM.AREA_ID
where a.country=804
  and c.date_off is null
  and a.area_id is null
  and a.region_id is not null
group by a.region, AR.AREA_NAME, ARG.REGION_ID,AR.AREA_ID, ARG.REGION_NAME
order by count(*) desc, ARG.REGION_NAME,a.region;


comment on column V_REGION_BY_REGION.NCOUNT is 'Кількість подібних значень';
comment on column V_REGION_BY_REGION.REGION_NAME is 'Область (поточне значення)';
comment on column V_REGION_BY_REGION.REGION is 'Район (поточне значення)';
comment on column V_REGION_BY_REGION.AREA_NAME is 'Район (призначене значення)';

GRANT SELECT ON v_region_by_region TO BARS_ACCESS_DEFROLE;