

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_GENERAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_DOG_GENERAL ***

create or replace view V_CIG_DOG_GENERAL as
select id,
       nd,
       cust_id,
       phase_id,
       pay_method_id,
       pay_period_id,
       operation,
       contract_type,
       contract_code,
       contract_date,
       contract_start_date,
       currency_id,
       credit_purpose,
       negative_status,
       application_date,
       exp_end_date,
       fact_end_date,
       upd_date,
       sync_date,
       branch,
       branch_dog,
       send_date,
       send_id,
       batch_id
  from CIG_DOG_GENERAL -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;

PROMPT *** ALTER_POLICY_INFO to CIG_DOG_CREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_CIG_DOG_GENERAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_CIG_DOG_GENERAL'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''V_CIG_DOG_GENERAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  V_CIG_DOG_GENERAL ***
grant SELECT,UPDATE                                                          on V_CIG_DOG_GENERAL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_DOG_GENERAL  to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_DOG_GENERAL  to CIG_ROLE;




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_GENERAL.sql =========*** End *** =
PROMPT ===================================================================================== 

