create or replace view v_street_by_street as
with a as (select  AA,
                   count(*) ncount,      
                   REGION_ID,
                   REGION_NAME,
                   AREA_ID,
                   AREA_NAME,
                   SETTLEMENT_ID,
                   SETTLEMENT_NAME
            from (       
                  select  
                                     TRANSLATE(TRIM ( REGEXP_REPLACE ( REGEXP_REPLACE (UPPER("BARS"."STRTOK"(ADDRESS,',',1)),'^(\,|\.|ок |ок\.|оп |оп\.|опнб |опнб\.|оеп |оеп\.|\оп-й |\оп-й.|опнбскнй |опнбскнй\.|оепескнй |оепескнй\.|бск\.|бск |ск |ск\.|бскхжъ |опняоейр |опняо |опняоейр\.|опняо\.|оп-р |оп-р\.|опр |опр\.)',''),'(\,|\.|/*|\"|\\|\/| а | а\.| асд | асдхмнй |\d)','',3)),'ETYUIOPAHKXCBM','ерсх╡нпюмйуябл') aa,  
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
                               and TRANSLATE(TRIM ( REGEXP_REPLACE ( REGEXP_REPLACE (UPPER("BARS"."STRTOK"(ADDRESS,',',1)),'^(\,|\.|ок |ок\.|оп |оп\.|опнб |опнб\.|оеп |оеп\.|\оп-й |\оп-й.|опнбскнй |опнбскнй\.|оепескнй |оепескнй\.|бск\.|бск |ск |ск\.|бскхжъ |опняоейр |опняо |опняоейр\.|опняо\.|оп-р |оп-р\.|опр |опр\.)',''),'(\,|\.|/*|\"|\\|\/| а | а\.| асд | асдхмнй |\d)','',3)),'ETYUIOPAHKXCBM','ерсх╡нпюмйуябл') is not null)
             group by  AA,      
                       REGION_ID,
                       REGION_NAME,
                       AREA_ID,
                       AREA_NAME,
                       SETTLEMENT_ID,
                       SETTLEMENT_NAME   )
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
comment on column V_STREET_BY_STREET.NCOUNT is 'йЁКЭЙЁЯРЭ ОНДЁАМХУ ГМЮВЕМЭ';
comment on column V_STREET_BY_STREET.REGION_NAME is 'нАКЮЯРЭ (ОНРНВМЕ ГМЮВЕММЪ)';
comment on column V_STREET_BY_STREET.AREA_NAME is 'пЮИНМ (ОНРНВМЕ ГМЮВЕММЪ)';
comment on column V_STREET_BY_STREET.SETTLEMENT_NAME is 'мЮЯЕКЕМХИ ОСМЙР (ОНРНВМЕ ГМЮВЕММЪ)';
comment on column V_STREET_BY_STREET.STREET is 'бСКХЖЪ (ОНРНВМЕ ГМЮВЕММЪ)';
comment on column V_STREET_BY_STREET.STREET_NAME is 'бСКХЖЪ (ОПХГМЮВЕМЕ ГМЮВЕММЪ)';

GRANT SELECT ON v_street_by_street TO BARS_ACCESS_DEFROLE;