PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PERSON_FO_PROFIT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PERSON_FO_PROFIT ***

create or replace procedure p_person_fo_profit (p_rnk in NBU_PROFIT_FO.rnk%type,
                                    p_real6month  in  NBU_PROFIT_FO.real6month%type default null,
                                    p_noreal6month in NBU_PROFIT_FO.noreal6month%type default null,
                                    p_status in NBU_PROFIT_FO.status%type default null,
                                    p_members in NBU_PROFIT_FO.members%type default null,
									p_real6income in NBU_PROFIT_FO.real6income%type default null,
									p_noreal6income in NBU_PROFIT_FO.noreal6income%type default null
									)
is
p_type number(3);
begin
 if p_rnk is null then
  raise_application_error (-20000,'RNK  л≥ента не введено!!!');
 else
  begin
 select case  
   when sed=91 and customer.ise in ('14200', '14100', '14201', '14101') then 2
   when k050=000 then 1
   when k050=910 then 2
     else to_number(k050)
      end  
       into p_type from customer where rnk=p_rnk;
       
      if p_type in (1,2) then   
        begin    
       insert into  NBU_PROFIT_FO (rnk,
                                real6month,
                                noreal6month,
                                status,
                                members,
								real6income,
								noreal6income,
                                type)
                      values (p_rnk,
                             p_real6month,
                             p_noreal6month,
                             p_status,
                             p_members,
							 p_real6income, 
							 p_noreal6income,
                             p_type);
        Exception when dup_val_on_index then
          update  NBU_PROFIT_FO set real6month= p_real6month,noreal6month=p_noreal6month, status=p_status, members=p_members,type=p_type,
                  real6income   =  p_real6income, 
				  noreal6income =  p_noreal6income
           where rnk=p_rnk;
           end;
       else 
         raise_application_error(-20000,' л≥ент не належить до —ѕƒ ч≥ ‘из.ос≥б');
       end if;        
   end;
  end if;
  commit;
end;
/

grant execute on p_person_fo_profit to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PERSON_FO_PROFIT.sql =========*** End *** ==
PROMPT ===================================================================================== 
