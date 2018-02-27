

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cig_cust_change_code.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cig_cust_change_code ***

create or replace view v_cig_cust_change_code as
select  cust_key, 
		mfo, 
		is_sync
  from cig_cust_change_code    -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354    
;

PROMPT *** ALTER_POLICY_INFO to v_cig_cust_change_code ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''v_cig_cust_change_code'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''v_cig_cust_change_code'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''v_cig_cust_change_code'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  v_cig_cust_change_code ***
grant SELECT,UPDATE                                                          on v_cig_cust_change_code  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cig_cust_change_code  to BARS_DM;
grant SELECT,UPDATE                                                          on v_cig_cust_change_code  to CIG_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cig_cust_change_code.sql =========*** End *** =
PROMPT ===================================================================================== 

