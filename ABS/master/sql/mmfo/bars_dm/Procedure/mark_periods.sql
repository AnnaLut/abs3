

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Procedure/MARK_PERIODS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MARK_PERIODS ***

  CREATE OR REPLACE PROCEDURE BARS_DM.MARK_PERIODS (p_date date)
is
    l_mark_date_start   date :=to_date('01.01.2015','dd.mm.yyyy');
    l_proc_date         date;
begin
    if p_date<l_mark_date_start then
        return;
    end if;

    --

    l_proc_date := l_mark_date_start;

    while (l_proc_date <= trunc (p_date)) loop
         begin
           insert into periods
                (id, type, sdate, edate)
           values
                (s_periods.nextval, 'DAY', trunc(l_proc_date),trunc(l_proc_date));
           exception when dup_val_on_index then null;
         end;

           if (l_proc_date) = last_day(l_proc_date) then
             begin
               insert into periods
                    (id, type, sdate, edate)
               values
                    (s_periods.nextval, 'MONTH', trunc(l_proc_date,'month'),trunc(l_proc_date));
             exception when dup_val_on_index then null;
             end;
           end if;

        l_proc_date:=l_proc_date+1;
    end loop;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Procedure/MARK_PERIODS.sql =========*** E
PROMPT ===================================================================================== 
