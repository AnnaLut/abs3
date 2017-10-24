
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_files.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NBUR_FILES 
is

g_header_version  constant varchar2(64)  := 'version 3.1  2016.12.23';
g_header_defs     constant varchar2(512) := '';

-- header_version - версія заголовку пакета
function header_version return varchar2;

-- body_version - версія тіла пакета
function body_version return varchar2;

-- налаштування параметрів та підготовка даних для файлу
procedure p_proc_set
( p_kf           in     varchar2    -- код филиала
, p_file_code    in     varchar2    -- код файла НБУ
, p_scheme       in     varchar2    -- код схемы
, p_datz         in     date        -- звітна дата
, p_type_spr     in     number      -- джерело переліку БР
, p_file_spr     in     varchar2    -- код файлу для умови
, o_nbuc         out    varchar2
, o_type         out    number
);

-- ідентифікатор файлу
function f_get_id_file (p_kodf in varchar2,
                        p_sheme in varchar2,
                        p_type in number) return number;

--
-- код файлу по ідентифікатору файлу
--
function F_GET_KODF
( p_file_id       in     nbur_ref_files.id%type
) return nbur_ref_files.file_code%type;

--повертає версію файлу
function f_get_version_file (p_file_id    in number,
                               p_report_date  in date,
                               p_kf           in varchar2 )  return number;

--   фиксация старта процесса формирования отчетного файла в списке сформированных файлов
function f_start_form_file (
               p_userid        in number,
               p_version_id    in number,
               p_file_id       in number,
               p_report_date   in date,
               p_kf            in varchar2,
               p_start_time    in timestamp )  return number;

--
--   фиксация окончания процесса формирования отчетного файла в списке сформированных файлов
--
function f_finish_form_file (p_version_id    in number,
                             p_file_id       in number,
                             p_report_date   in date,
                             p_kf            in varchar2,
                             p_status        in varchar2 default 'FINISHED')  return number;

-- інвалідація файлу
procedure p_set_invalid_file (p_file_id       in number,
                              p_report_date   in date,
                              p_kf            in varchar2,
                              p_version_id    in number);

-- створення нового файлу
function f_ins_new_file (p_kodf in varchar2,
                         p_sheme in varchar2,
                         p_type in number) return number;

-- вставка нового файлу для філії
function f_ins_new_file_kf (p_kodf in varchar2,
                            p_sheme in varchar2,
                            p_type in number,
                            p_kf in number) return number;

-- повертає статуу файлу версії
function f_get_files_status(p_report_date   in date,
                            p_kf            in varchar2,
                            p_version_id    in number,
                            p_file_id       in number) return varchar2;

-- оновлення статусу  версії
procedure p_update_files_status(p_report_date   in date,
                                p_kf            in varchar2,
                                p_version_id    in number,
                                p_file_id       in number,
                                p_status        in varchar2);

--блокування формування файлу
procedure p_block_file (p_report_date   in  date,
                       p_kf             in  varchar2,
                       p_version_id     in  number,
                       p_file_id        in  number,
                       p_status_code    out varchar2,
                       p_status_mes     out varchar2);

-- отримання назви  сформуваного файлу
function f_get_file_name (p_report_date  in date,
                          p_kf           in varchar2,
                          p_version_id   in number,
                          p_file_code    in varchar2,
                          p_scheme_code  in varchar2) return varchar2;

-- отримання сформуваного файлу (clob)
function f_get_file_clob (p_report_date  in date,
                          p_kf           in varchar2,
                          p_version_id   in number,
                          p_file_code    in varchar2,
                          p_scheme_code  in varchar2) return clob;

  -- отримання дати
  function f_get_date
  ( p_report_date  in date
  , p_type         in number
  ) return date;

  --------------------------------------------------------------------------------------------------
  -- service procedures
  --------------------------------------------------------------------------------------------------

  --
  -- SET_FILE
  --
  procedure SET_FILE
  ( p_file_id             out nbur_ref_files.id%type
  , p_file_code        in     nbur_ref_files.file_code%type
  , p_scm_code         in     nbur_ref_files.scheme_code%type
  , p_file_tp          in     nbur_ref_files.file_type%type default 1
  , p_file_nm          in     nbur_ref_files.file_name%type
  , p_file_fmt         in     nbur_ref_files.file_fmt%type default 'TXT'
  , p_scm_num          in     nbur_ref_files.scheme_number%type default '03'
  , p_unit_code        in     nbur_ref_files.unit_code%type default '21'
  , p_period_tp        in     nbur_ref_files.period_type%type
  , p_location_code    in     nbur_ref_files.location_code%type default '1'
  , p_file_code_alt    in     nbur_ref_files.file_code_alt%type default null
  , p_cnsl_tp          in     nbur_ref_files.consolidation_type%type
  , p_val_tp_ind       in     nbur_ref_files.value_type_ind%type default 'N'
  , p_view_nm          in     nbur_ref_files.view_nm%type default null
  , p_f_turns          in     nbur_ref_files.flag_turns%type default 0
  );

  --
  --
  --
  procedure SET_FILE_LOCAL
  ( p_kf               in     nbur_ref_files_local.kf%type
  , p_file_id          in     nbur_ref_files_local.file_id%type
  , p_file_path        in     nbur_ref_files_local.file_path%type
  , p_nbuc             in     nbur_ref_files_local.nbuc%type
  , p_e_address        in     nbur_ref_files_local.e_address%type
  );

  --
  --
  --
  procedure SET_FILE_PROC
  ( p_proc_id     in out nbur_ref_procs.id%type
  , p_file_id     in     nbur_ref_procs.file_id%type
  , p_proc_type   in     nbur_ref_procs.proc_type%type default 'F'
  , p_proc_active in     nbur_ref_procs.proc_active%type default 'Y'
  , p_scheme      in     nbur_ref_procs.scheme%type default 'BARS'
  , p_proc_name   in     nbur_ref_procs.proc_name%type
  , p_description in     nbur_ref_procs.description%type
  , p_version     in     nbur_ref_procs.version%type
  , p_date_start  in     nbur_ref_procs.date_start%type default null
  , p_date_finish in     nbur_ref_procs.date_finish%type default null
  );

  --
  -- File Structure
  --
  procedure SET_FILE_STC
  ( p_file_id          in     nbur_ref_form_stru.file_id%type
  , p_seg_num          in     nbur_ref_form_stru.segment_number%type
  , p_seg_nm           in     nbur_ref_form_stru.segment_name%type
  , p_seg_rule         in     nbur_ref_form_stru.segment_rule%type
  , p_key_attr         in     nbur_ref_form_stru.key_attribute%type
  , p_sort_attr        in     nbur_ref_form_stru.sort_attribute%type
  );

  --
  -- create view that represent file structure
  --
  procedure SET_FILE_VIEW
  ( p_file_id          in     nbur_ref_files.id%type
  );

  --
  -- create dependencies
  --
  procedure SET_FILE_DEPENDENCIES
  ( p_file_id          in     nbur_lnk_files_objects.file_id%type
  , p_obj_id           in     nbur_lnk_files_objects.object_id%type
  , p_strt_dt          in     nbur_lnk_files_objects.start_date%type
  );

  procedure SET_FILE_DEPENDENCIES
  ( p_file_code        in     nbur_ref_files.file_code%type
  , p_obj_id           in     nbur_lnk_files_objects.object_id%type
  , p_strt_dt          in     nbur_lnk_files_objects.start_date%type
  );

end NBUR_FILES;
/
CREATE OR REPLACE PACKAGE BODY BARS.NBUR_FILES 
is

  g_body_version  constant varchar2(64)  := 'version 5.8  2017.03.15';
  g_body_defs     constant varchar2(512) := '';

  MODULE_PREFIX   constant varchar2(10)  := 'NBUR';

-- header_version - верс_я заголовку пакета
function header_version return varchar2
is
begin
  return 'Package header NBUR_FILES ' || g_header_version || '.' || chr(10) ||
         'Package header definition(s): ' || chr(10) ||  g_header_defs;
end header_version;

-- body_version - верс_я т_ла пакета
function body_version return varchar2
is
begin
  return 'Package body NBUR_FILES ' || g_body_version || '.' || chr(10) ||
         'Package body definition(s): ' || chr(10) || g_body_defs;
end body_version;

procedure p_errors_log( p_add_mess in varchar2 := null )
is
  title      constant   varchar2(60) := $$PLSQL_UNIT||': ';
begin
  bars_audit.error( title || p_add_mess || CHR(10) || sqlerrm || CHR(10) || dbms_utility.format_error_backtrace() );
end p_errors_log;

-- налаштування параметрів та підготовка даних для файлу
procedure p_proc_set
( p_kf           in     varchar2    -- код филиала
, p_file_code    in     varchar2    -- код файла НБУ
, p_scheme       in     varchar2    -- код схемы
, p_datz         in     date        -- звітна дата
, p_type_spr     in     number      -- джерело переліку БР
, p_file_spr     in     varchar2    -- код файлу для умови
, o_nbuc         out    varchar2
, o_type         out    number
)
is
begin
    begin
        -- вибір параметрів для даного файлу
        select l.nbuc, nvl(f.consolidation_type,0)
        into o_nbuc, o_type
        from nbur_ref_files f,
             nbur_ref_files_local l
        where f.file_code = p_file_code
          and f.scheme_code = p_scheme
          and f.id = l.file_id
          and l.kf = p_kf;
    exception
       when no_data_found then
            o_nbuc := 'C';
            o_type := 0;
    end;

    -- для Крима та Київобласті формуємо обласний розріз навіть для схеми С
    -- для інших - для схеми С формуємо консолідований файл із o_nbuc в заголовку
    if p_scheme = 'C' and
       o_type = '4' and
       p_kf not in ('324805', '322669')
    then
       o_type := '0';
    end if;

    -- наповнення таблиці переліком БР дял формування файлу
    execute immediate 'truncate table nbur_tmp_kod_r020';

    if p_type_spr = 1 then
        insert into nbur_tmp_kod_r020
        select r020
        from kod_r020
        where a010 = p_file_spr
          and trim(prem) = 'КБ'
          and d_open between to_date ('01011997', 'ddmmyyyy') and p_datz
          and (d_close is null or
               d_close > p_datz);
    elsif p_type_spr = 2 then
        execute immediate 'insert into nbur_tmp_kod_r020
                           select r020
                           from sb_r020
                           where F_'||p_file_spr||' = ''1''
                              and d_open between to_date (''01011997'', ''ddmmyyyy'') and :p_datz
                              and (d_close is null or
                                   d_close > :p_datz) '
        using p_datz, p_datz;
    elsif p_type_spr = 3 then
        insert into nbur_tmp_kod_r020
        select r020
        from kl_f3_29
        where kf = p_file_spr;
    elsif p_type_spr = 4 then
        insert into nbur_tmp_kod_r020
        select r020
        from kl_f3_29_int
        where kf = p_file_spr;
    elsif p_type_spr = 5 then -- для файлу #20
        insert into nbur_tmp_kod_r020
        select distinct r020
        from kl_f20
        where kf='20';
    end if;
exception
    when others then
        p_errors_log('for KODF='||p_file_code||' KF='||p_kf);
end p_proc_set;

-- _дентиф_катор файлу
function f_get_id_file (p_kodf in varchar2,
                        p_sheme in varchar2,
                        p_type in number) return number is
   l_id_file    number;
begin
   select id
   into l_id_file
     from NBUR_REF_FILES
    where file_code = p_kodf
      and scheme_code = p_sheme
      and file_type = p_type;

    return l_id_file;
end f_get_id_file;

--
-- код файлу по ідентиф_катору файлу
--
function F_GET_KODF
( p_file_id       in     nbur_ref_files.id%type
) return nbur_ref_files.file_code%type
is
  l_file_code            nbur_ref_files.file_code%type;
begin

  begin
    select f.FILE_CODE
      into l_file_code
      from NBUR_REF_FILES f
     where f.ID = p_file_id;
  exception
    when NO_DATA_FOUND then
      l_file_code := null;
  end;

  return l_file_code;

end F_GET_KODF;

function f_get_version_file (p_file_id    in number,
                             p_report_date  in date,
                             p_kf           in varchar2 )  return number
is
    l_version_id       number;
begin
    begin
        select max(version_id)
        into l_version_id
        from nbur_lst_files
        where file_id = p_file_id and
              report_date = p_report_date and
              kf = p_kf and
              file_status in ('VALID', 'FINISHED');
    exception
        when no_data_found  then
            select max(version_id)
            into l_version_id
            from nbur_lst_files
            where file_id = p_file_id and
                  report_date = p_report_date and
                  kf = p_kf and
                  file_status not in ('RUNNING', 'STOPPED');
    end;

    return l_version_id;
exception
    when no_data_found  then
         p_errors_log('not found VERSION for '||p_file_id);
         return -1;
end f_get_version_file;

--   фиксация старта процесса формирования отчетного файла в списке сформированных файлов
function f_start_form_file (p_userid        in number,
                            p_version_id    in number,
                            p_file_id       in number,
                            p_report_date   in date,
                            p_kf            in varchar2,
                            p_start_time    in timestamp )  return number
is
    l_filename      varchar2(100);
    l_empty_string  clob := lpad(' ', 100, ' ');
    l_file_hash     nbur_lst_files.file_hash%type;
begin
   l_filename := nbur_forms.f_createfilename(p_file_id, p_report_date, p_kf, p_version_id);

   l_file_hash := SYS.DBMS_CRYPTO.Hash(l_empty_string, SYS.DBMS_CRYPTO.HASH_SH1);

   insert into NBUR_LST_FILES (report_date, kf, version_id, file_id, file_name,
         file_body, file_hash, file_status, start_time, finish_time, user_id)
   values (p_report_date, p_kf, p_version_id, p_file_id, l_filename,
         l_empty_string, l_file_hash, 'RUNNING', p_start_time, null, p_userid);

   return 0;
exception
   when others then
        p_errors_log('START_FORM_FILE error: '||sqlerrm||' '||
            sys_context('bars_context','user_mfo')||' '||user_id);
        return -1;
end f_start_form_file;

--   фиксация окончания процесса формирования отчетного файла в списке сформированных файлов
function f_finish_form_file
( p_version_id     in     number,
  p_file_id        in     number,
  p_report_date    in     date,
  p_kf             in     varchar2,
  p_status         in     varchar2 default 'FINISHED'
) return number
is
  l_file_body      clob;
  l_file_hash      nbur_lst_files.file_hash%type;
begin
  l_file_body := nbur_forms.f_createfilebody (p_file_id, p_report_date, p_kf, p_version_id);

  l_file_hash := SYS.DBMS_CRYPTO.Hash(l_file_body, SYS.DBMS_CRYPTO.HASH_SH1 );

  update NBUR_LST_FILES
     set finish_time = systimestamp,
         file_status = p_status,
         file_body = l_file_body,
         file_hash = l_file_hash
   where report_date  = p_report_date
     and kf = p_kf
     and version_id = p_version_id
     and file_id = p_file_id;

  return 0;

exception
  when others then
    p_errors_log('FINISH_FORM_FILE error: '||sqlerrm );
    return -1;
end f_finish_form_file;

-- _нвал_дац_я файлу
procedure p_set_invalid_file (p_file_id       in number,
                              p_report_date   in date,
                              p_kf            in varchar2,
                              p_version_id    in number)
is
    l_version_id   number := p_version_id;
begin
    if l_version_id is null then
       l_version_id := f_get_version_file(p_file_id, p_report_date, p_kf);
    end if;

    update NBUR_LST_FILES f
    set f.file_status = 'INVALID'
    where f.file_id = p_file_id and
          f.version_id = l_version_id and
          f.report_date = p_report_date and
          f.kf = p_kf;
end p_set_invalid_file;

-- створення нового файлу
function f_ins_new_file (p_kodf in varchar2,
                         p_sheme in varchar2,
                         p_type in number) return number is
begin

    return 0;
end f_ins_new_file;

-- вставка нового файлу для ф_л_ї
function f_ins_new_file_kf (p_kodf in varchar2,
                            p_sheme in varchar2,
                            p_type in number,
                            p_kf in number) return number is
begin

    return 0;
end f_ins_new_file_kf;

-- повертає статуу файлу версії
function f_get_files_status(p_report_date   in date,
                            p_kf            in varchar2,
                            p_version_id    in number,
                            p_file_id       in number) return varchar2
is
    l_status varchar2(20);
begin
    select file_status
    into l_status
    from NBUR_LST_FILES
    where report_date = p_report_date
       and kf = p_kf
       and FILE_ID = p_file_id
       and version_id = p_version_id;

    return l_status;
exception
    when no_data_found then
        return null;
end;

-- оновлення статусу  версії
procedure p_update_files_status(p_report_date   in date,
                                p_kf            in varchar2,
                                p_version_id    in number,
                                p_file_id       in number,
                                p_status        in varchar2)
is
begin
    if p_file_id is not null then -- оновлення статусу по одному файлу
        update NBUR_LST_FILES
           set file_status = p_status
         where report_date = p_report_date
           and kf = p_kf
           and FILE_ID = p_file_id
           and version_id = p_version_id;
    else -- по всіх файлах даної версії
        update NBUR_LST_FILES
           set file_status = p_status
         where report_date = p_report_date
           and kf = p_kf
           and version_id = p_version_id;
    end if;

end p_update_files_status;

--блокування формування файлу
procedure p_block_file (p_report_date   in  date,
                       p_kf             in  varchar2,
                       p_version_id     in  number,
                       p_file_id        in  number,
                       p_status_code    out varchar2,
                       p_status_mes     out varchar2)
is
    l_status varchar2(20);
begin
--    l_status := f_get_files_status(p_report_date, p_kf, p_version_id, p_file_id);
--
--    if l_status = 'BLOCKED' then
--       p_status_code := 'BLOCKED';
--       p_status_mes := 'Файл було заблоковано раніше';
--       return;
--    end if;
--
--    -- вставляємо в таблицю заблокованих
--    insert into NBUR_LST_BLC_FILES
--        (report_date, kf, version_id, file_id, blocked_time, user_name)
--    values
--        (p_report_date, p_kf, p_version_id, p_file_id, systimestamp, user_name);
--
--    -- проставляємо статус заблоковано для файлу
--    p_update_files_status(p_report_date, p_kf, p_version_id, p_file_id, 'BLOCKED');
--
--    -- проставляємо статус заблоковано для залежних від файлу обєктів
--    for k in (select o.object_id
--              from NBUR_LNK_FILES_OBJECTS o
--              where o.file_id = p_file_id and
--                   (o.start_date <= p_report_date and
--                    o.finish_date is null or
--                    o.finish_date > p_report_date))
--    loop
--        nbur_objects.block_version(p_report_date, p_kf, k.object_id, p_version_id);
--    end loop;

    p_status_code := 'OK';
    p_status_mes := 'Файл успішно заблоковано';
exception
    when others then
        p_status_code := 'ERROR';
        p_status_mes := 'При блокуванні виникла помилка! Зверніться до адміністратора!';
        p_errors_log('Помилка при блокуванні');
end p_block_file;

-- отримання назви  сформуваного файлу
function f_get_file_name (p_report_date  in date,
                          p_kf           in varchar2,
                          p_version_id   in number,
                          p_file_code    in varchar2,
                          p_scheme_code  in varchar2) return varchar2
is
    l_file_name     varchar2(20);
begin
    select f.FILE_NAME
    into l_file_name
    from NBUR_LST_FILES f, NBUR_REF_FILES r
    where  f.report_date = p_report_date
       and f.kf = p_kf
       and f.version_id = p_version_id
       and f.file_id = r.id
       and r.file_code = p_file_code
       and r.scheme_code = p_scheme_code;

    return l_file_name;
end f_get_file_name;

-- отримання сформуваного файлу (clob)
function f_get_file_clob (p_report_date  in date,
                          p_kf           in varchar2,
                          p_version_id   in number,
                          p_file_code    in varchar2,
                          p_scheme_code  in varchar2) return clob
is
    l_file_clob     clob;
begin
    select f.FILE_BODY
    into l_file_clob
    from NBUR_LST_FILES f, NBUR_REF_FILES r
    where  f.report_date = p_report_date
       and f.kf = p_kf
       and f.version_id = p_version_id
       and f.file_id = r.id
       and r.file_code = p_file_code
       and r.scheme_code = p_scheme_code;

    return l_file_clob;
end f_get_file_clob;

-- отримання дати
function f_get_date (p_report_date  in date,
                     p_type         in number) return date
is
    l_dc            number;
    l_ret_date      date;
begin
    if p_type = 1 then -- декада
       l_dc := TO_NUMBER(LTRIM(TO_CHAR(p_report_date,'DD'),'0'));

       FOR i IN 1..3
       LOOP
          IF l_dc BETWEEN 10*(i-1)+1 AND 10*(i-1)+10+Iif(i,3,0,1,0) THEN
             l_ret_date:=TO_DATE(LPAD(10*(i-1)+1,2,'0')||
                                 TO_CHAR(p_report_date,'mmyyyy'),'ddmmyyyy');
             EXIT;
          END IF;
       END LOOP;
    elsif p_type = 2 then -- місяць
       l_ret_date := trunc(p_report_date,'mm');
    else
       l_ret_date := p_report_date;
    end if;

    if nbur_calendar.f_is_holiday(l_ret_date) then
       l_ret_date := nbur_calendar.f_get_next_bank_date(l_ret_date, 1);
    end if;

    return l_ret_date;
end;

  --------------------------------------------------------------------------------------------------
  -- service procedures
  --------------------------------------------------------------------------------------------------

  --
  -- SET_FILE
  --
  procedure SET_FILE
  ( p_file_id             out nbur_ref_files.id%type
  , p_file_code        in     nbur_ref_files.file_code%type
  , p_scm_code         in     nbur_ref_files.scheme_code%type
  , p_file_tp          in     nbur_ref_files.file_type%type default 1
  , p_file_nm          in     nbur_ref_files.file_name%type
  , p_file_fmt         in     nbur_ref_files.file_fmt%type default 'TXT'
  , p_scm_num          in     nbur_ref_files.scheme_number%type default '03'
  , p_unit_code        in     nbur_ref_files.unit_code%type default '21'
  , p_period_tp        in     nbur_ref_files.period_type%type
  , p_location_code    in     nbur_ref_files.location_code%type default '1'
  , p_file_code_alt    in     nbur_ref_files.file_code_alt%type default null
  , p_cnsl_tp          in     nbur_ref_files.consolidation_type%type
  , p_val_tp_ind       in     nbur_ref_files.value_type_ind%type default 'N'
  , p_view_nm          in     nbur_ref_files.view_nm%type default null
  , p_f_turns          in     nbur_ref_files.flag_turns%type default 0
  ) is
    l_view_nm                 nbur_ref_files.view_nm%type;
  begin

    if ( p_view_nm Is Null )
    then
      l_view_nm := 'V_'||p_file_code;
    else
      l_view_nm := p_view_nm;
    end if;

    begin
      Insert into BARS.NBUR_REF_FILES
        ( FILE_CODE, SCHEME_CODE, FILE_TYPE, FILE_NAME, SCHEME_NUMBER, UNIT_CODE
        , PERIOD_TYPE, LOCATION_CODE, FILE_CODE_ALT, CONSOLIDATION_TYPE, VALUE_TYPE_IND
        , VIEW_NM, FLAG_TURNS, FILE_FMT )
      Values
        ( p_file_code, p_scm_code, p_file_tp, p_file_nm, p_scm_num, p_unit_code
        , p_period_tp, p_location_code, p_file_code_alt, p_cnsl_tp, p_val_tp_ind
        , l_view_nm, p_f_turns, p_file_fmt )
      returning ID
           into p_file_id;
    exception
      when DUP_VAL_ON_INDEX then
        update BARS.NBUR_REF_FILES
           set SCHEME_CODE        = p_scm_code
             , FILE_TYPE          = p_file_tp
             , FILE_NAME          = p_file_nm
             , SCHEME_NUMBER      = p_scm_num
             , UNIT_CODE          = p_unit_code
             , PERIOD_TYPE        = p_period_tp
             , LOCATION_CODE      = p_location_code
             , FILE_CODE_ALT      = p_file_code_alt
             , CONSOLIDATION_TYPE = p_cnsl_tp
             , VALUE_TYPE_IND     = p_val_tp_ind
             , VIEW_NM            = l_view_nm
             , FLAG_TURNS         = p_f_turns
             , FILE_FMT           = p_file_fmt
         where FILE_CODE = p_file_code
     returning ID
          into p_file_id;
    end;

  end SET_FILE;

  --
  --
  --
  procedure SET_FILE_LOCAL
  ( p_kf        in     nbur_ref_files_local.kf%type
  , p_file_id   in     nbur_ref_files_local.file_id%type
  , p_file_path in     nbur_ref_files_local.file_path%type
  , p_nbuc      in     nbur_ref_files_local.nbuc%type
  , p_e_address in     nbur_ref_files_local.e_address%type
  ) is
  begin

    begin
      Insert into BARS.NBUR_REF_FILES_LOCAL
        ( KF, FILE_ID, FILE_PATH, NBUC, E_ADDRESS )
      Values
        ( p_kf, p_file_id, p_file_path, p_nbuc, p_e_address );
    exception
      when DUP_VAL_ON_INDEX then
        update BARS.NBUR_REF_FILES_LOCAL
           set FILE_PATH = p_file_path
             , NBUC      = p_nbuc
             , E_ADDRESS = p_e_address
         where KF      = p_kf
           and FILE_ID = p_file_id;
    end;

  end SET_FILE_LOCAL;

  --
  --
  --
  procedure SET_FILE_PROC
  ( p_proc_id     in out nbur_ref_procs.id%type
  , p_file_id     in     nbur_ref_procs.file_id%type
  , p_proc_type   in     nbur_ref_procs.proc_type%type default 'F'
  , p_proc_active in     nbur_ref_procs.proc_active%type default 'Y'
  , p_scheme      in     nbur_ref_procs.scheme%type default 'BARS'
  , p_proc_name   in     nbur_ref_procs.proc_name%type
  , p_description in     nbur_ref_procs.description%type
  , p_version     in     nbur_ref_procs.version%type
  , p_date_start  in     nbur_ref_procs.date_start%type default null
  , p_date_finish in     nbur_ref_procs.date_finish%type default null
  ) is
  begin

    if ( p_proc_id is Null )
    then

      select nvl(max(ID)+1,1)
        into p_proc_id
        from BARS.NBUR_REF_PROCS
      ;

      begin
        Insert into BARS.NBUR_REF_PROCS
          ( ID, FILE_ID, PROC_TYPE, PROC_ACTIVE, SCHEME, PROC_NAME
          , DESCRIPTION, VERSION, DATE_START, DATE_FINISH )
        Values
          ( p_proc_id, p_file_id, p_proc_type, p_proc_active, p_scheme, p_proc_name
          , p_description, p_version, p_date_start, p_date_finish );
      exception
        when DUP_VAL_ON_INDEX then -- constraint UK_NBURREFPROCS_PROCNAME
          update BARS.NBUR_REF_PROCS
             set FILE_ID     = p_file_id
               , PROC_TYPE   = p_proc_type
               , PROC_ACTIVE = p_proc_active
               , SCHEME      = p_scheme
               , DESCRIPTION = p_description
               , VERSION     = p_version
               , DATE_START  = p_date_start
               , DATE_FINISH = p_date_finish
           where PROC_NAME   = p_proc_name
       returning ID
            into p_proc_id;
      end;

    else

      update BARS.NBUR_REF_PROCS
         set FILE_ID     = p_file_id
           , PROC_TYPE   = p_proc_type
           , PROC_ACTIVE = p_proc_active
           , SCHEME      = p_scheme
           , PROC_NAME   = p_proc_name
           , DESCRIPTION = p_description
           , VERSION     = p_version
           , DATE_START  = p_date_start
           , DATE_FINISH = p_date_finish
       where ID = p_proc_id;

    end if;

  end SET_FILE_PROC;

  --
  -- File Structure
  --
  procedure SET_FILE_STC
  ( p_file_id    in     nbur_ref_form_stru.file_id%type
  , p_seg_num    in     nbur_ref_form_stru.segment_number%type
  , p_seg_nm     in     nbur_ref_form_stru.segment_name%type
  , p_seg_rule   in     nbur_ref_form_stru.segment_rule%type
  , p_key_attr   in     nbur_ref_form_stru.key_attribute%type
  , p_sort_attr  in     nbur_ref_form_stru.sort_attribute%type
  ) is
  begin

    begin
      Insert into BARS.NBUR_REF_FORM_STRU
        ( FILE_ID, SEGMENT_NUMBER, SEGMENT_NAME, SEGMENT_RULE, KEY_ATTRIBUTE, SORT_ATTRIBUTE )
      Values
        ( p_file_id, p_seg_num, p_seg_nm, p_seg_rule, p_key_attr, p_sort_attr );
    exception
      when DUP_VAL_ON_INDEX then
        update BARS.NBUR_REF_FORM_STRU
           set SEGMENT_NAME   = p_seg_nm
             , SEGMENT_RULE   = p_seg_rule
             , KEY_ATTRIBUTE  = p_key_attr
             , SORT_ATTRIBUTE = p_sort_attr
         where FILE_ID        = p_file_id
           and SEGMENT_NUMBER = p_seg_num;
    end;

  end SET_FILE_STC;

  --
  -- create view that represent file structure
  --
  procedure SET_FILE_VIEW
  ( p_file_id          in     nbur_ref_files.id%type
  ) is
  /**
  <b>SET_FILE_VIEW</b> - Create view that represent file structure
  %param p_file_id -

  %version 1.3
  %usage
  */
    title          constant   varchar2(64) := $$PLSQL_UNIT||'.SET_FILE_VIEW';
    l_view_nm                 nbur_ref_files.view_nm%type;
    l_file_code               nbur_ref_files.file_code%type;
    l_file_name               nbur_ref_files.file_name%type;
    l_field_lst               varchar2(4096);
    l_view_stmt               varchar2(16384);
    l_cmnt_stmt               dbms_utility.lname_array; -- 4000
  begin

    bars_audit.trace( '%s: Entry with ( p_file_id=%s ).', title, to_char(p_file_id) );

    select f.VIEW_NM, f.FILE_CODE, f.FILE_NAME
      into l_view_nm, l_file_code, l_file_name
      from BARS.NBUR_REF_FILES f
     where ID = p_file_id
       and FILE_FMT = 'TXT';

    if ( l_view_nm Is Null )
    then

      l_view_nm := 'V_NBUR_'|| case when l_file_code like '#__'
                                    then l_file_code
                                    else 'OBU_' || SubStr(l_file_code, 2, 2 )
                               end;

      update BARS.NBUR_REF_FILES
         set VIEW_NM = l_view_nm
       where ID = p_file_id;

    end if;

    for c in
    ( select nvl(SEGMENT_CODE,'SEG_'||to_char(SEGMENT_NUMBER,'FM00')) as SEGMENT_CODE
           , SEGMENT_NAME
           , upper(SEGMENT_RULE) as SEGMENT_RULE
        from BARS.NBUR_REF_FORM_STRU
       where FILE_ID = p_file_id
         and KEY_ATTRIBUTE = 1
       order by SEGMENT_NUMBER
    ) loop

      l_field_lst := l_field_lst||'     , '||replace( c.SEGMENT_RULE, 'KODP', 'p.FIELD_CODE' )||' as '||c.SEGMENT_CODE||chr(10);

      If ( c.SEGMENT_NAME Is Not Null )
      then
        l_cmnt_stmt(l_cmnt_stmt.count+1) := '.'||c.SEGMENT_CODE||' is ' ||DBMS_ASSERT.ENQUOTE_LITERAL(translate(c.SEGMENT_NAME,'~''',' '));
      end if;

    end loop;

    --
    -- AGG_PROTOCOLS
    --

    -- view
    l_view_stmt := 'create or replace view BARS.'||l_view_nm||chr(10);
    l_view_stmt := l_view_stmt || 'as'                      ||chr(10);
    l_view_stmt := l_view_stmt || 'select p.REPORT_DATE'    ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.KF'             ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.VERSION_ID'     ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.NBUC'           ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.FIELD_CODE'     ||chr(10);
    l_view_stmt := l_view_stmt || l_field_lst;
    l_view_stmt := l_view_stmt || '     , p.FIELD_VALUE'                      ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.ERROR_MSG'                        ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.ADJ_IND'                          ||chr(10);
    l_view_stmt := l_view_stmt || '  from NBUR_AGG_PROTOCOLS_ARCH p'          ||chr(10);
    l_view_stmt := l_view_stmt || '  join NBUR_REF_FILES f'                   ||chr(10);
    l_view_stmt := l_view_stmt || '    on ( f.FILE_CODE = p.REPORT_CODE )'    ||chr(10);
    l_view_stmt := l_view_stmt || '  join NBUR_LST_FILES v'                   ||chr(10);
    l_view_stmt := l_view_stmt || '    on ( v.REPORT_DATE = p.REPORT_DATE and'||chr(10);
    l_view_stmt := l_view_stmt || '         v.KF          = p.KF          and'||chr(10);
    l_view_stmt := l_view_stmt || '         v.VERSION_ID  = p.VERSION_ID  and'||chr(10);
    l_view_stmt := l_view_stmt || '         v.FILE_ID     = f.ID )           '||chr(10);
    l_view_stmt := l_view_stmt || ' where p.REPORT_CODE = '|| DBMS_ASSERT.ENQUOTE_LITERAL( l_file_code )||chr(10);
    l_view_stmt := l_view_stmt || q'[   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )]';

    -- comments
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.REPORT_DATE is ' || q'['Звітна дата']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.KF          is ' || q'['Код фiлiалу (МФО)']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.VERSION_ID  is ' || q'['Ід. версії файлу']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.NBUC        is ' || q'['Код розрізу даних у звітному файлі']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.FIELD_CODE  is ' || q'['Код показника']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.FIELD_VALUE is ' || q'['Значення показника']';

    begin
      execute immediate l_view_stmt;
      execute immediate 'comment on table BARS.'||l_view_nm||' is ' || DBMS_ASSERT.ENQUOTE_LITERAL( l_file_code ||' - '|| l_file_name );
      execute immediate 'grant select on BARS.' ||l_view_nm||' to BARS_ACCESS_DEFROLE';
    exception
      when others then
        bars_audit.info(  title ||': '||chr(10)|| l_view_stmt );
        bars_audit.error( title ||': '||chr(10)|| dbms_utility.format_error_stack() );
    end;

    for i in l_cmnt_stmt.first..l_cmnt_stmt.last
    loop
      begin
        execute immediate 'comment on column BARS.'|| l_view_nm || l_cmnt_stmt(i);
      exception
        when others then
          bars_audit.info(  title ||': '||chr(10)|| l_cmnt_stmt(i) );
          bars_audit.error( title ||': '||chr(10)|| dbms_utility.format_error_stack() );
      end;
    end loop;

    --
    -- NBUR_DETAIL_PROTOCOLS_ARCH
    --

    l_view_nm   := l_view_nm||'_DTL';

    -- view
    l_view_stmt := 'create or replace view BARS.'||l_view_nm||chr(10);
    l_view_stmt := l_view_stmt || 'as'                      ||chr(10);
    l_view_stmt := l_view_stmt || 'select p.REPORT_DATE'    ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.KF'             ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.VERSION_ID'     ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.NBUC'           ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.FIELD_CODE'     ||chr(10);
    l_view_stmt := l_view_stmt || l_field_lst;
    l_view_stmt := l_view_stmt || '     , p.FIELD_VALUE'    ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.DESCRIPTION'    ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.ACC_ID'         ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.ACC_NUM'        ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.KV'             ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.MATURITY_DATE'  ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.CUST_ID'        ||chr(10);
    l_view_stmt := l_view_stmt || '     , c.CUST_CODE'      ||chr(10);
    l_view_stmt := l_view_stmt || '     , c.CUST_NAME'      ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.ND'             ||chr(10);
    l_view_stmt := l_view_stmt || '     , a.AGRM_NUM'       ||chr(10);
    l_view_stmt := l_view_stmt || '     , a.BEG_DT'         ||chr(10);
    l_view_stmt := l_view_stmt || '     , a.END_DT'         ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.REF'            ||chr(10);
    l_view_stmt := l_view_stmt || '     , p.BRANCH'         ||chr(10);
    l_view_stmt := l_view_stmt || '  from NBUR_DETAIL_PROTOCOLS_ARCH p'       ||chr(10);
    l_view_stmt := l_view_stmt || '  join NBUR_REF_FILES f'                   ||chr(10);
    l_view_stmt := l_view_stmt || '    on ( f.FILE_CODE = p.REPORT_CODE )'    ||chr(10);
    l_view_stmt := l_view_stmt || '  join NBUR_LST_FILES v'                   ||chr(10);
    l_view_stmt := l_view_stmt || '    on ( v.REPORT_DATE = p.REPORT_DATE and'||chr(10);
    l_view_stmt := l_view_stmt || '         v.KF          = p.KF          and'||chr(10);
    l_view_stmt := l_view_stmt || '         v.VERSION_ID  = p.VERSION_ID  and'||chr(10);
    l_view_stmt := l_view_stmt || '         v.FILE_ID     = f.ID )           '||chr(10);
    l_view_stmt := l_view_stmt || '  left outer'                              ||chr(10);
    l_view_stmt := l_view_stmt || '  join V_NBUR_DM_CUSTOMERS c'              ||chr(10);
    l_view_stmt := l_view_stmt || '    on ( p.REPORT_DATE = c.REPORT_DATE and'||chr(10);
    l_view_stmt := l_view_stmt || '         p.KF          = c.KF          and'||chr(10);
--  l_view_stmt := l_view_stmt || '         p.VERSION_ID = C.VERSION_ID   and'||chr(10);
    l_view_stmt := l_view_stmt || '         p.CUST_ID    = c.CUST_ID )'       ||chr(10);
    l_view_stmt := l_view_stmt || '  left outer'                              ||chr(10);
    l_view_stmt := l_view_stmt || '  join V_NBUR_DM_AGREEMENTS a'             ||chr(10);
    l_view_stmt := l_view_stmt || '    on ( p.REPORT_DATE = a.REPORT_DATE and'||chr(10);
    l_view_stmt := l_view_stmt || '         p.KF          = a.KF          and'||chr(10);
--  l_view_stmt := l_view_stmt || '         p.VERSION_ID  = a.VERSION_ID  and'||chr(10);
    l_view_stmt := l_view_stmt || '         p.nd          = a.AGRM_ID )'      ||chr(10);
    l_view_stmt := l_view_stmt || ' where p.REPORT_CODE = '|| DBMS_ASSERT.ENQUOTE_LITERAL( l_file_code )||chr(10);
    l_view_stmt := l_view_stmt || q'[   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )]';

    -- comments
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.DESCRIPTION   is ' || q'['Опис (коментар)']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.ACC_ID        is ' || q'['Ід. рахунка']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.ACC_NUM       is ' || q'['Номер рахунка']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.KV            is ' || q'['Ід. валюти']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.MATURITY_DATE is ' || q'['Дата Погашення']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.CUST_ID       is ' || q'['Ід. клієнта']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.CUST_CODE     is ' || q'['Код клієнта']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.CUST_NAME     is ' || q'['Назва клієнта']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.REF           is ' || q'['Ід. платіжного документа']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.ND            is ' || q'['Ід. договору']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.AGRM_NUM      is ' || q'['Номер договору']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.BEG_DT        is ' || q'['Дата початку договору']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.END_DT        is ' || q'['Дата закінчення договору']';
    l_cmnt_stmt(l_cmnt_stmt.count+1) := '.BRANCH        is ' || q'['Код підрозділу']';

    begin
      execute immediate l_view_stmt;
      execute immediate 'comment on table BARS.'||l_view_nm||' is ' || DBMS_ASSERT.ENQUOTE_LITERAL( 'Детальний протокол файлу ' || l_file_code );
      execute immediate 'grant select on BARS.' ||l_view_nm||' to BARS_ACCESS_DEFROLE';
    exception
      when others then
        bars_audit.info(  title ||': '||chr(10)|| l_view_stmt );
        bars_audit.error( title ||': '||chr(10)|| dbms_utility.format_error_stack() );
    end;

    for i in l_cmnt_stmt.first..l_cmnt_stmt.last
    loop
      begin
        execute immediate 'comment on column BARS.'|| l_view_nm || l_cmnt_stmt(i);
      exception
        when others then
          bars_audit.info(  title ||': '||chr(10)|| l_cmnt_stmt(i) );
          bars_audit.error( title ||': '||chr(10)|| dbms_utility.format_error_stack() );
      end;
    end loop;

    bars_audit.trace( '%s: Exit.', title );

  exception
    when NO_DATA_FOUND then
      bars_audit.trace( '%s: Exit with error: file with id=%s has different type than TXT.', title, to_char(p_file_id) );
  end SET_FILE_VIEW;

  --
  -- create dependencies
  --
  procedure SET_FILE_DEPENDENCIES
  ( p_file_id          in     nbur_lnk_files_objects.file_id%type
  , p_obj_id           in     nbur_lnk_files_objects.object_id%type
  , p_strt_dt          in     nbur_lnk_files_objects.start_date%type
  ) is
    title        constant     varchar2(60)  := $$PLSQL_UNIT||'.SET_FILE_DPND';
  begin

    bars_audit.trace( '%s: Entry with ( file_id=%s, obj_id=%s ).'
                    , title, to_char(p_file_id), to_char(p_obj_id) );

    if ( p_obj_id Is Null )
    then -- видадення усіх залежностей для файлу

      delete BARS.NBUR_LNK_FILES_OBJECTS
       where FILE_ID = p_file_id;

      bars_audit.info( title || ': deleted new dependency for file #' || to_char(p_file_id) );

    else -- внесення нової залежності для файлу

      begin

        Insert
          into BARS.NBUR_LNK_FILES_OBJECTS
             ( FILE_ID, OBJECT_ID, START_DATE )
        Values
            ( p_file_id, p_obj_id, trunc(nvl(p_strt_dt,sysdate)) );

        bars_audit.info( title || ': added new dependency for file #' || to_char(p_file_id) );

      exception
        when DUP_VAL_ON_INDEX
        then null;
      end;

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SET_FILE_DEPENDENCIES;

  --
  -- create dependencies
  --
  procedure SET_FILE_DEPENDENCIES
  ( p_file_code        in     nbur_ref_files.file_code%type
  , p_obj_id           in     nbur_lnk_files_objects.object_id%type
  , p_strt_dt          in     nbur_lnk_files_objects.start_date%type
    ) is
    title        constant     varchar2(60) := $$PLSQL_UNIT||'.SET_FILE_DPND';
    l_file_id                 nbur_ref_files.id%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_file_code=%s, obj_id=%s ).'
                    , title, p_file_code, to_char(p_obj_id) );

    case
      when ( p_file_code is Null )
      then
       raise_application_error( -20666, 'Value for parameter [p_file_code] must be specified!', true );
      when ( length( p_file_code ) != 3 )
      then
        raise_application_error( -20666, 'Value for parameter [p_file_code] must contain 3 chars!', true );
      else
        l_file_id := case SubStr(p_file_code,1,1)
                       when '#' then '1'
                       when '@' then '2'
                       else '0' end
                       || to_char(ASCII(SubStr(p_file_code,2,1)))
                       || to_char(ASCII(SubStr(p_file_code,3,1)));
    end case;

    SET_FILE_DEPENDENCIES
    ( p_file_id => l_file_id
    , p_obj_id  => p_obj_id
    , p_strt_dt => p_strt_dt
    );

    bars_audit.trace( '%s: Exit.', title );

  end SET_FILE_DEPENDENCIES;



begin
  null;
end NBUR_FILES;
/
 show err;
 
PROMPT *** Create  grants  NBUR_FILES ***
grant EXECUTE                                                                on NBUR_FILES      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBUR_FILES      to RPBN002;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nbur_files.sql =========*** End *** 
 PROMPT ===================================================================================== 
 