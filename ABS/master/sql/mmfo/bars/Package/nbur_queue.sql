
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_queue.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.NBUR_QUEUE
is

  g_header_version  constant varchar2(64)  := 'version 4.7  2017.08.19';
  g_header_defs     constant varchar2(512) := '';

  -- header_version - ����� ��������� ������
  function header_version return varchar2;

  -- body_version - ����� ��� ������
  function body_version return varchar2;

  -- ��������� ���������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
  function f_get_local_version(p_report_date in date, p_kf in varchar2) return number;

  -- ��������� ����������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
  function f_get_global_version(p_report_date in date,
                                p_kf in varchar2,
                                p_local_version_id in number:=null) return number;

  -- ��������� ����
  function f_create_version(p_report_date         in date,
                            p_kf                  in varchar2,
                            p_version_id          in number,
                            p_global_version_id   out number) return number;

  -- ��������� ������� ����
  procedure p_update_version(p_report_date    in date,
                             p_kf             in varchar2,
                             p_version_id     in number,
                             p_status         in varchar2,
                             p_type           in number default 1);

  -- ��������� ������� ������ ����������� ID
  procedure p_update_version(p_global_version_id in number,
                             p_status in varchar2);

  -- ��������� ������� �����  ���� ��������� �� ����� ��� �� KF
  procedure p_update_other_version(p_report_date in date,
                                   p_kf in varchar2,
                                   p_version_id in number,
                                   p_status in varchar2);

  -- ������� ����� � �����
  function f_put_queue_form (p_report_date in date,
                             p_file_code in varchar2,
                             p_scheme in varchar2,
                             p_type in number,
                             p_kf in varchar2,
                             p_status in number default 0) return varchar2;

  -- ������� ����� � �����
  function f_put_queue_form_by_id (p_file_id in number,
                                   p_bank_date in date,
                                   p_report_date in date,
                                   p_kf in varchar2,
                                   p_userid in number,
                                   p_status in number default 0) return number;

  -- ������� ��� ����� � �����
  function f_put_queue_all_forms (p_bank_date in date,
                                  p_report_date in date  default null,
                                  p_kf in varchar2 default null) return number;

  -- �������� ���������� ���������� ����� � ����� ��� ����� ������������ ������� ����������
  -- � ����� ������� ����� ����� �����, � � ���� ����� ����������� ����������� �����
  procedure p_repeat_put_forms;

  -- ������� ��� �������� ����� � �����
  function f_put_queue_dep_forms (p_bank_date in date,
                                  p_report_date in date,
                                  p_kf in varchar2,
                                  p_type in number,
                                  p_userid in number,
                                  p_status in number default 0) return number;

  -- ������� ��'���� � �����
  function f_put_queue_object (p_object_id in number,
                               p_report_date in date,
                               p_kf in varchar2,
                               p_status in number default 0) return number;

  -- ������� ��� ��'���� � �����
  function f_put_queue_all_objects (p_report_date in date,
                                    p_kf in varchar2) return number;

  -- ����� ����� � ��'����
  function f_check_queue_objects(p_kf in varchar2 default null) return number;

  -- ����� ����� ��� ��'����
  function f_check_queue_without_objects(p_period_type in number, p_kf in varchar2 default null) return number;
    -- p_period_type = 1 - ������������ ������ �� ������ �����
    -- p_period_type = 2 - ������������ ���� �����

  -- ����� ����� � �����
  function f_check_queue_forms(p_version_id   in number,
                               p_report_date  in date,
                               p_kf           in varchar2,
                               p_userid       in number,
                               p_proc_type    in number,
                               p_period_type  in number) return number;

  -- ����� ����� � ������� ������
  function f_check_queue_group_forms( p_version_id    in number,
                                      p_report_date   in date,
                                      p_kf            in varchar2,
                                      p_userid        in number,
                                      p_file_id       in number,
                                      p_file_id_end   in number,
                                      p_proc_type     in number,
                                      p_period_type   in number) return number;

  -- ������� ����� � ��'����
  procedure p_clear_queue_objects( p_report_date in date,
                                   p_kf          in varchar2);

  -- ������� ����� � �����
  procedure p_clear_queue_forms( p_report_date in date,
                                 p_kf in varchar2,
                                 p_period_type   in number);

  --
  procedure p_clear_queue_one_form( p_report_date  in date,
                                    p_kf           in varchar2,
                                    p_file_id      in number);

  -- ��������� ������ �� ���������� ���� ����� �� ��볿
  procedure p_rollback_all( p_report_date in date
                          , p_kf in varchar2 );

  --
  -- DAILY_TASK
  --
  procedure DAILY_TASK;

end NBUR_QUEUE;
/
show error;

CREATE OR REPLACE PACKAGE BODY BARS.NBUR_QUEUE
is
  g_body_version  constant varchar2(64)  := 'version 7.0  2017.11.23';
  g_body_defs     constant varchar2(512) := '';

  MODULE_PREFIX   constant varchar2(10)  := 'NBUR';

  --
  -- types
  --

  --
  -- variables
  --
  l_usr_mfo            varchar2(6);
  l_bankdate           date;

    -- header_version - ����� ��������� ������
    function header_version return varchar2 is
    begin
      return 'Package header NBUR_QUEUE ' || g_header_version || '.' || chr(10) ||
             'Package header definition(s): ' || chr(10) ||  g_header_defs;
    end header_version;

    -- body_version - ����� ��� ������
    function body_version return varchar2 is
    begin
      return 'Package body NBUR_QUEUE ' || g_body_version || '.' || chr(10) ||
             'Package body definition(s): ' || chr(10) || g_body_defs;
    end body_version;

    procedure p_errors_log(p_add_mes in varchar2, p_errm in varchar2) is
    begin
      logger.error( $$PLSQL_UNIT||': '||p_add_mes||CHR(10)||p_errm||CHR(10)||
                     dbms_utility.format_error_backtrace());
    end;

    procedure p_errors_log(p_add_mes in varchar2 := null) is
    begin
      p_errors_log(p_add_mes, sqlerrm);
    end;

    procedure p_errors_log(p_report_date in date,
                           p_kf in number,
                           p_file_id in number,
                           p_report_code in varchar2,
                           p_version_id in number,
                           p_userid in number,
                           p_add_mes in varchar2 := null)
    is
        l_txt   clob;
        l_errm  clob := sqlerrm;
    begin
        p_errors_log('', l_errm);

        l_txt :=  l_errm||CHR(10)||dbms_utility.format_error_backtrace();

        l_txt :=  replace(l_txt, CHR(10), '<br> '||CHR(10));

        insert into nbur_lst_errors (report_date, kf, report_code, version_id,
            error_id, error_txt, userid, file_id)
        values (p_report_date, p_kf, p_report_code, p_version_id,
            s_nbur_errors.nextval, l_txt, p_userid, p_file_id);
    end;

    procedure p_info_log(p_add_mes in varchar2 := null) is
    begin
      logger.info( $$PLSQL_UNIT||': '||p_add_mes||CHR(10));
    end;

    procedure p_send_message(p_txt_mes in varchar2,
                             p_uid     in number := null) is
    begin
        -- ������� ����������� �����������

       if getglobaloption('BMS')='1'-- BMS �������: 1-����������� �������� ���������
       then
          bms.add_subscriber(p_uid);
          bms.enqueue_msg(p_txt_mes, dbms_aq.no_delay, dbms_aq.never, p_uid);
       end if;
    end;

    -- ��������� ��� ���������� ����� �� ����� � ������ � �����
    procedure p_notice_all(p_proc_type in number,
                           p_period_type in number,
                           p_kf in varchar2 default null) is
    begin
        -- ����� ��� �������, �� �������� �����, �� ���������� ��-������
        if p_proc_type = 1 then
           update NBUR_QUEUE_FORMS
           set status = 1
           where proc_type = p_proc_type and
                 (p_kf is null or nvl(kf, p_kf) = p_kf);

           update NBUR_QUEUE_OBJECTS
           set status = 1
           where (p_kf is null or nvl(kf, p_kf) = p_kf);
        else -- ������� ������� ����������� (��� NBUR_QUEUE_OBJECTS)
           update NBUR_QUEUE_FORMS
           set status = 1
           where proc_type = p_proc_type and
                 id in (select id
                        from NBUR_REF_FILES
                        where p_period_type = 1 and period_type in ('D', 'T') or
                              p_period_type = 2 and period_type not in ('D', 'T')) and
                 (p_kf is null or nvl(kf, p_kf) = p_kf);
        end if;

        commit;
    end p_notice_all;

    procedure p_send_message_all(p_kf           in varchar2,
                                 p_filecode     in varchar2,
                                 p_txt_mes      in varchar2) is
    begin
        -- �������� ��� ������������, ���� ������� ��� ����, �����������
        for k in (select usr_id
                  from V_NBUR_ROLE_USER_FILE
                  where file_code = p_filecode and
                        usr_id in  (select id
                                    from staff$base
                                    where SUBSTR (bars_context.extract_mfo (branch), 1, 12) = p_kf or
                                          branch = '/')
                  order by 1)
        loop
            p_send_message(p_txt_mes, k.usr_id);
        end loop;
    end;

    function f_try_old_proc(p_report_date      in date,
                            p_kodf             in varchar2,
                            p_a017             in varchar2,
                            p_kf               in varchar2
                          ) return number
    is
        l_ret         number  := 0;
        l_proc_name   varchar2(100);
    begin
        select max(p.name) proc_name
        into l_proc_name
        from kl_f00 f, rep_proc p
        where f.kodf= p_kodf and
              f.procc = p.procc;

         begin
             execute immediate
                  'begin '||l_proc_name||'(:dat_); end; '
             using p_report_date;

             p_send_message('���� #'||p_kodf||'('||p_a017||') �� ���� '||
                  to_char(p_report_date, 'dd.mm.yyyy')||' ������ ����������!', user_id);
         exception
              when others then
                      p_send_message('��� ���������� ����� #'||p_kodf||'('||p_a017||') �� ���� '||
                          to_char(p_report_date, 'dd.mm.yyyy')||' ������� �������!', user_id);

                      p_errors_log('ERROR LOAD #'||p_kodf||'('||p_a017||')'||
                         ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
         end;

        return l_ret;
    end f_try_old_proc;

    -- ��������� ���������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
    function f_get_local_version(p_report_date      in date,
                                 p_kf               in varchar2) return number
    is
        l_local_version_id    number;
    begin
        -- ���� ������� ����� �� ��� kf, �� �������
        -- ��������� ����� ���� �� ��� kf
        if p_kf is null then
           select nvl(max(version_id), 0)
           into l_local_version_id
           from NBUR_LST_VERSIONS
           where report_date = p_report_date;
        else -- ������ ��������� ����� �������� ������kf
           select nvl(max(version_id), 0)
           into l_local_version_id
           from NBUR_LST_VERSIONS
           where report_date = p_report_date and
                 kf = p_kf;
        end if;

        return l_local_version_id;
    end f_get_local_version;

    -- ��������� ����������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
    function f_get_global_version(p_report_date in date,
                                  p_kf in varchar2,
                                  p_local_version_id in number:=null) return number
    is
        l_global_version_id    number;
        l_local_version_id     number := p_local_version_id;
    begin
        if l_local_version_id is null then
           l_local_version_id := f_get_local_version(p_report_date, p_kf);
        end if;

        select id
        into l_global_version_id
        from NBUR_LST_VERSIONS
        where report_date = p_report_date and
              kf = p_kf and
              version_id = l_local_version_id;

        return l_global_version_id;
    exception
        when no_data_found then
             p_errors_log('not found ID for DAT='||to_char(p_report_date, 'dd.mm.yyyy')||' KF= '||p_kf);
             return -1;
    end;

    -- ��������� ����
    function f_create_version(p_report_date         in date,
                              p_kf                  in varchar2,
                              p_version_id          in number,
                              p_global_version_id   out number) return number is
        l_global_version_id    number;
        l_local_version_id     number;
    begin
        if p_version_id is null then
           l_local_version_id := f_get_local_version(p_report_date, p_kf) + 1;
        else
           l_local_version_id := p_version_id;
        end if;

        if p_kf is not null then
            l_global_version_id := S_NBUR_LIST_VERSIONS.nextval;

            insert into NBUR_LST_VERSIONS(ID, REPORT_DATE, KF, VERSION_ID, CREATED_TIME, STATUS)
            values (l_global_version_id, p_report_date, p_kf, l_local_version_id, sysdate, 'RUNNING');

            p_global_version_id := l_global_version_id;

            logger.trace( 'NBUR create version %s for KF = %s.', l_global_version_id||' '||l_local_version_id, p_kf);
        else
            for i in (select KF from BARS.MV_KF)
            loop
                l_global_version_id := S_NBUR_LIST_VERSIONS.nextval;

                insert into NBUR_LST_VERSIONS(ID, REPORT_DATE, KF, VERSION_ID, CREATED_TIME, STATUS)
                values (l_global_version_id, p_report_date, i.kf, l_local_version_id, sysdate, 'RUNNING');

                logger.trace( 'NBUR create version %s for KF = %s.', l_global_version_id||' '||l_local_version_id, i.kf);
            end loop;

            l_global_version_id := null;
        end if;

        return l_local_version_id;
    end f_create_version;

    -- ��������� �������  ����
    procedure p_update_version(p_report_date    in date,
                               p_kf             in varchar2,
                               p_version_id     in number,
                               p_status         in varchar2,
                               p_type           in number default 1)
    is
        l_global_version_id    number;
    begin
        l_global_version_id := f_get_global_version(p_report_date, p_kf, p_version_id);

        if l_global_version_id < 0 then
           return;
        end if;

        p_update_version(l_global_version_id, p_status);

        -- ���� ��� ���������� DM
        if p_status = 'FINISHED' and p_type = 1 then
           nbur_objects.SAVE_VERSION(p_report_date, p_kf, p_version_id);
        end if;
    end p_update_version;

    procedure p_update_version(p_global_version_id in number,
                               p_status in varchar2) is
    begin
        update NBUR_LST_VERSIONS
        set status = p_status,
            CREATED_TIME = sysdate
        where id = p_global_version_id;
    end p_update_version;

    -- ��������� ������� �����  ���� ��������� �� ����� ��� �� KF
    procedure p_update_other_version(p_report_date in date,
                                     p_kf in varchar2,
                                     p_version_id in number,
                                     p_status in varchar2)
    is
    begin
      for k in ( select ID global_version_id, VERSION_ID
                   from NBUR_LST_VERSIONS
                  where report_date = p_report_date
                    and kf = p_kf
                    and version_id < p_version_id
                    and status in ('VALID', 'FINISHED')
                )
      loop

--      nbur_files.p_update_files_status(p_report_date, p_kf, k.version_id, null, p_status);

        p_update_version(k.global_version_id, p_status);

      end loop;

    end p_update_other_version;

    -- ��������� ����, ���� ���� �����������
    function f_blc_obj_version(p_report_date      in date,
                               p_kf               in varchar2,
                               p_object_id        in number) return number
    is
        l_local_version_id    number;
    begin
        select max(version_id)
        into l_local_version_id
        from NBUR_LST_BLC_OBJECTS
        where report_date = p_report_date and
              kf = p_kf and
              object_id = p_object_id;

        return l_local_version_id;
    end f_blc_obj_version;

    -- ��������� ����, ���� ���� �����������
    function f_blc_file_version(p_report_date      in date,
                                p_kf               in varchar2,
                                p_file_id          in number) return number
    is
        l_local_version_id    number;
    begin
        select max(version_id)
        into l_local_version_id
        from NBUR_LST_BLC_FILES
        where report_date = p_report_date and
              kf = p_kf and
              file_id = p_file_id;

        return l_local_version_id;
    end f_blc_file_version;

    -- ������� ����� � ��'����
    procedure p_clear_queue_objects(p_report_date in date,
                                    p_kf in varchar2) is
    begin
        delete
        from NBUR_QUEUE_OBJECTS
        where report_date = p_report_date and
              kf = p_kf and
              status = 1;
    end p_clear_queue_objects;

    -- ������� ����� � ��'����
    procedure p_clear_queue_objects_all(p_report_date in date) is
    begin
        delete
        from NBUR_QUEUE_OBJECTS
        where report_date = p_report_date and
              status = 1;
    end p_clear_queue_objects_all;

    -- ������� ������ ����� � �����
    procedure p_clear_queue_one_form(p_report_date  in date,
                                     p_kf           in varchar2,
                                     p_file_id      in number) is
    begin
        delete
        from NBUR_QUEUE_FORMS
        where report_date = p_report_date and
              kf = p_kf and
              id = p_file_id and
              status = 1;
    end p_clear_queue_one_form;

    -- ������� ����� � �����
    procedure p_clear_queue_forms(p_report_date in date,
                                  p_kf in varchar2,
                                  p_period_type   in number) is
    begin
        delete
        from NBUR_QUEUE_FORMS
        where report_date = p_report_date and
              kf = p_kf and
              id in (select id
                     from NBUR_REF_FILES
                     where p_period_type = 1 and period_type in ('D', 'T') or
                           p_period_type = 2 and period_type not in ('D', 'T')) and
              status = 1;
    end p_clear_queue_forms;

    -- ������� ����� � �����
    procedure p_clear_queue_forms_all(p_report_date in date) is
    begin
        delete
        from NBUR_QUEUE_FORMS
        where report_date = p_report_date and
              status = 1;
    end p_clear_queue_forms_all;

    -- ������� ����� � �����
    function f_put_queue_form (p_report_date in date,
                               p_file_code in varchar2,
                               p_scheme in varchar2,
                               p_type in number,
                               p_kf in varchar2,
                               p_status in number default 0) return varchar2 is
        l_id_file         number;
        l_cnt             number;
        l_ret             number;
        l_ret_mes         varchar2(200);
        l_ret_mes_add     varchar2(200);
        l_wokdday         date;
    begin
        select count(*)
        into l_cnt
        from mv_kf
        where kf = p_kf;

        if l_cnt = 0 then
           l_ret_mes := '���������� ����� �� ������ �������� ���������! �������, ����-�����, ���� ���!';

           return l_ret_mes;
        end if;

        -- ������������� �����
        l_id_file := nbur_files.f_get_id_file(p_file_code, p_scheme, p_type);

        l_wokdday := f_workday(p_report_date);

        if l_wokdday is null then
           l_ret_mes := '���� '||to_char(p_report_date, 'dd.mm.yyyy')||' � �������� ����!'||
                        ' ������� ���� ����!';

           return l_ret_mes;
        end if;

        select count(*)
        into l_cnt
        from NBUR_REF_CALENDAR b
        where b.calendar_date = l_bankdate and
              b.report_date = p_report_date and
              nvl(b.kf, p_kf) = p_kf and
              b.file_id = l_id_file and
              status = 'TRUE';

        if (p_kf = 300465 and
            p_report_date < to_date('17032017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 324805 and
            p_report_date < to_date('01042017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 322669 and
            p_report_date < to_date('26052017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 351823 and
            p_report_date < to_date('08092017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 304665 and
            p_report_date < to_date('20102017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 335106 and
            p_report_date < to_date('24112017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
            p_report_date > bankdate
        then
          l_cnt := -1;
        else -- ��������� �� ���� �������� �� ���������� ��������� ��������
          l_cnt := 1;
        end if;

        if l_cnt > 0 then
            -- ������� � �����
            l_ret := f_put_queue_form_by_id(l_id_file, l_bankdate, p_report_date,
                            p_kf, user_id, p_status);

            if l_ret = -3 then -- ��� � � ����
                p_info_log('NBUR F_PUT_QUEUE_FORM ��� � � ����'||CHR(10)||
                            ' file_code='||to_char(p_file_code)||
                            ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
            end if;
        elsif l_cnt = -1 then
            -- ���� �� ��������� ��� ����������
            p_info_log('NBUR F_PUT_QUEUE_FORM ���� ���������� ��� ���������� ������ �����! '||
                        ' file_code='||to_char(p_file_code)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

            l_ret := -4;
        else
            -- ���� �� ��������� ��� ����������
            p_info_log('NBUR F_PUT_QUEUE_FORM ����������� ��� ���������� � �� ='||
                        to_char(l_bankdate, 'dd.mm.yyyy')||CHR(10)||
                        ' file_code='||to_char(p_file_code)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

            l_ret := -2;
        end if;

        if l_ret in (0, -3) then
           begin
               SELECT f_nbur_get_wait_time((case when p_type = 1 then 1
                                                 when p_type = 2 and f.PERIOD_TYPE in ('D', 'T') then 2
                                                 else 3
                                            end)) wait_time
                 INTO l_ret_mes_add
                  FROM nbur_ref_files f, nbur_ref_procs l
                 WHERE f.id = l_id_file AND f.id = l.file_id(+);
           exception
              when others then l_ret_mes_add := '';
           end;

           if trim(l_ret_mes_add) is not null then
              l_ret_mes_add := '�� ������� ������� ����� ������� '||l_ret_mes_add||' ��.';
           end if;
        end if;

        if l_ret = 0 then
           l_ret_mes := '���� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' ������� � �����. ������� �� �����������! '||l_ret_mes_add;
        elsif l_ret = -2 then
           l_ret_mes := '���� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' �� ��������� ��� ���������� �� ��� ����. ��������� �� ������������!';
        elsif l_ret = -3 then
           l_ret_mes := '���� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' ��� � � ����. ������� �� �����������! '||l_ret_mes_add;
        elsif l_ret = -4 then
           l_ret_mes := '�� ���� �� �������� ��� ���������� ����� !!!'||
                        ' ������� ���� ����!';
        else
           l_ret_mes := '�������� � ��������� ����� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' � �����. ��������� �� ������������!';
        end if;

        return l_ret_mes;
    end f_put_queue_form;

    -- ������� ����� � �����
    function f_put_queue_form_by_id (p_file_id in number,
                                     p_bank_date in date,
                                     p_report_date in date,
                                     p_kf in varchar2,
                                     p_userid in number,
                                     p_status in number default 0) return number is
        l_ret             number;
        l_type_proc       number;
        l_exists          number := 0;
    begin
        begin
            select (case
                        when proc_type = 'F' then 1 -- ���� ���������
                        when proc_type = 'O' then 2 -- ��������������
                        else 0                      -- �� ����������
                    end)
            into l_type_proc
            from NBUR_REF_PROCS
            where file_id = p_file_id and
                proc_type in ('F', 'O') and
                (date_finish is null or date_finish > p_report_date);
        exception
            when no_data_found then l_type_proc := 0;
        end;

        -- �������� �������� ����� � ����
        select count(*)
        into l_exists
        from NBUR_QUEUE_FORMS
        where id = p_file_id and
              report_date = p_report_date and
              kf = p_kf;

        if l_exists > 0 then
           -- ��� � � ����
           return -3;
        end if;

        -- ������� � �����
        begin
            insert into NBUR_QUEUE_FORMS(ID, REPORT_DATE, DATE_START, KF, USER_ID, STATUS, PROC_TYPE)
            values(p_file_id, p_report_date, sysdate, p_kf, p_userid, p_status, l_type_proc);
        exception
            when others then
                if sqlcode = -1 then
                   -- ��� � � ����
                   return -3;
                else
                   p_errors_log('F_PUT_QUEUE_FORM 2) id='||to_char(p_file_id)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF= '||p_kf);

                   return -1;
                end if;
        end;

        -- ������� � ����� ������� ��'���� ��� ����� �����
        for k in (select l.object_id, f.report_date, f.kf
                  from NBUR_QUEUE_FORMS f, NBUR_LNK_FILES_OBJECTS l
                  where f.status = p_status and
                      (f.kf = p_kf or p_kf is null) and
                      f.id = p_file_id and
                      f.id = l.file_id and
                     (l.start_date <= f.report_date and
                      l.finish_date is null or
                      l.finish_date > f.report_date))
        loop
            -- ������� � ����� �����
            l_ret := f_put_queue_object(k.object_id, k.report_date, k.kf, p_status);
        end loop;

        -- ������� � ����� �������� ����, �� �������� �� ������ ������
        l_ret := f_put_queue_dep_forms (p_bank_date, p_report_date, p_kf, 2,
                        p_userid, p_status);

        return 0;
    end f_put_queue_form_by_id;

    -- ������� ��� �������� ����� � �����
    function f_put_queue_dep_forms (p_bank_date in date,
                                    p_report_date in date,
                                    p_kf in varchar2,
                                    p_type in number,
                                    p_userid in number,
                                    p_status in number default 0) return number
    is
        l_ret   number;
    begin
        if p_type = 1 then
            -- ������� � ����� �����, �� �������� �� ������ ��'���� � ����
            for k in (select distinct l.file_id, q.kf
                      from NBUR_QUEUE_OBJECTS q,
                           NBUR_LNK_FILES_OBJECTS l,
                           NBUR_REF_FILES_LOCAL f
                      where q.status = p_status and
                            (q.report_date = p_report_date or p_report_date is null) and
                             nvl(q.kf, p_kf) = p_kf and
                             q.id = l.object_id and
                             l.file_id = f.file_id and
                             (l.start_date <= p_report_date and
                              l.finish_date is null or
                              l.finish_date > p_report_date) and
                             nvl(f.kf, p_kf) = p_kf and
                             f.file_id not in (select b.id
                                               from NBUR_QUEUE_FORMS b
                                               where b.status = 1 and
                                                     b.report_date = p_report_date and
                                                     (nvl(b.kf, p_kf) = p_kf)) and
                             f.file_id in (select b.file_id
                                           from NBUR_REF_CALENDAR b
                                           where b.calendar_date = p_bank_date and
                                                 nvl(b.report_date, p_report_date) = p_report_date and
                                                 nvl(b.kf, p_kf) = p_kf and
                                                 status = 'TRUE')
                     )
            loop
                -- ������� � �����
                l_ret := f_put_queue_form_by_id (k.file_id, p_bank_date,
                            p_report_date, k.kf, p_userid, p_status);
            end loop;
        elsif p_type = 2 then
            -- ������� � ����� �����, �� �������� �� ������ ����� NBUR_QUEUE_FORMS
            for k in (select distinct l.file_dep_id, q.kf
                      from NBUR_QUEUE_FORMS q,
                           NBUR_LNK_FILES_FILES l,
                           NBUR_REF_FILES_LOCAL f
                      where  q.status = p_status and
                             (q.report_date = p_report_date or p_report_date is null) and
                             nvl(q.kf, p_kf) = p_kf and
                             q.id = l.file_id and
                             l.file_dep_id = f.file_id and
                             (l.start_date <= p_report_date and
                              l.finish_date is null or
                              l.finish_date > p_report_date) and
                             nvl(f.kf, p_kf) = p_kf and
                             f.file_id not in (select b.id
                                               from NBUR_QUEUE_FORMS b
                                               where b.status = 1 and
                                                     b.report_date = p_report_date and
                                                     (nvl(b.kf, p_kf) = p_kf)) and
                             f.file_id in (select b.file_id
                                           from NBUR_REF_CALENDAR b
                                           where b.calendar_date = p_bank_date and
                                                 nvl(b.report_date, p_report_date) = p_report_date and
                                                 nvl(b.kf, p_kf) = p_kf and
                                                 status = 'TRUE')
                     )
            loop
                -- ������� � �����
                l_ret := f_put_queue_form_by_id (k.file_dep_id, p_bank_date,
                                p_report_date, k.kf, p_userid, p_status);
            end loop;
        end if;

        return 0;
    end f_put_queue_dep_forms;

    -- ������� ��� ����� � �����
    function f_put_queue_all_forms (p_bank_date in date,
                                    p_report_date in date  default null,
                                    p_kf in varchar2 default null) return number is
        l_ret   number;
    begin
        -- ������ ����� ��� �������
        for k in (select report_date, file_id, nvl(kf, p_kf) kf
                  from NBUR_REF_CALENDAR
                  where calendar_date = p_bank_date and
                        (report_date = p_report_date or p_report_date is null) and
                        (nvl(kf, p_kf) = p_kf or p_kf is null) and
                        status = 'TRUE'
                  order by id)
        loop
            -- ������� � �����
            l_ret := f_put_queue_form_by_id (k.file_id, p_bank_date, k.report_date,
                            k.kf, null, 0);
        end loop;

        return 0;
    end f_put_queue_all_forms;

    -- �������� ���������� ���������� ����� � ����� ��� ����� ������������ ������� ����������
    -- � ����� ������� ����� ����� �����, � � ���� ����� ����������� ����������� �����
    procedure p_repeat_put_forms
    is
        l_ret number;

        TYPE t_tab_queue IS TABLE OF NBUR_QUEUE_FORMS%ROWTYPE;
        l_tab_queue t_tab_queue;
    begin
        SELECT *
        BULK COLLECT INTO l_tab_queue
        FROM NBUR_QUEUE_FORMS;

        for i in l_tab_queue.first..l_tab_queue.last loop
            p_clear_queue_one_form(l_tab_queue(i).report_date, l_tab_queue(i).kf, l_tab_queue(i).id);

            l_ret := f_put_queue_form_by_id(l_tab_queue(i).id, bankdate, l_tab_queue(i).report_date, l_tab_queue(i).kf, l_tab_queue(i).user_id);
        end loop;

        commit;
    end p_repeat_put_forms;

    -- ������� ��'���� � �����
    function f_put_queue_object (p_object_id in number,
                                 p_report_date in date,
                                 p_kf in varchar2,
                                 p_status in number default 0) return number is
    begin
        -- ������� � �����
        begin
            insert into NBUR_QUEUE_OBJECTS(ID, REPORT_DATE, DATE_START, ROW_COUNT, KF, STATUS)
            values(p_object_id, p_report_date, sysdate, 0, p_kf, p_status);
        exception
            when others then
                if sqlcode = -1 then
                   return 1;
                else
                   p_errors_log('PUT QUEUE OBJ id='||to_char(p_object_id)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

                   return -1;
                end if;
        end;

        return 0;
    end f_put_queue_object;

    -- ������� ��� ��'���� � �����
    function f_put_queue_all_objects (p_report_date in date,
                                      p_kf in varchar2) return number is
        l_ret   number;
    begin
        for k in (select L.OBJECT_ID, f.kf
                  from NBUR_QUEUE_FORMS f, NBUR_LNK_FILES_OBJECTS l
                  where (f.kf = p_kf or p_kf is null) and
                      f.id = l.file_id and
                     (l.start_date <= p_report_date and
                      l.finish_date is null or
                      l.finish_date > p_report_date))
        loop
            -- ������� � �����
            l_ret := f_put_queue_object(k.object_id, p_report_date, p_kf);
        end loop;

        return 0;
    end f_put_queue_all_objects;

    -- ������� ��� �������� ����� � �����
    function f_put_queue_dep_objects(p_status in number default 0,
                                     p_kf in varchar2 default null) return number
    is
        l_ret   number;
    begin
        -- ������� � ����� �����, �� �������� �� ������ ��'���� � ����
        for k in (select l.object_pid object_id, o.report_date, o.kf
                  from NBUR_QUEUE_OBJECTS o
                  join
                        (select object_id, CONNECT_BY_ROOT object_pid as object_pid
                        from NBUR_LNK_OBJECT_OBJECT l
                        CONNECT BY NOCYCLE PRIOR object_id = object_pid) l
                   on (O.ID = l.object_id)
                   where (p_kf is not null and
                          p_kf = o.kf or
                          p_kf is null) and
                         o.status = p_status and
                         not exists (select 1
                                     from NBUR_QUEUE_OBJECTS o1
                                     where o1.id = l.object_pid and
                                           o1.report_date = o.report_date and
                                           o1.kf = o.kf)
                 )
        loop
            -- ������� � �����
            l_ret := f_put_queue_object(k.object_id, k.report_date, k.kf, p_status);
        end loop;

        return 0;
    end f_put_queue_dep_objects;

    function f_load_object(p_report_date in date,
                           p_kf          in varchar2,
                           p_version_id  in number,
                           p_object_id   in number,
                           p_object_name in varchar2,
                           p_proc_insert in varchar2
                           ) return number
    is
        l_version_blc_id        number;
    begin
        if p_kf is not null then
           l_version_blc_id := f_blc_obj_version(p_report_date, p_kf, p_object_id);
        else
           l_version_blc_id := null;
        end if;

        if l_version_blc_id is null then
            -- ���� ���� ����������� ���� �����, �� ������� � ��������
            if p_proc_insert is not null
            then
               declare
                   l_cnt         number := 0;
                   l_start_time  timestamp := systimestamp;
               begin
                   execute immediate
                        'begin '||trim(p_proc_insert)||'(:dat_, :kf_, :id_); end; '
                   using p_report_date, p_kf, p_version_id;
               exception
                    when others then
                        select count(*)
                        into l_cnt
                        from NBUR_LST_OBJECTS
                        where report_date = p_report_date and
                              kf = p_kf and
                              object_id = p_object_id and
                              version_id = p_version_id;

                        if l_cnt = 0 then
                            insert into NBUR_LST_OBJECTS
                                 (REPORT_DATE, KF, OBJECT_ID, VERSION_ID, START_TIME, FINISH_TIME, OBJECT_STATUS )
                            values
                                 (p_report_date, p_kf, p_object_id, p_version_id, l_start_time, systimestamp, 'ERROR' );
                        else
                            update NBUR_LST_OBJECTS
                            set finish_time = systimestamp,
                                object_status = 'ERROR'
                            where report_date = p_report_date and
                                  kf = p_kf and
                                  object_id = p_object_id and
                                  version_id = p_version_id;
                        end if;

                        p_errors_log('ERROR LOAD '||p_object_name||
                           ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
                        return -1;
               end;

               commit;
            end if;
        else -- ������ ������� � ������
            declare
                l_sql_fields            varchar2(2000);
                l_sql_txt               varchar2(20000);
                l_glb_version_blc_id    number;
                l_start_time            timestamp;
            begin
                select listagg(column_name, ', ') WITHIN GROUP (ORDER BY rn)
                into l_sql_fields
                from (select column_name, rownum rn
                      from (select column_name
                            from ALL_TAB_COLUMNS
                            where owner = 'BARS' and
                                table_name = p_object_name
                                intersect
                            select column_name
                            from ALL_TAB_COLUMNS
                            where owner = 'BARS' and
                                table_name = p_object_name||'_ARCH'));

                l_sql_txt := 'insert into '||p_object_name||'('||l_sql_fields||')'||chr(10);
                l_sql_txt := l_sql_txt || ' select '||l_sql_fields||' from '||p_object_name||'_ARCH'||chr(10);
                l_sql_txt := l_sql_txt || ' where  report_date = :p1 and kf = :p2 and version_id = :p3 ';

                begin
                   l_start_time := systimestamp;

                   execute immediate l_sql_txt
                   using p_report_date, p_kf, l_version_blc_id;

                   l_glb_version_blc_id := f_get_global_version(p_report_date, p_kf, l_version_blc_id);

                   insert into BARS.NBUR_LST_OBJECTS
                         (REPORT_DATE, KF, OBJECT_ID, VERSION_ID, START_TIME, OBJECT_STATUS )
                   values
                         (p_report_date, p_kf, p_object_id, p_version_id, l_start_time, 'FINISHED' );

                   insert into NBUR_LNK_VERSIONS(REPORT_DATE, KF, VERSION_ID, OBJECT_ID, GLBL_VRSN_ID)
                   values (p_report_date, p_kf, p_version_id, p_object_id, l_glb_version_blc_id);
                exception
                    when others then
                        insert into BARS.NBUR_LST_OBJECTS
                             (REPORT_DATE, KF, OBJECT_ID, VERSION_ID, START_TIME, OBJECT_STATUS )
                        values
                             (p_report_date, p_kf, p_object_id, p_version_id, l_start_time, 'ERROR' );

                        p_errors_log('ERROR LOAD '||p_object_name||
                           ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
                        return -1;
                end;

                commit;
            exception
                when others then
                    p_errors_log('ERROR LOAD '||p_object_name||
                       ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
            end;
        end if;

        return 0;
    end;

    -- ����� ����� � ��'����
    function f_check_queue_objects(p_kf in varchar2 default null) return number is
        l_ret                   number;
        l_report_date           date;
        l_report_date_prev      date;
        l_kf                    varchar2(6);
        l_kf_prev               varchar2(6);
        l_version_id            number;
        l_global_version_id     number;
        l_version_blc_id        number;
        l_user_id               number;
    begin
        l_user_id := user_id;

        -- ��������� �� ����� � ����� ��� �������
        p_notice_all(1, null, p_kf);

        -- ������� � ����� �������� ����� (�� � ���������� ���������)
        l_ret := f_put_queue_dep_objects(1, p_kf);

        -- ��������� ������� ������������
        for p in (select distinct o.report_date, k.kf, o.kf kfo,
                    dense_rank() over (partition by o.report_date order by k.kf) rnum
                  from NBUR_QUEUE_OBJECTS o,
                       V_NBUR_PERELIK_KF k
                  where ((p_kf is not null and
                          p_kf = k.kf or
                          p_kf is null) and o.kf = k.kf
                            or
                         o.kf is null) and
                        o.status = 1
                  order by 1 desc, 2)
        loop
            l_report_date := p.report_date;
            l_kf := p.kf;

            -- ��������� ���� ��� ������������
            -- ���� ���������� �� kf, �� ��� ��� - ��������� ����� ����
            if p.rnum = 1 and p.kfo is null then
               l_version_id := f_create_version(l_report_date, p.kfo, null, l_global_version_id);
            elsif p.kfo is not null then
               l_version_id := f_create_version(l_report_date, p.kf, null, l_global_version_id);
            end if;

            commit;

            -- ���������� ����� �� ���������� �����
            for o in (select q.report_date,
                             nvl(q.kf, l_kf) kf,
                             q.id object_id,
                             o.object_name,
                             o.proc_insert,
                             count(l.object_id) cnt
                        from nbur_queue_objects q
                        join nbur_ref_objects o
                        on (q.id = o.id)
                        left outer join nbur_lst_blc_objects l
                        on (q.report_date = l.report_date and
                            q.id = l.object_id and
                            (l.kf = q.kf or q.kf is null))
                        where q.status = 1 and
                              q.report_date = l_report_date and
                              nvl(q.kf, l_kf)  = l_kf
                        group by q.report_date, q.kf, q.id, o.object_name, o.proc_insert
                        order by q.id
                     )
            loop
                -- ���o �� ��� � ���� ����������� ���� �����,
                -- �� ������� � �������� �� ��� kf �� ���� ���
                -- � ��������� ������� ���� ��� �� ���������� kf
                if p.rnum = 1 and o.cnt = 0 then
                   l_ret := f_load_object(o.report_date, p.kfo, l_version_id,
                            o.object_id, o.object_name, o.proc_insert);
                else
                -- ������ - ������� �� ������ kf (� �������� �� � ������)
                   l_ret := f_load_object(o.report_date, o.kf, l_version_id,
                            o.object_id, o.object_name, o.proc_insert);
                end if;

                commit;
            end loop;

            -- �������� ������������ ����� �� �������� �������
            -- �� ��������� � ����� �����, �� ���������� �� ���
            -- � ����������� ����������� ��� ������� � �����
            for k in (select id file_id, nvl(kf, l_kf) kf, report_date, user_id
                      from nbur_queue_forms f
                      where status = 1 and
                            proc_type = 1 and
                            report_date = l_report_date and
                            nvl(f.kf, l_kf)  = l_kf and
                            not exists (select 1 -- ���� �� ������������
                                        from nbur_lst_blc_files b
                                        where b.report_date = f.report_date and
                                              b.kf = nvl(f.kf, l_kf) and
                                              b.file_id = f.id) and
                            exists (select 1
                                    from NBUR_LNK_FILES_OBJECTS l,
                                         NBUR_LST_OBJECTS o
                                    where l.file_id = f.id and
                                          l.object_id = o.object_id and
                                          o.report_date = f.report_date and
                                          o.kf = nvl(f.kf, l_kf) and
                                          o.version_id = l_version_id and
                                          o.object_status in ('ERROR', 'RUNNING'))
                     )
            loop
                -- ������� ������ ��� ������ ����������
                l_ret := nbur_files.f_start_form_file(k.user_id, l_version_id, k.file_id,
                                    k.report_date, k.kf, sysdate);

                --������������ ������ ��� ������������ ����������� �����, �� �� ������� �����
                l_ret := nbur_files.f_finish_form_file(l_version_id, k.file_id,
                                    k.report_date, k.kf, 'STOPPED');

                -- �������� ���� � �����
                p_clear_queue_one_form(k.report_date, k.kf, k.file_id);

                p_send_message('���������� ����� ����������� ����� ������� ��� ����������� �����!'||
                                    ' ��������� �� ������������!', k.user_id);
            end loop;

            -- ������� �����
            p_clear_queue_objects(l_report_date, l_kf);

            commit;

            -- ���������� ��� ����� � ����� (��������� ���������� �����)
            for k in (select id file_id, nvl(kf, l_kf) kf, report_date
                      from nbur_queue_forms f
                      where status = 1 and
                            proc_type = 1 and
                            report_date = l_report_date and
                            nvl(f.kf, l_kf) = l_kf and
                            not exists (select 1 -- ���� �� ������������
                                        from nbur_lst_blc_files b
                                        where b.report_date = f.report_date and
                                              b.kf = nvl(f.kf, l_kf) and
                                              b.file_id = f.id)
                     )
            loop
                nbur_files.p_set_invalid_file (k.file_id, k.report_date, k.kf, null);
            end loop;

            -- �������� ����� �� ���������� �����
            l_ret := f_check_queue_forms(l_version_id, l_report_date, l_kf, l_user_id, 1, null);

            p_update_other_version(l_report_date, l_kf, l_version_id, 'INVALID');

            p_update_version(l_report_date, l_kf, l_version_id, 'FINISHED');

            l_report_date_prev := l_report_date;
            l_kf_prev := l_kf;

            commit;
        end loop;

        return l_ret;
    end f_check_queue_objects;

    -- ����� ����� ��� ��'����
    function f_check_queue_without_objects(p_period_type in number, p_kf in varchar2 default null) return number
    -- p_period_type = 1 - ������������ ������ �� ������ �����
    -- p_period_type = 2 - ������������ ���� �����
    is
        l_ret                   number;
        l_report_date           date;
        l_report_date_prev      date;
        l_kf                    varchar2(6);
        l_version_id            number;
        l_global_version_id     number;
        l_version_blc_id        number;
        l_user_id               number;
    begin
        l_user_id := user_id;

        -- ��������� �� ����� � ����� ��� �������
        p_notice_all(0, p_period_type, p_kf); -- ������ ��� �������� (���������!!!)
        p_notice_all(2, p_period_type, p_kf); -- ������������ ��-�������

        -- ��������� ������� ������������
        for p in (select distinct o.report_date, k.kf, o.kf kfo,
                    dense_rank() over (partition by o.report_date order by k.kf) rnum
                  from NBUR_QUEUE_FORMS o,
                       V_NBUR_PERELIK_KF k
                  where ((p_kf is not null and
                          p_kf = k.kf or
                          p_kf is null) and o.kf = k.kf
                            or
                         o.kf is null) and
                        o.status = 1 and
                        o.id in (select id
                                 from NBUR_REF_FILES
                                 where p_period_type = 1 and period_type in ('D', 'T') or
                                       p_period_type = 2 and period_type not in ('D', 'T')) and
                        o.proc_type in (0, 2)
                  order by 1 desc, 2)
        loop
            l_report_date := p.report_date;
            l_kf := p.kf;

            -- ��������� ���� ��� ������������
            -- ���� ���������� �� kf, �� ��� ��� - ��������� ����� ����
            if p.rnum = 1 and p.kfo is null then
               l_version_id := f_create_version(l_report_date, p.kfo, null, l_global_version_id);
            elsif p.kfo is not null then
               l_version_id := f_create_version(l_report_date, p.kf, null, l_global_version_id);
            end if;

            commit;

            -- ���������� ��� ����� � ����� (��������� ���������� �����)
            for k in (select id file_id, nvl(kf, l_kf) kf, report_date
                      from nbur_queue_forms f
                      where status = 1 and
                            id in (select id
                                   from NBUR_REF_FILES
                                   where p_period_type = 1 and period_type in ('D', 'T') or
                                         p_period_type = 2 and period_type not in ('D', 'T')) and
                            proc_type in (0, 2) and
                            report_date = l_report_date and
                            nvl(f.kf, l_kf) = l_kf and
                            not exists (select 1 -- ���� �� ������������
                                        from nbur_lst_blc_files b
                                        where b.report_date = f.report_date and
                                              b.kf = nvl(f.kf, l_kf) and
                                              b.file_id = f.id)
                     )
            loop
                nbur_files.p_set_invalid_file (k.file_id, k.report_date, k.kf, null);
            end loop;

            -- �������� ����� �� ���������� �����
            --��� �������� (���������)
            l_ret := f_check_queue_forms(l_version_id, l_report_date, l_kf, l_user_id, 0, null);

            -- ��-�������
            l_ret := f_check_queue_forms(l_version_id, l_report_date, l_kf, l_user_id, 2, p_period_type);

            p_update_other_version(l_report_date, l_kf, l_version_id, 'INVALID');

            p_update_version(l_report_date, l_kf, l_version_id, 'FINISHED', 2);

            l_report_date_prev := l_report_date;

            commit;
        end loop;

        return l_ret;
    end f_check_queue_without_objects;

    -- ����� ����� � �����
    function f_check_queue_forms( p_version_id  in number,
                                  p_report_date in date,
                                  p_kf          in varchar2,
                                  p_userid      in number,
                                  p_proc_type   in number,
                                  p_period_type in number
                                 ) return number
    is
      title       constant   varchar2(60)  := $$PLSQL_UNIT||'.PP_FORMS';
      l_task_nm              varchar2(100) := 'NBUR_PARSE_QUEUE_'||p_kf;
      l_sql_stmt             varchar2(4000);
      e_task_not_found       exception;
      pragma exception_init( e_task_not_found, -29498 );
    begin
        execute immediate 'ALTER SESSION DISABLE PARALLEL DDL';
        execute immediate 'ALTER SESSION SET PARALLEL_DEGREE_LIMIT = 16';

        begin
          DBMS_PARALLEL_EXECUTE.drop_task(task_name => l_task_nm);
        exception
          when e_task_not_found then
            null;
        end;

        DBMS_PARALLEL_EXECUTE.create_task(task_name => l_task_nm);

        l_sql_stmt  := 'select file_id file_id_begin, file_id file_id_end
                        from (select unique q.id file_id,
                                   (case when g.PERIOD_TYPE in (''D'', ''T'') then 1
                                         when g.PERIOD_TYPE = ''M'' then 2
                                              else 3
                                    end) group_num,
                                    q.date_start
                            from BARS.NBUR_QUEUE_FORMS q,
                                 BARS.NBUR_REF_FILES g
                            where q.status = 1 and
                                  q.proc_type = '||to_char(p_proc_type)||' and
                                  q.report_date = to_date('''||to_char(p_report_date,'ddmmyyyy')||''',
                                ''ddmmyyyy'') and nvl(q.kf, '''||p_kf||''') = '''||p_kf||''' and '||
                                (case when p_period_type is null then ' '
                                      else
                                         (case when p_period_type = 1
                                               then 'g.period_type in (''D'', ''T'') and '
                                               else 'g.period_type not in (''D'', ''T'') and '
                                         end)
                                end) ||
                                'q.id = g.id)
                        order by group_num, date_start, file_id';

        DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name  => l_task_nm,
                                                    sql_stmt   => l_sql_stmt,
                                                    by_rowid   => FALSE);

        l_sql_stmt := 'declare
                         l_ret number;
                       begin
                         l_ret := BARS.NBUR_QUEUE.F_CHECK_QUEUE_GROUP_FORMS('||to_char(p_version_id)||
            ', to_date('''||to_char(p_report_date,'ddmmyyyy')||''',''ddmmyyyy''), '||p_kf||', '||
            to_char(p_userid)||', :start_id, :end_id, '||to_char(p_proc_type)||','||
            (case when p_period_type is null then 'null' else to_char(p_period_type) end)||');
                       end; ';

        DBMS_PARALLEL_EXECUTE.run_task(task_name        => l_task_nm,
                                            sql_stmt        => l_sql_stmt,
                                            language_flag   => DBMS_SQL.NATIVE,
                                            parallel_level  => 5);

        begin
          DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );
        exception
          when e_task_not_found then
            null;
        end;

        commit;

        return 0;

    end f_check_queue_forms;

    -- ����� ����� � ������� ������
    function f_check_queue_group_forms(p_version_id    in number,
                                       p_report_date   in date,
                                       p_kf            in varchar2,
                                       p_userid        in number,
                                       p_file_id       in number,
                                       p_file_id_end   in number,
                                       p_proc_type     in number,
                                       p_period_type   in number
                                      ) return number
    is
        l_ret                   number;
        l_file_id               number;
        l_version_blc_id        number;
        l_message               clob;
        l_flagOK                number;
        l_error_mes             clob;

    begin
        p_info_log('Begin PP for group from '||to_char(p_file_id)||' to '||to_char(p_file_id_end)||
               ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

        bc.subst_mfo(p_kf);

        -- �������� �����
        for k in (select l.file_id, q.report_date, k.kf,
                         g.file_code||'('||g.scheme_code||')' object_name,
                         p.proc_name, nvl(q.user_id, p_userid) userid,
                         g.file_code, substr(g.file_code,2,2) kodf,
                         G.SCHEME_CODE a017
                  from NBUR_QUEUE_FORMS q,
                       NBUR_REF_FILES_LOCAL l,
                       NBUR_REF_FILES g,
                       NBUR_REF_PROCS p,
                       V_NBUR_PERELIK_KF k
                  where q.status = 1 and
                        q.proc_type = p_proc_type and
                        q.report_date = p_report_date and
                        nvl(k.kf, p_kf) = p_kf and
                        nvl(q.kf, p_kf) = p_kf and
                        nvl(q.kf, p_kf) = l.kf and
                        q.id = l.file_id and
                        l.file_id = g.id and
                        (p_period_type is null or
                         p_period_type = 1 and g.period_type in ('D', 'T') or
                         p_period_type = 2 and g.period_type not in ('D', 'T')) and
                        g.id = p.file_id(+) and
                        p.proc_type(+) in ( 'F', 'O') and
                        q.id between p_file_id and p_file_id_end
                  order by (case when g.PERIOD_TYPE in ('D', 'T') then 1
                                 when g.PERIOD_TYPE = 'M' then 2
                                 else 3
                            end), q.date_start)
        loop
            l_file_id := k.file_id;

            l_message := '';
            l_flagOK := 1;

            l_version_blc_id := f_blc_file_version(k.report_date, k.kf, k.file_id);

            if l_version_blc_id is null then
                -- ��������� �������������� ������ �����
                l_ret := nbur_files.f_start_form_file(k.userid, p_version_id, l_file_id,
                                    k.report_date, k.kf, sysdate);

                -- ���������� �����
                if k.PROC_NAME is not null
                then
                   commit;

                   execute immediate 'ALTER SESSION DISABLE PARALLEL DDL';

                   -- ������� ������� �� ���� �������
                   delete
                   from nbur_detail_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   delete
                   from nbur_agg_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   begin
                       if p_proc_type = 2 then
                          p_info_log(k.PROC_NAME||' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy')||CHR(10));
                       end if;

                       DBMS_APPLICATION_INFO.SET_CLIENT_INFO('���� '||k.file_code||' �� '||to_char(k.report_date, 'dd.mm.yyyy')||' �� ���='||k.kf);

                       execute immediate
                            'begin '||k.PROC_NAME||'(:dat_, :kf_, :form_id); end; '
                       using k.report_date, k.kf, l_ret;

                       if p_proc_type = 2 then
                          p_info_log(k.PROC_NAME||' end for date = '||to_char(p_report_date, 'dd.mm.yyyy')||CHR(10));
                       end if;

                       l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                        ' (����� '||to_char(p_version_id)||') ������ ����������!';
                   exception
                        when others then
                            l_flagOK := 0;

                            l_message := '��� ���������� ����� '||k.object_name||' �� ���� '||
                                to_char(k.report_date, 'dd.mm.yyyy')||' ������� �������!';

                            l_error_mes := 'ERROR LOAD '||k.OBJECT_NAME||
                               ' dat='||to_char(k.report_date, 'dd.mm.yyyy')||' KF='||k.kf;

                            p_errors_log(k.report_date, k.kf, l_file_id, k.file_code, p_version_id, k.userid, l_error_mes);
                   end;
                else
                   commit;

                   execute immediate 'ALTER SESSION DISABLE PARALLEL DDL';

                   -- ������� ������� �� ���� �������
                   delete
                   from nbur_detail_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   delete
                   from nbur_agg_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   if k.file_code like '#%' or k.file_code like '@51%' then
                      begin
                         insert into nbur_agg_protocols(REPORT_DATE, KF, REPORT_CODE, NBUC,
                             FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND)
                         select unique datf, kf, k.file_code, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), ERR_MSG, fl_mod
                         from tmp_nbu
                         where kodf=substr(k.file_code,2,2) and
                               datf = k.report_date and
                               kf = k.kf;

                         insert into NBUR_DETAIL_PROTOCOLS(REPORT_DATE, KF, REPORT_CODE, NBUC,
                             FIELD_CODE, FIELD_VALUE, DESCRIPTION, ACC_ID, ACC_NUM, KV,
                            MATURITY_DATE, CUST_ID, REF, ND, BRANCH)
                         select unique k.report_date, k.kf, k.file_code, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), COMM, ACC,
                             NLS, KV, MDATE, RNK,REF,  ND, TOBO
                         from rnbu_trace_arch
                         where kodf=substr(k.file_code,2,2) and
                               datf = k.report_date and
                               kf = k.kf;

                          l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                            ' (����� '||to_char(p_version_id)||') ������ ����������!';

                          commit;
                      exception
                         when others then
                             l_flagOK := 0;

                             l_message := '��� ���������� ����� '||k.object_name||' �� ���� '||
                                    to_char(k.report_date, 'dd.mm.yyyy')||' ������� �������!';

                             l_error_mes := 'ERROR LOAD '||k.OBJECT_NAME||
                                   ' dat='||to_char(k.report_date, 'dd.mm.yyyy')||' KF='||k.kf;

                             p_errors_log(l_error_mes);
                      end;
                   else
                      begin
                         insert into nbur_agg_protocols(REPORT_DATE, KF, REPORT_CODE, NBUC,
                             FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND)
                         select unique datf, kf, '@'||kodf, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), ERR_MSG, fl_mod
                         from tmp_irep
                         where kodf=substr(k.file_code,2,2) and
                               datf = k.report_date and
                               kf = k.kf;

                         insert into NBUR_DETAIL_PROTOCOLS(REPORT_DATE, KF, REPORT_CODE, NBUC,
                            FIELD_CODE, FIELD_VALUE, DESCRIPTION, ACC_ID, ACC_NUM, KV,
                            MATURITY_DATE, CUST_ID, REF, ND, BRANCH)
                         select unique k.report_date, k.kf, k.file_code, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), COMM, ACC,
                            NLS, KV, MDATE, RNK,REF,  ND, TOBO
                         from rnbu_trace_int_arch
                         where kodf=substr(k.file_code,2,2) and
                              datf = k.report_date and
                              kf = k.kf;

                         l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                               ' (����� '||to_char(p_version_id)||') ������ ����������!';

                         commit;
                      exception
                         when others then
                             l_flagOK := 0;

                             l_message := '��� ���������� ����� '||k.object_name||' �� ���� '||
                                    to_char(k.report_date, 'dd.mm.yyyy')||' ������� �������!';

                             p_errors_log('ERROR LOAD '||k.OBJECT_NAME||
                                   ' dat='||to_char(k.report_date, 'dd.mm.yyyy')||' KF='||k.kf);
                      end;
                   end if;
                end if;

                commit;

                l_ret := nbur_files.f_finish_form_file(p_version_id, l_file_id,
                            k.report_date, k.kf,
                            (case when l_flagOK = 0 then 'ERROR' else 'FINISHED' end));

                -- �������� ����� ����, ���� ��� ������������
                if l_flagOK = 1 then
                   NBUR_OBJECTS.SAVE_FILE_VERSION(k.report_date, k.kf, p_version_id, l_file_id);
                end if;
            else
                l_flagOK := 0;

                l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                        ' ����������� � ���� '||to_char(l_version_blc_id);

                p_info_log(l_message);
            end if;

            p_clear_queue_one_form(p_report_date, p_kf, l_file_id);

            -- �������� ���������� ��� ������������(���� ��������� ����� � ������������ � COBUMMFOTEST-516)
            p_send_message(l_message, k.userid);

            commit;
        end loop;

        bc.home;

        p_info_log('End PP for group from '||to_char(p_file_id)||' to '||to_char(p_file_id_end)||
               ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

        return 0;
    end f_check_queue_group_forms;

    -- ��������� ������ �� ���������� ���� ����� �� ��볿
    procedure p_rollback_all( p_report_date in date, p_kf in varchar2 )
    is
    begin
      null;
    end p_rollback_all;

    --
    -- DAILY_TASK
    --
    procedure DAILY_TASK
    is
    /**
    <b>DAILY_TASK</b> - Queue filling

    %version 1.0
    %usage   Filling report queue
    */
      title  constant  varchar2(64) := $$PLSQL_UNIT||'.DAILY_TASK';
      l_bnk_dt         date; -- ��������� ��������� ����
      l_rpt_d_dt       date; -- ����� ���� ��� ��������    �����
      l_rpt_t_dt       date; -- ����� ���� ��� ��������    �����
      l_rpt_m_dt       date; -- ����� ���� ��� ̲������    �����
      l_rpt_q_dt       date; -- ����� ���� ��� ����������� �����
      l_rpt_p_dt       date; -- ����� ���� ��� ϲ�в����   �����
      l_rpt_y_dt       date; -- ����� ���� ��� в����      �����
      l_ret            pls_integer;
    begin

      l_bnk_dt := gl.gbd();

      bars_audit.trace( '%s: l_bnk_dt=%s.', title, to_char(l_bnk_dt,'dd.mm.yyyy') );

      if ( l_bnk_dt Is Not Null )
      then

        l_rpt_d_dt := BARS.DAT_NEXT_U( l_bnk_dt, -1 );

        l_rpt_t_dt := case
                        when ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM')+10, 0 ) )
                        then BARS.DAT_NEXT_U( l_bnk_dt, -1 )
                        when ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM')+20, 0 ) )
                        then BARS.DAT_NEXT_U( l_bnk_dt, -1 )
                        when ( l_bnk_dt = BARS.DAT_NEXT_U( last_day(l_bnk_dt)  +01, 0 ) )
                        then BARS.DAT_NEXT_U( l_bnk_dt, -1 )
                        else null
                      end;

        if ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM'), 0 ) )
        then -- ���� ��������� ���� = ������ ������� ���� �����
          -- ����� ���� = ���. ���. ���� �������� (�������) �����
          l_rpt_m_dt := BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM'), -1 ) ;
        end if;

        if ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'Q'), 0 ) )
        then -- ���� ��������� ���� = ������ ������� ���� ��������
          -- ����� ���� = ���. ���. ���� �������� (�������) ��������
          l_rpt_q_dt := BARS.DAT_NEXT_U( trunc(l_bnk_dt,'Q'), -1 ) ;
        end if;

        bars_audit.trace( '%s: l_rpt_d_dt=%s, l_rpt_t_dt=%s, l_rpt_m_dt=%s, l_rpt_q_dt=%s, l_rpt_p_dt=%s, l_rpt_y_dt=%s'
                        , title, to_char(l_rpt_d_dt,'dd.mm.yyyy'), to_char(l_rpt_t_dt,'dd.mm.yyyy')
                               , to_char(l_rpt_m_dt,'dd.mm.yyyy'), to_char(l_rpt_q_dt,'dd.mm.yyyy')
                               , to_char(l_rpt_p_dt,'dd.mm.yyyy'), to_char(l_rpt_y_dt,'dd.mm.yyyy') );

        for c in
        ( select f.FILE_ID
               , f.RPT_DT
               , m.KF
            from ( select ID as FILE_ID
                        , case PERIOD_TYPE
                             when 'D' then l_rpt_d_dt
                             when 'T' then l_rpt_t_dt
                             when 'M' then l_rpt_m_dt
                             when 'Q' then l_rpt_q_dt
                             when 'P' then l_rpt_p_dt
                             when 'Y' then l_rpt_y_dt
                             else null
                           end as RPT_DT
                     from NBUR_REF_FILES
                     where file_code not in ('#2C', '#42', '#8B', '#12') and
                           PERIOD_TYPE in ('D', 'T')
                 ) f
           cross
            join MV_KF m
           where f.RPT_DT Is Not Null
        ) loop

          l_ret := NBUR_QUEUE.f_put_queue_form_by_id( p_file_id     => c.FILE_ID
                                                    , p_bank_date   => l_bnk_dt
                                                    , p_report_date => c.RPT_DT
                                                    , p_kf          => c.KF
                                                    , p_userid      => null );

          bars_audit.trace( '%s: l_ret=%s, kf=%s, file_id=%s.', title, to_char(l_ret), c.KF, to_char(c.FILE_ID) );

        end loop;

      else
        bars_audit.error( title||': global bank date Is Null!' );
      end if;

      commit;

    end DAILY_TASK;



BEGIN

  -- Set user kf value
  l_usr_mfo := sys_context('bars_context','user_mfo');

  -- ��������� ���� (��������)
  l_bankdate := gl.bd;

END NBUR_QUEUE;
/
 show errors;
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_queue.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE PACKAGE BARS.NBUR_QUEUE
is

  g_header_version  constant varchar2(64)  := 'version 4.7  2017.08.19';
  g_header_defs     constant varchar2(512) := '';

  -- header_version - ����� ��������� ������
  function header_version return varchar2;

  -- body_version - ����� ��� ������
  function body_version return varchar2;

  -- ��������� ���������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
  function f_get_local_version(p_report_date in date, p_kf in varchar2) return number;

  -- ��������� ����������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
  function f_get_global_version(p_report_date in date, 
                                p_kf in varchar2,
                                p_local_version_id in number:=null) return number;

  -- ��������� ����
  function f_create_version(p_report_date         in date,
                            p_kf                  in varchar2,
                            p_version_id          in number,
                            p_global_version_id   out number) return number;

  -- ��������� ������� ����
  procedure p_update_version(p_report_date    in date, 
                             p_kf             in varchar2,
                             p_version_id     in number, 
                             p_status         in varchar2,
                             p_type           in number default 1);

  -- ��������� ������� ������ ����������� ID
  procedure p_update_version(p_global_version_id in number, 
                             p_status in varchar2);    
                             
  -- ��������� ������� �����  ���� ��������� �� ����� ��� �� KF
  procedure p_update_other_version(p_report_date in date, 
                                   p_kf in varchar2,
                                   p_version_id in number, 
                                   p_status in varchar2);
                                                    
  -- ������� ����� � �����
  function f_put_queue_form (p_report_date in date,
                             p_file_code in varchar2,
                             p_scheme in varchar2,
                             p_type in number,
                             p_kf in varchar2,
                             p_status in number default 0) return varchar2;

  -- ������� ����� � �����
  function f_put_queue_form_by_id (p_file_id in number, 
                                   p_bank_date in date,
                                   p_report_date in date,
                                   p_kf in varchar2,
                                   p_userid in number,
                                   p_status in number default 0) return number;

  -- ������� ��� ����� � ����� 
  function f_put_queue_all_forms (p_bank_date in date,  
                                  p_report_date in date  default null, 
                                  p_kf in varchar2 default null) return number;
                                  
  -- �������� ���������� ���������� ����� � ����� ��� ����� ������������ ������� ����������
  -- � ����� ������� ����� ����� �����, � � ���� ����� ����������� ����������� �����
  procedure p_repeat_put_forms;

  -- ������� ��� �������� ����� � ����� 
  function f_put_queue_dep_forms (p_bank_date in date,  
                                  p_report_date in date,
                                  p_kf in varchar2, 
                                  p_type in number,
                                  p_userid in number,
                                  p_status in number default 0) return number;
                                              
  -- ������� ��'���� � �����
  function f_put_queue_object (p_object_id in number, 
                               p_report_date in date, 
                               p_kf in varchar2,
                               p_status in number default 0) return number;            

  -- ������� ��� ��'���� � �����
  function f_put_queue_all_objects (p_report_date in date, 
                                    p_kf in varchar2) return number;         
                                    
  -- ����� ����� � ��'����
  function f_check_queue_objects(p_kf in varchar2 default null) return number;

  -- ����� ����� ��� ��'����
  function f_check_queue_without_objects(p_period_type in number, p_kf in varchar2 default null) return number;
    -- p_period_type = 1 - ������������ ������ �� ������ �����
    -- p_period_type = 2 - ������������ ���� �����
  
  -- ����� ����� � �����
  function f_check_queue_forms(p_version_id   in number, 
                               p_report_date  in date,
                               p_kf           in varchar2,
                               p_userid       in number,
                               p_proc_type    in number,
                               p_period_type  in number) return number;

  -- ����� ����� � ������� ������
  function f_check_queue_group_forms( p_version_id    in number, 
                                      p_report_date   in date,
                                      p_kf            in varchar2,
                                      p_userid        in number,
                                      p_file_id       in number,
                                      p_file_id_end   in number,
                                      p_proc_type     in number,
                                      p_period_type   in number) return number;

  -- ������� ����� � ��'����
  procedure p_clear_queue_objects( p_report_date in date, 
                                   p_kf          in varchar2);

  -- ������� ����� � �����
  procedure p_clear_queue_forms( p_report_date in date, 
                                 p_kf in varchar2,
                                 p_period_type   in number);

  -- 
  procedure p_clear_queue_one_form( p_report_date  in date,
                                    p_kf           in varchar2,
                                    p_file_id      in number);

  -- ��������� ������ �� ���������� ���� ����� �� ��볿
  procedure p_rollback_all( p_report_date in date
                          , p_kf in varchar2 );

  --
  -- DAILY_TASK
  --
  procedure DAILY_TASK;

end NBUR_QUEUE;
/
show err;

CREATE OR REPLACE PACKAGE BODY BARS.NBUR_QUEUE 
is
  g_body_version  constant varchar2(64)  := 'version 7.0  2017.11.23';
  g_body_defs     constant varchar2(512) := '';
  
  MODULE_PREFIX   constant varchar2(10)  := 'NBUR';
  
  --
  -- types
  --
  
  --
  -- variables
  --
  l_usr_mfo            varchar2(6);
  l_bankdate           date;

    -- header_version - ����� ��������� ������
    function header_version return varchar2 is
    begin
      return 'Package header NBUR_QUEUE ' || g_header_version || '.' || chr(10) ||
             'Package header definition(s): ' || chr(10) ||  g_header_defs;
    end header_version;

    -- body_version - ����� ��� ������
    function body_version return varchar2 is
    begin
      return 'Package body NBUR_QUEUE ' || g_body_version || '.' || chr(10) ||
             'Package body definition(s): ' || chr(10) || g_body_defs;
    end body_version;

    procedure p_errors_log(p_add_mes in varchar2, p_errm in varchar2) is
    begin
      logger.error( $$PLSQL_UNIT||': '||p_add_mes||CHR(10)||p_errm||CHR(10)||
                     dbms_utility.format_error_backtrace());
    end;
    
    procedure p_errors_log(p_add_mes in varchar2 := null) is
    begin
      p_errors_log(p_add_mes, sqlerrm);
    end;
    
    procedure p_errors_log(p_report_date in date, 
                           p_kf in number, 
                           p_file_id in number, 
                           p_report_code in varchar2, 
                           p_version_id in number, 
                           p_userid in number,
                           p_add_mes in varchar2 := null) 
    is
        l_txt   clob;
        l_errm  clob := sqlerrm;
    begin
        p_errors_log('', l_errm);
        
        l_txt :=  l_errm||CHR(10)||dbms_utility.format_error_backtrace();
        
        l_txt :=  replace(l_txt, CHR(10), '<br> '||CHR(10));
        
        insert into nbur_lst_errors (report_date, kf, report_code, version_id, 
            error_id, error_txt, userid, file_id)
        values (p_report_date, p_kf, p_report_code, p_version_id, 
            s_nbur_errors.nextval, l_txt, p_userid, p_file_id);
    end;

    procedure p_info_log(p_add_mes in varchar2 := null) is
    begin
      logger.info( $$PLSQL_UNIT||': '||p_add_mes||CHR(10));
    end;

    procedure p_send_message(p_txt_mes in varchar2,
                             p_uid     in number := null) is
    begin
        -- ������� ����������� �����������

       if getglobaloption('BMS')='1'-- BMS �������: 1-����������� �������� ���������
       then
          bms.add_subscriber(p_uid);
          bms.enqueue_msg(p_txt_mes, dbms_aq.no_delay, dbms_aq.never, p_uid);
       end if;
    end;

    -- ��������� ��� ���������� ����� �� ����� � ������ � �����
    procedure p_notice_all(p_proc_type in number, 
                           p_period_type in number, 
                           p_kf in varchar2 default null) is
    begin
        -- ����� ��� �������, �� �������� �����, �� ���������� ��-������
        if p_proc_type = 1 then
           update NBUR_QUEUE_FORMS
           set status = 1
           where proc_type = p_proc_type and
                 (p_kf is null or nvl(kf, p_kf) = p_kf);
                 
           update NBUR_QUEUE_OBJECTS
           set status = 1 
           where (p_kf is null or nvl(kf, p_kf) = p_kf);
        else -- ������� ������� ����������� (��� NBUR_QUEUE_OBJECTS)
           update NBUR_QUEUE_FORMS
           set status = 1
           where proc_type = p_proc_type and
                 id in (select id 
                        from NBUR_REF_FILES 
                        where p_period_type = 1 and period_type in ('D', 'T') or
                              p_period_type = 2 and period_type not in ('D', 'T')) and
                 (p_kf is null or nvl(kf, p_kf) = p_kf);
        end if;

        commit;
    end p_notice_all;

    procedure p_send_message_all(p_kf           in varchar2,
                                 p_filecode     in varchar2,
                                 p_txt_mes      in varchar2) is
    begin
        -- �������� ��� ������������, ���� ������� ��� ����, �����������
        for k in (select usr_id
                  from V_NBUR_ROLE_USER_FILE
                  where file_code = p_filecode and
                        usr_id in  (select id
                                    from staff$base
                                    where SUBSTR (bars_context.extract_mfo (branch), 1, 12) = p_kf or
                                          branch = '/')
                  order by 1)
        loop
            p_send_message(p_txt_mes, k.usr_id);
        end loop;
    end;

    function f_try_old_proc(p_report_date      in date,
                            p_kodf             in varchar2,
                            p_a017             in varchar2,
                            p_kf               in varchar2
                          ) return number
    is
        l_ret         number  := 0;
        l_proc_name   varchar2(100);
    begin
        select max(p.name) proc_name
        into l_proc_name
        from kl_f00 f, rep_proc p
        where f.kodf= p_kodf and
              f.procc = p.procc;

         begin
             execute immediate
                  'begin '||l_proc_name||'(:dat_); end; '
             using p_report_date;

             p_send_message('���� #'||p_kodf||'('||p_a017||') �� ���� '||
                  to_char(p_report_date, 'dd.mm.yyyy')||' ������ ����������!', user_id);
         exception
              when others then
                      p_send_message('��� ���������� ����� #'||p_kodf||'('||p_a017||') �� ���� '||
                          to_char(p_report_date, 'dd.mm.yyyy')||' ������� �������!', user_id);

                      p_errors_log('ERROR LOAD #'||p_kodf||'('||p_a017||')'||
                         ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
         end;

        return l_ret;
    end f_try_old_proc;

    -- ��������� ���������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
    function f_get_local_version(p_report_date      in date,
                                 p_kf               in varchar2) return number
    is
        l_local_version_id    number;
    begin
        -- ���� ������� ����� �� ��� kf, �� �������
        -- ��������� ����� ���� �� ��� kf
        if p_kf is null then
           select nvl(max(version_id), 0)
           into l_local_version_id
           from NBUR_LST_VERSIONS
           where report_date = p_report_date;
        else -- ������ ��������� ����� �������� ������kf
           select nvl(max(version_id), 0)
           into l_local_version_id
           from NBUR_LST_VERSIONS
           where report_date = p_report_date and
                 kf = p_kf;
        end if;

        return l_local_version_id;
    end f_get_local_version;

    -- ��������� ����������� �������������� �������� ���� ����� ��� ����� ���� �� ��볿
    function f_get_global_version(p_report_date in date,
                                  p_kf in varchar2,
                                  p_local_version_id in number:=null) return number
    is
        l_global_version_id    number;
        l_local_version_id     number := p_local_version_id;
    begin
        if l_local_version_id is null then
           l_local_version_id := f_get_local_version(p_report_date, p_kf);
        end if;

        select id
        into l_global_version_id
        from NBUR_LST_VERSIONS
        where report_date = p_report_date and
              kf = p_kf and
              version_id = l_local_version_id;

        return l_global_version_id;
    exception
        when no_data_found then
             p_errors_log('not found ID for DAT='||to_char(p_report_date, 'dd.mm.yyyy')||' KF= '||p_kf);
             return -1;
    end;

    -- ��������� ����
    function f_create_version(p_report_date         in date,
                              p_kf                  in varchar2,
                              p_version_id          in number,
                              p_global_version_id   out number) return number is
        l_global_version_id    number;
        l_local_version_id     number;
    begin
        if p_version_id is null then
           l_local_version_id := f_get_local_version(p_report_date, p_kf) + 1;
        else
           l_local_version_id := p_version_id;
        end if;

        if p_kf is not null then
            l_global_version_id := S_NBUR_LIST_VERSIONS.nextval;

            insert into NBUR_LST_VERSIONS(ID, REPORT_DATE, KF, VERSION_ID, CREATED_TIME, STATUS)
            values (l_global_version_id, p_report_date, p_kf, l_local_version_id, sysdate, 'RUNNING');

            p_global_version_id := l_global_version_id;

            logger.trace( 'NBUR create version %s for KF = %s.', l_global_version_id||' '||l_local_version_id, p_kf);
        else
            for i in (select KF from BARS.MV_KF)
            loop
                l_global_version_id := S_NBUR_LIST_VERSIONS.nextval;

                insert into NBUR_LST_VERSIONS(ID, REPORT_DATE, KF, VERSION_ID, CREATED_TIME, STATUS)
                values (l_global_version_id, p_report_date, i.kf, l_local_version_id, sysdate, 'RUNNING');

                logger.trace( 'NBUR create version %s for KF = %s.', l_global_version_id||' '||l_local_version_id, i.kf);
            end loop;

            l_global_version_id := null;
        end if;

        return l_local_version_id;
    end f_create_version;

    -- ��������� �������  ����
    procedure p_update_version(p_report_date    in date,
                               p_kf             in varchar2,
                               p_version_id     in number,
                               p_status         in varchar2,
                               p_type           in number default 1)
    is
        l_global_version_id    number;
    begin
        l_global_version_id := f_get_global_version(p_report_date, p_kf, p_version_id);

        if l_global_version_id < 0 then
           return;
        end if;

        p_update_version(l_global_version_id, p_status);

        -- ���� ��� ���������� DM
        if p_status = 'FINISHED' and p_type = 1 then
           nbur_objects.SAVE_VERSION(p_report_date, p_kf, p_version_id);
        end if;
    end p_update_version;

    procedure p_update_version(p_global_version_id in number,
                               p_status in varchar2) is
    begin
        update NBUR_LST_VERSIONS
        set status = p_status,
            CREATED_TIME = sysdate
        where id = p_global_version_id;
    end p_update_version;

    -- ��������� ������� �����  ���� ��������� �� ����� ��� �� KF
    procedure p_update_other_version(p_report_date in date,
                                     p_kf in varchar2,
                                     p_version_id in number,
                                     p_status in varchar2)
    is
    begin
      for k in ( select ID global_version_id, VERSION_ID
                   from NBUR_LST_VERSIONS
                  where report_date = p_report_date
                    and kf = p_kf
                    and version_id < p_version_id
                    and status in ('VALID', 'FINISHED')
                )
      loop

--      nbur_files.p_update_files_status(p_report_date, p_kf, k.version_id, null, p_status);

        p_update_version(k.global_version_id, p_status);
        
      end loop;
      
    end p_update_other_version;
    
    -- ��������� ����, ���� ���� �����������
    function f_blc_obj_version(p_report_date      in date,
                               p_kf               in varchar2,
                               p_object_id        in number) return number
    is
        l_local_version_id    number;
    begin
        select max(version_id)
        into l_local_version_id
        from NBUR_LST_BLC_OBJECTS
        where report_date = p_report_date and
              kf = p_kf and
              object_id = p_object_id;

        return l_local_version_id;
    end f_blc_obj_version;

    -- ��������� ����, ���� ���� �����������
    function f_blc_file_version(p_report_date      in date,
                                p_kf               in varchar2,
                                p_file_id          in number) return number
    is
        l_local_version_id    number;
    begin
        select max(version_id)
        into l_local_version_id
        from NBUR_LST_BLC_FILES
        where report_date = p_report_date and
              kf = p_kf and
              file_id = p_file_id;

        return l_local_version_id;
    end f_blc_file_version;

    -- ������� ����� � ��'����
    procedure p_clear_queue_objects(p_report_date in date,
                                    p_kf in varchar2) is
    begin
        delete
        from NBUR_QUEUE_OBJECTS
        where report_date = p_report_date and
              kf = p_kf and
              status = 1;
    end p_clear_queue_objects;

    -- ������� ����� � ��'����
    procedure p_clear_queue_objects_all(p_report_date in date) is
    begin
        delete
        from NBUR_QUEUE_OBJECTS
        where report_date = p_report_date and
              status = 1;
    end p_clear_queue_objects_all;

    -- ������� ������ ����� � �����
    procedure p_clear_queue_one_form(p_report_date  in date,
                                     p_kf           in varchar2,
                                     p_file_id      in number) is
    begin
        delete
        from NBUR_QUEUE_FORMS
        where report_date = p_report_date and
              kf = p_kf and
              id = p_file_id and
              status = 1;
    end p_clear_queue_one_form;

    -- ������� ����� � �����
    procedure p_clear_queue_forms(p_report_date in date,
                                  p_kf in varchar2,
                                  p_period_type   in number) is
    begin
        delete
        from NBUR_QUEUE_FORMS
        where report_date = p_report_date and
              kf = p_kf and
              id in (select id 
                     from NBUR_REF_FILES 
                     where p_period_type = 1 and period_type in ('D', 'T') or
                           p_period_type = 2 and period_type not in ('D', 'T')) and
              status = 1;
    end p_clear_queue_forms;

    -- ������� ����� � �����
    procedure p_clear_queue_forms_all(p_report_date in date) is
    begin
        delete
        from NBUR_QUEUE_FORMS
        where report_date = p_report_date and
              status = 1;
    end p_clear_queue_forms_all;

    -- ������� ����� � �����
    function f_put_queue_form (p_report_date in date,
                               p_file_code in varchar2,
                               p_scheme in varchar2,
                               p_type in number,
                               p_kf in varchar2,
                               p_status in number default 0) return varchar2 is
        l_id_file         number;
        l_cnt             number;
        l_ret             number;
        l_ret_mes         varchar2(200);
        l_ret_mes_add     varchar2(200);
        l_wokdday         date;
    begin
        select count(*)
        into l_cnt
        from mv_kf   
        where kf = p_kf; 
        
        if l_cnt = 0 then
           l_ret_mes := '���������� ����� �� ������ �������� ���������! �������, ����-�����, ���� ���!';

           return l_ret_mes;
        end if;

        -- ������������� �����
        l_id_file := nbur_files.f_get_id_file(p_file_code, p_scheme, p_type);
        
        l_wokdday := f_workday(p_report_date);
        
        if l_wokdday is null then
           l_ret_mes := '���� '||to_char(p_report_date, 'dd.mm.yyyy')||' � �������� ����!'||  
                        ' ������� ���� ����!';

           return l_ret_mes;
        end if;

        select count(*)
        into l_cnt
        from NBUR_REF_CALENDAR b
        where b.calendar_date = l_bankdate and
              b.report_date = p_report_date and
              nvl(b.kf, p_kf) = p_kf and
              b.file_id = l_id_file and
              status = 'TRUE';
        
        if (p_kf = 300465 and
            p_report_date < to_date('17032017','ddmmyyyy') and 
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 324805 and
            p_report_date < to_date('01042017','ddmmyyyy') and 
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 322669 and
            p_report_date < to_date('26052017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 351823 and
            p_report_date < to_date('08092017','ddmmyyyy') and 
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 304665 and
            p_report_date < to_date('20102017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or
           (p_kf = 335106 and
            p_report_date < to_date('24112017','ddmmyyyy') and
            p_report_date <> to_date('30122016','ddmmyyyy')) or            
            p_report_date > bankdate
        then
          l_cnt := -1;
        else -- ��������� �� ���� �������� �� ���������� ��������� ��������
          l_cnt := 1;
        end if;

        if l_cnt > 0 then
            -- ������� � �����
            l_ret := f_put_queue_form_by_id(l_id_file, l_bankdate, p_report_date,
                            p_kf, user_id, p_status);

            if l_ret = -3 then -- ��� � � ����
                p_info_log('NBUR F_PUT_QUEUE_FORM ��� � � ����'||CHR(10)||
                            ' file_code='||to_char(p_file_code)||
                            ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
            end if;
        elsif l_cnt = -1 then
            -- ���� �� ��������� ��� ����������
            p_info_log('NBUR F_PUT_QUEUE_FORM ���� ���������� ��� ���������� ������ �����! '||
                        ' file_code='||to_char(p_file_code)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

            l_ret := -4;
        else
            -- ���� �� ��������� ��� ����������
            p_info_log('NBUR F_PUT_QUEUE_FORM ����������� ��� ���������� � �� ='||
                        to_char(l_bankdate, 'dd.mm.yyyy')||CHR(10)||
                        ' file_code='||to_char(p_file_code)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

            l_ret := -2;
        end if;
        
        if l_ret in (0, -3) then
           begin
               SELECT f_nbur_get_wait_time((case when p_type = 1 then 1
                                                 when p_type = 2 and f.PERIOD_TYPE in ('D', 'T') then 2
                                                 else 3
                                            end)) wait_time
                 INTO l_ret_mes_add
                  FROM nbur_ref_files f, nbur_ref_procs l
                 WHERE f.id = l_id_file AND f.id = l.file_id(+);
           exception
              when others then l_ret_mes_add := '';
           end;         
           
           if trim(l_ret_mes_add) is not null then
              l_ret_mes_add := '�� ������� ������� ����� ������� '||l_ret_mes_add||' ��.';
           end if;                               
        end if;
        
        if l_ret = 0 then
           l_ret_mes := '���� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' ������� � �����. ������� �� �����������! '||l_ret_mes_add;
        elsif l_ret = -2 then
           l_ret_mes := '���� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' �� ��������� ��� ���������� �� ��� ����. ��������� �� ������������!';
        elsif l_ret = -3 then
           l_ret_mes := '���� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' ��� � � ����. ������� �� �����������! '||l_ret_mes_add;
        elsif l_ret = -4 then
           l_ret_mes := '�� ���� �� �������� ��� ���������� ����� !!!'||
                        ' ������� ���� ����!';
        else
           l_ret_mes := '�������� � ��������� ����� '||to_char(p_file_code)||' �� '||to_char(p_report_date, 'dd.mm.yyyy')||
                        ' � �����. ��������� �� ������������!';
        end if;

        return l_ret_mes;
    end f_put_queue_form;

    -- ������� ����� � �����
    function f_put_queue_form_by_id (p_file_id in number,
                                     p_bank_date in date,
                                     p_report_date in date,
                                     p_kf in varchar2,
                                     p_userid in number,
                                     p_status in number default 0) return number is
        l_ret             number;
        l_type_proc       number;
        l_exists          number := 0;
    begin
        begin
            select (case
                        when proc_type = 'F' then 1 -- ���� ���������
                        when proc_type = 'O' then 2 -- ��������������
                        else 0                      -- �� ����������
                    end)
            into l_type_proc
            from NBUR_REF_PROCS
            where file_id = p_file_id and
                proc_type in ('F', 'O') and
                (date_finish is null or date_finish > p_report_date);
        exception
            when no_data_found then l_type_proc := 0;
        end;

        -- �������� �������� ����� � ����
        select count(*)
        into l_exists
        from NBUR_QUEUE_FORMS
        where id = p_file_id and
              report_date = p_report_date and
              kf = p_kf;
              
        if l_exists > 0 then
           -- ��� � � ����
           return -3;
        end if;
        
        -- ������� � �����
        begin
            insert into NBUR_QUEUE_FORMS(ID, REPORT_DATE, DATE_START, KF, USER_ID, STATUS, PROC_TYPE)
            values(p_file_id, p_report_date, sysdate, p_kf, p_userid, p_status, l_type_proc);
        exception
            when others then
                if sqlcode = -1 then
                   -- ��� � � ����
                   return -3;
                else
                   p_errors_log('F_PUT_QUEUE_FORM 2) id='||to_char(p_file_id)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF= '||p_kf);

                   return -1;
                end if;
        end;

        -- ������� � ����� ������� ��'���� ��� ����� �����
        for k in (select l.object_id, f.report_date, f.kf
                  from NBUR_QUEUE_FORMS f, NBUR_LNK_FILES_OBJECTS l
                  where f.status = p_status and
                      (f.kf = p_kf or p_kf is null) and
                      f.id = p_file_id and
                      f.id = l.file_id and
                     (l.start_date <= f.report_date and
                      l.finish_date is null or
                      l.finish_date > f.report_date))
        loop
            -- ������� � ����� �����
            l_ret := f_put_queue_object(k.object_id, k.report_date, k.kf, p_status);
        end loop;

        -- ������� � ����� �������� ����, �� �������� �� ������ ������
        l_ret := f_put_queue_dep_forms (p_bank_date, p_report_date, p_kf, 2,
                        p_userid, p_status);

        return 0;
    end f_put_queue_form_by_id;

    -- ������� ��� �������� ����� � �����
    function f_put_queue_dep_forms (p_bank_date in date,
                                    p_report_date in date,
                                    p_kf in varchar2,
                                    p_type in number,
                                    p_userid in number,
                                    p_status in number default 0) return number
    is
        l_ret   number;
    begin
        if p_type = 1 then
            -- ������� � ����� �����, �� �������� �� ������ ��'���� � ����
            for k in (select distinct l.file_id, q.kf
                      from NBUR_QUEUE_OBJECTS q,
                           NBUR_LNK_FILES_OBJECTS l,
                           NBUR_REF_FILES_LOCAL f
                      where q.status = p_status and
                            (q.report_date = p_report_date or p_report_date is null) and
                             nvl(q.kf, p_kf) = p_kf and
                             q.id = l.object_id and
                             l.file_id = f.file_id and
                             (l.start_date <= p_report_date and
                              l.finish_date is null or
                              l.finish_date > p_report_date) and
                             nvl(f.kf, p_kf) = p_kf and
                             f.file_id not in (select b.id
                                               from NBUR_QUEUE_FORMS b
                                               where b.status = 1 and
                                                     b.report_date = p_report_date and
                                                     (nvl(b.kf, p_kf) = p_kf)) and
                             f.file_id in (select b.file_id
                                           from NBUR_REF_CALENDAR b
                                           where b.calendar_date = p_bank_date and
                                                 nvl(b.report_date, p_report_date) = p_report_date and
                                                 nvl(b.kf, p_kf) = p_kf and
                                                 status = 'TRUE')
                     )
            loop
                -- ������� � �����
                l_ret := f_put_queue_form_by_id (k.file_id, p_bank_date,
                            p_report_date, k.kf, p_userid, p_status);
            end loop;
        elsif p_type = 2 then
            -- ������� � ����� �����, �� �������� �� ������ ����� NBUR_QUEUE_FORMS
            for k in (select distinct l.file_dep_id, q.kf
                      from NBUR_QUEUE_FORMS q,
                           NBUR_LNK_FILES_FILES l,
                           NBUR_REF_FILES_LOCAL f
                      where  q.status = p_status and
                             (q.report_date = p_report_date or p_report_date is null) and
                             nvl(q.kf, p_kf) = p_kf and
                             q.id = l.file_id and
                             l.file_dep_id = f.file_id and
                             (l.start_date <= p_report_date and
                              l.finish_date is null or
                              l.finish_date > p_report_date) and
                             nvl(f.kf, p_kf) = p_kf and
                             f.file_id not in (select b.id
                                               from NBUR_QUEUE_FORMS b
                                               where b.status = 1 and
                                                     b.report_date = p_report_date and
                                                     (nvl(b.kf, p_kf) = p_kf)) and
                             f.file_id in (select b.file_id
                                           from NBUR_REF_CALENDAR b
                                           where b.calendar_date = p_bank_date and
                                                 nvl(b.report_date, p_report_date) = p_report_date and
                                                 nvl(b.kf, p_kf) = p_kf and
                                                 status = 'TRUE')
                     )
            loop
                -- ������� � �����
                l_ret := f_put_queue_form_by_id (k.file_dep_id, p_bank_date,
                                p_report_date, k.kf, p_userid, p_status);
            end loop;
        end if;

        return 0;
    end f_put_queue_dep_forms;

    -- ������� ��� ����� � �����
    function f_put_queue_all_forms (p_bank_date in date,
                                    p_report_date in date  default null,
                                    p_kf in varchar2 default null) return number is
        l_ret   number;
    begin
        -- ������ ����� ��� �������
        for k in (select report_date, file_id, nvl(kf, p_kf) kf
                  from NBUR_REF_CALENDAR
                  where calendar_date = p_bank_date and
                        (report_date = p_report_date or p_report_date is null) and
                        (nvl(kf, p_kf) = p_kf or p_kf is null) and
                        status = 'TRUE'
                  order by id)
        loop
            -- ������� � �����
            l_ret := f_put_queue_form_by_id (k.file_id, p_bank_date, k.report_date,
                            k.kf, null, 0);
        end loop;

        return 0;
    end f_put_queue_all_forms;

    -- �������� ���������� ���������� ����� � ����� ��� ����� ������������ ������� ����������
    -- � ����� ������� ����� ����� �����, � � ���� ����� ����������� ����������� �����
    procedure p_repeat_put_forms
    is
        l_ret number;

        TYPE t_tab_queue IS TABLE OF NBUR_QUEUE_FORMS%ROWTYPE;
        l_tab_queue t_tab_queue;
    begin
        SELECT *
        BULK COLLECT INTO l_tab_queue
        FROM NBUR_QUEUE_FORMS;

        for i in l_tab_queue.first..l_tab_queue.last loop
            p_clear_queue_one_form(l_tab_queue(i).report_date, l_tab_queue(i).kf, l_tab_queue(i).id);

            l_ret := f_put_queue_form_by_id(l_tab_queue(i).id, bankdate, l_tab_queue(i).report_date, l_tab_queue(i).kf, l_tab_queue(i).user_id);
        end loop;

        commit;
    end p_repeat_put_forms;

    -- ������� ��'���� � �����
    function f_put_queue_object (p_object_id in number,
                                 p_report_date in date,
                                 p_kf in varchar2,
                                 p_status in number default 0) return number is
    begin
        -- ������� � �����
        begin
            insert into NBUR_QUEUE_OBJECTS(ID, REPORT_DATE, DATE_START, ROW_COUNT, KF, STATUS)
            values(p_object_id, p_report_date, sysdate, 0, p_kf, p_status);
        exception
            when others then
                if sqlcode = -1 then
                   return 1;
                else
                   p_errors_log('PUT QUEUE OBJ id='||to_char(p_object_id)||
                        ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

                   return -1;
                end if;
        end;

        return 0;
    end f_put_queue_object;

    -- ������� ��� ��'���� � �����
    function f_put_queue_all_objects (p_report_date in date,
                                      p_kf in varchar2) return number is
        l_ret   number;
    begin
        for k in (select L.OBJECT_ID, f.kf
                  from NBUR_QUEUE_FORMS f, NBUR_LNK_FILES_OBJECTS l
                  where (f.kf = p_kf or p_kf is null) and
                      f.id = l.file_id and
                     (l.start_date <= p_report_date and
                      l.finish_date is null or
                      l.finish_date > p_report_date))
        loop
            -- ������� � �����
            l_ret := f_put_queue_object(k.object_id, p_report_date, p_kf);
        end loop;

        return 0;
    end f_put_queue_all_objects;

    -- ������� ��� �������� ����� � �����
    function f_put_queue_dep_objects(p_status in number default 0,
                                     p_kf in varchar2 default null) return number
    is
        l_ret   number;
    begin
        -- ������� � ����� �����, �� �������� �� ������ ��'���� � ����
        for k in (select l.object_pid object_id, o.report_date, o.kf
                  from NBUR_QUEUE_OBJECTS o
                  join
                        (select object_id, CONNECT_BY_ROOT object_pid as object_pid
                        from NBUR_LNK_OBJECT_OBJECT l
                        CONNECT BY NOCYCLE PRIOR object_id = object_pid) l
                   on (O.ID = l.object_id)
                   where (p_kf is not null and
                          p_kf = o.kf or
                          p_kf is null) and
                         o.status = p_status and
                         not exists (select 1
                                     from NBUR_QUEUE_OBJECTS o1
                                     where o1.id = l.object_pid and
                                           o1.report_date = o.report_date and
                                           o1.kf = o.kf)
                 )
        loop
            -- ������� � �����
            l_ret := f_put_queue_object(k.object_id, k.report_date, k.kf, p_status);
        end loop;

        return 0;
    end f_put_queue_dep_objects;

    function f_load_object(p_report_date in date,
                           p_kf          in varchar2,
                           p_version_id  in number,
                           p_object_id   in number,
                           p_object_name in varchar2,
                           p_proc_insert in varchar2
                           ) return number
    is
        l_version_blc_id        number;
    begin
        if p_kf is not null then
           l_version_blc_id := f_blc_obj_version(p_report_date, p_kf, p_object_id);
        else
           l_version_blc_id := null;
        end if;

        if l_version_blc_id is null then
            -- ���� ���� ����������� ���� �����, �� ������� � ��������
            if p_proc_insert is not null
            then
               declare
                   l_cnt         number := 0;
                   l_start_time  timestamp := systimestamp;
               begin
                   execute immediate
                        'begin '||trim(p_proc_insert)||'(:dat_, :kf_, :id_); end; '
                   using p_report_date, p_kf, p_version_id;
               exception
                    when others then
                        select count(*)
                        into l_cnt
                        from NBUR_LST_OBJECTS
                        where report_date = p_report_date and
                              kf = p_kf and
                              object_id = p_object_id and
                              version_id = p_version_id;

                        if l_cnt = 0 then
                            insert into NBUR_LST_OBJECTS
                                 (REPORT_DATE, KF, OBJECT_ID, VERSION_ID, START_TIME, FINISH_TIME, OBJECT_STATUS )
                            values
                                 (p_report_date, p_kf, p_object_id, p_version_id, l_start_time, systimestamp, 'ERROR' );
                        else
                            update NBUR_LST_OBJECTS
                            set finish_time = systimestamp,
                                object_status = 'ERROR'
                            where report_date = p_report_date and
                                  kf = p_kf and
                                  object_id = p_object_id and
                                  version_id = p_version_id;
                        end if;

                        p_errors_log('ERROR LOAD '||p_object_name||
                           ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
                        return -1;
               end;

               commit;
            end if;
        else -- ������ ������� � ������
            declare
                l_sql_fields            varchar2(2000);
                l_sql_txt               varchar2(20000);
                l_glb_version_blc_id    number;
                l_start_time            timestamp;
            begin
                select listagg(column_name, ', ') WITHIN GROUP (ORDER BY rn)
                into l_sql_fields
                from (select column_name, rownum rn
                      from (select column_name
                            from ALL_TAB_COLUMNS
                            where owner = 'BARS' and
                                table_name = p_object_name
                                intersect
                            select column_name
                            from ALL_TAB_COLUMNS
                            where owner = 'BARS' and
                                table_name = p_object_name||'_ARCH'));

                l_sql_txt := 'insert into '||p_object_name||'('||l_sql_fields||')'||chr(10);
                l_sql_txt := l_sql_txt || ' select '||l_sql_fields||' from '||p_object_name||'_ARCH'||chr(10);
                l_sql_txt := l_sql_txt || ' where  report_date = :p1 and kf = :p2 and version_id = :p3 ';

                begin
                   l_start_time := systimestamp;

                   execute immediate l_sql_txt
                   using p_report_date, p_kf, l_version_blc_id;

                   l_glb_version_blc_id := f_get_global_version(p_report_date, p_kf, l_version_blc_id);

                   insert into BARS.NBUR_LST_OBJECTS
                         (REPORT_DATE, KF, OBJECT_ID, VERSION_ID, START_TIME, OBJECT_STATUS )
                   values
                         (p_report_date, p_kf, p_object_id, p_version_id, l_start_time, 'FINISHED' );

                   insert into NBUR_LNK_VERSIONS(REPORT_DATE, KF, VERSION_ID, OBJECT_ID, GLBL_VRSN_ID)
                   values (p_report_date, p_kf, p_version_id, p_object_id, l_glb_version_blc_id);
                exception
                    when others then
                        insert into BARS.NBUR_LST_OBJECTS
                             (REPORT_DATE, KF, OBJECT_ID, VERSION_ID, START_TIME, OBJECT_STATUS )
                        values
                             (p_report_date, p_kf, p_object_id, p_version_id, l_start_time, 'ERROR' );

                        p_errors_log('ERROR LOAD '||p_object_name||
                           ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
                        return -1;
                end;

                commit;
            exception
                when others then
                    p_errors_log('ERROR LOAD '||p_object_name||
                       ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);
            end;
        end if;

        return 0;
    end;

    -- ����� ����� � ��'����
    function f_check_queue_objects(p_kf in varchar2 default null) return number is
        l_ret                   number;
        l_report_date           date;
        l_report_date_prev      date;
        l_kf                    varchar2(6);
        l_kf_prev               varchar2(6);
        l_version_id            number;
        l_global_version_id     number;
        l_version_blc_id        number;
        l_user_id               number;
    begin
        l_user_id := user_id;

        -- ��������� �� ����� � ����� ��� �������
        p_notice_all(1, null, p_kf);

        -- ������� � ����� �������� ����� (�� � ���������� ���������)
        l_ret := f_put_queue_dep_objects(1, p_kf);

        -- ��������� ������� ������������
        for p in (select distinct o.report_date, k.kf, o.kf kfo,
                    dense_rank() over (partition by o.report_date order by k.kf) rnum
                  from NBUR_QUEUE_OBJECTS o,
                       V_NBUR_PERELIK_KF k
                  where ((p_kf is not null and
                          p_kf = k.kf or
                          p_kf is null) and o.kf = k.kf
                            or
                         o.kf is null) and
                        o.status = 1
                  order by 1 desc, 2)
        loop
            l_report_date := p.report_date;
            l_kf := p.kf;

            -- ��������� ���� ��� ������������
            -- ���� ���������� �� kf, �� ��� ��� - ��������� ����� ����
            if p.rnum = 1 and p.kfo is null then
               l_version_id := f_create_version(l_report_date, p.kfo, null, l_global_version_id);
            elsif p.kfo is not null then
               l_version_id := f_create_version(l_report_date, p.kf, null, l_global_version_id);
            end if;

            commit;

            -- ���������� ����� �� ���������� �����
            for o in (select q.report_date,
                             nvl(q.kf, l_kf) kf,
                             q.id object_id,
                             o.object_name,
                             o.proc_insert,
                             count(l.object_id) cnt
                        from nbur_queue_objects q
                        join nbur_ref_objects o
                        on (q.id = o.id)
                        left outer join nbur_lst_blc_objects l
                        on (q.report_date = l.report_date and
                            q.id = l.object_id and
                            (l.kf = q.kf or q.kf is null))
                        where q.status = 1 and
                              q.report_date = l_report_date and
                              nvl(q.kf, l_kf)  = l_kf
                        group by q.report_date, q.kf, q.id, o.object_name, o.proc_insert
                        order by q.id
                     )
            loop
                -- ���o �� ��� � ���� ����������� ���� �����,
                -- �� ������� � �������� �� ��� kf �� ���� ���
                -- � ��������� ������� ���� ��� �� ���������� kf
                if p.rnum = 1 and o.cnt = 0 then
                   l_ret := f_load_object(o.report_date, p.kfo, l_version_id,
                            o.object_id, o.object_name, o.proc_insert);
                else
                -- ������ - ������� �� ������ kf (� �������� �� � ������)
                   l_ret := f_load_object(o.report_date, o.kf, l_version_id,
                            o.object_id, o.object_name, o.proc_insert);
                end if;
                
                commit;
            end loop;

            -- �������� ������������ ����� �� �������� �������
            -- �� ��������� � ����� �����, �� ���������� �� ���
            -- � ����������� ����������� ��� ������� � �����
            for k in (select id file_id, nvl(kf, l_kf) kf, report_date, user_id
                      from nbur_queue_forms f
                      where status = 1 and
                            proc_type = 1 and
                            report_date = l_report_date and
                            nvl(f.kf, l_kf)  = l_kf and
                            not exists (select 1 -- ���� �� ������������
                                        from nbur_lst_blc_files b
                                        where b.report_date = f.report_date and
                                              b.kf = nvl(f.kf, l_kf) and
                                              b.file_id = f.id) and
                            exists (select 1
                                    from NBUR_LNK_FILES_OBJECTS l,
                                         NBUR_LST_OBJECTS o
                                    where l.file_id = f.id and
                                          l.object_id = o.object_id and
                                          o.report_date = f.report_date and
                                          o.kf = nvl(f.kf, l_kf) and
                                          o.version_id = l_version_id and
                                          o.object_status in ('ERROR', 'RUNNING'))
                     )
            loop
                -- ������� ������ ��� ������ ����������
                l_ret := nbur_files.f_start_form_file(k.user_id, l_version_id, k.file_id,
                                    k.report_date, k.kf, sysdate);

                --������������ ������ ��� ������������ ����������� �����, �� �� ������� �����
                l_ret := nbur_files.f_finish_form_file(l_version_id, k.file_id,
                                    k.report_date, k.kf, 'STOPPED');

                -- �������� ���� � �����
                p_clear_queue_one_form(k.report_date, k.kf, k.file_id);

                p_send_message('���������� ����� ����������� ����� ������� ��� ����������� �����!'||
                                    ' ��������� �� ������������!', k.user_id);
            end loop;

            -- ������� �����
            p_clear_queue_objects(l_report_date, l_kf);

            commit;

            -- ���������� ��� ����� � ����� (��������� ���������� �����)
            for k in (select id file_id, nvl(kf, l_kf) kf, report_date
                      from nbur_queue_forms f
                      where status = 1 and
                            proc_type = 1 and
                            report_date = l_report_date and
                            nvl(f.kf, l_kf) = l_kf and
                            not exists (select 1 -- ���� �� ������������
                                        from nbur_lst_blc_files b
                                        where b.report_date = f.report_date and
                                              b.kf = nvl(f.kf, l_kf) and
                                              b.file_id = f.id)
                     )
            loop
                nbur_files.p_set_invalid_file (k.file_id, k.report_date, k.kf, null);
            end loop;

            -- �������� ����� �� ���������� �����
            l_ret := f_check_queue_forms(l_version_id, l_report_date, l_kf, l_user_id, 1, null);

            p_update_other_version(l_report_date, l_kf, l_version_id, 'INVALID');

            p_update_version(l_report_date, l_kf, l_version_id, 'FINISHED');

            l_report_date_prev := l_report_date;
            l_kf_prev := l_kf;
            
            commit;
        end loop;

        return l_ret;
    end f_check_queue_objects;

    -- ����� ����� ��� ��'����
    function f_check_queue_without_objects(p_period_type in number, p_kf in varchar2 default null) return number
    -- p_period_type = 1 - ������������ ������ �� ������ �����
    -- p_period_type = 2 - ������������ ���� �����
    is
        l_ret                   number;
        l_report_date           date;
        l_report_date_prev      date;
        l_kf                    varchar2(6);
        l_version_id            number;
        l_global_version_id     number;
        l_version_blc_id        number;
        l_user_id               number;
    begin
        l_user_id := user_id;

        -- ��������� �� ����� � ����� ��� �������
        p_notice_all(0, p_period_type, p_kf); -- ������ ��� �������� (���������!!!)
        p_notice_all(2, p_period_type, p_kf); -- ������������ ��-�������

        -- ��������� ������� ������������
        for p in (select distinct o.report_date, k.kf, o.kf kfo,
                    dense_rank() over (partition by o.report_date order by k.kf) rnum
                  from NBUR_QUEUE_FORMS o,
                       V_NBUR_PERELIK_KF k
                  where ((p_kf is not null and
                          p_kf = k.kf or
                          p_kf is null) and o.kf = k.kf
                            or
                         o.kf is null) and
                        o.status = 1 and
                        o.id in (select id 
                                 from NBUR_REF_FILES 
                                 where p_period_type = 1 and period_type in ('D', 'T') or
                                       p_period_type = 2 and period_type not in ('D', 'T')) and
                        o.proc_type in (0, 2)
                  order by 1 desc, 2)
        loop
            l_report_date := p.report_date;
            l_kf := p.kf;

            -- ��������� ���� ��� ������������
            -- ���� ���������� �� kf, �� ��� ��� - ��������� ����� ����
            if p.rnum = 1 and p.kfo is null then
               l_version_id := f_create_version(l_report_date, p.kfo, null, l_global_version_id);
            elsif p.kfo is not null then
               l_version_id := f_create_version(l_report_date, p.kf, null, l_global_version_id);
            end if;

            commit;

            -- ���������� ��� ����� � ����� (��������� ���������� �����)
            for k in (select id file_id, nvl(kf, l_kf) kf, report_date
                      from nbur_queue_forms f
                      where status = 1 and
                            id in (select id 
                                   from NBUR_REF_FILES 
                                   where p_period_type = 1 and period_type in ('D', 'T') or
                                         p_period_type = 2 and period_type not in ('D', 'T')) and
                            proc_type in (0, 2) and
                            report_date = l_report_date and
                            nvl(f.kf, l_kf) = l_kf and
                            not exists (select 1 -- ���� �� ������������
                                        from nbur_lst_blc_files b
                                        where b.report_date = f.report_date and
                                              b.kf = nvl(f.kf, l_kf) and
                                              b.file_id = f.id)
                     )
            loop
                nbur_files.p_set_invalid_file (k.file_id, k.report_date, k.kf, null);
            end loop;

            -- �������� ����� �� ���������� �����
            --��� �������� (���������)
            l_ret := f_check_queue_forms(l_version_id, l_report_date, l_kf, l_user_id, 0, null);

            -- ��-�������
            l_ret := f_check_queue_forms(l_version_id, l_report_date, l_kf, l_user_id, 2, p_period_type);

            p_update_other_version(l_report_date, l_kf, l_version_id, 'INVALID');

            p_update_version(l_report_date, l_kf, l_version_id, 'FINISHED', 2);

            l_report_date_prev := l_report_date;

            commit;
        end loop;

        return l_ret;
    end f_check_queue_without_objects;

    -- ����� ����� � �����
    function f_check_queue_forms( p_version_id  in number,
                                  p_report_date in date,
                                  p_kf          in varchar2,
                                  p_userid      in number,
                                  p_proc_type   in number,
                                  p_period_type in number
                                 ) return number
    is
      title       constant   varchar2(60)  := $$PLSQL_UNIT||'.PP_FORMS';
      l_task_nm              varchar2(100) := 'NBUR_PARSE_QUEUE_'||p_kf;
      l_sql_stmt             varchar2(4000);
      e_task_not_found       exception;
      pragma exception_init( e_task_not_found, -29498 );
    begin
        execute immediate 'ALTER SESSION DISABLE PARALLEL DDL';
        execute immediate 'ALTER SESSION SET PARALLEL_DEGREE_LIMIT = 16';

        begin
          DBMS_PARALLEL_EXECUTE.drop_task(task_name => l_task_nm);
        exception
          when e_task_not_found then
            null;
        end;
        
        DBMS_PARALLEL_EXECUTE.create_task(task_name => l_task_nm);

        l_sql_stmt  := 'select file_id file_id_begin, file_id file_id_end
                        from (select unique q.id file_id,
                                   (case when g.PERIOD_TYPE in (''D'', ''T'') then 1
                                         when g.PERIOD_TYPE = ''M'' then 2
                                              else 3
                                    end) group_num,
                                    q.date_start
                            from BARS.NBUR_QUEUE_FORMS q,
                                 BARS.NBUR_REF_FILES g
                            where q.status = 1 and
                                  q.proc_type = '||to_char(p_proc_type)||' and
                                  q.report_date = to_date('''||to_char(p_report_date,'ddmmyyyy')||''',
                                ''ddmmyyyy'') and nvl(q.kf, '''||p_kf||''') = '''||p_kf||''' and '||
                                (case when p_period_type is null then ' ' 
                                      else 
                                         (case when p_period_type = 1 
                                               then 'g.period_type in (''D'', ''T'') and '
                                               else 'g.period_type not in (''D'', ''T'') and '
                                         end) 
                                end) ||
                                'q.id = g.id)
                        order by group_num, date_start, file_id';

        DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name  => l_task_nm,
                                                    sql_stmt   => l_sql_stmt,
                                                    by_rowid   => FALSE);

        l_sql_stmt := 'declare
                         l_ret number;
                       begin
                         l_ret := BARS.NBUR_QUEUE.F_CHECK_QUEUE_GROUP_FORMS('||to_char(p_version_id)||
            ', to_date('''||to_char(p_report_date,'ddmmyyyy')||''',''ddmmyyyy''), '||p_kf||', '||
            to_char(p_userid)||', :start_id, :end_id, '||to_char(p_proc_type)||','||
            (case when p_period_type is null then 'null' else to_char(p_period_type) end)||');
                       end; ';

        DBMS_PARALLEL_EXECUTE.run_task(task_name        => l_task_nm,
                                            sql_stmt        => l_sql_stmt,
                                            language_flag   => DBMS_SQL.NATIVE,
                                            parallel_level  => 5);
       
        begin
          DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );
        exception
          when e_task_not_found then
            null;
        end;
        
        commit;

        return 0;
        
    end f_check_queue_forms;

    -- ����� ����� � ������� ������
    function f_check_queue_group_forms(p_version_id    in number,
                                       p_report_date   in date,
                                       p_kf            in varchar2,
                                       p_userid        in number,
                                       p_file_id       in number,
                                       p_file_id_end   in number,
                                       p_proc_type     in number,
                                       p_period_type   in number
                                      ) return number
    is
        l_ret                   number;
        l_file_id               number;
        l_version_blc_id        number;
        l_message               clob;
        l_flagOK                number;
        l_error_mes             clob;
        
    begin
        p_info_log('Begin PP for group from '||to_char(p_file_id)||' to '||to_char(p_file_id_end)||
               ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

        bc.subst_mfo(p_kf);

        -- �������� �����
        for k in (select l.file_id, q.report_date, k.kf,
                         g.file_code||'('||g.scheme_code||')' object_name,
                         p.proc_name, nvl(q.user_id, p_userid) userid,
                         g.file_code, substr(g.file_code,2,2) kodf,
                         G.SCHEME_CODE a017
                  from NBUR_QUEUE_FORMS q,
                       NBUR_REF_FILES_LOCAL l,
                       NBUR_REF_FILES g,
                       NBUR_REF_PROCS p,
                       V_NBUR_PERELIK_KF k
                  where q.status = 1 and
                        q.proc_type = p_proc_type and
                        q.report_date = p_report_date and
                        nvl(k.kf, p_kf) = p_kf and
                        nvl(q.kf, p_kf) = p_kf and
                        nvl(q.kf, p_kf) = l.kf and
                        q.id = l.file_id and
                        l.file_id = g.id and
                        (p_period_type is null or
                         p_period_type = 1 and g.period_type in ('D', 'T') or
                         p_period_type = 2 and g.period_type not in ('D', 'T')) and
                        g.id = p.file_id(+) and
                        p.proc_type(+) in ( 'F', 'O') and
                        q.id between p_file_id and p_file_id_end
                  order by (case when g.PERIOD_TYPE in ('D', 'T') then 1
                                 when g.PERIOD_TYPE = 'M' then 2
                                 else 3
                            end), q.date_start)
        loop
            l_file_id := k.file_id;

            l_message := '';
            l_flagOK := 1;

            l_version_blc_id := f_blc_file_version(k.report_date, k.kf, k.file_id);

            if l_version_blc_id is null then
                -- ��������� �������������� ������ �����
                l_ret := nbur_files.f_start_form_file(k.userid, p_version_id, l_file_id,
                                    k.report_date, k.kf, sysdate);

                -- ���������� �����
                if k.PROC_NAME is not null
                then
                   commit;

                   execute immediate 'ALTER SESSION DISABLE PARALLEL DDL';

                   -- ������� ������� �� ���� �������
                   delete
                   from nbur_detail_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   delete
                   from nbur_agg_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   begin
                       if p_proc_type = 2 then
                          p_info_log(k.PROC_NAME||' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy')||CHR(10));
                       end if;
                       
                       DBMS_APPLICATION_INFO.SET_CLIENT_INFO('���� '||k.file_code||' �� '||to_char(k.report_date, 'dd.mm.yyyy')||' �� ���='||k.kf);
                       
                       execute immediate
                            'begin '||k.PROC_NAME||'(:dat_, :kf_, :form_id); end; '
                       using k.report_date, k.kf, l_ret;

                       if p_proc_type = 2 then
                          p_info_log(k.PROC_NAME||' end for date = '||to_char(p_report_date, 'dd.mm.yyyy')||CHR(10));
                       end if;

                       l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                        ' (����� '||to_char(p_version_id)||') ������ ����������!';
                   exception
                        when others then
                            l_flagOK := 0;

                            l_message := '��� ���������� ����� '||k.object_name||' �� ���� '||
                                to_char(k.report_date, 'dd.mm.yyyy')||' ������� �������!';
                            
                            l_error_mes := 'ERROR LOAD '||k.OBJECT_NAME||
                               ' dat='||to_char(k.report_date, 'dd.mm.yyyy')||' KF='||k.kf;

                            p_errors_log(k.report_date, k.kf, l_file_id, k.file_code, p_version_id, k.userid, l_error_mes);
                   end;
                else
                   commit;

                   execute immediate 'ALTER SESSION DISABLE PARALLEL DDL';

                   -- ������� ������� �� ���� �������
                   delete
                   from nbur_detail_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   delete
                   from nbur_agg_protocols
                   where report_date = k.report_date and
                         report_code = k.file_code and
                         kf = k.kf;

                   if k.file_code like '#%' or k.file_code like '@51%' then
                      begin
                         insert into nbur_agg_protocols(REPORT_DATE, KF, REPORT_CODE, NBUC,
                             FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND)
                         select unique datf, kf, k.file_code, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), ERR_MSG, fl_mod
                         from tmp_nbu
                         where kodf=substr(k.file_code,2,2) and
                               datf = k.report_date and
                               kf = k.kf;

                         insert into NBUR_DETAIL_PROTOCOLS(REPORT_DATE, KF, REPORT_CODE, NBUC,
                             FIELD_CODE, FIELD_VALUE, DESCRIPTION, ACC_ID, ACC_NUM, KV,
                            MATURITY_DATE, CUST_ID, REF, ND, BRANCH)
                         select unique k.report_date, k.kf, k.file_code, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), COMM, ACC,
                             NLS, KV, MDATE, RNK,REF,  ND, TOBO
                         from rnbu_trace_arch
                         where kodf=substr(k.file_code,2,2) and
                               datf = k.report_date and
                               kf = k.kf;

                          l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                            ' (����� '||to_char(p_version_id)||') ������ ����������!';

                          commit;
                      exception
                         when others then
                             l_flagOK := 0;

                             l_message := '��� ���������� ����� '||k.object_name||' �� ���� '||
                                    to_char(k.report_date, 'dd.mm.yyyy')||' ������� �������!';
                             
                             l_error_mes := 'ERROR LOAD '||k.OBJECT_NAME||
                                   ' dat='||to_char(k.report_date, 'dd.mm.yyyy')||' KF='||k.kf;
                                   
                             p_errors_log(l_error_mes);
                      end;
                   else
                      begin
                         insert into nbur_agg_protocols(REPORT_DATE, KF, REPORT_CODE, NBUC,
                             FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND)
                         select unique datf, kf, '@'||kodf, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), ERR_MSG, fl_mod
                         from tmp_irep
                         where kodf=substr(k.file_code,2,2) and
                               datf = k.report_date and
                               kf = k.kf;

                         insert into NBUR_DETAIL_PROTOCOLS(REPORT_DATE, KF, REPORT_CODE, NBUC,
                            FIELD_CODE, FIELD_VALUE, DESCRIPTION, ACC_ID, ACC_NUM, KV,
                            MATURITY_DATE, CUST_ID, REF, ND, BRANCH)
                         select unique k.report_date, k.kf, k.file_code, nvl(trim(nbuc), p_kf) nbuc, kodp, nvl(znap, ' '), COMM, ACC,
                            NLS, KV, MDATE, RNK,REF,  ND, TOBO
                         from rnbu_trace_int_arch
                         where kodf=substr(k.file_code,2,2) and
                              datf = k.report_date and
                              kf = k.kf;

                         l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                               ' (����� '||to_char(p_version_id)||') ������ ����������!';

                         commit;
                      exception
                         when others then
                             l_flagOK := 0;

                             l_message := '��� ���������� ����� '||k.object_name||' �� ���� '||
                                    to_char(k.report_date, 'dd.mm.yyyy')||' ������� �������!';

                             p_errors_log('ERROR LOAD '||k.OBJECT_NAME||
                                   ' dat='||to_char(k.report_date, 'dd.mm.yyyy')||' KF='||k.kf);
                      end;
                   end if;
                end if;

                commit;

                l_ret := nbur_files.f_finish_form_file(p_version_id, l_file_id,
                            k.report_date, k.kf,
                            (case when l_flagOK = 0 then 'ERROR' else 'FINISHED' end));

                -- �������� ����� ����, ���� ��� ������������
                if l_flagOK = 1 then
                   NBUR_OBJECTS.SAVE_FILE_VERSION(k.report_date, k.kf, p_version_id, l_file_id);
                end if;
            else
                l_flagOK := 0;

                l_message := '���� '||k.object_name||' �� ���� '||to_char(k.report_date, 'dd.mm.yyyy')||
                        ' ����������� � ���� '||to_char(l_version_blc_id);

                p_info_log(l_message);
            end if;

            p_clear_queue_one_form(p_report_date, p_kf, l_file_id);

            -- �������� ���������� ��� ������������(���� ��������� ����� � ������������ � COBUMMFOTEST-516)
            p_send_message(l_message, k.userid);

            commit;
        end loop;

        bc.home;

        p_info_log('End PP for group from '||to_char(p_file_id)||' to '||to_char(p_file_id_end)||
               ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf);

        return 0;
    end f_check_queue_group_forms;

    -- ��������� ������ �� ���������� ���� ����� �� ��볿
    procedure p_rollback_all( p_report_date in date, p_kf in varchar2 )
    is
    begin
      null;
    end p_rollback_all;
    
    --
    -- DAILY_TASK
    --
    procedure DAILY_TASK
    is
    /**
    <b>DAILY_TASK</b> - Queue filling 
    
    %version 1.0
    %usage   Filling report queue
    */
      title  constant  varchar2(64) := $$PLSQL_UNIT||'.DAILY_TASK';
      l_bnk_dt         date; -- ��������� ��������� ����
      l_rpt_d_dt       date; -- ����� ���� ��� ��������    �����
      l_rpt_t_dt       date; -- ����� ���� ��� ��������    �����
      l_rpt_m_dt       date; -- ����� ���� ��� ̲������    �����
      l_rpt_q_dt       date; -- ����� ���� ��� ����������� �����
      l_rpt_p_dt       date; -- ����� ���� ��� ϲ�в����   �����
      l_rpt_y_dt       date; -- ����� ���� ��� в����      �����
      l_ret            pls_integer;
    begin
      
      l_bnk_dt := gl.gbd();
      
      bars_audit.trace( '%s: l_bnk_dt=%s.', title, to_char(l_bnk_dt,'dd.mm.yyyy') );
      
      if ( l_bnk_dt Is Not Null )
      then
        
        l_rpt_d_dt := BARS.DAT_NEXT_U( l_bnk_dt, -1 );
        
        l_rpt_t_dt := case 
                        when ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM')+10, 0 ) ) 
                        then BARS.DAT_NEXT_U( l_bnk_dt, -1 )
                        when ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM')+20, 0 ) ) 
                        then BARS.DAT_NEXT_U( l_bnk_dt, -1 )
                        when ( l_bnk_dt = BARS.DAT_NEXT_U( last_day(l_bnk_dt)  +01, 0 ) ) 
                        then BARS.DAT_NEXT_U( l_bnk_dt, -1 )
                        else null
                      end;
        
        if ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM'), 0 ) )
        then -- ���� ��������� ���� = ������ ������� ���� �����
          -- ����� ���� = ���. ���. ���� �������� (�������) �����
          l_rpt_m_dt := BARS.DAT_NEXT_U( trunc(l_bnk_dt,'MM'), -1 ) ;
        end if;
        
        if ( l_bnk_dt = BARS.DAT_NEXT_U( trunc(l_bnk_dt,'Q'), 0 ) )
        then -- ���� ��������� ���� = ������ ������� ���� ��������
          -- ����� ���� = ���. ���. ���� �������� (�������) ��������
          l_rpt_q_dt := BARS.DAT_NEXT_U( trunc(l_bnk_dt,'Q'), -1 ) ;
        end if;
        
        bars_audit.trace( '%s: l_rpt_d_dt=%s, l_rpt_t_dt=%s, l_rpt_m_dt=%s, l_rpt_q_dt=%s, l_rpt_p_dt=%s, l_rpt_y_dt=%s'
                        , title, to_char(l_rpt_d_dt,'dd.mm.yyyy'), to_char(l_rpt_t_dt,'dd.mm.yyyy')
                               , to_char(l_rpt_m_dt,'dd.mm.yyyy'), to_char(l_rpt_q_dt,'dd.mm.yyyy')
                               , to_char(l_rpt_p_dt,'dd.mm.yyyy'), to_char(l_rpt_y_dt,'dd.mm.yyyy') );
        
        for c in 
        ( select f.FILE_ID
               , f.RPT_DT
               , m.KF 
            from ( select ID as FILE_ID
                        , case PERIOD_TYPE
                             when 'D' then l_rpt_d_dt
                             when 'T' then l_rpt_t_dt
                             when 'M' then l_rpt_m_dt
                             when 'Q' then l_rpt_q_dt
                             when 'P' then l_rpt_p_dt
                             when 'Y' then l_rpt_y_dt
                             else null
                           end as RPT_DT
                     from NBUR_REF_FILES
                     where file_code not in ('#2C', '#42', '#8B', '#12') and
                           PERIOD_TYPE in ('D', 'T')
                 ) f
           cross
            join MV_KF m
           where f.RPT_DT Is Not Null
        ) loop
          
          l_ret := NBUR_QUEUE.f_put_queue_form_by_id( p_file_id     => c.FILE_ID
                                                    , p_bank_date   => l_bnk_dt
                                                    , p_report_date => c.RPT_DT
                                                    , p_kf          => c.KF
                                                    , p_userid      => null );
          
          bars_audit.trace( '%s: l_ret=%s, kf=%s, file_id=%s.', title, to_char(l_ret), c.KF, to_char(c.FILE_ID) );
          
        end loop;
        
      else
        bars_audit.error( title||': global bank date Is Null!' );
      end if;
      
      commit;
       
    end DAILY_TASK;



BEGIN

  -- Set user kf value
  l_usr_mfo := sys_context('bars_context','user_mfo');

  -- ��������� ���� (��������)
  l_bankdate := gl.bd;

END NBUR_QUEUE;
/
show err;

PROMPT *** Create  grants  NBUR_QUEUE ***
grant EXECUTE                                                                on NBUR_QUEUE      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBUR_QUEUE      to RPBN002;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nbur_queue.sql =========*** End *** 
 PROMPT ===================================================================================== 
 