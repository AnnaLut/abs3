

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cig_cust_company.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cig_cust_company ***

create or replace view v_cig_cust_company as
select  cust_id, 
		role_id, 
		status_id, 
		lang_name, 
		name, 
		lang_abbreviation, 
		abbreviation, 
		ownership, 
		registr_date, 
		economic_activity, 
		employe_count, 
		reg_num, 
		phone_office, 
		phone_mobile, 
		phone_fax, 
		email, 
		website, 
		fact_territory_id, 
		fact_street_buildnum, 
		fact_post_index, 
		reg_territory_id, 
		reg_street_buildnum, 
		reg_post_index, 
		branch
  from cig_cust_company    -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354    
;

PROMPT *** ALTER_POLICY_INFO to v_cig_cust_company ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''v_cig_cust_company'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''v_cig_cust_company'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''v_cig_cust_company'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  v_cig_cust_company ***
grant SELECT,UPDATE                                                          on v_cig_cust_company  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cig_cust_company  to BARS_DM;
grant SELECT,UPDATE                                                          on v_cig_cust_company  to CIG_ROLE;




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cig_cust_company.sql =========*** End *** =
PROMPT ===================================================================================== 

