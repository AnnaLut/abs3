

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CIG_EVENTS ***

create or replace view V_CIG_EVENTS as
select  evt_id, 
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
  from CIG_EVENTS    -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354    
;

PROMPT *** ALTER_POLICY_INFO to V_CIG_EVENTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_CIG_EVENTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_CIG_EVENTS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''V_CIG_EVENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  V_CIG_EVENTS ***
grant SELECT,UPDATE                                                          on V_CIG_EVENTS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_EVENTS  to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_EVENTS  to CIG_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_EVENTS.sql =========*** End *** =
PROMPT ===================================================================================== 

