

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_CUST_INDIVIDUAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_CUST_INDIVIDUAL ***

create or replace view V_CIG_CUST_INDIVIDUAL as
select cust_id,
       role_id,
       first_name,
       surname,
       fathers_name,
       gender,
       classification,
       birth_surname,
       date_birth,
       place_birth,
       residency,
       citizenship,
       neg_status,
       education,
       marital_status,
       position,
       cust_key,
       passp_ser,
       passp_num,
       passp_iss_date,
       passp_exp_date,
       passp_organ,
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
  from CIG_CUST_INDIVIDUAL -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
   
   
;

PROMPT *** ALTER_POLICY_INFO to CIG_DOG_CREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_CIG_CUST_INDIVIDUAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_CIG_CUST_INDIVIDUAL'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''V_CIG_CUST_INDIVIDUAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  V_CIG_CUST_INDIVIDUAL ***
grant SELECT,UPDATE                                                          on V_CIG_CUST_INDIVIDUAL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_CUST_INDIVIDUAL  to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_CUST_INDIVIDUAL  to CIG_ROLE;




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_CUST_INDIVIDUAL.sql =========*** End *** =
PROMPT ===================================================================================== 

