
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dwhcck.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DWHCCK 
is
    -------------------------------------------------------------------
    --                                                               --
    --         Обслуживание загрузки кредитного портфеля в хранилище --
    --                                                               --
    -------------------------------------------------------------------



    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_HEAD      constant varchar2(64)  := 'version 1.0  29.12.2011';

    -----------------------------------------------------------------
    -- Переменные
    -----------------------------------------------------------------


    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2;



    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2;



    ------------------------------------------------------------------
    -- START_LOAD_ROUTINE
    --
    -- Выполнение действий на старте загрузки
    --
    --
    procedure start_load_routine(p_date date);



    ------------------------------------------------------------------
    -- FINISH_LOAD_ROUTINE
    --
    -- Выполнение действий на окончании загрузки
    --
    -- p_errcode - 0 - загрузка успешна,  1 - c ошибкой
    -- p_errmsg  - сообщение об ошибке
    --
    procedure finish_load_routine(p_date date, p_errcode number, p_errmsg varchar2);



    ------------------------------------------------------------------
    -- GET_DATE_TO_LOAD
    --
    -- Получить слеующую дату для загрузки
    --
    --
    function get_date_to_load return date;


    ------------------------------------------------------------------
    -- CHECK_IMPORT_STATUS
    --
    -- p_date        - дата формирования инв ведомости
    -- p_daymon_flag - тип инв. ведомости (0-дневная, 1-месячная)
    -- p_retcode     - 0 - можно выполнять, 1 - нельзя выполнять
    -- p_errmsg      - текст сообщения
    --
    --
    procedure check_import_status(
                                  p_date            date,
                                  p_daymon_flag     number,
                                  p_errmsg      out varchar2,
                                  p_retcode     out number);





    ------------------------------------------------------------------
    -- SET_IMPORT_STATUS
    --
    -- Обновляет статус загрузки
    --
    -- p_date        - дата формирования инв ведомости
    -- p_daymon_flag - тип инв. ведомости (0-дневная, 1-месячная)
    --
    --
    procedure set_import_status(p_date date, p_daymon_flag number);





    ------------------------------------------------------------------
    -- NEST_DBLCREDITS
    --
    -- Население временной таблицы dwh_tmp_dblcredits
    -- кредитами, у которых тело кредита учитывается на 2203 или 2233
    --
    -- p_date        - дата формирования
    -- p_daymon_flag - тип инв. ведомости (0-дневная, 1-месячная)
    --
    --
    procedure nest_dblcredits(p_date date);

end bars_dwhcck;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_DWHCCK 
is
    -------------------------------------------------------------------
    --                                                               --
    --         Обслуживание загрузки кредитного портфеля в хранилище --
    --                                                               --
    -------------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    VERSION_BODY      constant varchar2(64)  := 'version 1.1 20.11.2017';
    G_MODULE          constant varchar2(4)   := 'DWHC';
    G_TRACE     constant varchar2(100)       := 'bars_cckdwh.';


    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2 is
    begin
       return 'Package header bars_cckdwh: '||VERSION_HEAD;
    end header_version;




    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2 is
    begin
       return 'Package body bars_cckdwh: '||VERSION_BODY;
    end body_version;




    ------------------------------------------------------------------
    -- START_LOAD_ROUTINE
    --
    -- Выполнение действий на старте загрузки
    --
    --
    procedure start_load_routine(p_date date)
    is
       l_trace varchar2(1000) := G_MODULE||'start_load_routine: ';
    begin
       bars_audit.info(l_trace||' старт загрузки '||to_char(p_date,'dd/mm/yyyy'));
       update dwh_import_stat set status = 'LOADING' where bank_date = p_date;
    end;



    ------------------------------------------------------------------
    -- FINISH_LOAD_ROUTINE
    --
    -- Выполнение действий на окончании загрузки
    --
    -- p_errcode - 0 - загрузка успешна,  1 - c ошибкой
    -- p_errmsg  - сообщение об ошибке
    --
    procedure finish_load_routine(p_date date, p_errcode number, p_errmsg varchar2)
    is
       l_trace varchar2(1000) := G_MODULE||'finish_load_routine: ';
    begin
       bars_audit.info(l_trace||' окончание загрузки '||to_char(p_date,'dd/mm/yyyy'));

       if p_errcode = 0 then
          update dwh_import_stat set status = 'LOADED' where bank_date = p_date;
       else
          update dwh_import_stat set status = 'ERROR', errmsg = substr(p_errmsg,1,1000)
           where bank_date = p_date;
           bars_audit.error(l_trace||'ошибки: '||p_errmsg);
       end if;
    end;




    ------------------------------------------------------------------
    -- GET_DATE_TO_LOAD
    --
    -- Получить слеующую дату для загрузки
    --
    --
    function get_date_to_load return date
    is
       l_date date;
    begin
       select min(bank_date) into l_date
         from dwh_import_stat d
        where status = 'NEW_ALL'
          and not exists
             (select 1 from  dwh_import_stat
               where status in ('NEW_DAY',  -- в предидущих датах не должно быть только дневной
                                'NEW_MON',  -- только месячной
                                'ERROR',    -- ошибок
                                'LOADING')  -- или в стадии загрузки
                 and bank_date < d.bank_date
             );

       return l_date;

    end;
    ------------------------------------------------------------------
    -- CHECK_IMPORT_STATUS
    --
    -- Проверка возможности дальнейшего выполнения инв. ведомости
    --
    --
    -- p_date        - дата формирования инв ведомости
    -- p_daymon_flag - тип инв. ведомости (0-дневная, 1-месячная)
    -- p_retcode     - 0 - можно выполнять, 1 - нельзя выполнять
    -- p_errmsg      - текст сообщения
    --
    --
    procedure check_import_status(
                                  p_date            date,
                                  p_daymon_flag     number,
                                  p_errmsg      out varchar2,
                                  p_retcode     out number)
    is
       l_stat         dwh_import_stat%rowtype;
       l_maxdate      date;
       l_type         varchar2(3);  -- признак даты: только дневная = DAY, дневная+месячная = ALL
       l_status       varchar2(10);
       l_trace        varchar2(1000) := G_MODULE||'.check_import_status: ';
    begin

       bars_audit.info(l_trace||'Начало проверки возможности выполнения инв. ведомости за '||to_char(p_date,'dd-mm-yyyy')||' тип: '||case when p_daymon_flag=1 then 'месячная' else 'дневная' end);

       begin

          -- Для месячной проверим - єто последний день месяца или нет
          if p_daymon_flag = 1 then
             -- найдем какого типа указанная дата: месячная или дневная
             select max(dat) into l_maxdate
               from ( select trunc(p_date,'mm')-1 + level dat
                        from dual
                     connect by level <= to_char(last_day(p_date), 'dd')
                    )
              where dat not in (select holiday from holiday);

             if p_date <> l_maxdate then
                p_errmsg  := 'Дата '||to_char(p_date,'dd/mm/yyy')||' не является последней датой месяца - выполнение месячной невозможно';
                p_retcode := 1;
                return;
             end if;
          end if;


          select * into l_stat from dwh_import_stat where bank_date = p_date;
          bars_audit.info(l_trace||'Данная дата уже есть в списке выполненных со статусом '||l_stat.type);

          --такая дата уже есть
          if l_stat.type = 'DAY' then    -- за этот день должна быть только дневная
             case l_stat.status
                  when 'NEW_DAY' then    -- ведомость уже была рассчитана за этот день, но не загружена - формируем ведомость еще раз
                                      p_errmsg  := 'Ведомость уже была построена, но не загружена - формируем ведомость еще раз ';
                                      p_retcode := 0;
                  when 'NEW_MON' then    -- странный статус для дневной
                                      p_errmsg  := 'При выполнени дневной инв. ведомости за '||to_char(p_date)||' в таблице статуса загрузок обнаружен некорректный статус '||l_stat.status;
                                      p_retcode := 1;
                  when 'NEW_ALL' then    -- странный статус для дневной
                                      p_errmsg  := 'При выполнени дневной инв. ведомости за '||to_char(p_date)||' в таблице статуса загрузок обнаружен некорректный статус '||l_stat.status;
                                      p_retcode := 1;
                  when 'ERROR'  then
                                      p_errmsg  := 'При загрузке в хранилище произошли ошибки. Дальнейший расчет ведомости за это число приостановлено';
                                      p_retcode := 1;
                  when 'LOADED' then
                                      p_errmsg  := 'Данная дата уже загружена в хранилище - повторное выполнение невозможно';
                                      p_retcode := 1;
                  when 'LOADING' then
                                      p_errmsg  := 'Данная дата загружается в хранилище - повторное выполнение невозможно';
                                      p_retcode := 1;
                  else                p_errmsg  := 'Неизвестный код статуса загрузки '||l_stat.status;
                                      p_retcode := 1;
             end case;
          else                        -- за этот день должна быть дневная и месячная
              case l_stat.status
                  when 'NEW_DAY' then
                                      p_errmsg  := 'Дневная ведомость уже была построена, стрим месячную';
                                      p_retcode := 0;
                  when 'NEW_MON' then
                                      p_errmsg  := 'Месячная ведомость уже была расчитана, но не загружена. Продолжнаем выполнение ';
                                      p_retcode := 0;
                  when 'NEW_ALL' then
                                      p_errmsg  := 'Месячная и дневная ведомость уже была расчитана, но не загружена. Продолжнаем выполнение месячной';
                                      p_retcode := 0;
                  when 'ERROR'  then
                                      p_errmsg  := 'При загрузке в хранилище произошли ошибки. Дальнейший расчет ведомости за это число приостановлено';
                                      p_retcode := 1;
                  when 'LOADED' then
                                      p_errmsg  := 'Данная дата уже загружена в хранилище - повторное выполнение невозможно';
                                      p_retcode := 1;
                  when 'LOADING' then
                                      p_errmsg  := 'Данная дата загружается в хранилище - повторное выполнение невозможно';
                                      p_retcode := 1;
                  else                p_errmsg  := 'Неизвестный код статуса загрузки '||l_stat.status;
                                      p_retcode := 1;
              end case;
          end if;

          bars_audit.info(l_trace||p_errmsg);
          return;

       exception when no_data_found then
          bars_audit.info(l_trace||'Инведомость да данное число не выполнялась');
          p_retcode := 0;
       end;
    end;


    ------------------------------------------------------------------
    -- SET_IMPORT_STATUS
    --
    -- Обновляет статус загрузки
    --
    -- p_date        - дата формирования инв ведомости
    -- p_daymon_flag - тип инв. ведомости (0-дневная, 1-месячная)
    --
    --
    procedure set_import_status(p_date date, p_daymon_flag number)
    is
       l_stat         dwh_import_stat%rowtype;
       l_maxdate      date;
       l_type         varchar2(3);  -- признак даты: только дневная = DAY, дневная+месячная = ALL
       l_status       varchar2(10);
       l_trace        varchar2(1000) := 'dwh_set_import_status: ';
    begin

       begin


          select * into l_stat from dwh_import_stat where bank_date = p_date;

          --такая дата уже есть
          if l_stat.type = 'DAY' then    -- за этот день должна быть только дневная

             if p_daymon_flag = 1 then   -- предидущий тип данного дня - дневная, а указали флаг месячной - выходим
                return;
             end if;
             case l_stat.status
                  when 'NEW_DAY' then  l_status := 'NEW_ALL';   -- была дневная, а мы ее переформировали
                  when 'NEW_ALL' then  l_status := 'NEW_ALL';   -- была дневная, а мы ее переформировали
                  when 'NEW_MON' then  l_status := 'NEW_ALL';   -- непонятно почему такой статус, а мы ее переформировали
                  else return;
             end case;
          else                           -- за этот день должна быть дневная  и месячная
             if p_daymon_flag = 0  then  -- ведомость формируют дневную
                case l_stat.status
                     when 'NEW_DAY' then  l_status := 'NEW_DAY';  -- была дневная, а мы ее переформировали
                     when 'NEW_MON' then  l_status := 'NEW_ALL';  -- была месячная, а мы ее дополнили дневной и получили полную
                     when 'NEW_ALL' then  l_status := 'NEW_ALL';  -- была полная, а мы переформировали дневную
                    else return;
                end case;
             else                      -- ведомость формируют месячную
                case l_stat.status
                     when 'NEW_DAY' then  l_status := 'NEW_ALL';  -- была дневная, а мы дополнили месячной
                     when 'NEW_MON' then  l_status := 'NEW_MON';  -- была месячная, а мы ее переформировали
                     when 'NEW_ALL' then  l_status := 'NEW_ALL';  -- была полная, а мы переформировали меячную
                    else return;
                end case;
             end if;
          end if;

          delete from dwh_import_stat where bank_date = p_date;
          l_type := l_stat.type;

       exception when no_data_found then

          -- найдем какого типа указанная дата: месячная или дневная
          select max(dat) into l_maxdate
            from ( select trunc(p_date,'mm')-1 + level dat
                     from dual
                  connect by level <= to_char(last_day(p_date), 'dd')
                 )
          where dat not in (select holiday from holiday);

          l_type := 'DAY';
          if p_date = l_maxdate then
             l_type := 'ALL';
          end if;


          -- записи еще небыло
          if p_daymon_flag = 0 then     -- формируют дневную
             if  l_type = 'DAY' then    -- и дата требует только дневную
                 l_status := 'NEW_ALL';
             else                       -- и дата требует как дневную так и месячную
                 l_status := 'NEW_DAY';
             end if;
          else                       -- формируют месячную
             if  l_type = 'DAY' then    -- и дата требует только дневную
                 bars_error.raise_error(l_trace||' выполнение месячной ведомости за дату, которая не является последним днем месяца');
             else                       -- и дата требует как дневную так и месячную
                 l_status := 'NEW_MON';
             end if;
          end if;

       end;

       insert into dwh_import_stat(sys_date, bank_date, type, status, retry_cnt)
       values(sysdate, p_date, l_type, l_status, 0 );

    end;



    ------------------------------------------------------------------
    -- NEST_DBLCREDITS
    --
    -- Население временной таблицы dwh_tmp_dblcredits
    -- кредитами, у которых тело кредита учитывается на 2203 или 2233
    --
    -- p_date        - дата формирования
    -- p_daymon_flag - тип инв. ведомости (0-дневная, 1-месячная)
    --
    --
    procedure nest_dblcredits(p_date date)
    is
    begin
       delete from  dwh_tmp_dblcredits;

       insert into dwh_tmp_dblcredits(g00, gt, gr, g59)
       select g00, gt, gr, g59
         from ( select g00, gt, gr, g59, count(*)  cnt
                  from inv_cck_fl
                 where g19 = '2203'
                   and gr <> 'I'
                 group by g00, gt, gr, g59
              )
        where cnt > 1;
    end;


end bars_dwhcck;
/
 show err;
 
PROMPT *** Create  grants  BARS_DWHCCK ***
grant EXECUTE                                                                on BARS_DWHCCK     to BARSDWH_ACCESS_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dwhcck.sql =========*** End ***
 PROMPT ===================================================================================== 
 