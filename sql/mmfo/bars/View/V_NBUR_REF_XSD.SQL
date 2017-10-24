SET DEFINE OFF;

create or replace view V_NBUR_REF_XSD
( FILE_ID
, FILE_CODE
, FILE_NAME
, SCHEMA_DATE
, CHANGE_DATE
, XSD
) as
select f.ID, f.FILE_CODE, f.FILE_NAME, r.SCM_DT, r.CHG_DT
      , 't'||lower(SubStr(f.FILE_CODE,2,2))||'x.xsd'
  from NBUR_REF_FILES f
  left outer
  join NBUR_REF_XSD r
    on ( r.FILE_ID = f.ID )
 where f.FILE_TYPE = 1
   and f.FILE_FMT = 'XML'
;

show err

COMMENT ON TABLE V_NBUR_REF_XSD IS 'Довідник наявних XSD схем для файлів звітності НБУ';

grant select on V_NBUR_REF_XSD to BARS_ACCESS_DEFROLE;
