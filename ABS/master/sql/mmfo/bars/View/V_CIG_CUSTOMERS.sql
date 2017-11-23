

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_CUSTOMERS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_CUSTOMERS ***

create or replace view V_CIG_CUSTOMERS as
select cust_id,
       cust_type,
       rnk,
       upd_date,
       sync_date,
       cust_name,
       cust_code,
       last_err,
       branch
  from CIG_CUSTOMERS  -- На саму таблицу накладывать политики нельзя. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354
;

PROMPT *** ALTER_POLICY_INFO to CIG_DOG_CREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''V_CIG_CUSTOMERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''V_CIG_CUSTOMERS'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''V_CIG_CUSTOMERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  V_CIG_CUSTOMERS ***
grant SELECT,UPDATE                                                          on V_CIG_CUSTOMERS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_CUSTOMERS  to BARS_DM;
grant SELECT,UPDATE                                                          on V_CIG_CUSTOMERS  to CIG_ROLE;




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_CUSTOMERS.sql =========*** End *** =
PROMPT ===================================================================================== 

