

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cig_dog_sync_params.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cig_dog_sync_params ***

create or replace view v_cig_dog_sync_params as
select  nd, 
		mfo, 
		data_type, 
		sync_type, 
		is_sync
  from cig_dog_sync_params    -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354    
;

PROMPT *** ALTER_POLICY_INFO to v_cig_dog_sync_params ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''v_cig_dog_sync_params'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''v_cig_dog_sync_params'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''v_cig_dog_sync_params'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  v_cig_dog_sync_params ***
grant SELECT,UPDATE                                                          on v_cig_dog_sync_params  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cig_dog_sync_params  to BARS_DM;
grant SELECT,UPDATE                                                          on v_cig_dog_sync_params  to CIG_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cig_dog_sync_params.sql =========*** End *** =
PROMPT ===================================================================================== 

