

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cig_sync_data.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cig_sync_data ***

create or replace view v_cig_sync_data as
select data_id, data_type, branch
  from CIG_SYNC_DATA -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_CREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''v_cig_sync_data'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''v_cig_sync_data'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''v_cig_sync_data'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  v_cig_sync_data ***
grant SELECT,UPDATE                                                          on v_cig_sync_data  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cig_sync_data  to BARS_DM;
grant SELECT,UPDATE                                                          on v_cig_sync_data  to CIG_ROLE;


exec bpa.alter_policies('v_cig_sync_data');

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cig_sync_data.sql =========*** End *** =
PROMPT ===================================================================================== 

