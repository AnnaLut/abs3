create or replace view v_customer_address_import as
select c.rnk,
       ca.type_id,
       CAT.NAME type_name,
       substr(ltrim(c.nmk), 1, instr(ltrim(c.nmk), ' ') -1) as Surname,
       substr(ltrim(c.nmk), instr(ltrim(c.nmk), ' ',1) +1, instr(ltrim(c.nmk), ' ',1, 2)- instr(ltrim(c.NMK),' ',1)-1) as Firstname,
       trim(substr(c.nmk, instr(ltrim(c.nmk), ' ', 1, 2))) as Parentname,
       ca.country,
       cntr.name country_name,
       ca.zip,
       ca.domain,
       ca.region,
       ca.locality,
       ca.address,
--------------------------
       ca.territory_id,
       ca.locality_type,
       alt.name locality_type_name, 
       ca.street_type,
       ast.name street_type_name,
       ca.street,
       ca.home_type,
       aht.name home_type_name,
       ca.home,
       ca.homepart_type,
       ahpt.name homepart_type_name,
       ca.homepart,
       ca.room_type,
       art.name room_type_name,
       ca.room,
       ca.comm,
---------------------------
       AR.REGION_ID,
       AR.REGION_NAME,
       AA.AREA_ID,
       AA.AREA_NAME,
       ASETTT.SETTLEMENT_TP_ID,
       ASETTT.SETTLEMENT_TP_NM,
       ASETT.SETTLEMENT_ID,
       ASETT.SETTLEMENT_NAME,
       asttt.str_tp_id,
       asttt.str_tp_nm,
       ASTT.STREET_ID,
       ASTT.STREET_NAME,
       aht.id aht_id,
       aht.name  aht_name,
       aht.value aht_value,
       AH.HOUSE_ID,
       AH.HOUSE_NUM,
       ahpt.id ahpt_id,
       ahpt.name ahpt_name,
       ahpt.value ahpt_value,
       art.id    art_id,
       art.name  art_name,
       art.value art_value
from      customer                  c
     join customer_address         ca on c.rnk=ca.rnk
     join customer_address_type   CAT on CAT.ID=CA.TYPE_ID
     join country                cntr on ca.country=cntr.country
LEFT JOIN address_locality_type   ALT on ca.locality_type = alt.id
LEFT JOIN Address_Street_Type     AST on ca.street_type = ast.id
LEFT JOIN Address_Home_Type       AHT on ca.home_type = aht.id
LEFT JOIN Address_Homepart_Type   AHPT on ca.homepart_type = ahpt.id
LEFT JOIN Address_Room_Type       ART on ca.room_type = art.id

     
LEFT JOIN ADR_REGIONS              ar on CA.REGION_ID = ar.REGION_ID
LEFT JOIN ADR_AREAS                aa on CA.AREA_ID = AA.AREA_ID
LEFT JOIN ADR_SETTLEMENTS       asett on CA.SETTLEMENT_ID = ASETT.SETTLEMENT_ID
LEFT JOIN ADR_SETTLEMENT_TYPES asettt on asettt.settlement_tp_id = asett.SETTLEMENT_TYPE_ID
LEFT JOIN ADR_STREETS            astt on CA.STREET_ID = ASTT.STREET_ID
LEFT JOIN ADR_STREET_TYPES      asttt on astt.street_type = asttt.str_tp_id
LEFT JOIN ADR_HOME_TYPE           aht on aht.id = ca.home_type
LEFT JOIN ADR_HOUSES               ah on CA.HOUSE_ID = AH.HOUSE_ID
LEFT JOIN ADR_HOMEPART_TYPE      ahpt on ahpt.id=ca.homepart_type
LEFT JOIN ADR_ROOM_TYPE           art on art.id=ca.room_type
where c.date_off is null
;
comment on column V_CUSTOMER_ADDRESS_IMPORT.TYPE_NAME is 'Тип адреси';
comment on column V_CUSTOMER_ADDRESS_IMPORT.SURNAME is 'Прізвище';
comment on column V_CUSTOMER_ADDRESS_IMPORT.FIRSTNAME is 'Ім''я';
comment on column V_CUSTOMER_ADDRESS_IMPORT.PARENTNAME is 'По батьвові';
comment on column V_CUSTOMER_ADDRESS_IMPORT.COUNTRY_NAME is 'Країна';
comment on column V_CUSTOMER_ADDRESS_IMPORT.DOMAIN is 'Область (поточне значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.REGION is 'Район (поточне значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.LOCALITY is 'Населений пункт (поточне значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.ADDRESS is 'Адреса (поточне значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.REGION_NAME is 'Область (призначене значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.AREA_NAME is 'Район (призначене значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.SETTLEMENT_NAME is 'Насалений пункт (призначене значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.STREET_NAME is 'Вулиця (призначене значення)';
comment on column V_CUSTOMER_ADDRESS_IMPORT.HOUSE_NUM is 'Будинок (призначене значення)';



GRANT SELECT ON BARS.V_ADR_AREAS TO BARS_ACCESS_DEFROLE;
