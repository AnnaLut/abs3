create or replace view v_street_by_street as
with a as (select TRANSLATE(TRIM( REGEXP_REPLACE ( REGEXP_REPLACE (UPPER("BARS"."STRTOK"(ADDRESS,',',1)),'^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)',''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)','',3)),'ETYUIOPAHKXCBM','���Ȳ���������') aa,
                  count(*) ncount,
                  ARG.REGION_ID,
                  ARG.REGION_NAME,
                  ADA.AREA_ID,
                  ADA.AREA_NAME,
                  ADS.SETTLEMENT_ID,
                  ADS.SETTLEMENT_NAME
           from  CUSTOMER_ADDRESS a
                 JOIN CUSTOMER       C        ON C.RNK        = A.RNK
                 JOIN ADR_REGIONS      ARG    ON ARG.REGION_ID = A.REGION_ID
            left JOIN ADR_AREAS        ADA    ON ADA.AREA_ID   = A.AREA_ID
                 join Adr_Settlements  ADS    on ADS.SETTLEMENT_ID = A.settlement_id
           where a.country=804
             and c.date_off is null
             and a.street_id is null
             group by  TRANSLATE(TRIM( REGEXP_REPLACE ( REGEXP_REPLACE (UPPER("BARS"."STRTOK"(ADDRESS,',',1)),'^(\,|\.|�� |��\.|�� |��\.|���� |����\.|��� |���\.|\��-� |\��-�.|�������� |��������\.|�������� |��������\.|���\.|��� |�� |��\.|������ |�������� |����� |��������\.|�����\.|��-� |��-�\.|��� |���\.)',''),'(\,|\.|\*|\"|\\|\/| � | �\.| ��� | ������� |\d)','',3)),'ETYUIOPAHKXCBM','���Ȳ���������'),
                       ARG.REGION_ID,
                       ARG.REGION_NAME,
                       ADA.AREA_ID,
                       ADA.AREA_NAME,
                       ADS.SETTLEMENT_ID,
                       ADS.SETTLEMENT_NAME)
select a.ncount,
       A.REGION_ID,
       A.REGION_NAME,
       A.AREA_ID,
       A.AREA_NAME,
       A.SETTLEMENT_ID,
       A.SETTLEMENT_NAME,
       a.aa street,
       AR.STREET_ID,
       AR.STREET_NAME

from  a
left join STREETS_MATCH     RM    on RM.STREET    =  a.aa
left join Adr_Streets       AR    on AR.STREET_ID = RM.STREET_ID
order by 1 desc;

comment on column v_street_by_street.NCOUNT is 'ʳ������ ������� �������';
comment on column v_street_by_street.REGION_NAME is '������� (������� ��������)';
comment on column v_street_by_street.AREA_NAME is '����� (������� ��������)';
comment on column v_street_by_street.SETTLEMENT_NAME is '��������� ����� (������� ��������)';
comment on column v_street_by_street.street is '������ (������� ��������)';
comment on column v_street_by_street.STREET_NAME  is '������ (���������� ��������)';

GRANT SELECT ON v_street_by_street TO BARS_ACCESS_DEFROLE;