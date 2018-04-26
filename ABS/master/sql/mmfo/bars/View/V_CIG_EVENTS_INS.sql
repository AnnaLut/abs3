PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS_INS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_EVENTS ***

/* Formatted on 05/04/2018 19:12:55 (QP5 v5.256.13226.35510) */
CREATE OR REPLACE FORCE VIEW BARS.V_CIG_EVENTS_INS
(
   EVT_ID,
   EVT_DATE,
   EVT_UNAME,
   EVT_STATE_ID,
   EVT_MESSAGE,
   EVT_ORAERR,
   EVT_ND,
   EVT_RNK,
   BRANCH,
   EVT_DTYPE,
   EVT_CUSTTYPE
)
AS
   SELECT evt_id,
          evt_date,
          evt_uname,
          evt_state_id,
          evt_message,
          evt_oraerr,
          evt_nd,
          evt_rnk,
          branch,
          evt_dtype,
          evt_custtype
     FROM CIG_EVENTS -- Ќа саму таблицу накладывать политики нельз€. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_CIG_EVENTS_INS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_CIG_EVENTS_INS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''V_CIG_EVENTS_INS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  grants  V_CIG_EVENTS ***
GRANT SELECT ON BARS.V_CIG_EVENTS_INS         TO BARSREADER_ROLE;
GRANT SELECT, UPDATE ON BARS.V_CIG_EVENTS_INS TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_CIG_EVENTS_INS         TO BARS_DM;
GRANT SELECT, UPDATE ON BARS.V_CIG_EVENTS_INS TO CIG_ROLE;
GRANT SELECT ON BARS.V_CIG_EVENTS_INS         TO UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS_INS.sql =========*** End *** =
PROMPT ===================================================================================== 
