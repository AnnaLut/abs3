CREATE OR REPLACE VIEW VW_ESCR_REG_BODY_CA
(deal_id, deal_kf, deal_adr_id, deal_region, deal_full_address, deal_build_type, deal_event_id, deal_event, deal_build_id, deal_event_rw,id)
AS
SELECT deal_id,
          deal_kf,
          deal_adr_id,
          deal_region,
          deal_full_address,
          deal_bulid_type,
          deal_event_id,
          deal_event,
          deal_build_id,
          ROWNUM DEAL_EVENT_RW,
          id
     FROM (SELECT t.id,
                  t.deal_id,
                  NULL AS deal_kf,
                  t.deal_adr_id,
                  t.deal_region,
                  t.deal_full_address,
                  t1.TYPE deal_bulid_type,
                  t.deal_event_id,
                  t2.name deal_event,
                  t.deal_build_id
             FROM escr_reg_body t
                  JOIN escr_build_types t1
                     ON t.deal_build_id = t1.id
                  JOIN escr_events t2
                     ON t.deal_event_id = t2.id);
