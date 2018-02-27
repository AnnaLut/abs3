

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_cig_dog_stop.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view v_cig_dog_stop ***

create or replace view v_cig_dog_stop as
select dog_id, 
       stop_date, 
       staff_id, 
       branch
  from cig_dog_stop    -- Ќа саму таблицу накладывать политики нельз€. http://jira.unity-bars.com.ua:11000/browse/COBUMMFO-5354    
;

PROMPT *** ALTER_POLICY_INFO to v_cig_dog_stop ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''v_cig_dog_stop'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''v_cig_dog_stop'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''v_cig_dog_stop'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/
                                                       
PROMPT *** Create  grants  v_cig_dog_stop ***
grant SELECT,UPDATE                                                          on v_cig_dog_stop  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on v_cig_dog_stop  to BARS_DM;
grant SELECT,UPDATE                                                          on v_cig_dog_stop  to CIG_ROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_cig_dog_stop.sql =========*** End *** =
PROMPT ===================================================================================== 

