

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_BODY_CA.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REG_BODY_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REG_BODY_CA ("DEAL_ID", "DEAL_KF", "DEAL_ADR_ID", "DEAL_REGION", "DEAL_FULL_ADDRESS", "DEAL_BUILD_TYPE", "DEAL_EVENT_ID", "DEAL_EVENT", "DEAL_BUILD_ID", "DEAL_EVENT_RW", "ID") AS 
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

PROMPT *** Create  grants  VW_ESCR_REG_BODY_CA ***
grant SELECT                                                                 on VW_ESCR_REG_BODY_CA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REG_BODY_CA.sql =========*** En
PROMPT ===================================================================================== 
