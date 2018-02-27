

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cig_dog_noninstalment.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cig_dog_noninstalment ***

create or replace view v_cig_dog_noninstalment as
select  id, 
		dog_id, 
		limit_curr_id, 
		limit_sum, 
		update_date, 
		credit_usage, 
		used_curr_id, 
		used_sum, 
		sync_date, 
		branch
  from cig_dog_noninstalment    -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354    
;

PROMPT *** ALTER_POLICY_INFO to v_cig_dog_noninstalment ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''v_cig_dog_noninstalment'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''v_cig_dog_noninstalment'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''v_cig_dog_noninstalment'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  v_cig_dog_noninstalment ***
grant SELECT,UPDATE                                                          on v_cig_dog_noninstalment  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cig_dog_noninstalment  to BARS_DM;
grant SELECT,UPDATE                                                          on v_cig_dog_noninstalment  to CIG_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cig_dog_noninstalment.sql =========*** End *** =
PROMPT ===================================================================================== 

