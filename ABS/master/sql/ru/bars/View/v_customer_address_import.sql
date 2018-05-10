create or replace view bars.v_customer_address_import as
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
       ar.region_id,
       ar.region_name,
       aa.area_id,
       aa.area_name,
       asettt.settlement_tp_id,
       asettt.settlement_tp_nm,
       asett.settlement_id,
       asett.settlement_name,
       asttt.str_tp_id,
       asttt.str_tp_nm,
       astt.street_id,
       astt.street_name,
       ahttt.id aht_tp_id,
       ahttt.name  aht_tp_nm,
       ahttt.value aht_tp_value,
       ah.house_id,
       case when instr(ah.house_num_add,'/')=0 and instr(ah.house_num_add,',')=0 and ah.house_num_add is not null then ah.HOUSE_NUM||'-'||ah.HOUSE_NUM_ADD
            when instr(ah.house_num_add,'/')=1 or instr(ah.house_num_add,',')=1 then ah.HOUSE_NUM||ah.HOUSE_NUM_ADD
            else HOUSE_NUM
       end house_num,
       ahpttt.id ahpt_tp_id,
       ahpttt.name ahpt_tp_nm,
       ahpttt.value ahpt_tp_value,
       arttt.id    art_tp_id,
       arttt.name  art_tp_nm,
       arttt.value art_tp_value
from      customer                  c
     join customer_address         ca on c.rnk=ca.rnk
     join customer_address_type   cat on cat.id=ca.type_id
     join country                cntr on ca.country=cntr.country
left join address_locality_type   alt on ca.locality_type = alt.id
left join address_street_type     ast on ca.street_type = ast.id
left join address_home_type       aht on ca.home_type = aht.id
left join address_homepart_type   ahpt on ca.homepart_type = ahpt.id
left join address_room_type       art on ca.room_type = art.id
left join adr_regions              ar on ca.region_id = ar.region_id
left join adr_areas                aa on ca.area_id = aa.area_id
left join adr_settlements       asett on ca.settlement_id = asett.settlement_id
left join adr_settlement_types asettt on asettt.settlement_tp_id = ca.locality_type_n
left join adr_streets            astt on ca.street_id = astt.street_id
left join adr_street_types      asttt on asttt.str_tp_id = ca.street_type_n
left join adr_home_type         ahttt on ahttt.id = ca.home_type
left join adr_houses               ah on ca.house_id = ah.house_id
left join adr_homepart_type    ahpttt on ahpttt.id=ca.homepart_type
left join adr_room_type         arttt on arttt.id=ca.room_type
where c.date_off is null
;
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.TYPE_NAME is 'Тип адреси';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.SURNAME is 'Прізвище';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.FIRSTNAME is 'Ім''я';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.PARENTNAME is 'По батьвові';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.COUNTRY_NAME is 'Країна';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.DOMAIN is 'Область (поточне значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.REGION is 'Район (поточне значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.LOCALITY is 'Населений пункт (поточне значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.ADDRESS is 'Адреса (поточне значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.REGION_NAME is 'Область (призначене значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.AREA_NAME is 'Район (призначене значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.SETTLEMENT_NAME is 'Насалений пункт (призначене значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.STREET_NAME is 'Вулиця (призначене значення)';
comment on column BARS.V_CUSTOMER_ADDRESS_IMPORT.HOUSE_NUM is 'Будинок (призначене значення)';
