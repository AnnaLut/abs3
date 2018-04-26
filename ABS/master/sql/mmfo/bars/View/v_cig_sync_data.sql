

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_SYNC_DATA.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_SYNC_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_SYNC_DATA ("DATA_ID", "DATA_TYPE", "BRANCH") AS 
  select data_id, data_type, branch
  from CIG_SYNC_DATA -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_CIG_SYNC_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_CIG_SYNC_DATA'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''V_CIG_SYNC_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
PROMPT *** Create  grants  V_CIG_SYNC_DATA ***
grant SELECT,UPDATE                                                          on V_CIG_SYNC_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_SYNC_DATA to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_SYNC_DATA to CIG_ROLE;
grant SELECT                                                                 on V_CIG_SYNC_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_SYNC_DATA.sql =========*** End **
PROMPT ===================================================================================== 
