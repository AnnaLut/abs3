
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_calendar.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NBUR_CALENDAR 
is

g_header_version  constant varchar2(64)  := 'version 3.0  2016.07.06';
g_header_defs     constant varchar2(512) := '';

-- header_version - версія заголовку пакета
function header_version return varchar2;

-- body_version - версія тіла пакета
function body_version return varchar2;

-- вихідний = true, робочий = false
function f_is_holiday (p_dat in date) return boolean;

-- банківська дата p_day назад
function f_get_prev_bank_date (p_dat in date,
                               p_day in number) return date;

-- банківська дата p_day вперед
function f_get_next_bank_date (p_dat in date,
                               p_day in number) return date;

-- заповненнч календаря по файлу для філії
procedure f_fill_calendar_file_kf (p_file_id in number,
                                   p_begin_date in date,
                                   p_end_date in date,
                                   p_kf in number);

-- заповненнч календаря по всіх файлах для філії
procedure f_fill_calendar_kf (p_begin_date in date,
                              p_end_date in date,
                              p_kf in number);

-- заповненнч календаря по всіх файлах для всіх
procedure f_fill_calendar (p_begin_date in date,
                           p_end_date in date);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.NBUR_CALENDAR 
is

g_body_version  constant varchar2(64)  := 'version 4.1  2016.08.07';
g_body_defs     constant varchar2(512) := '';

MODULE_PREFIX   constant varchar2(10)   := 'NBUR';

-- header_version - версія заголовку пакета
function header_version return varchar2 is
begin
  return 'Package header NBUR_CALENDAR ' || g_header_version || '.' || chr(10) ||
         'Package header definition(s): ' || chr(10) ||  g_header_defs;
end header_version;

-- body_version - версія тіла пакета
function body_version return varchar2 is
begin
  return 'Package body NBUR_CALENDAR ' || g_body_version || '.' || chr(10) ||
         'Package body definition(s): ' || chr(10) || g_body_defs;
end body_version;

-- вихідний = true, робочий = false
function f_is_holiday (p_dat in date) return boolean is
    l_ret   boolean;
    l_cnt   number;
begin
    SELECT count(*)
    INTO l_cnt
    FROM holiday
    WHERE kv = 980 AND
          holiday = p_dat;

    l_ret := (case when l_cnt = 0 then false else true end);

    return l_ret;
end f_is_holiday;

-- банківська дата p_day назад
function f_get_prev_bank_date (p_dat in date,
                               p_day in number) return date is
   l_dat          date;
BEGIN
   l_dat := p_dat - p_day;

   -- якщо день не вихідний
   IF not f_is_holiday(l_dat)
   THEN
      RETURN l_dat;
   END IF;

   FOR i IN 1 .. 10
   LOOP
       l_dat := l_dat - 1;

       -- якщо день не вихідний
       IF not f_is_holiday(l_dat)
       THEN
          RETURN l_dat;
       END IF;
   END LOOP;

   return null;
end;

-- банківська дата p_day вперед
function f_get_next_bank_date (p_dat in date,
                               p_day in number) return date is
   l_dat          date;
BEGIN
   l_dat := p_dat + p_day;

   -- якщо день не вихідний
   IF not f_is_holiday(l_dat)
   THEN
      RETURN l_dat;
   END IF;

   FOR i IN 1 .. 10
   LOOP
       l_dat := l_dat + 1;

       -- якщо день не вихідний
       IF not f_is_holiday(l_dat)
       THEN
          RETURN l_dat;
       END IF;
   END LOOP;

   return null;
end;

-- заповненнч календаря по файлу для філії
procedure f_fill_calendar_file_kf (p_file_id in number,
                                   p_begin_date in date,
                                   p_end_date in date,
                                   p_kf in number) is
    l_count         number;
    l_count_day     number;
    l_exist         number;
    l_exist_holiday number;
    l_days_form     number;
    l_day           number;
    l_file_code     varchar2(3);

    l_cal_date      date;
    l_rep_date      date;
    l_cur_date      date;

    l_period_type   NBUR_REF_PERIODS.period_type%type;
begin
    -- вилучаємо попередні записи
    delete
    from NBUR_REF_CALENDAR
    where FILE_ID = p_file_id and
          CALENDAR_DATE between p_begin_date and p_end_date and
          (kf = p_kf or p_kf is null);

    -- визначаємо тип та кількість днів для формування
    begin
        select s.days_form, f.period_type
        into l_days_form, l_period_type
        from NBUR_REF_FILE_SCHEDULE s, NBUR_REF_FILES f
        where s.file_id = p_file_id and
            s.file_id = f.id;
    exception
        when no_data_found then
             select f.file_code
                into l_file_code
                from NBUR_REF_FILES f
                where f.id = p_file_id;

            logger.error ('NBUR_CALENDAR: Файл '||l_file_code||' відсутній у NBUR_REF_FILE_SCHEDULE');
            return;
    end;

    l_count := p_end_date - p_begin_date;

    -- щоденні файли формуються кожного дня за попередній
    if l_period_type = 'D' then
       for i_add in 0 .. l_count loop
           l_cal_date := p_begin_date + i_add;

           if not f_is_holiday(l_cal_date) then
              l_rep_date := f_get_prev_bank_date(l_cal_date, 1);

              insert into NBUR_REF_CALENDAR(ID, CALENDAR_DATE, REPORT_DATE, FILE_ID, KF, STATUS)
              values (s_nbur_ref_calendar.nextval, l_cal_date, l_rep_date, p_file_id, p_kf, 'TRUE');
           end if;
       end loop;
    end if;

    -- декадний формується в дату 10, 20 та кінець місяця (чи поепердні робочі дні)
    if l_period_type = 'T' then
       for i_add in 0 .. l_count loop
           l_cal_date := p_begin_date + i_add;
           l_day := to_number(to_char(l_cal_date, 'DD'));

           if l_day in (1, 11, 21) then
               if f_is_holiday(l_cal_date) then
                  l_cal_date := f_get_next_bank_date(l_cal_date, 1);
               end if;

               l_rep_date := f_get_prev_bank_date(l_cal_date, 1);

               insert into NBUR_REF_CALENDAR(ID, CALENDAR_DATE, REPORT_DATE, FILE_ID, KF, STATUS)
               values (s_nbur_ref_calendar.nextval, l_cal_date, l_rep_date, p_file_id, p_kf, 'TRUE');
           end if;
       end loop;
    end if;

    -- місячний файл формується останній банківський день попереднього місяця
    -- протягом l_days_form банківських днів
    -- те саме й для квартальних, піврічних  та річних файлів (поки що)
    if l_period_type in ('M', 'Q', 'P', 'Y') then
       for i_add in 0 .. l_count loop
           l_cal_date := p_begin_date + i_add;
           l_day := to_number(to_char(l_cal_date, 'DD'));

           l_rep_date := f_get_prev_bank_date(l_cal_date, 1);

           if f_is_holiday(l_cal_date) then
              l_cal_date := f_get_next_bank_date(l_cal_date, 1);
           end if;

           if l_day = 1 then
              l_count := 0;
              l_count_day := 0;

              loop
                  exit when l_count_day >= l_days_form or
                            l_cal_date + l_count > p_end_date or
                            l_period_type = 'Y' and to_char(l_cal_date, 'MM') <> '01' or
                            l_period_type = 'P' and to_char(l_cal_date, 'MM') not in ('01', '07') or
                            l_period_type = 'Q' and to_char(l_cal_date, 'MM') not in ('01', '04', '07', '10') ;

                  l_cur_date := l_cal_date + l_count;

                  if f_is_holiday(l_cur_date) then
                     null;
                  else
                     insert into NBUR_REF_CALENDAR(ID, CALENDAR_DATE, REPORT_DATE, FILE_ID, KF, STATUS)
                     values (s_nbur_ref_calendar.nextval, l_cur_date, l_rep_date, p_file_id, p_kf, 'TRUE');

                     l_count_day := l_count_day + 1;
                  end if;

                  l_count := l_count + 1;
              end loop;
           end if;
       end loop;
    end if;

    return;
end f_fill_calendar_file_kf;

-- заповненнч календаря по всіх файлах для філії
procedure f_fill_calendar_kf (p_begin_date in date,
                              p_end_date in date,
                              p_kf in number)
is
begin
    for k in (select id file_id
              from NBUR_REF_FILES
              order by id)
    loop
        f_fill_calendar_file_kf (k.file_id, p_begin_date, p_end_date, p_kf);
    end loop;

end f_fill_calendar_kf;

-- заповненнч календаря по всіх файлах для всіх
procedure f_fill_calendar (p_begin_date in date,
                           p_end_date in date)
is
begin
    for k in (select id file_id
              from NBUR_REF_FILES
              order by id)
    loop
        f_fill_calendar_file_kf (k.file_id, p_begin_date, p_end_date, null);
    end loop;

end f_fill_calendar;

end;
/
 show err;
 
PROMPT *** Create  grants  NBUR_CALENDAR ***
grant EXECUTE                                                                on NBUR_CALENDAR   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBUR_CALENDAR   to RPBN002;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nbur_calendar.sql =========*** End *
 PROMPT ===================================================================================== 
 