create or replace view v_adr_areas
(area_id, area_nm, region_id, region_name)
as
select A.AREA_ID
     , A.AREA_NAME
     , A.REGION_ID
     , R.REGION_NAME
 from BARS.ADR_AREAS   A,
      BARS.ADR_REGIONS R
 where A.REGION_ID = R.REGION_ID      ;
comment on table V_ADR_AREAS is '������� ������';
comment on column V_ADR_AREAS.AREA_ID is '������������� ������';
comment on column V_ADR_AREAS.AREA_NM is '����� ������';
comment on column V_ADR_AREAS.REGION_ID is '������������� ������';
comment on column V_ADR_AREAS.REGION_NAME is '����� ������';

GRANT SELECT ON BARS.V_ADR_AREAS TO BARS_ACCESS_DEFROLE;
