PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/F_GET_DEPOSIT_SCHEDULE.sql =========*** Run 
PROMPT ===================================================================================== 

CREATE OR REPLACE FUNCTION F_GET_DEPOSIT_SCHEDULE (
                                                    p_schedule_begin_dt date --Дата начала построения графика
                                                    , p_schedule_end_dt date --Дата окончания построения графика
                                                    , p_frequency       number --Частота выплаты
                                                    , p_cust_type       number default 3 --Тип клиента, по-умолчанию физ-лицо
                                                  )
return t_deposit_schedules pipelined
is
  l_row                    t_deposit_schedule;    
  l_period_mnth            number; --Периодичность выплаты в месяцах
    
  l_counter                number := 1;
  l_dt                     date;
  l_period_begin_dt        date; --Дата начала периода
  l_period_end_dt          date; --Дата окончания периода    
begin
   --Если выплата в конце срока, то формируем запись на 1 платеж
   if (p_frequency = 400)
   then
     l_row := t_deposit_schedule(
                                   SCHEDULE_BEGIN_DT => p_schedule_begin_dt
                                   , SCHEDULE_END_DT => p_schedule_end_dt
                                   , FREQ => p_frequency
                                   , FREQ_MNTH => null
                                   , PERIOD_BEGIN_DT => p_schedule_begin_dt
                                   , PERIOD_END_DT => case
                                                        when p_cust_type = 3
                                                      then
                                                        p_schedule_end_dt - 1
                                                      else
                                                        p_schedule_end_dt
                                                      end
                                );
                                
     pipe row(l_row);
   else
     l_period_mnth := case                   
                        when p_frequency in (2, 5) then 1 --Месячная выплата
                        when p_frequency in (7) then 3 --Квартальная выплата
                        when p_frequency in (180) then 6 --Полугодовая выплата
                        when p_frequency in (360) then 12 --Годовая выплата
                      else
                        1 --Если не определились, то получается месячная выплата
                      end;
                      
     --Дата окончания предыдущего периода
     l_dt := p_schedule_begin_dt;
     while l_dt < p_schedule_end_dt
     loop
       l_period_begin_dt := l_dt;

       --Для физ. лиц и юр. лиц по разному расчитывыем графики
       if (p_cust_type = 3)
       then
         l_period_end_dt := least(add_months(p_schedule_begin_dt, l_period_mnth * l_counter) - 1, p_schedule_end_dt - 1);
       else
         l_period_end_dt := least(last_day(add_months(p_schedule_begin_dt, l_period_mnth * l_counter)), p_schedule_end_dt);
       end if;

       --Поанализируем проверяем нужно ли схлопывать периоды
       if ( 
            (l_period_mnth < 12 and to_char(l_period_end_dt, 'mmyyyy') = to_char(p_schedule_end_dt, 'mmyyyy'))
            or (l_period_mnth >= 12 and to_char(l_period_end_dt, 'yyyy') = to_char(p_schedule_end_dt, 'yyyy'))           
          )
       then
         if (p_cust_type = 3) 
         then
           l_period_end_dt :=  p_schedule_end_dt - 1;
         else
           l_period_end_dt := p_schedule_end_dt;       
         end if;
       end if;

       l_row := t_deposit_schedule(
                                   SCHEDULE_BEGIN_DT => p_schedule_begin_dt
                                   , SCHEDULE_END_DT => p_schedule_end_dt
                                   , FREQ => p_frequency
                                   , FREQ_MNTH => l_period_mnth
                                   , PERIOD_BEGIN_DT => l_period_begin_dt
                                   , PERIOD_END_DT => l_period_end_dt
                                );
       pipe row(l_row);
  
       l_counter := l_counter + 1;
       l_dt := l_period_end_dt + 1;          
     end loop;                                            
   end if;

   return;
end;
/
show err;
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/F_GET_DEPOSIT_SCHEDULE.sql =========*** End 
PROMPT ===================================================================================== 