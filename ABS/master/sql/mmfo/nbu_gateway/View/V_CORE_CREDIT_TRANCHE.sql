PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_CREDIT_TRANCHE.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_CREDIT_TRANCHE ***
create or replace view V_CORE_CREDIT_TRANCHE as 
select "REQUEST_ID","RNK","ND","NUMDOGTR","DOGDAYTR","ENDDAYTR","SUMZAGALTR","R030TR","PROCCREDITTR","PERIODBASETR","PERIODPROCTR","SUMARREARSTR","ARREARBASETR","ARREARPROCTR","DAYBASETR","DAYPROCTR","FACTENDDAYTR","KLASSTR","RISKTR","KF" from      CORE_CREDIT_TRANCHE t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'LOAN_TRANCHE')
                         group by r.kf);

grant SELECT                                  on V_CORE_CREDIT_TRANCHE   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_CREDIT_TRANCHE.sql =========*** End *** 
PROMPT ===================================================================================== 
