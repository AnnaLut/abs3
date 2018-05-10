CREATE OR REPLACE VIEW V_CUSTOMER_ADDRESS AS
SELECT
          ca.rnk,
          ca.type_id,
          ca.country,
          ca.zip,
          ca.domain,
          ca.region,
          ca.locality,
          ca.address,
          ca.territory_id,
          ca.locality_type,
          ca.street_type,
          ca.street,
          ca.home_type,
          ca.home,
          ca.homepart_type,
          ca.homepart,
          ca.room_type,
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
          aht.id aht_tp_id,
          aht.name  aht_tp_nm,
          aht.value aht_tp_value,
          ah.house_id,
          case when instr(ah.house_num_add,'/')=0 and instr(ah.house_num_add,',')=0 and ah.house_num_add is not null then ah.HOUSE_NUM||'-'||ah.HOUSE_NUM_ADD
            when instr(ah.house_num_add,'/')=1 or instr(ah.house_num_add,',')=1 then ah.HOUSE_NUM||ah.HOUSE_NUM_ADD
            else HOUSE_NUM
          end house_num,
          ahpt.id ahpt_tp_id,
          ahpt.name ahpt_tp_nm,
          ahpt.value ahpt_tp_value,
          art.id    art_tp_id,
          art.name  art_tp_nm,
          art.value art_tp_value
     from customer_address ca
  --   left join clv_customer_address       clv      on ca.rnk = clv.rnk
  --   left join clv_request                q        on ca.rnk =  q.rnk and  q.req_type in (0, 2)
     left join adr_regions                ar       on ca.region_id = ar.region_id
     left join adr_areas                  aa       on ca.area_id = aa.area_id
     left join adr_settlements            asett    on ca.settlement_id = asett.settlement_id
     left join adr_settlement_types       asettt   on asettt.settlement_tp_id = ca.locality_type_n
     left join adr_streets                astt     on ca.street_id = astt.street_id
     left join adr_street_types           asttt    on asttt.str_tp_id = ca.street_type_n
     left join adr_home_type              aht      on aht.id = ca.home_type
     left join adr_houses                 ah       on ca.house_id = ah.house_id
     left join adr_homepart_type          ahpt     on ahpt.id=ca.homepart_type
     left join adr_room_type              art      on art.id=ca.room_type
  UNION ALL
   SELECT ca.rnk,
          ca.type_id,
          ca.country,
          ca.zip,
          ca.domain,
          ca.region,
          ca.locality,
          ca.address,
          ca.territory_id,
          ca.locality_type,
          ca.street_type,
          ca.street,
          ca.home_type,
          ca.home,
          ca.homepart_type,
          ca.homepart,
          ca.room_type,
          ca.room,
          ca.comm,
---------------------------
          null region_id,
          null region_name,
          null area_id,
          null area_name,
          null settlement_tp_id,
          null settlement_tp_nm,
          null settlement_id,
          null settlement_name,
          null str_tp_id,
          null str_tp_nm,
          null street_id,
          null street_name,
          null aht_tp_id,
          null aht_tp_nm,
          null aht_tp_value,
          null house_id,
          null house_num,
          null ahpt_tp_id,
          null ahpt_tp_nm,
          null ahpt_tp_value,
          null art_tp_id,
          null art_tp_nm,
          null art_tp_value          
     FROM clv_customer_address ca, clv_request q
    WHERE ca.rnk = q.rnk AND q.req_type IN (0, 2) ;


GRANT SELECT ON bars.V_CUSTOMER_ADDRESS  TO BARS_ACCESS_DEFROLE;
