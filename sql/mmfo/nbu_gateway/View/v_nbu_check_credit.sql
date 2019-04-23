create or replace view v_nbu_check_credit as
select  rnk,type_credit,kf,check_person,nd from (
                                    select  c.rnk ,case when  f.rnk is not null then 1
                                                        when u.rnk is not null then 2
                                                        end check_person,
                                                   case when c.numdog like '%¡œ %' then 2
                                                        when c.vidd in (10) then 3
                                                        else 1 end type_credit
                                       ,c.kf,c.nd,c.request_id,max(c.request_id) over (partition by c.rnk,c.nd,c.kf) max_req                                                         
                                    from nbu_gateway.core_credit c 
                                    left join (select rnk from (select rnk,request_id,max(request_id) over (partition by rnk) max_req from nbu_gateway.core_person_fo) where request_id=max_req) f on f.rnk=c.rnk
                                    left join (select rnk from (select rnk,request_id,max(request_id) over (partition by rnk) max_req from nbu_gateway.core_person_uo) where request_id=max_req) u on u.rnk=c.rnk
                                    )
                                   where max_req=request_id
/

