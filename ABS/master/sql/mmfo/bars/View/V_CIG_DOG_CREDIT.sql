

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_CREDIT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_DOG_CREDIT ***

create or replace view V_CIG_DOG_CREDIT as
select id,
       dog_id,
       limit_curr_id,
       limit_sum,
       update_date,
       credit_usage,
       res_curr_id,
       res_sum,
       overdue_curr_id,
       overdue_sum,
       sync_date,
       branch,
       overdue_day_cnt,
       overdue_cnt
  from CIG_DOG_CREDIT -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_CREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_CIG_DOG_CREDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_CIG_DOG_CREDIT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''V_CIG_DOG_CREDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  V_CIG_DOG_CREDIT ***
grant SELECT,UPDATE                                                          on V_CIG_DOG_CREDIT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_DOG_CREDIT  to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_DOG_CREDIT  to CIG_ROLE;


exec bpa.alter_policies('V_CIG_DOG_CREDIT');

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_DOG_CREDIT.sql =========*** End *** =
PROMPT ===================================================================================== 

