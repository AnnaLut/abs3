PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/F_GET_DEPOSIT_SCHEDULE.sql =========*** Run 
PROMPT ===================================================================================== 

CREATE OR REPLACE FUNCTION F_GET_DEPOSIT_SCHEDULE (
                                                    p_schedule_begin_dt date --���� ������ ���������� �������
                                                    , p_schedule_end_dt date --���� ��������� ���������� �������
                                                    , p_frequency       number --������� �������
                                                    , p_cust_type       number default 3 --��� �������, ��-��������� ���-����
                                                  )
return t_deposit_schedules pipelined
is
  l_row                    t_deposit_schedule;    
  l_period_mnth            number; --������������� ������� � �������
    
  l_counter                number := 1;
  l_dt                     date;
  l_period_begin_dt        date; --���� ������ �������
  l_period_end_dt          date; --���� ��������� �������    
begin
   --���� ������� � ����� �����, �� ��������� ������ �� 1 ������
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
                        when p_frequency in (2, 5) then 1 --�������� �������
                        when p_frequency in (7) then 3 --����������� �������
                        when p_frequency in (180) then 6 --����������� �������
                        when p_frequency in (360) then 12 --������� �������
                      else
                        1 --���� �� ������������, �� ���������� �������� �������
                      end;
                      
     --���� ��������� ����������� �������
     l_dt := p_schedule_begin_dt;
     while l_dt < p_schedule_end_dt
     loop
       l_period_begin_dt := l_dt;

       --��� ���. ��� � ��. ��� �� ������� ����������� �������
       if (p_cust_type = 3)
       then
         l_period_end_dt := least(add_months(p_schedule_begin_dt, l_period_mnth * l_counter) - 1, p_schedule_end_dt - 1);
       else
         l_period_end_dt := least(last_day(add_months(p_schedule_begin_dt, l_period_mnth * l_counter)), p_schedule_end_dt);
       end if;

       --������������� ��������� ����� �� ���������� �������
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