PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ow_transform_acc  ====== *** End ***
PROMPT ===================================================================================== 

create or replace package ow_transform_acc is

  -- Author  : OLEH.YAROSHENKO
  -- Created : 6/23/2018 12:36:41 PM
  -- Purpose : Change cards accrounts number in 26_5 to 26_0

   gc_header_version  constant varchar2(64)  := 'version 1.0 6/23/2018';

   gc_bnk_dt          constant date := coalesce(GL.GBD(),DAT_NEXT_U(trunc(sysdate),0),trunc(sysdate));

   function header_version return varchar2;

   function body_version return varchar2;

   function get_new_nls(
                          p_kf    in accounts.kf%type
                          , p_nbs in accounts.nbs%type
                          , p_nls in accounts.nls%type
                       )
   return varchar2;

   procedure fill_accounts_forecast(
                                      p_kf in accounts.kf%type
                                   );

   procedure fill_accounts_forecast_le(
                                        p_kf in accounts.kf%type
                                      );

   procedure fill_accounts_forecast_inst(
                                           p_kf     in accounts.kf%type
                                        );

   procedure transfer_out_files(
                                  p_mode in number
                                  , p_filename out varchar2
                                  , p_filebody out clob
                                  , p_msg out varchar2
                               );

   procedure transfer_w4_out_files(
                                     p_mode in number
                                     , p_filename out varchar2
                                     , p_filebody out clob
                                     , p_msg out varchar2
                                  );

   procedure transfer_out_files_le(
                                     p_mode in number
                                     , p_filename out varchar2
                                     , p_filebody out clob
                                     , p_msg out varchar2
                                  );

   procedure transfer_w4_out_files_le(
                                        p_mode in number
                                        , p_filename out varchar2
                                        , p_filebody out clob
                                        , p_msg out varchar2
                                     );

   procedure forecast_upload(
                               p_filename out varchar2
                               , p_filebody out clob
                            );

   procedure forecast_upload_le(
                                  p_filename   out varchar2
                                  , p_filebody out clob
                               );

   procedure account_interest_transform(p_kf in accounts.kf%type);

   procedure transforms(
                          p_kf in accounts.kf%type
                       );

   procedure account_interest_transform_le(p_kf in accounts.kf%type);

   procedure transforms_le(
                             p_kf in accounts.kf%type
                          );

   procedure transforms_instant(
                                  p_kf in accounts.kf%type
                               );

   procedure close_legal_entity(
                                  p_kf          in accounts.kf%type
                                  , p_bank_date in date default dat_next_u(gc_bnk_dt, 1)
                               );

   procedure set_trigger ( p_mode varchar2);
end ow_transform_acc;
/
create or replace package body ow_transform_acc is
   gc_nbs_person        constant varchar2(4) := '2625';
   gc_nbs_legal_entity  constant varchar2(4) := '2605';
   gc_nbs_nonfin_entity constant varchar2(4) := '2655';

   gc_body_version     constant varchar2(64)      := 'version 1.0  6/23/2018';

   gc_delimiter        constant char(1)      := ';';

   gc_date_transform   constant date := to_date('01/01/2019', 'mm/dd/yyyy');

   gc_ow_par_ftrans_code constant ow_params.par%type := 'W4_FTRANS';
   gc_ow_par_ftrans_comm constant ow_params.comm%type := 'Ознака необхідності генерації файла по трансформаційній таблиці для фіз. осіб';

   gc_ow_par_ftrans_w4_code constant ow_params.par%type := 'W4_FTR_W4';
   gc_ow_par_ftrans_w4_comm constant ow_params.comm%type := 'Ознака необхідності генерації файла по зміненим рахункам для фіз. осіб';

   gc_ow_par_ftrans_code_le constant ow_params.par%type := 'W4_FTRANSU';
   gc_ow_par_ftrans_comm_le constant ow_params.comm%type := 'Ознака необхідності генерації файла по трансформаційній таблиці для юр. осіб';

   gc_ow_par_ftrans_w4_code_le constant ow_params.par%type := 'W4_FTR_W4U';
   gc_ow_par_ftrans_w4_comm_le constant ow_params.comm%type := 'Ознака необхідності генерації файла по зміненим рахункам для юр. осіб';

   -- header_version - возвращает версию заголовка пакета
   function header_version return varchar2 is
   begin
      return 'Package header ow_transform_acc ' || gc_header_version;
   end header_version;

   -- body_version - возвращает версию тела пакета
   function body_version return varchar2 is
   begin
      return 'Package body ow_transform_acc ' || gc_body_version;
   end body_version;

   -- Проверяем есть ли номер счета среди уже сгенерированных
   function check_nls(
                        p_acc       in accounts.acc%type
                        , p_nls     in accounts.nls%type
                        , p_nls_new in accounts.nls%type
                        , p_kf      in accounts.kf%type
                     )
   return boolean
   as
      l_count integer;
   begin
      select count(*)
      into l_count
      from (
              select 1 from accounts where nls = p_nls_new and kf = p_kf and (nlsalt is null or nlsalt <> p_nls)
              union all
              select 1 from TRANSFORM_2017_FORECAST where new_nls = p_nls_new and kf = p_kf and acc <> p_acc
           );
      return (l_count = 0 and length(p_nls_new) = 14);
   end;

   -- Проверяем есть ли номер счета среди открытых и открывался ли он для этого счета
   function check_nls_open(
                            p_nls     in accounts.nls%type
                            , p_kv      in accounts.kv%type
                          )
   return boolean
   as
      l_count integer;
   begin
      select count(*)
      into l_count
      from (
              select 1 from accounts where nlsalt = p_nls and kv = p_kv
           );
      return (l_count = 0 );
   end;

   -- генерируем новый номер счета
   function get_new_nls(
                          p_kf    in accounts.kf%type
                          , p_nbs in accounts.nbs%type
                          , p_nls in accounts.nls%type
                       )
   return varchar2
   as
   begin
      return vkrzn( substr( p_kf, 1,5), p_nbs||'0'||substr( p_nls, 6,9));
   end;

   -- Проверяем есть ли номер счета среди сгенерированных
   -- если нет - возвращаем
   -- если есть - генерируем новый и опять проверяем (и так 100 раз)
   -- если за 100 раз не подобрали - вернули null
   function redefine_nls(
                           p_acc       in accounts.acc%type
                           , p_nls     in accounts.nls%type
                           , p_nls_new in accounts.nls%type
                           , p_nbs     in accounts.nbs%type
                           , p_kf      in accounts.kf%type
                        )
   return accounts.nls%type
   is
      l_try integer := 0;
      l_nls accounts.nls%type := p_nls_new;
   begin
      while l_try < 100 loop
         if check_nls(p_acc, p_nls, l_nls, p_kf) then
            exit;
         end if;
         l_try := l_try + 1;
         l_nls := get_new_nls(p_kf, p_nbs, p_nbs||'0'||trunc(dbms_random.value(100000000, 999999999)));
      end loop;

      if l_try = 100 then
         l_nls := null;
      end if;

      return l_nls;
   end redefine_nls;

   --заполняем таблицу прогнозов
   procedure fill_accounts_forecast(
                                      p_kf     in accounts.kf%type
                                      , p_flag in integer -- 0 - физицеские лица, 1 - юридические лица
                                   )
   as
      l_trace varchar2(100) := 'ow_transform_acc.fill_accounts_forecast: ';

      l_nbs   accounts.nbs%type;

      l_acc_cnt integer := 0;
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для KF='||p_kf);

      for c in (
                  select a.kf
                         , a.rnk
                         , a.kv
                         , a.acc
                         , a.nbs
                         , a.nls
                         , a.ob22
                         , t.r020_new new_nbs
                         , t.ob_new new_ob22
                         , get_new_nls(a.kf, r020_new, a.nls) new_nls
                  from accounts a
                  join transfer_2017 t on a.nbs = t.r020_old and a.ob22 = t.ob_old
                       and t.dat_beg = gc_date_transform
                       and (
                              (t.r020_old in ( gc_nbs_person) and p_flag = 0)
                              or (t.r020_old in ( gc_nbs_legal_entity, gc_nbs_nonfin_entity) and p_flag = 1)
                           )
                  where a.dazs is null
                        and a.kf = p_kf
                  order by a.nbs
               )
      loop
         c.new_nls := redefine_nls(c.acc, c.nls, c.new_nls, c.new_nbs, c.kf);

         if c.new_nls is null then
            bars_audit.info(l_trace||'Рахунок не підібрано. KF='||c.kf||', ACC='||c.acc||', NLS='||c.nls);
         else
            begin
               insert into TRANSFORM_2017_FORECAST  values (c.kf, c.kv, c.acc, c.nbs, c.nls, c.ob22, c.new_nbs, c.new_ob22, c.new_nls, sysdate, c.rnk);
            exception
               when dup_val_on_index then
                    update transform_2017_forecast
                    set nbs =  c.nbs
                        , ob22 = c.ob22
                        , new_nbs  = c.new_nbs
                        , new_ob22 = c.new_ob22
                        , new_nls  = c.new_nls
                        , insert_date = sysdate
                        , rnk = c.rnk
                        , kf = c.kf
                        , kv = c.kv
                    where acc = c.acc;
            end;
            l_acc_cnt := l_acc_cnt + 1;
         end if;

         if not tools.equals(c.nbs, l_nbs) and l_nbs is not null then
            commit;
            bars_audit.info(l_trace||'Оброблені рахунки по балансовому KF='||p_kf||', NSB='||l_nbs||', Всього рахунків ='||(l_acc_cnt-1));
            l_acc_cnt := 0;
         end if;
         l_nbs := c.nbs;
      end loop;
      bars_audit.info(l_trace||'Оброблені рахунки по балансовому KF='||p_kf||', NSB='||l_nbs||', Всього рахунків ='||l_acc_cnt);

      commit;

      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   --заполняем таблицу прогнозов физических лиц
   procedure fill_accounts_forecast(
                                      p_kf in accounts.kf%type
                                   )
   as
   begin
	  fill_accounts_forecast(p_kf, 0);
   end;

   --заполняем таблицу прогнозов юридических лиц
   procedure fill_accounts_forecast_le(
                                        p_kf in accounts.kf%type
                                      )
   as
   begin
	  fill_accounts_forecast(p_kf, 1);
   end;

   --заполняем таблицу прогнозов для Instant
   procedure fill_accounts_forecast_inst(
                                           p_kf     in accounts.kf%type
                                        )
   as
      l_trace varchar2(100) := 'ow_transform_acc.fill_accounts_forecast_inst: ';

      l_nbs   accounts.nbs%type;

      l_acc_cnt integer := 0;
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для KF='||p_kf);

      for c in (
                  select a.kf
                         , a.rnk
                         , a.kv
                         , a.acc
                         , a.nbs
                         , a.nls
                         , a.ob22
                         , nvl(r020_new, '2620') new_nbs
                         , t.ob_new new_ob22
                         , get_new_nls(a.kf, nvl(r020_new, '2620'), a.nls) new_nls
                  from accounts a
                  join w4_acc_instant i on a.acc = i.acc
                  left join transfer_2017 t on a.nbs = t.r020_old
                                               and a.ob22 = t.ob_old
                  where a.kf = p_kf
                        and regexp_like(a.nls, '^'||gc_nbs_person)
                  order by a.nbs
               )
      loop
         c.new_nls := redefine_nls(c.acc, c.nls, c.new_nls, c.new_nbs, c.kf);

         if c.new_nls is null then
            bars_audit.info(l_trace||'Рахунок не підібрано. KF='||c.kf||', ACC='||c.acc||', NLS='||c.nls);
         else
            begin
               insert into TRANSFORM_2017_FORECAST  values (c.kf, c.kv, c.acc, c.nbs, c.nls, c.ob22, null, c.new_ob22, c.new_nls, sysdate, c.rnk);
            exception
               when dup_val_on_index then
                    update transform_2017_forecast
                    set nbs =  c.nbs
                        , ob22 = c.ob22
                        , new_nbs  = null
                        , new_ob22 = c.new_ob22
                        , new_nls  = c.new_nls
                        , insert_date = sysdate
                        , rnk = c.rnk
                        , kf = c.kf
                        , kv = c.kv
                    where acc = c.acc;
            end;
            l_acc_cnt := l_acc_cnt + 1;
         end if;

         l_nbs := c.nbs;
      end loop;
      bars_audit.info(l_trace||'Оброблені рахунки по балансовому KF='||p_kf||', NBS=INSTANT, Всього рахунків ='||l_acc_cnt);

      commit;

      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   -- проверяем, выгружался ли ранее файл замены счетов 26_5 => 26_0
   function file_transfer_check(
	                              p_par    in ow_params.par%type
                                  , p_comm in ow_params.comm%type
	                           )
   return boolean
   as
      l_ret integer := 0;
   begin
	  begin
	     select val
         into l_ret
         from ow_params
         where par = p_par
               and kf = sys_context('bars_context','user_mfo');
      exception
		 when no_data_found then
			insert into ow_params(par, val, comm, kf)
            values(p_par, 0, p_comm, sys_context('bars_context','user_mfo'));
      end;
	  return (l_ret = 0);
   end;

   -- Установка признака формирования файла замены счетов
   procedure set_file_transfer(
	                             p_value in integer
	                             , p_par in ow_params.par%type
	                          )
   as
   begin
	  update ow_params w
      set w.val = p_value
      where w.par = p_par
            and kf = sys_context('bars_context','user_mfo');
   end;

   --формирование файла замены счетов 2625 => 2620 на основании таблицы прогноза замены
   procedure transfer_out_files(
                                  p_mode in number
                                  , p_filename out varchar2
                                  , p_filebody out clob
                                  , p_msg out varchar2
                               )
   is
      l_trace varchar2(100) := 'ow_transform_acc.transfer_out_files: ';
      l_clob_data    clob;
   begin

      bars_audit.info(l_trace || 'Start. KF='||sys_context('bars_context','user_mfo'));

      if file_transfer_check(gc_ow_par_ftrans_code, gc_ow_par_ftrans_comm) then
         p_filename := 'transfer_out_files_'||sys_context('bars_context','user_mfo')||'.csv';

         dbms_lob.createtemporary(l_clob_data,FALSE);

         for c in (
                     select p.val       BRANCH_CODE
                            , t.kv      CURRENCY
                            , t.nls     NUMBER_2625
                            , t.new_nls NUMBER_2620
                     from TRANSFORM_2017_FORECAST t
                     join ow_params p on p.kf = t.kf and p.par = 'W4_BRANCH'
                     where regexp_like(t.nls, '^'||gc_nbs_person)
                           and p.kf = sys_context('bars_context','user_mfo')
                  )
         loop
             dbms_lob.append(l_clob_data, c.branch_code||gc_delimiter
                          ||c.number_2625||gc_delimiter
                          ||c.number_2620||gc_delimiter
                          ||c.currency||
                          tools.crlf);

         end loop;
         if l_clob_data is null then
            raise_application_error(-20000, 'Відсутні дані для формування файлу');
	     end if;
         set_file_transfer(1, gc_ow_par_ftrans_code);
      else
         raise_application_error(-20000, 'Файл було згенеровано раніше. Для повторної генерації файла установіть флаг '||
                                   gc_ow_par_ftrans_comm||' ('||gc_ow_par_ftrans_code||')  в 0');
      end if;

      p_filebody := l_clob_data;

      bars_audit.info(l_trace || 'Finish. KF='||sys_context('bars_context','user_mfo'));

   end;

   -- формирование файла замены счетов 2625 => 2620 на после процедуры замены на основании таблицы счетов
   procedure transfer_w4_out_files(
                                     p_mode in number
                                     , p_filename out varchar2
                                     , p_filebody out clob
                                     , p_msg out varchar2
                                  )
   is
      l_trace varchar2(100) := 'ow_transform_acc.transfer_w4_out_files: ';
      l_clob_data    clob;
   begin

      bars_audit.info(l_trace || 'Start. KF='||sys_context('bars_context','user_mfo'));

      if file_transfer_check(gc_ow_par_ftrans_w4_code, gc_ow_par_ftrans_w4_comm) then
         p_filename := 'transfer_w4_out_files_'||sys_context('bars_context','user_mfo')||'.csv';

         dbms_lob.createtemporary(l_clob_data,FALSE);

         for c in (
                     select p.val      BRANCH_CODE
                            , t.kv     CURRENCY
                            , t.nlsalt NUMBER_2625
                            , t.nls    NUMBER_2620
                     from accounts t
                     join ow_params p on p.kf = t.kf and p.par = 'W4_BRANCH' and p.kf = sys_context('bars_context','user_mfo')
                     where t.dazs is null and t.nlsalt is not null
                           and t.dat_alt is not null
                           and regexp_like(t.nlsalt, '^'||gc_nbs_person)

                  )
         loop
            dbms_lob.append(l_clob_data, c.branch_code||gc_delimiter
                          ||c.number_2625||gc_delimiter
                          ||c.number_2620||gc_delimiter
                          ||c.currency||tools.crlf);
         end loop;
         if l_clob_data is null then
            raise_application_error(-20000, 'Відсутні дані для формування файлу');
	     end if;
         set_file_transfer(1, gc_ow_par_ftrans_w4_code);
      else
         raise_application_error(-20000, 'Файл було згенеровано раніше. Для повторної генерації файла установіть флаг '||
                                   gc_ow_par_ftrans_w4_comm||' ('||gc_ow_par_ftrans_w4_code||')  в 0');
      end if;

      p_filebody := l_clob_data;

      bars_audit.info(l_trace || 'Finish. KF='||sys_context('bars_context','user_mfo'));

   end;

   --формирование файла замены счетов 2605 => 2600 на основании таблицы прогноза замены
   procedure transfer_out_files_le(
                                     p_mode in number
                                     , p_filename out varchar2
                                     , p_filebody out clob
                                     , p_msg out varchar2
                                  )
   is
      l_trace varchar2(100) := 'ow_transform_acc.transfer_out_files_le: ';
      l_clob_data    clob;
   begin

      bars_audit.info(l_trace || 'Start. KF='||sys_context('bars_context','user_mfo'));

      if file_transfer_check(gc_ow_par_ftrans_code_le, gc_ow_par_ftrans_comm_le) then
         p_filename := 'transfer_out_files_le_'||sys_context('bars_context','user_mfo')||'.csv';

         dbms_lob.createtemporary(l_clob_data,FALSE);

         for c in (
                     select p.val       BRANCH_CODE
                            , t.kv      CURRENCY
                            , t.nls     NUMBER_2625
                            , t.new_nls NUMBER_2620
                     from TRANSFORM_2017_FORECAST t
                     join ow_params p on p.kf = t.kf and p.par = 'W4_BRANCH'
                     where regexp_like(t.nls, '^26[0,5]5')
                           and p.kf = sys_context('bars_context','user_mfo')
                  )
         loop
             dbms_lob.append(l_clob_data, c.branch_code||gc_delimiter
                          ||c.number_2625||gc_delimiter
                          ||c.number_2620||gc_delimiter
                          ||c.currency||
                          tools.crlf);

         end loop;
         if l_clob_data is null then
            raise_application_error(-20000, 'Відсутні дані для формування файлу');
	     end if;
         set_file_transfer(1, gc_ow_par_ftrans_code_le);
      else
         raise_application_error(-20000, 'Файл було згенеровано раніше. Для повторної генерації файла установіть флаг '||
                                   gc_ow_par_ftrans_comm_le||' ('||gc_ow_par_ftrans_code_le||')  в 0');
      end if;

      p_filebody := l_clob_data;

      bars_audit.info(l_trace || 'Finish. KF='||sys_context('bars_context','user_mfo'));

   end;

   -- формирование файла замены счетов 2605 => 2600 на после процедуры замены на основании таблицы счетов
   procedure transfer_w4_out_files_le(
                                        p_mode in number
                                        , p_filename out varchar2
                                        , p_filebody out clob
                                        , p_msg out varchar2
                                     )
   is
      l_trace varchar2(100) := 'ow_transform_acc.transfer_w4_out_files_le: ';
      l_clob_data    clob;
   begin

      bars_audit.info(l_trace || 'Start. KF='||sys_context('bars_context','user_mfo'));

      if file_transfer_check(gc_ow_par_ftrans_w4_code_le, gc_ow_par_ftrans_w4_comm_le) then
         p_filename := 'transfer_w4_out_files_le_'||sys_context('bars_context','user_mfo')||'.csv';

         dbms_lob.createtemporary(l_clob_data,FALSE);

         for c in (
                     select p.val      BRANCH_CODE
                            , t.kv     CURRENCY
                            , t.nlsalt NUMBER_2625
                            , t.nls    NUMBER_2620
                     from accounts t
                     join ow_params p on p.kf = t.kf and p.par = 'W4_BRANCH' and p.kf = sys_context('bars_context','user_mfo')
                     where t.dazs is null and t.nlsalt is not null
                           and t.dat_alt is not null
                           and regexp_like(t.nlsalt, '^26[0,5]5')

                  )
         loop
            dbms_lob.append(l_clob_data, c.branch_code||gc_delimiter
                          ||c.number_2625||gc_delimiter
                          ||c.number_2620||gc_delimiter
                          ||c.currency||tools.crlf);
         end loop;
         if l_clob_data is null then
            raise_application_error(-20000, 'Відсутні дані для формування файлу');
	     end if;
         set_file_transfer(1, gc_ow_par_ftrans_w4_code_le);
      else
         raise_application_error(-20000, 'Файл було згенеровано раніше. Для повторної генерації файла установіть флаг '||
                                   gc_ow_par_ftrans_w4_comm_le||' ('||gc_ow_par_ftrans_w4_code_le||')  в 0');
      end if;

      p_filebody := l_clob_data;

      bars_audit.info(l_trace || 'Finish. KF='||sys_context('bars_context','user_mfo'));

   end;

   --Выгрузка прогноза замены счетов для сателитных систем
   procedure forecast_upload(
                               p_flag in integer -- 0 - физицеские лица, 1 - юридические лица
                               , p_filename in out nocopy varchar2
                               , p_filebody in out nocopy clob
                            )
   is
      l_trace        varchar2(100) := 'ow_transform_acc.forecast_upload: ';
      l_delimiter    char(1) := '|';
      l_clob_data    clob;
   begin

      bars_audit.info(l_trace || 'Start. KF='||sys_context('bars_context','user_mfo'));

      p_filename := 'forecast_upload_'||(case p_flag when 1 then 'le_' else '' end)||sys_context('bars_context','user_mfo')||'.csv';

      dbms_lob.createtemporary(l_clob_data,FALSE);

      for c in (
                  select KF
                         , RNK
                         , KV
                         , ACC
                         , NBS
                         , NLS
                         , OB22
                         , NEW_NBS
                         , NEW_OB22
                         , NEW_NLS
                         , INSERT_DATE
                 from v_transform_forecast t
                 where (t.nbs in ( gc_nbs_person) and p_flag = 0)
                       or (t.nbs in ( gc_nbs_legal_entity, gc_nbs_nonfin_entity) and p_flag = 1)
               )
      loop
          dbms_lob.append(l_clob_data, c.KF||l_delimiter
                          ||c.rnk||l_delimiter
                          ||c.kv||l_delimiter
                          ||c.acc||l_delimiter
                          ||c.nbs||l_delimiter
                          ||c.nls||l_delimiter
                          ||c.ob22||l_delimiter
                          ||c.NEW_NBS||l_delimiter
                          ||c.NEW_ob22||l_delimiter
                          ||c.new_nls||l_delimiter
                          ||to_char(c.insert_date, 'dd.mm.yyyy HH24:MI:SS')||tools.crlf);

      end loop;
      if l_clob_data is null then
         raise_application_error(-20000, 'Відсутні дані для формування файлу');
	  end if;

      p_filebody := l_clob_data;

      bars_audit.info(l_trace || 'Finish. KF='||sys_context('bars_context','user_mfo'));

   end;

   procedure forecast_upload(
                               p_filename   out varchar2
                               , p_filebody out clob
                            )
   as
   begin
	  forecast_upload( 0, p_filename, p_filebody);
   end;

   procedure forecast_upload_le(
                                  p_filename   out varchar2
                                  , p_filebody out clob
                               )
   as
   begin
	  forecast_upload( 1, p_filename, p_filebody);
   end;

   -- замена номеров счетов для физических лиц
   function accounts_transform(
                                 p_dt   in transfer_2017%rowtype
                                 , p_kf in accounts.kf%type
                              )
   return integer
   as
      l_trace varchar2(100) := 'ow_transform_acc.accounts_transform: ';

      l_count integer := 0;
      l_try   integer := 0;

   begin
      for c in (
                  select a.*
                         , a.nls     nls_old
                         , a.nbs     nbs_old
                         , a.ob22    ob_old
                         , coalesce(t.new_nls, get_new_nls(a.kf, p_dt.r020_new, a.nls)) nls_new
                         , nvl(t.new_nbs, p_dt.r020_new) nbs_new
                         , nvl(t.new_ob22, p_dt.ob_new)  ob_new
                         , t.new_nls nls_new_forecast
                  from accounts a
                  left join transform_2017_forecast t on a.acc = t.acc
                  where a.dazs is null
                        and a.dat_alt is null
                        and a.kf = p_kf
                        and a.nbs = p_dt.r020_old
                        and a.ob22 = p_dt.ob_old
             )
      loop
         l_try := 0;
         while l_try < 100 loop
            begin
               update accounts
               set NLS       = c.nls_new
                   , nbs     = c.nbs_new
                   , ob22    = c.ob_new
                   , nlsalt  = c.Nls_Old
                   , nbs2    = c.nbs_old
                   , DAT_ALT = gc_bnk_dt
               where acc = c.ACC;

               l_try := 100;
            exception
               when DUP_VAL_ON_INDEX then
				    -- что-то вдруг пошло не так, генерируем новый номер счета и повторяем попытку (и так 100 раз)
                    c.nls_new := get_new_nls(p_kf => p_kf, p_nbs => c.nbs_new , p_nls => c.nbs_new||'0'||trunc(dbms_random.value(100000000, 999999999)));
                    l_try := l_try + 1 ;
               when others then
                    l_try := 101;
            end;
         end loop;

         -- Если счет успешно подобран
         if l_try <= 100 then
            -- если прогнозный номер счета и реальный отличаются - обновляем в прогнозной таблице
            if not tools.equals(c.nls_new, c.nls_new_forecast) then
               begin
                  update transform_2017_forecast t
                  set t.new_nls = c.nls_new
                      , t.rnk   = c.rnk
                  where t.acc = c.ACC;
                  -- а если его нет - добавляем
                  if sql%rowcount = 0 then
                     insert into transform_2017_forecast
                     (
                        kf
                        , kv
                        , acc
                        , rnk
                        , nbs
                        , nls
                        , ob22
                        , new_nbs
                        , new_ob22
                        , new_nls
                        , insert_date
                     )
                     values
                     (
                        c.kv
                        , c.kv
                        , c.acc
                        , c.rnk
                        , c.nbs_old
                        , c.nls_old
                        , c.ob_old
                        , c.nbs_new
                        , c.ob_new
                        , c.nls_new
                        , trunc(sysdate)
                     );
   	              end if;
               end;
            end if;

			-- сохраняем старый OB22
            update SPECPARAM set OB22_alt = c.ob_old  where acc = c.ACC ;

            -- обновляем новый номер счета в депозитах
            update DPT_DEPOSIT t
            set t.nls_p = c.nls_new
            where t.rnk = c.rnk
                  and t.kv = c.kv
                  and t.mfo_p = c.kf
                  and t.nls_p = c.nls_old;

            update DPT_DEPOSIT t
            set t.nls_d = c.nls_new
            where t.rnk = c.rnk
                  and t.kv = c.kv
                  and t.mfo_d = c.kf
                  and t.nls_d = c.nls_old;

            -- обновляем новый номер счета регулярных платежах
            update sto_det t
            set nlsa = c.nls_new
            where nlsa = c.nls_old
                  and t.kf = c.kf
                  and t.kva = c.kv;

            update sto_det t
            set nlsb = c.nls_new
            where nlsb = c.nls_old
                  and t.mfob = c.kf
                  and t.kvb = c.kv;

            /*--- Журнал счетов
            delete from accounts_update where acc = c.acc and trunc(chgdate) = trunc(sysdate);

            ----- закрыть chgaction = 3
            INSERT INTO accounts_update
               (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
                chgdate , chgaction , doneby ,idupd  , effectdate, branch,ob22, globalbd,send_sms  )
            VALUES (c.acc   ,c.nls  ,c.nlsalt,c.kv    ,c.nbs_old   ,c.nbs2,c.daos  ,c.isp   ,c.nms   ,c.pap,
                 c.grp   ,c.sec  ,c.seci  ,c.seco  ,c.vid   ,c.tip , gc_bnk_dt,   -- дата закр
                 c.blkd  ,c.blkk  ,c.lim,   c.pos   ,c.accc ,c.tobo,c.mdate ,c.ostx  ,c.rnk ,c.kf    ,
                 sysdate      ,3,user_name ,bars_sqnc.get_nextval('s_accounts_update',c.kf), gc_bnk_dt, c.branch, c.ob22 ,
                 ow_transform_acc.gc_bnk_dt, c.send_sms);

            ----- открыть chgaction = 1
            INSERT INTO accounts_update
               (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
                chgdate , chgaction , doneby,idupd  , effectdate, branch,ob22,globalbd,send_sms  )
            VALUES (c.acc  ,c.nls_new  ,c.nls ,c.kv ,c.nbs_new,c.nbs_old, gc_bnk_dt,-- дата откр
                    c.isp  ,c.nms  ,c.pap ,c.grp,c.sec ,c.seci, c.seco,c.vid  ,c.tip ,  -- yjdsq nbg cx
                    c.dazs ,c.blkd ,c.blkk,c.lim, c.pos,c.accc,c.tobo ,c.mdate,c.ostx,c.rnk ,c.kf   ,
                    sysdate     ,1,user_name ,bars_sqnc.get_nextval('s_accounts_update',c.kf), gc_bnk_dt, c.branch, c.ob_new ,
                    gc_bnk_dt, c.send_sms   );

            -- Update  chgaction = 2 Воccтановить для ХД дату открытия = дате открытия из accounts c.DAOS
            INSERT INTO   accounts_update
               (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
                 chgdate , chgaction , doneby,idupd  , effectdate, branch,ob22,globalbd,send_sms  )
            VALUES (c.acc  ,c.nls_new  ,c.nls ,c.kv ,c.nbs_new, c.nbs2, c.DAOS ,-- дата откр
                    c.isp  ,c.nms  ,c.pap ,c.grp,c.sec ,c.seci, c.seco,c.vid  ,c.tip ,  -- yjdsq nbg cx
                    c.dazs ,c.blkd ,c.blkk,c.lim, c.pos,c.accc,c.tobo ,c.mdate, c.ostx,c.rnk ,c.kf   ,
                    sysdate     ,2,user_name ,bars_sqnc.get_nextval('s_accounts_update',c.kf), gc_bnk_dt, c.branch, c.ob_new,
                    gc_bnk_dt, c.send_sms);*/

            -- коммитим каждые 1000 счетов
            if MOD(l_count,1000) = 0 then
			   commit;
            end if;

            l_count := l_count + 1;

         else
            bars_audit.info(l_trace||'Для рахунку NLS='||c.nls_old||' не підібрано новий номер рахунку');
         end if;
      end loop;

     return l_count;
   end;

   -- Замена в шаблонах начисления процентов на остаток по счету
   procedure account_interest_transform(p_kf in accounts.kf%type)
   is
      l_trace varchar2(100) := 'ow_transform_acc.account_interest_transform: ';
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для='||p_kf);

      for j in (
                  select  i.rowid, i.mfob, i.nlsb, i.kvb, a.nls, i.id
                  from bars.int_accn i
                  join bars.accounts a on i.mfob = a.kf and i.nlsb = a.nlsalt and i.kvb = a.kv
                  where i.mfob = p_kf
                        and a.nlsalt like gc_nbs_person||'%'
               )
      loop
         update bars.int_accn set nlsb = j.nls where rowid = j.rowid;
      end loop;

      commit;
      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   -- замена номеров счетов для физ лиц
   procedure transforms(
                          p_kf in accounts.kf%type
                       )
   as
      l_trace varchar2(100) := 'ow_transform_acc.transforms: ';
      l_count integer := 0;
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для='||p_kf);

      for c in (
                  select td.*
                  from transfer_2017 td
                  where td.dat_beg = gc_date_transform
                        and td.r020_old = gc_nbs_person --only person
               )
      loop
         bars_audit.info(l_trace||'Старт для KF='||p_kf||' R020_OLD='||c.r020_old||' OB_OLD='||c.ob_old);

         l_count := accounts_transform(c, p_kf);

         bars_audit.info(l_trace||'Завершення для KF='||p_kf||' R020_OLD='||c.r020_old||' OB_OLD='||c.ob_old||'. Оброблено рахунків '||l_count);

         update TRANSFER_2017
         set dat_end = gc_bnk_dt
             , col = nvl(l_count,0)
         where r020_old     = c.r020_old
               and ob_old   = c.ob_old
               and r020_new = c.r020_new
               and ob_old   = c.ob_new
               ;
         commit;
      end loop;

      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   -- замена номеров счетов для физических лиц
   function accounts_transform_le(
                                    p_dt   in transfer_2017%rowtype
                                    , p_kf in accounts.kf%type
                                 )
   return integer
   as
      l_trace varchar2(100) := 'ow_transform_acc.accounts_transform_le: ';

      l_count integer := 0;
      l_try   integer := 0;

      l_customer customer%rowtype;

      l_nkd  specparam.nkd%type;

   begin
      for c in (
                  select a.*
                         , a.nls     nls_old
                         , a.nbs     nbs_old
                         , a.ob22    ob_old
                         , coalesce(t.new_nls, get_new_nls(a.kf, p_dt.r020_new, a.nls)) nls_new
                         , nvl(t.new_nbs, p_dt.r020_new) nbs_new
                         , nvl(t.new_ob22, p_dt.ob_new)  ob_new
                         , t.new_nls nls_new_forecast
                         , null acc_new
                  from accounts a
                  left join transform_2017_forecast t on a.acc = t.acc
                  where a.dazs is null
                        and a.kf = p_kf
                        and a.nbs = p_dt.r020_old
                        and a.ob22 = p_dt.ob_old
             )
      loop
		 if check_nls_open(c.nls_old, c.kv) then
            l_try := 0;
            while l_try < 100 loop
               begin
	              -- открываем счет
                  accreg.OPN_ACC(
                                   p_acc      => c.acc_new
                                   , p_rnk    => c.rnk
                                   , p_nbs    => c.nbs_new
                                   , p_ob22   => c.ob_new
                                   , p_nls    => c.nls_new
                                   , p_nms    => c.nms
                                   , p_kv     => c.kv
                                   , p_isp    => c.isp
                                   , p_nlsalt => c.nls_old
                                   , p_pap    => 2 --c.pap
                                   , p_tip    => c.tip
                                   , p_pos    => c.pos
                                   , p_vid    => c.vid
                                   , p_branch => c.branch
                                   , p_ostx   => c.ostx
                                   , p_blkd   => to_number(getglobaloption('DPA_BLK')) -- Блокируем дебетовые обороты
                                   , p_blkk   => 99 -- Блокируем кредитовые обороты
                                   , p_mode   => 99
                                );
                  l_try := 100;
               exception
                  when others then
                       bars_audit.info(l_trace||'Error open account: Error Code - '||sqlcode||' Error Message - '||sqlerrm);

		               if sqlcode = -20666 then -- accreg.OPN_ACC генерирует ошибку ORA-20666
                          -- что-то вдруг пошло не так при открытии счета, генерируем новый номер счета и повторяем попытку (и так 100 раз)
                          c.nls_new := get_new_nls(p_kf => p_kf, p_nbs => c.nbs_new , p_nls => c.nbs_new||'0'||trunc(dbms_random.value(100000000, 999999999)));
                          l_try := l_try + 1 ;
                       else
                          l_try := 101;
                       end if;
               end;
            end loop;

            -- Если счет успешно подобран
            if l_try <= 100 then
               -- если прогнозный номер счета и реальный отличаются - обновляем в прогнозной таблице
               if not tools.equals(c.nls_new, c.nls_new_forecast) then
                  begin
                     update transform_2017_forecast t
                     set t.new_nls = c.nls_new
                         , t.rnk   = c.rnk
                     where t.acc = c.ACC;
                     -- а если его нет - добавляем
                     if sql%rowcount = 0 then
                        insert into transform_2017_forecast
                        (
                           kf
                           , kv
                           , acc
                           , rnk
                           , nbs
                           , nls
                           , ob22
                           , new_nbs
                           , new_ob22
                           , new_nls
                           , insert_date
                        )
                        values
                        (
                           c.kv
                           , c.kv
                           , c.acc
                           , c.rnk
                           , c.nbs_old
                           , c.nls_old
                           , c.ob_old
                           , c.nbs_new
                           , c.ob_new
                           , c.nls_new
                           , trunc(sysdate)
                        );
      	              end if;
                  end;
               end if;

               -- обновляем параметры нового счета
               begin
                  update accounts
                  set nbs2      = c.nbs_old
                      , DAT_ALT = gc_bnk_dt
                      , send_sms = c.send_sms
                  where acc = c.Acc_New;
               exception
                  when others then
                       bars_audit.info(l_trace||'Error Update Account Parameters: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
               end;

               -- Устанавливаем дополнительные параметры
               begin
                  accreg.setAccountSParam(c.Acc_New, 'R011', '1');
                  accreg.setAccountSParam(c.Acc_New, 'R013', '9');
                  accreg.setAccountSParam(c.Acc_New, 'S180', '1');
                  accreg.setAccountSParam(c.Acc_New, 'S240', '1');
                  begin
					 select sp.nkd
                     into l_nkd
                     from specparam sp
                     where sp.acc = c.acc;
                  exception
                     when others then
                          l_nkd := null;
                  end;
                  accreg.setAccountSParam(c.Acc_New, 'NKD', l_nkd);
               exception
                  when others then
                       bars_audit.info(l_trace||'Error Set Account Spec Parameters: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
               end;


      			-- сохраняем старый OB22
               begin
                  update SPECPARAM set OB22_alt = c.ob_old where acc = c.Acc_New ;
               exception
			      when others then
                       bars_audit.info(l_trace||'Error Update Account SpecParameters OB22_alt: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
               end;

               l_customer := customer_utl.read_customer(c.rnk);
               l_customer.nmk := nvl(l_customer.nmkk,substr(l_customer.nmk,1,38));

               If NVL( c.vid,0) <> 0 then  -- DPA отсылаем данные о новом счете в ДПА

                  -- Кто-то в обход триггера уже что-то вставляет в ree_tmp по счету с признаком OT = 1
                  -- пробуем это исправить
                  update ree_tmp r
                  set r.ot = '6'
                      , r.odat = gc_bnk_dt
                  where r.mfo = c.kf
                        and r.nls = c.Nls_New
                        and r.kv = c.kv;

                  if sql%rowcount = 0 then
					 -- Нам никто не помог?! Уррра-а-а. Добавим сами
                     begin
                        Insert into ree_tmp(mfo,    id_a,     rt, ot,        nls,     odat,        kv,    c_ag,   nmk,   nmkw,   c_reg,    c_dst, prz)
                        select c.kf, l_customer.Okpo, l_customer.tgr,'6', c.Nls_New, gc_bnk_dt, c.KV, G.rezid, l_customer.nmk, l_customer.nmk, l_customer.c_reg, l_customer.c_dst, 1
                        from codcagent G
                        where codcagent = l_customer.codcagent
                              and exists (select 1 from DPA_NBS where nbs = c.nbs_new and TYPE='DPA' and TAXOTYPE=1) ;
                     exception
                        when others then
                             bars_audit.info(l_trace||'Error Insert DPA Message: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
                     end;
                  end if;
               end if ; -- DPA

               begin
                  INSERT INTO accounts_update
                     (
                       acc
                       , nls
                       , nlsalt
                       , kv
                       , nbs
                       , nbs2
                       , daos
                       , isp
                       , nms
                       , pap
                       , grp
                       , sec
                       , seci
                       , seco
                       , vid
                       , tip
                       , dazs
                       , blkd
                       , blkk
                       , lim
                       , pos
                       , accc
                       , tobo
                       , mdate
                       , ostx
                       , rnk
                       , kf
                       , chgdate
                       , chgaction
                       , doneby
                       , idupd
                       , effectdate
                       , branch
                       , ob22
                       , globalbd
                       , send_sms
                     )
                  select a.acc
                         , a.nls
                         , a.nlsalt
                         , a.kv
                         , a.nbs
                         , a.nbs2
                         , gc_bnk_dt
                         , a.isp
                         , a.nms
                         , a.pap
                         , a.grp
                         , a.sec
                         , a.seci
                         , a.seco
                         , a.vid
                         , a.tip
                         , a.dazs
                         , a.blkd
                         , a.blkk
                         , a.lim
                         , a.pos
                         , a.accc
                         , a.tobo
                         , a.mdate
                         , a.ostx
                         , a.rnk
                         , a.kf
                         , sysdate
                         , 1
                         , user_name
                         , bars_sqnc.get_nextval('s_accounts_update', a.kf)
                         , gc_bnk_dt
                         , a.branch
                         , a.ob22
                         , gc_bnk_dt
                         , a.send_sms
                  from accounts a
                  where a.acc = c.Acc_New;
               exception
   			      when others then
                       bars_audit.info(l_trace||'Error Insert ACCOUNTS_UPDATE: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
               end;

                -- коммитим каждые 1000 счетов
               if MOD(l_count,1000) = 0 then
	              commit;
               end if;

               l_count := l_count + 1;

            else
               bars_audit.info(l_trace||'Для рахунку NLS='||c.nls_old||' не підібрано новий номер рахунку');
            end if;
         else
            bars_audit.info(l_trace||'Для рахунку NLS='||c.nls_old||' вже виконано трансформацію');
         end if;
      end loop;

     return l_count;
   end;

   -- Замена в шаблонах начисления процентов на остаток по счету
   procedure account_interest_transform_le(p_kf in accounts.kf%type)
   is
      l_trace varchar2(100) := 'ow_transform_acc.account_interest_transform_le: ';
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для='||p_kf);

      for j in (
                  select  i.rowid, i.mfob, i.nlsb, i.kvb, a.nls, i.id
                  from bars.int_accn i
                  join bars.accounts a on i.mfob = a.kf and i.nlsb = a.nlsalt and i.kvb = a.kv
                  where i.mfob = p_kf
                        and (
                               a.nlsalt like gc_nbs_legal_entity||'%'
                               or a.nlsalt like gc_nbs_nonfin_entity||'%'
                            )

               )
      loop
         update bars.int_accn set nlsb = j.nls where rowid = j.rowid;
      end loop;

      commit;
      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   -- замена номеров счетов для юридических лиц лиц
   procedure transforms_le(
                             p_kf in accounts.kf%type
                          )
   as
      l_trace varchar2(100) := 'ow_transform_acc.transforms_le: ';
      l_count integer := 0;
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для='||p_kf);

      for c in (
                  select td.*
                  from transfer_2017 td
                  where td.dat_beg = gc_date_transform
                        and td.r020_old in ( gc_nbs_legal_entity,  gc_nbs_nonfin_entity)
               )
      loop
         bars_audit.info(l_trace||'Старт для KF='||p_kf||' R020_OLD='||c.r020_old||' OB_OLD='||c.ob_old);

         l_count := accounts_transform_le(c, p_kf);

         bars_audit.info(l_trace||'Завершення для KF='||p_kf||' R020_OLD='||c.r020_old||' OB_OLD='||c.ob_old||'. Оброблено рахунків '||l_count);

         update TRANSFER_2017
         set dat_end = gc_bnk_dt
             , col = nvl(l_count,0)
         where r020_old     = c.r020_old
               and ob_old   = c.ob_old
               and r020_new = c.r020_new
               and ob_new   = c.ob_new
               ;
         commit;
      end loop;

      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   -- замена номеров счетов для физических лиц INSTANT
   procedure transforms_instant(
                                  p_kf in accounts.kf%type
                               )
   as
      l_trace varchar2(100) := 'ow_transform_acc.transforms_instant: ';
      l_count integer := 0;
      l_try   integer := 0;
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для='||p_kf);

      for c in (
                  select a.*
                         , a.nbs     nbs_old
                         , a.ob22    ob_old
                         , a.nls     nls_old
                         , t.new_nbs nbs_new
                         , t.ob22    ob_new
                         , coalesce(t.new_nls, get_new_nls(a.kf, '2620', a.nls)) nls_new
                         , t.new_nls nls_new_forecast
                  from accounts a
                  join w4_acc_instant i on i.acc = a.acc
                  left join transform_2017_forecast t on a.acc = t.acc
                  where a.dat_alt is null
                        and a.kf = p_kf
                        and regexp_like(a.nls, '^'||gc_nbs_person)
             )
      loop
         l_try := 0;
         while l_try < 100 loop
            begin
               update accounts
               set NLS       = c.nls_new
                   , nlsalt  = c.Nls_Old
                   , DAT_ALT = gc_bnk_dt
               where acc = c.ACC;

               l_try := 100;
            exception
               when DUP_VAL_ON_INDEX then
				    -- что-то вдруг пошло не так, генерируем новый номер счета и повторяем попытку (и так 100 раз)
                    c.nls_new := get_new_nls(p_kf => p_kf, p_nbs => '2620' , p_nls => '26200'||trunc(dbms_random.value(100000000, 999999999)));
                    l_try := l_try + 1 ;
               when others then
                    l_try := 101;
            end;
         end loop;

         -- Если счет успешно подобран
         if l_try <= 100 then
            -- если прогнозный номер счета и реальный отличаются - обновляем в прогнозной таблице
            if not tools.equals(c.nls_new, c.nls_new_forecast) then
               begin
                  update transform_2017_forecast t
                  set t.new_nls = c.nls_new
                      , t.rnk   = c.rnk
                  where t.acc = c.ACC;
                  -- а если его нет - добавляем
                  if sql%rowcount = 0 then
                     insert into transform_2017_forecast
                     (
                        kf
                        , kv
                        , acc
                        , rnk
                        , nbs
                        , nls
                        , ob22
                        , new_nbs
                        , new_ob22
                        , new_nls
                        , insert_date
                     )
                     values
                     (
                        c.kv
                        , c.kv
                        , c.acc
                        , c.rnk
                        , c.nbs_old
                        , c.nls_old
                        , c.ob_old
                        , c.nbs_new
                        , c.ob_new
                        , c.nls_new
                        , trunc(sysdate)
                     );
   	              end if;
               end;
            end if;

            --- Журнал счетов
 /*           delete from accounts_update where acc = c.acc and trunc(chgdate) = trunc(sysdate);

            ----- закрыть chgaction = 3
            INSERT INTO accounts_update
               (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
                chgdate , chgaction , doneby ,idupd  , effectdate, branch,ob22, globalbd,send_sms  )
            VALUES (c.acc   ,c.nls  ,c.nlsalt,c.kv    ,c.nbs_old   ,c.nbs2,c.daos  ,c.isp   ,c.nms   ,c.pap,
                 c.grp   ,c.sec  ,c.seci  ,c.seco  ,c.vid   ,c.tip , gc_bnk_dt,   -- дата закр
                 c.blkd  ,c.blkk  ,c.lim,   c.pos   ,c.accc ,c.tobo,c.mdate ,c.ostx  ,c.rnk ,c.kf    ,
                 sysdate      ,3,user_name ,bars_sqnc.get_nextval('s_accounts_update',c.kf), gc_bnk_dt, c.branch, c.ob22 ,
                 ow_transform_acc.gc_bnk_dt, c.send_sms);

            ----- открыть chgaction = 1
            INSERT INTO accounts_update
               (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
                chgdate , chgaction , doneby,idupd  , effectdate, branch,ob22,globalbd,send_sms  )
            VALUES (c.acc  ,c.nls_new  ,c.nls ,c.kv ,c.nbs_new,c.nbs_old, gc_bnk_dt,-- дата откр
                    c.isp  ,c.nms  ,c.pap ,c.grp,c.sec ,c.seci, c.seco,c.vid  ,c.tip ,  -- yjdsq nbg cx
                    c.dazs ,c.blkd ,c.blkk,c.lim, c.pos,c.accc,c.tobo ,c.mdate,c.ostx,c.rnk ,c.kf   ,
                    sysdate     ,1,user_name ,bars_sqnc.get_nextval('s_accounts_update',c.kf), gc_bnk_dt, c.branch, c.ob_new ,
                    gc_bnk_dt, c.send_sms   );

            -- Update  chgaction = 2 Воccтановить для ХД дату открытия = дате открытия из accounts c.DAOS
            INSERT INTO   accounts_update
               (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
                 chgdate , chgaction , doneby,idupd  , effectdate, branch,ob22,globalbd,send_sms  )
            VALUES (c.acc  ,c.nls_new  ,c.nls ,c.kv ,c.nbs_new, c.nbs2, c.DAOS ,-- дата откр
                    c.isp  ,c.nms  ,c.pap ,c.grp,c.sec ,c.seci, c.seco,c.vid  ,c.tip ,  -- yjdsq nbg cx
                    c.dazs ,c.blkd ,c.blkk,c.lim, c.pos,c.accc,c.tobo ,c.mdate, c.ostx,c.rnk ,c.kf   ,
                    sysdate     ,2,user_name ,bars_sqnc.get_nextval('s_accounts_update',c.kf), gc_bnk_dt, c.branch, c.ob_new,
                    gc_bnk_dt, c.send_sms);
*/
            if MOD(l_count,1000) = 0 then
			   commit;
            end if;

            l_count := l_count + 1;

         else
            bars_audit.info(l_trace||'Для рахунку NLS='||c.nls_old||' не підібрано новий номер рахунку');
         end if;
      end loop;

      commit;

      bars_audit.info(l_trace||'Оброблені рахунки по балансовому KF='||p_kf||', NBS=INSTANT, Всього рахунків ='||l_count);
      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   procedure close_legal_entity(
                                  p_kf          in accounts.kf%type
                                  , p_bank_date in date default dat_next_u(gc_bnk_dt, 1)
                               )
   as
      l_trace varchar2(100) := 'ow_transform_acc.close_legal_entity: ';

      l_customer customer%rowtype;

      l_count integer := 0;

      l_purpouse oper.nazn%type;
      l_tt       oper.tt%type;
      l_ref      oper.ref%type;
   begin
      bc.go(p_kf);
      bars_audit.info(l_trace||'Старт для='||p_kf);

      for c in (
		          select a.*
                         , an.acc acc_new
                         , an.nls nls_new
                  from accounts a
                  join transform_2017_forecast t on t.acc = a.acc
                  join accounts an on an.kf = t.kf and an.nls = t.new_nls and an.kv = t.kv
                  where a.nbs in ( gc_nbs_legal_entity,  gc_nbs_nonfin_entity)
                        and a.dazs is null
                        and a.kf = p_kf
                        and an.daos <= trunc(sysdate) - 3
               )
      loop
         l_customer := customer_utl.read_customer(c.rnk);
         l_customer.nmk := nvl(l_customer.nmkk,substr(l_customer.nmk,1,38));

         begin
            update accounts a
            set a.blkd = 0         -- сримаем блокировку по дебиту со старого счета
                , a.blkk = 0         -- снимаем блокировку по кредиту со старого счета
            where acc = c.acc ;
         exception
            when others then
                 bars_audit.info(l_trace||'Error Crear Locks Old Account: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         begin
            update accounts a
            set a.blkd = 0         -- сримаем блокировку по дебиту с нового счета
                , a.blkk = 0       -- снимаем блокировку по кредиту с нового счета
            where acc = c.acc_new ;
         exception
            when others then
                 bars_audit.info(l_trace||'Error Crear Locks New Account: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         If NVL( c.vid,0) <> 0 then  -- DPA
            begin
               delete from ree_tmp where kv = c.KV and nls = c.NLs and mfo=c.kf ;
            exception
               when others then
                    bars_audit.info(l_trace||'Error Delete DPA Message: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
            end;

            begin
               Insert into ree_tmp ( mfo,    id_a,     rt, ot,        nls,     odat,        kv,    c_ag,   nmk,   nmkw,   c_reg,    c_dst, prz) --  cae?uoea
               select  c.kf, l_customer.Okpo, l_customer.tgr, '5', c.Nls, p_bank_date, c.KV, G.rezid, l_customer.nmk, l_customer.nmk, l_customer.c_reg, l_customer.c_dst, 1
               from codcagent G  where codcagent = l_customer.codcagent and exists (select 1 from DPA_NBS where nbs = c.nbs and TYPE='DPA' and TAXOTYPE=3) ;
            exception
               when others then
                    bars_audit.info(l_trace||'Error Insert DPA Message: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
            end;
         end if ; -- DPA

         begin
            delete from accounts_update where acc = c.acc and trunc(chgdate) = trunc(sysdate);
         exception
   		    when others then
                 bars_audit.info(l_trace||'Error Delete ACCOUNTS_UPDATE: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         begin
            INSERT INTO accounts_update
               (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
                chgdate , chgaction , doneby ,idupd  , effectdate, branch,ob22, globalbd, send_sms)
            VALUES (c.acc, c.nls, c.nlsalt, c.kv, c.nbs, c.nbs2, c.daos, c.isp, c.nms, c.pap,
                 c.grp, c.sec, c.seci, c.seco, c.vid, c.tip, p_bank_date,
                 c.blkd, c.blkk, c.lim, c.pos, c.accc, c.tobo, c.mdate, c.ostx, c.rnk, c.kf,
                 sysdate, 3, user_name, bars_sqnc.get_nextval('s_accounts_update',c.kf), gc_bnk_dt, c.branch, c.ob22 ,
                 ow_transform_acc.gc_bnk_dt, c.send_sms);
         exception
   		    when others then
                 bars_audit.info(l_trace||'Error Insert ACCOUNTS_UPDATE: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         begin
            update W4_ACC set acc_pk = c.acc_new where acc_pk = c.acc;
         exception
            when others then
                bars_audit.info(l_trace||'Error Update W4_ACC: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         begin
            update W4_ACC_INSTANT set acc = c.acc_new where acc = c.acc;
         exception
            when others then
                 bars_audit.info(l_trace||'Error Update W4_ACC_INSTANT: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         -- обновляем новый номер счета в депозитах
         begin
            update Dpu_Deal t
            set t.nls_p = c.nls_new
            where t.rnk = c.rnk
                  and t.mfo_p = c.kf
                  and t.nls_p = c.nls;
         exception
	        when others then
                 bars_audit.info(l_trace||'Error Update Dpu_Deal NLS_P Parameters: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         begin
            update Dpu_Deal t
            set t.nls_d = c.nls_new
            where t.rnk = c.rnk
                  and t.mfo_d = c.kf
                  and t.nls_d = c.nls;
         exception
            when others then
                 bars_audit.info(l_trace||'Error Update Dpu_Deal NLS_D Parameters: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         -- обновляем новый номер счета регулярных платежах
         begin
            update sto_det t
            set nlsa = c.nls_new
            where nlsa = c.nls
                  and t.kf = c.kf
                  and t.kva = c.kv;
         exception
		    when others then
                 bars_audit.info(l_trace||'Error Update STO_DET NLSA Parameters: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         begin
            update sto_det t
            set nlsb = c.nls_new
            where nlsb = c.nls
                  and t.mfob = c.kf
                  and t.kvb = c.kv;
         exception
      	    when others then
                 bars_audit.info(l_trace||'Error Update STO_DET NLSB Parameters: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         for cw in (
      	              select c.acc_new acc
                             , aw.tag
                             , aw.value
                             , aw.kf
                      from accountsw aw
                      where aw.acc = c.acc
                            /*and (
                                     aw.tag like 'LIE\_%' escape '\' -- аресты
                                     or aw.tag like 'W4%' -- Way4
                                     or aw.tag like 'PK\_%' escape '\' -- БПК
                                  )*/
                   )
         loop
	        begin
               insert into accountsw values cw;
            exception
		       when dup_val_on_index then null;
               when others then
                    bars_audit.info(l_trace||'Error Insert Into ACCOUNTSW: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
               end;
         end loop;

         /*-- Удаляем аресты по старому счету
         begin
			delete from accountsw aw
            where aw.acc = c.acc and aw.tag like 'LIE\_%' escape '\';
         exception
      	    when others then
                 bars_audit.info(l_trace||'Error Delete Arests Old Account: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;*/

         -- перенос графика событий
         begin
            insert into acc_sob
            (acc, isp, fdat, txt, kf)
            select c.acc_new, isp, fdat, txt, kf
            from acc_sob
            where acc = c.acc;
         exception
		    when others then
                 bars_audit.info(l_trace||'Error Transfer Schedule of Events: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         -- перенос остатка на новый счет
         if c.ostc <> 0 then
            begin
               l_purpouse := 'Перенесення залишку при зміні балансового номеру карткових рахунків';
               l_tt := case c.kv
                            when gl.BASEVAL then '101' -- для национальной
                            else '100'                 -- для другой
                       end;
               gl.ref(l_ref);
               gl.in_doc3(
                            ref_ => l_ref, tt_ => l_tt, nd_ => lpad(to_char(l_ref),  10, ' '), vob_=> 6, pdat_=>SYSDATE,
                            vdat_=> gc_bnk_dt, dk_ => case when c.ostc > 0 then 1 else 0 end,
                            kv_ => c.kv, s_ => abs(c.ostc), kv2_=> c.kv, s2_ => abs(c.ostc), sk_ => null,
                            data_=> gc_bnk_dt, datp_=> gc_bnk_dt,
                            nam_a_ => l_customer.nmk, nlsa_=> c.nls, mfoa_=> c.kf,
                            nam_b_ => l_customer.nmk, nlsB_=> c.nls_new, mfoB_=> c.kf,
                            nazn_ => l_purpouse, d_rec_ => null, id_a_ => l_customer.okpo, id_b_=> l_customer.okpo,
                            id_o_ => null, sign_ => null, sos_ => 1, prty_=> null, uid_=> null
                         );
               gl.payv(0, l_ref, gc_bnk_dt, l_tt, case when c.ostc > 0 then 1 else 0 end, c.kv, c.nls, abs(c.ostc), c.kv, c.nls_new, abs(c.ostc));
               gl.pay (2, l_ref, gc_bnk_dt);
            exception
		   	   when others then
                    bars_audit.info(l_trace||'Error Transform Rest: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
            end;
         end if;

         -- Устанавливаем блокировки старого счета на новый
         begin
            update accounts a
            set a.blkd = c.blkd
                , a.blkk = c.blkk
            where acc = c.acc_new ;
         exception
            when others then
                 bars_audit.info(l_trace||'Error Restore Locks New Account: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         begin
            update accounts a
            set a.dazs = p_bank_date -- закрываем старый счет следующим банковским днем
            where acc = c.acc ;
         exception
            when others then
                 bars_audit.info(l_trace||'Error Close Old Account: Error Code - '||sqlcode||' Error Message - '||sqlerrm);
         end;

         -- коммитим каждые 1000 счетов
         if MOD(l_count,1000) = 0 then
            commit;
         end if;

         l_count := l_count + 1;
      end loop;

      commit;

      bars_audit.info(l_trace||'Завершення для KF='||p_kf);
      bc.home();
   end;

   procedure set_trigger ( p_mode varchar2) IS
      l_trace varchar2(100) := 'ow_transform_acc.set_trigger: ';
   begin
	  begin
         execute immediate ' alter trigger TBU_ACCOUNTS_CHECKBLK ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBU_ACCOUNTS_CHECKBLK в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger tau_accounts_ATM ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера tau_accounts_ATM в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger tiu_acca ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера tiu_acca в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TBU_ACCOUNTS_DAOS ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBU_ACCOUNTS_DAOS в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      /*begin
         execute immediate ' alter trigger TU_SAL ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_SAL в режим '|| upper(p_mode)||' '||sqlerrm);
      end;*/

      begin
         execute immediate ' alter trigger TAIU_ACCOUNTS_OB22 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAIU_ACCOUNTS_OB22 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TBU_ACCOUNTS_TAX ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBU_ACCOUNTS_TAX в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TAI_ACCOUNTS_CP ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAI_ACCOUNTS_CP в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TAU_ACCOUNTS_CP_OSTC ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAU_ACCOUNTS_CP_OSTC в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_DPT_PAYMENTS ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_DPT_PAYMENTS в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_KOB1 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_KOB1 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      /*begin
         execute immediate ' alter trigger TIU_ACCOUNTS_BRANCH_TOBO ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_ACCOUNTS_BRANCH_TOBO в режим '|| upper(p_mode)||' '||sqlerrm);
      end;*/

      begin
         execute immediate ' alter trigger TIU_ACCOUNTS_NEWCASH ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_ACCOUNTS_NEWCASH в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TIU_BLKD11 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_BLKD11 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TAU_ACCOUNTS_OST67 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAU_ACCOUNTS_OST67 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TAU_OSTX_KPROLOG ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAU_OSTX_KPROLOG в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TBIU_ACCOUNTS_DESTRUCT_PASSP ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBIU_ACCOUNTS_DESTRUCT_PASSP в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      --execute immediate ' alter trigger TBI_ACCOUNTS_ALL ' || p_mode ;
      begin
         execute immediate ' alter trigger TBU_ACCOUNTS_1004 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBU_ACCOUNTS_1004 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_ACCOUNTS_GRP ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_ACCOUNTS_GRP в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_ACCOUNTS_RNK ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_ACCOUNTS_RNK в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      --execute immediate ' alter trigger TU_ACCOUNTS_SP ' || p_mode ;
      begin
         execute immediate ' alter trigger TU_ACCOUNT_OVERSOB ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_ACCOUNT_OVERSOB в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      --execute immediate ' alter trigger TAU_ACCOUNTS_NBU49 ' || p_mode ;
      /*begin
         execute immediate ' alter trigger TU_SAL_A ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_SAL_A в режим '|| upper(p_mode)||' '||sqlerrm);
      end;*/

      /*begin
         execute immediate ' alter trigger TU_SAL_R ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_SAL_R в режим '|| upper(p_mode)||' '||sqlerrm);
      end;*/

      begin
         execute immediate ' alter trigger TU_SBN ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_SBN в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TIU_TIP ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_TIP в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TIU_ZAPRET810 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_ZAPRET810 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TIU_POS ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_POS в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_9830 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_9830 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      /*begin
         execute immediate ' alter trigger TU_SAL_B ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_SAL_B в режим '|| upper(p_mode)||' '||sqlerrm);
      end;*/

      begin
         execute immediate ' alter trigger TIU_ACC ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_ACC в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TBU_ACCOUNTS_DAZS ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBU_ACCOUNTS_DAZS в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TBU_ACCOUNTS_KF ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBU_ACCOUNTS_KF в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      /*begin
         execute immediate ' alter trigger TAI_ACCOUNTS_TAX ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAI_ACCOUNTS_TAX в режим '|| upper(p_mode)||' '||sqlerrm);
      end;*/

      begin
         execute immediate ' alter trigger TAU_ACCOUNTS_NBU449 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAU_ACCOUNTS_NBU449 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_NLK ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_NLK в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TBIU_ACCOUNTS_OB22 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBIU_ACCOUNTS_OB22 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      --execute immediate ' alter trigger TIU_ZAPRET_26MFO ' || p_mode ;
      begin
         execute immediate ' alter trigger TIU_ACCOUNT67 ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_ACCOUNT67 в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TIU_ACCB ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TIU_ACCB в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TAU_ACCOUNTS_SMS ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAU_ACCOUNTS_SMS в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TAU_ACCOUNTS_OVER_LIM ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TAU_ACCOUNTS_OVER_LIM в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_SS_DEB ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_SS_DEB в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TBU_ACCOUNTS_XOZ ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TBU_ACCOUNTS_XOZ в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TU_DPTADD ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TU_DPTADD в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      begin
         execute immediate ' alter trigger TI_ACCOUNTS_RKO ' || p_mode ;
      exception
		 when others then
              bars_audit.info(l_trace||'Ошибка перевода триггера TI_ACCOUNTS_RKO в режим '|| upper(p_mode)||' '||sqlerrm);
      end;

      --execute immediate ' alter trigger TU_ACCOUNTS_RKO ' || p_mode ;
   end;

end ow_transform_acc;
/

show err;

PROMPT *** Create  grants  ***
grant EXECUTE on ow_transform_acc to BARS_ACCESS_DEFROLE;
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/ow_transform_acc  ====== *** End ***
PROMPT ===================================================================================== 
