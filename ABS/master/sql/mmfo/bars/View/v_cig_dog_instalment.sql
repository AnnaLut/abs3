

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cig_dog_instalment.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cig_dog_instalment ***

create or replace view v_cig_dog_instalment as
select id,
       dog_id,
       body_sum,
       body_curr_id,
       body_total_cnt,
       instalment_curr_id,
       instalment_sum,
       update_date,
       outstand_cnt,
       outstand_curr_id,
       outstand_sum,
       overdue_cnt,
       overdue_curr_id,
       overdue_sum,
       sync_date,
       branch,
       overdue_day_cnt
  from cig_dog_instalment    -- Ќа саму таблицу накладывать политики нельз€. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354   
;

PROMPT *** ALTER_POLICY_INFO to v_cig_dog_instalment ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''v_cig_dog_instalment'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''v_cig_dog_instalment'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''v_cig_dog_instalment'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  v_cig_dog_instalment ***
grant SELECT,UPDATE                                                          on v_cig_dog_instalment  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cig_dog_instalment  to BARS_DM;
grant SELECT,UPDATE                                                          on v_cig_dog_instalment  to CIG_ROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cig_dog_instalment.sql =========*** End *** =
PROMPT ===================================================================================== 

