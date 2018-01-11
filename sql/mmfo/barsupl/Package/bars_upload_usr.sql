
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/package/bars_upload_usr.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSUPL.BARS_UPLOAD_USR is

    -----------------------------------------------------------------
    --
    --         ����� ���������������� ������� �� �������� ������   --
    --
    --   created: anny (14-11-2012)
    --
    -----------------------------------------------------------------

    G_HEADER_VERSION      constant varchar2(64)  :='version 5.2 15.08.2017';



    ----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    function body_version return varchar2;



    ---------------------------------------------------------------
    --  GET_PARAM
    --
    --   �������� �������� ���������
    --
    -----------------------------------------------------------------
    function get_param(p_param_name varchar2) return varchar2;



    ---------------------------------------------------------------
    --  CRETAE_INTERFACE_JOB
    --
    --   �������� ������������� �����. ������������ - ��� ���, ������ ����� ���� ������� ��� ��������� � ����������
    --
    --    p_interval     --  �������� ��� ����� ��� ������������ ����������
    --    p_jobname      --  ��� �����
    --    p_enabled      --  (1 enabled/ 0 -disabled)
    --    p_sheduled     --  (1 - ���������, 0-������� ��� ������������ ����������)
    --    p_bankdate     --  ���������� ���� ��� �������� (null - ��� �������������� �������  � ��������������� ����������� ���������� ����)
    --    p_group_id     --  ������ ��������
    -----------------------------------------------------------------
    procedure create_interface_job ( p_jobname    varchar2,
                                     p_enabled    number,
                                     p_sheduled   number,
                                     p_bankdate   date default null
                                   );
    procedure create_interface_job ( p_group_id   number,
                                     p_enabled    number,
                                     p_sheduled   number,
                                     p_bankdate   date default null
                                   );
    ---------------------------------------------------------------
    --  RECREATE_INTERFACE_JOB
    --
    --   ������������ ������������� ������� �� ��������� ���������� � upl_autojob_params
    --
    -----------------------------------------------------------------
    procedure recreate_interface_job(p_jobname varchar2);




    ---------------------------------------------------------------
    --  ROUTINE_FOR_JOB
    --
    --   �������� �������� ��� ���������� �� � ����� ��� ��������
    --
    --    p_bankdate    --  ���������� ����
    --    p_typeid      --  ��� ���� ��������(������ ��������)
    --    p_usearc      --  ������������� ���� ������
    --    p_useftp      --  ��������� ����� �� FTP
    --    p_usecopy     --  ����������� ������ � ��������� �������
    --    p_sheduled    --  (1 - ���������, 0-������� ��� ������������ ����������)
    --    p_kf          --  ��� ������������ ������� (���)
    -----------------------------------------------------------------
    procedure routine_for_job ( p_bankdate   date,
                                p_groupid    number,
                                p_usearc     number,
                                p_useftp     number,
                                p_usecopy    number,
                                p_sheduled   number,
                                p_kf         varchar2
                              );


    ---------------------------------------------------------------
    --  ENABLE_INTERFACE_JOB
    --
    --   �������������� ������������ �������
    --
    -----------------------------------------------------------------
    procedure enable_interface_job(p_jobname varchar2);



    ---------------------------------------------------------------
    --  DISABLE_INTERFACE_JOB
    --
    --   ���������������� ������������ �������
    --
    -----------------------------------------------------------------
    procedure disable_interface_job(p_jobname varchar2);

   ---------------------------------------------------------------
   --  TUDA
   ---------------------------------------------------------------
   procedure tuda (p_kf varchar2 default bars_upload.get_param('KF'));

   ---------------------------------------------------------------
   --  SUDA
   ---------------------------------------------------------------
   procedure suda;



    --------------------------------------------------------------
    --  CHECK_JOB_STATUS
    --
    --   ��������� ������ ����������� ����� (� out �����������), ��� ����������� exception
    --
    --    p_bankdate    --  ���������� ���� ��������� ��������
    --    p_jobname     --  ��� �����
    --    p_errcode     --  ��� ������
    --    p_errmsg      --  ����� ������
    -----------------------------------------------------------------
    procedure  check_job_status(  p_bankdate   date,
                                  p_jobname    varchar2,
                                  p_errcode out varchar2,  -- ��� ������
                                  p_errmsg  out varchar2   -- ��������� �� ������
                                ) ;

    ---------------------------------------------------------------
    --  DELETE_JOBINFO
    --
    --   ������� ������ �� ������� ���������� ������� �� �������� (upl_current_jobs)
    --
    --    p_bankdate    --  ���������� ���� ��������� ��������
    --    p_jobname        --  ��� ��������
    -----------------------------------------------------------------
    procedure delete_jobinfo (  p_bankdate   date,
                                p_jobname    varchar2
                             );
    procedure delete_jobinfo (  p_bankdate   date,
                                p_groupid    number
                             );

    ---------------------------------------------------------------
    --  CLEAR_LOGS
    --
    --   �������� ������� ������ ��������
    --   p_from_start_time - �� ����� ���� ����������� ��������
    --
    -----------------------------------------------------------------
    procedure clear_logs(p_from_date date);


    -----------------------------------------------------------------
    --  UPLOAD_FILE
    --
    --   ��������� ����  �� ����������� �������� UPL_FILES
    --
    --    p_filecode    --  ������������� ��� ����� �� ����������� (UPL_FILES)
    --    p_sqlid       --  ���� ����� ���� ����������� � ��������� ����������� ������� (����� ������� ������ ��-��������� �� upl_files.sql_id)
    --    p_param1      --  ��������� �������� ��������� 1 (������ �������� ����� ������������ ��� bind ���������� � �������� �� ��������)
    --    p_param2      --  ��������� �������� ��������� 2
    --
    -----------------------------------------------------------------
    procedure upload_file( p_filecode   upl_files.file_code%type,
                           p_sqlid      number,
                           p_param1     varchar2,
                           p_param2     varchar2
                          );

    -----------------------------------------------------------------
    --  SET_LAST_WORK_DATE, GET_LAST_WORK_DATE
    --
    --   �������� ���� ���������� �������� ���, ������� ������ ���� ������� ��������
    --
    --    p_bankdate     --  ���� ������� ��������
    -----------------------------------------------------------------
    procedure set_last_work_date (p_bankdate date default null);
    function  get_last_work_date (p_bankdate date default null) return date RESULT_CACHE; --DETERMINISTIC;


    -----------------------------------------------------------------
    --  IS_HOLIDAY
    --
    --  �������� �� ���� �������� �������� ��� ����������� ����
    --
    --    p_bankdate     --  ���������� ���� ��������
    --    p_sysdate      --  ��������� ���� ��������
    --    (������ ���� ���� �� ����������)
    --    p_group_id     --  ������ ��������
    -----------------------------------------------------------------
    function is_holiday (p_bankdate date default null, p_sysdate date default null, p_group_id number) return number;

end;
/
CREATE OR REPLACE PACKAGE BODY BARSUPL.BARS_UPLOAD_USR is

    -----------------------------------------------------------------
    --                                                             --
    --         ����� ���������������� ������� �� �������� ������   --
    --                                                             --
    --   created: anny (14-11-2012)
    --                                                             --
    --03.06.2014 - ��������� ��������� ������ ������������� �
    --  �� �������� � upl_stats (V.Kharin)
    -- version 5.1 26.01.2017 � ��������� tuda �� ��������� ������� "bars_upload.get_param('KF')"
    --                        ��� ���� ����������� �� ��������� ������������ �������� ����������� ������.
    -- version 5.4 15.08.2017 ��������� ����������� ������� �������� �� ������ ������, ����� �������� �� ����� ����� (create_interface_job)
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- ���������                                                   --
    -----------------------------------------------------------------

    G_BODY_VERSION              constant varchar2(64)         := 'version 5.4 15.08.2017';
    G_TRACE                     constant varchar2(20)         := 'bars_upload_usr.';
    G_MODULE                    constant varchar2(3)          := 'UPL';

 -- �� ������������
 --   G_DAILY_JOB_NAME            constant varchar2(100)   := 'daily_upload_job';
 --   G_MANUAL_INIT_JOB_NAME      constant varchar2(100)   := 'initial_upload_job';
 --   G_MANUAL_INICR_JOB_NAME     constant varchar2(100)   := 'inicrement_upload_job';
 --   G_DAILY_REF_JOB_NAME        constant varchar2(100)   := 'dailyref_upload_job';

    G_JOB_OWNER                 constant varchar2(100)   := 'BARSUPL.';

    -----------------------------------------------------------------
    -- ����������
    -----------------------------------------------------------------
    G_UPL_D0               date;  --���������� ����
    G_UPL_D1               date;  --��������� �� �������� ���� ����� ����� G_UPL_D0

    ----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    --
    --
    function header_version return varchar2
    is
    begin
       return 'package header BARS_UPLOAD_USR: ' || G_BODY_VERSION;
    end header_version;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    --
    --
    function body_version return varchar2
    is
    begin
       return 'package body BARS_UPLOAD_USR: ' || G_BODY_VERSION;
    end body_version;


    -----------------------------------------------------------------
    --  LOG_START_JOB()
    --
    --    ����������������� ����� �����
    --    (��� ����������� ��������� ������� ����� �������� ��
    --    ��������� ��������� ����� �������� � ������� ��������� upl_stats)
    --
    --    p_groupid    - ��� ������ ��������
    --    p_statusid   - ��� ������ � �������-������ �������� (upl_stats)
    --    p_bankdate   - ���� ����
    -----------------------------------------------------------------
    procedure log_job_event(
                    p_groupid          number   ,
                    p_statid           number   ,
                    p_bankdate         date     )
    is
       pragma autonomous_transaction;
    begin
       bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���
       insert into upl_current_jobs(job_id,  stat_id, group_id,  bank_date, start_time, status_id)
       values(s_upl_current_jobs.nextval, p_statid, p_groupid, p_bankdate, sysdate, 0);
       commit;
       exception when others then
           rollback;
           raise;
    end;

    ---------------------------------------------------------------
    --  TUDA
    --
    procedure tuda (p_kf varchar2 default  bars_upload.get_param('KF'))
    is
      l_kf        varchar2(6);
      l_sql_str   varchar2(200);
    begin

       if barsupl.bars_upload_utl.is_mmfo > 1
       then
         l_kf := nvl(p_kf, bars_upload.get_param('KF'));
         if l_kf  is null then
            bars.bars_error.raise_nerror(G_MODULE, 'NO_CORRECT_KF', 'NULL' );
         end if;
          l_sql_str := 'begin bars.bc.go(''' || l_kf || '''); end;';
       else
          l_sql_str := 'begin bars.tuda; end;';
       end if;

       execute immediate l_sql_str;
    exception when others then
       if sqlcode = -6550 then
          null;
       else
          raise;
       end if;
    end;

    ---------------------------------------------------------------
    --  SUDA
    --
    procedure suda
    is
	   l_sql_str   varchar2(200);
    begin
       if barsupl.bars_upload_utl.is_mmfo > 1
       then
          l_sql_str := 'begin bars.bc.go(''/''); end;';
       else
          l_sql_str := 'begin bars.suda; end;';
       end if;

       execute immediate l_sql_str;
    exception when others then
       if sqlcode = -6550 then null;
       end if;
    end;



    ------------- --------------------------------------------------
    --  GET_BANKDAY_FOR_UPLOAD
    --
    --   �������� ��������� �������� ���������� ���� ��� ��������, ������� ��� �� ����������
    --   p_day_before - ���- �� ���������� ���� �����
    -----------------------------------------------------------------
    function get_bankday_for_upload(p_day_before number,
                                    p_groupid    number) return date
    is
        l_bankdate date;
        l_status   number;
        l_errmsg   varchar2(1000);
        l_trace    varchar2(1000):= G_TRACE||'get_bankday: ';
    begin
       bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���

       bars.bars_audit.info(l_trace||'��������� ���������� ���� ��� �������� �� '||p_day_before||' ����. ��� ����� ��� ������ �������� �'||p_groupid);
       select max(fdat) into l_bankdate from bars.fdat where fdat <= trunc( sysdate );

       bars.bars_audit.info(l_trace||'������������ ����. ����, ������� ����� ��� ����� ���������: '||to_char(l_bankdate, 'dd/mm/yyyy') );
       select max(fdat) into l_bankdate
        from ( select fdat, (row_number() over (order by fdat desc))-1 n
                from bars.fdat
               where fdat <=( select max(fdat) from bars.fdat
                               where fdat <= trunc( sysdate )
                             )
             ) fd
       where n = p_day_before;
       bars.bars_audit.info(l_trace||'������������ ����. ����, ����� '||p_day_before||' ����, ������� ������ ��� ����� ���������: '||to_char(l_bankdate, 'dd/mm/yyyy') );

       begin
          select bank_date,  status_id
               into l_bankdate, l_status
            from upl_current_jobs
           where bank_date = l_bankdate
             and status_id in (0)  -- � ������ ��������
             --and status_id in (0,1)  -- � ������ �������� ��� ��� ��������� ������� ��������������� ��������
             and group_id  =  p_groupid;
          if l_status = 0 then  --  � ������ ��������
             l_errmsg := bars.bars_error.get_nerror_text(G_MODULE, 'BANKDATE_IN_UPLOADING',  to_char(l_bankdate,'dd/mm/yyyy'));
             bars.bars_audit.error(l_trace||l_errmsg);
             bars.bars_error.raise_nerror(G_MODULE, 'BANKDATE_IN_UPLOADING', to_char(l_bankdate,'dd/mm/yyyy'));
--          else
--             l_errmsg := bars.bars_error.get_nerror_text(G_MODULE, 'BANKDATE_WAS_UPLOADED',  to_char(l_bankdate,'dd/mm/yyyy'));
--             bars.bars_audit.error(l_trace||l_errmsg);
--             bars.bars_error.raise_nerror(G_MODULE, 'BANKDATE_WAS_UPLOADED', to_char(l_bankdate,'dd/mm/yyyy'));
          end if;
       exception when no_data_found then
          null;
       end;


       --suda;
       return l_bankdate;
    end;


    -----------------------------------------------------------------
    --  UPLOAD_DATA
    --
    --   ��������� ��������� ��� ��������������� �������� �� ��������� ���������� ����
    --
    --    p_bankdate    --  ���������� ���� ��������� ��������
    --    p_parentid    --  ��� ������������� �������� �� ������� ������( ��� �����)
    --    p_groupid     --  ��� ������ ��������       --  1 (G_INITIAL)- ���������, 2 (G_INCREMENTAL)- ���������������
    --    p_usearc      --  ������������� ���� ������
    --    p_useftp      --  ��������� ����� �� FTP
    --    p_usecopy     --  ����������  ���� �� ����
    -----------------------------------------------------------------

    procedure upload_data( p_bankdate   date,
                           p_parentid   number default null,
                           p_groupid    number,
                           p_usearc     number,
                           p_useftp     number,
                           p_usecopy    number
                          )
    is
       l_trace        varchar2(1000):= G_TRACE||'upload_data: ';
       l_auditid      number;  -- ����� � ������� ���������� ��� �������� ������ ������
       l_auditflid    number;  -- ����� � ������� ���������� ��� �������� ����� ����������
       l_arcfilename  varchar2(200);
    begin
       bars_audit.info(l_trace||' ����.����='||to_char(p_bankdate,'dd/mm/yyyy')||' parentid='||p_parentid||' groupid ='||p_groupid||' usearc='||p_usearc);

       execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ''. ''';

       l_auditid := bars_upload.upload_file_group( p_filegroup  => p_groupid,
                                                   p_parentid   => p_parentid,
                                                   p_param1     => to_char(p_bankdate,'dd/mm/yyyy'),
                                                   p_param2     => to_char(p_groupid, 'FM9999999'), --null,
                                                   p_forcestop  => 0);
       begin
          if p_usearc  =  1 then
               if  bars_upload.get_param('ARCH_METHOD') = 'JAVA' then
                l_arcfilename:= bars_upload_utl.make_archive_bygroup(l_auditid, null);
             end if;
             if  bars_upload.get_param('ARCH_METHOD') = 'JOB' then
                l_arcfilename:= bars_upload_utl.make_archive_bygroup_byjob(l_auditid, null);
             end if;
             -- ���� ���������� �������������, ��  ��� �������� ����� �� �����������  ������������ � upl_stats
             -- � ������ ����� ��������� ���� �� ����������� � �������� ��� �������� � �����
          end if;
       exception when others then --V.Kharin
          null; -- ������� ������ ��� ��������� � ������ ��������� stat_file
       end;

        -- �������� �������� ���� �� �����������
       l_auditflid := bars_upload.upload_stat_file (  p_filegroup  => p_groupid,
                                                      p_parentid   => l_auditid,
                                                      p_param1     => to_char(p_bankdate,'dd/mm/yyyy'));

       if p_usearc  =  1 then
          -- � ������ � ���� ���� ���������� ������� � �����
          if  bars_upload.get_param('ARCH_METHOD') = 'JAVA' then
             l_arcfilename:= bars_upload_utl.make_archive_bygroup(l_auditid, l_auditflid);
          end if;
          if  bars_upload.get_param('ARCH_METHOD') = 'JOB' then
             l_arcfilename:= bars_upload_utl.make_archive_bygroup_byjob(l_auditid, l_auditflid);
          end if;
       end if;
       --����� ������ ��������� �� ������� � ���������

       if p_useftp  =  1 then
          bars_upload_utl.send_file_to_ftp(l_arcfilename, l_auditid);
       end if;

       if p_usecopy = 1 then
          if bars_upload.get_group_param(p_groupid, 'COPY_TO_DIR')  is not null then
             bars_upload_utl.copy_file( p_srcpath     => bars_upload.get_param('ARC_OS_DIR'),
                                        p_srcfilename => l_arcfilename,
                                        p_dstpath     => bars_upload.get_group_param(p_groupid,'COPY_TO_DIR'),
                                        p_dstfilename => l_arcfilename,
                                        p_groupid     => p_groupid);
          end if;
       end if;
    end;


    ---------------------------------------------------------------
    --  CHECK_JOB_STATUS
    --
    --   ��������� ������ ����������� ����� (� out �����������), ��� ����������� exception
    --
    --    p_bankdate    --  ���������� ���� ��������� ��������
    --    p_jobname     --  ��� �����
    --    p_errcode     --  ��� ������
    --    p_errmsg      --  ����� ������
    -----------------------------------------------------------------
    procedure  check_job_status(  p_bankdate   date,
                                  p_jobname    varchar2,
                                  p_errcode out varchar2,  -- ��� ������
                                  p_errmsg  out varchar2   -- ��������� �� ������
                                )
    is
       l_statusid  number;
       l_groupid   number;
       l_errmsg    varchar2(500);
       l_errname   varchar2(500);
       l_errcode   varchar2(4);
       l_trace     varchar2(1000) := G_TRACE||'check_job_status: ';
    begin
       bars_upload.init_params (p_force => 1); --�������������� ������������� ���������� ����� ������� ��������

       bars_upload_utl.check_kf(); --������������ ������ ���� �� ������ ���

       begin
          l_groupid := bars_upload.get_job_param(p_jobname,'GROUPID');
          bars.bars_audit.trace(l_trace||'�������� ������� ������� �� '||to_char(p_bankdate,'dd/mm/yyyy')||'  �������  �'||p_jobname||' group = '||l_groupid);
          select status_id into l_statusid
            from upl_current_jobs
           where bank_date = trunc(p_bankdate)
             and group_id  =  l_groupid
             and kf = bars.gl.kf;

          case when l_statusid  = bars_upload.G_UPLOADING then l_errname := 'STILL_UPLOADING';      l_errcode := '0028';  -- ��� �� ����� err_uppl
               when l_statusid  = bars_upload.G_UPLOADED  then l_errname := 'WAS_YET_UPLOADED';     l_errcode := '0022';
               when l_statusid  = bars_upload.G_UPLERROR  then l_errname := 'UPLOADED_WITH_ERRORS'; l_errcode := '0029';
               else                                            l_errname := 'UNKNOWN_STATUS';       l_errcode := '0030';
          end case;

          l_errmsg := bars.bars_error.get_nerror_text(G_MODULE, l_errname,  to_char(p_bankdate,'dd/mm/yyyy'), p_jobname, to_char(l_statusid));

          p_errcode := l_errcode;
          p_errmsg  := l_errmsg;
          bars.bars_audit.trace(l_trace||' '||p_errcode ||': '||p_errmsg);
       exception when no_data_found then
          bars.bars_audit.trace(l_trace||' '||p_errcode ||': ������������ �� �����������');
          p_errcode := '0000';
       end;

    end;


    ---------------------------------------------------------------
    --  CHECK_GROUP_STATUS
    --
    --   ��������� ������ ����������� ����� ���  ����������� exception
    --
    --    p_bankdate    --  ���������� ���� ��������� ��������
    --    p_jobname     --  ��� ������ ��� ���� ��������
    -----------------------------------------------------------------
    procedure  check_group_status(  p_bankdate    date,
                                    p_groupid     number,
                                    p_errcode out varchar2,  -- ��� ������
                                    p_errmsg  out varchar2 )  -- ��������� �� ������)
    is
       --l_errmsg    varchar2(500);
       --l_errcode   varchar2(4);
       l_jobname   varchar2(200);
    begin
       bars_upload.init_params (p_force => 1); --�������������� ������������� ���������� ����� ������� ��������

       bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���

       select job_name into l_jobname
         from upl_autojob_param_values
        where param = 'GROUPID'
          and value  =  to_char(p_groupid)
          and kf = bars.gl.kf;

       check_job_status( p_bankdate   => p_bankdate,
                         p_jobname    => l_jobname,
                         p_errcode    => p_errcode,
                         p_errmsg     => p_errmsg );
        --if l_errcode <> '0000' then
           -- bars.bars_error.raise_nerror(G_MODULE, 'GENERAL_ERROR', l_errmsg);
        --end if;
    end;



    ---------------------------------------------------------------
    --  DELETE_JOBINFO
    --
    --   ������� ������ �� ������� ���������� ������� �� �������� (upl_current_jobs)
    --
    --    p_bankdate    -- ���������� ���� ��������� ��������
    --    p_jobname     -- ��� ��������
    --    p_groupid     -- ������ ��������
    -----------------------------------------------------------------
    procedure delete_jobinfo (  p_bankdate   date,
                                p_jobname    varchar2 )
    is
       l_trace     varchar2(1000) := G_TRACE ||'delete_jobinfo: ';
       l_groupid   number;
    begin
        bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���
        l_groupid := bars_upload.get_job_param(p_jobname,'GROUPID');
        delete_jobinfo(p_bankdate, l_groupid);
    end;

    procedure delete_jobinfo (  p_bankdate   date,
                                p_groupid    number )
    is
       pragma autonomous_transaction;
       l_trace     varchar2(1000) := G_TRACE ||'delete_jobinfo: ';
    begin
        bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���
        bars.bars_audit.info(l_trace||'�������� ������ ��  '||to_char(p_bankdate,'dd/mm/yyyy')||' group = '||p_groupid);
        delete from upl_current_jobs
         where bank_date = trunc(p_bankdate)
           and group_id  = p_groupid
           and kf        = bars.gl.kf;
       commit;
    end;

    ---------------------------------------------------------------
    --  ROUTINE_FOR_JOB
    --
    --   �������� �������� ��� ���������� �� � ����� ��� ��������
    --
    --    p_bankdate    --  ���������� ����
    --    p_typeid      --  ��� ���� ��������(������ ��������)
    --    p_usearc      --  ������������� ���� ������
    --    p_useftp      --  ��������� ����� �� FTP
    --    p_usecopy     --  ����������� ������ � ��������� �������
    --    p_sheduled    --  (1 - ���������, 0-������� ��� ������������ ����������)
    --    p_kf          --  ��� ������������ ������� (���)
    -----------------------------------------------------------------
    procedure routine_for_job ( p_bankdate   date,
                                p_groupid    number,
                                p_usearc     number,
                                p_useftp     number,
                                p_usecopy    number,
                                p_sheduled   number,
                                p_kf         varchar2
                              )
    is
       l_statid      number;
       l_groupid     number;
       l_bankdate    date;
       l_daybefore   number;
       l_holiday_upl varchar2(1); --�������� HOLIDAY_UPLOAD
       l_holiday_ch  varchar2(1); --�������� HOLIDAY_CHECK_STATUS
       l_holiday     number;      --���� �������� ��������?
       l_errcode     varchar2(4);
       l_errmsg      varchar2(500);
       l_trace       varchar2(1000) := G_TRACE ||'routine_for_job: ';
    begin
       bars.bars_audit.info(l_trace||'����� ���������� �������� �� ���������� ��������');

       begin
          bars_upload_usr.tuda(p_kf);
       exception when others then
          l_errmsg := '������ bars_upload_usr.tuda(' || p_kf || ')';
          bars_upload.log_error_process(
                    p_stop_time  => sysdate,
                    p_errmess    => l_errmsg,
                    p_id         => l_statid);
          bars.bars_audit.error(l_trace||'������ bars_upload_usr.tuda(' || p_kf || '): '||substr(SQLERRM,1,3980));
          raise;
       end;
       bars.bars_audit.info(l_trace||'�������� �� ������� ' || p_kf || ' _ ' || bars.gl.kf);

       bars_upload.init_params (p_force => 1); --�������������� ������������� ���������� ����� ������� ��������

       bars_upload.log_start_process(
                    p_start_time       => sysdate,
                    p_jobid            =>  null,
                    p_groupid          =>  null,
                    p_fileid           =>  null,
                    p_parentid         =>  null,
                    p_sqlid            =>  null,
                    p_params           =>  null,
                    p_bankdate         =>  p_bankdate,
                    p_id               =>  l_statid);

       l_bankdate := p_bankdate;
--bars.bars_audit.error(l_trace||'111_ bars.gl.kf=' || nvl(bars.gl.kf, 'NULL') );
       l_daybefore := bars_upload.get_group_param(p_groupid, 'BANKDAYS_BEFORE');
       bars.bars_audit.info(l_trace||'l_daybefore = '||l_daybefore);
--bars.bars_audit.error(l_trace||'222_ bars.gl.kf=' || nvl(bars.gl.kf, 'NULL') );
       if l_bankdate is null then   -- �.�. ���� ����� ��������� ���������
          l_bankdate :=  get_bankday_for_upload( l_daybefore, p_groupid);
       end if;
       bars.bars_audit.info(l_trace||'���������� ����: '||to_char(l_bankdate,'dd/mm/yyyy') );
--bars.bars_audit.error(l_trace||'333_ bars.gl.kf=' || nvl(bars.gl.kf, 'NULL') );
       if l_bankdate is null then
          bars.bars_error.raise_nerror(G_MODULE,'NO_BANKDATE_TO_UPLOAD');
       end if;

       bars.bars_audit.info(l_trace||'����� �������� �� �������� ��: '||to_char(l_bankdate,'dd/mm/yyyy')||' �� ������: '||p_groupid);

       --���� sysdate - �������� ����, ��������� �� ��������� HOLIDAY_UPLOAD
       l_holiday_upl := bars_upload.get_group_param(p_groupid, 'HOLIDAY_UPLOAD');

       l_holiday     := is_holiday (p_bankdate => null,
                                    p_sysdate  => sysdate,
                                    p_group_id => p_groupid);

       if l_holiday_upl = '0' and l_holiday = 1 and p_sheduled = 1 then --
          l_errmsg := to_char(sysdate, 'dd/mm/yyyy') || ' - �������� ����. �������� HOLIDAY_UPLOAD=0 ��������� ��������.';
          bars_upload.log_error_process(
                    p_stop_time  => sysdate,
                    p_errmess    => l_errmsg,
                    p_id         => l_statid);
          bars.bars_error.raise_nerror(G_MODULE,'GENERAL_ERROR', l_errmsg);
       end if;


       l_holiday_ch  := bars_upload.get_group_param(p_groupid, 'HOLIDAY_CHECK_STATUS');
       l_holiday     := is_holiday (p_bankdate => l_bankdate,
                                    p_sysdate  => null,
                                    p_group_id => p_groupid);

       check_group_status(  p_bankdate => l_bankdate, p_groupid => p_groupid, p_errcode => l_errcode, p_errmsg => l_errmsg);

       bars.bars_audit.trace(l_trace||'�������� ������� ����� �� ��������: '||l_errcode);
       bars.bars_audit.trace(l_trace||'���������: '||l_errmsg);

       if l_errcode <> '0000' then
          if l_errcode = '0022' and l_holiday = 1 and l_holiday_ch <> '1' then --WAS_YET_UPLOADED
             bars.bars_audit.info(l_trace||'���������� ����: '||to_char(l_bankdate,'dd/mm/yyyy') || ' ����������� � �������� ����. HOLIDAY_CHECK_STATUS=0 - ��������� ��������.' );
             delete_jobinfo(l_bankdate, p_groupid);
          else
             bars_upload.log_error_process( p_stop_time  => sysdate,
                                            p_errmess    => l_errmsg,
                                            p_id         => l_statid);
             bars.bars_audit.error(l_trace||'����� �� ��������� ����� �� ��������');
             bars.bars_error.raise_nerror(G_MODULE,'GENERAL_ERROR', l_errmsg);
          end if;
       end if;

       log_job_event(p_groupid  => p_groupid,
                     p_statid   => l_statid ,
                     p_bankdate => l_bankdate);

       upload_data(  p_bankdate => l_bankdate,
                     p_parentid => l_statid  ,
                     p_groupid  => p_groupid ,
                     p_usearc   => p_usearc  ,
                     p_useftp   => p_useftp  ,
                     p_usecopy  => p_usecopy);
       bars.bars_audit.trace(l_trace||'�������� ���������� ������ �������� �� ��������');
    end;

    ---------------------------------------------------------------
    --  CRETAE_JOB
    --
    --   �������� ����� (� ������������� � ������������). ������������ - ��� ���, ������ ����� ���� ������� ��� ��������� � ����������
    --                                                    ����������� - ��� �������� , �������� �����������
    --    p_interval     --  �������� ��� ����� ��� ������������ ����������
    --    p_jobname      --  ��� �����
    --    p_plsql        --  ���  plsql
    --    p_enabled      --  (1 enabled/ 0 -disabled)
    --    p_autodrop     --  �������� ����� ����������
    --    p_forcedel     --  (1 - ������� , ���� �����������)
    -----------------------------------------------------------------
    procedure create_job ( p_jobname    varchar2,
                           p_interval   varchar2 default null,
                           p_plsql      varchar2,
                           p_enabled    number,
                           p_comment    varchar2,
                           p_autodrop   number  ,
                           p_forcedel   number default 1
                         )
    is
       l_nextrun         date;
       l_trace           varchar2(1000) := G_TRACE ||'create_job: ';
       l_region_prfx     varchar2(100);
       l_jobname         varchar2(300);
    begin

       bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���
       -- �������� ������� ��� ����� �� ������������ ��
       l_region_prfx := bars_upload.get_param('REGION_PRFX');
       -- ���������� ��� ����� � ������ �������
       --l_jobname := G_JOB_OWNER || p_jobname || '_' || l_region_prfx;
       l_jobname := G_JOB_OWNER || p_jobname;

       if p_forcedel = 1 then
             begin
             dbms_scheduler.drop_job(job_name  => l_jobname);
          exception when others then
             if sqlcode = -27475 then null;
             else raise;
             end if;
          end;
       end if;

       dbms_scheduler.create_job(
             job_name        =>  l_jobname,
             job_type        => 'PLSQL_BLOCK',
             start_date      => systimestamp ,
             repeat_interval => p_interval   ,
             auto_drop       => (case when p_autodrop = 0 then FALSE else TRUE end)  ,
             job_action      => p_plsql      ,
             enabled         => (case when p_enabled = 0 then FALSE else TRUE end),
             comments        => p_comment);

       if  p_interval is not null then
          dbms_scheduler.evaluate_calendar_string(p_interval,systimestamp,null,l_nextrun);
       end if;

       bars.bars_audit.info(l_trace||'������� ������� ��������');
       bars.bars_audit.info(l_trace||'PL/SQL: '||p_plsql);
       if  p_interval is not null then
           bars.bars_audit.info(l_trace||'interval: '||p_interval||'. ��������� ���� ����������: '||to_char(l_nextrun,'dd/mm/yyyy hh24:mi:ss'));
       end if;

       dbms_scheduler.set_attribute( name      => l_jobname,
                                     attribute => 'logging_level',
                                     value     => DBMS_SCHEDULER.LOGGING_FULL);
    end;


    ---------------------------------------------------------------
    --  CRETAE_INTERFACE_JOB
    --
    --   �������� ������������� �����. ������������ - ��� ���, ������ ����� ���� ������� ��� ��������� � ����������
    --
    --    p_interval     --  �������� ��� ����� ��� ������������ ����������
    --    p_jobname      --  ��� �����
    --    p_enabled      --  (1 enabled/ 0 -disabled)
    --    p_sheduled     --  (1 - ���������, 0-������� ��� ������������ ����������)
    --    p_bankdate     --  ���������� ���� ��� �������� (null - ��� �������������� �������  � ��������������� ����������� ���������� ����)
    --
    -----------------------------------------------------------------
    procedure create_interface_job ( p_jobname    varchar2,
                                     p_enabled    number,
                                     p_sheduled   number,
                                     p_bankdate   date default null
                                   )
    is
       l_groupid      number;
       l_interval     varchar2(300);
       l_usearc       number;
       l_usecopy      number;
       l_useftp       number;
       l_real_jobname varchar2(300);  -- ���� ���� ����������� ����������, ����� �� ������ ����� ������ ��� ����
       l_bnkdtstr     varchar2(300);
       l_trace        varchar2(1000) := G_TRACE ||'create_interface_job(p_jobname): ';
       l_kf           varchar2(6);
    begin
       bars_upload.init_params (p_force => 1); --�������������� ������������� ����������

       l_groupid  := bars_upload.get_job_param(p_jobname, 'GROUPID');
       l_usearc   := bars_upload.get_job_param(p_jobname, 'USE_ARCH');
       l_usecopy  := bars_upload.get_job_param(p_jobname, 'USE_COPY');
       l_useftp   := bars_upload.get_job_param(p_jobname, 'USE_FTP');
       l_kf       := bars_upload.get_param('KF');
       l_bnkdtstr := case when p_bankdate is null then 'null' else 'to_date('''||to_char(p_bankdate,'dd/mm/yyyy')||''',''dd/mm/yyyy'')' end;

       bars.bars_audit.info(l_trace||'bankdate: '||l_bnkdtstr);

       if p_sheduled = 1 then
          l_interval := 'FREQ=DAILY;BYDAY='||bars_upload.get_job_param(p_jobname, 'WHEN_DAYLIST')||';'||
                                           'BYHOUR='  ||bars_upload.get_job_param(p_jobname, 'WHEN_HOUR')||';'||
                                           'BYMINUTE='||bars_upload.get_job_param(p_jobname, 'WHEN_MINUTE')||';BYSECOND=0';
          l_real_jobname := p_jobname;
       else
         l_interval := null;
         l_real_jobname := p_jobname||'_onetime';
       end if;

       create_job ( p_jobname  => l_real_jobname,
                    p_interval => l_interval,
                    p_plsql    => 'begin
   bars.bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                              p_userid    => '|| bars.gl.aUID ||',
                              p_hostname  => null,
                              p_appname   => ''UPLD:' || l_real_jobname || ';group=' || l_groupid ||';'|| case when p_bankdate is null then 'null' else to_char(p_bankdate,'dd/mm/yyyy') end || ';'|| l_kf ||''');
   bars.bc.go('''||l_kf||''');
   barsupl.bars_upload_usr.routine_for_job( '||l_bnkdtstr||' , '||l_groupid||','||l_usearc||','||l_useftp||','||l_usecopy||','||p_sheduled||','''||l_kf||''');
end;',
                    p_enabled  => p_enabled,
                    p_autodrop => case when p_sheduled = 0 then 1 else 0 end ,
                    p_comment  => 'Automatic uploading job',
                    p_forcedel => 1);
    end;

    ---------------------------------------------------------------
    --  CRETAE_INTERFACE_JOB
    --
    --   �������� ������������� �����. ������������ - ��� ���, ������ ����� ���� ������� ��� ��������� � ����������
    --
    --    p_group_id     -- ����� ����� ��� ������������
    --    p_enabled      --  (1 enabled/ 0 -disabled)
    --    p_sheduled     --  (1 - ���������, 0-������� ��� ������������ ����������)
    --    p_bankdate     --  ���������� ���� ��� �������� (null - ��� �������������� �������  � ��������������� ����������� ���������� ����)
    --
    -----------------------------------------------------------------
    procedure create_interface_job ( p_group_id   number,
                                     p_enabled    number,
                                     p_sheduled   number,
                                     p_bankdate   date default null
                                   )
    is
       l_jobname      varchar2(200);
       l_trace        varchar2(1000) := G_TRACE||'create_interface_job(p_group_id): ';
    begin
       bars_upload.init_params (p_force => 1); --�������������� ������������� ����������

       select val.job_name
         into l_jobname
         from barsupl.upl_autojob_param_values val
        where val.param = 'GROUPID' and val.value = p_group_id;

       create_interface_job ( p_jobname  => l_jobname,
                              p_enabled  => p_enabled,
                              p_sheduled => p_sheduled,
                              p_bankdate => p_bankdate
                            );
    exception when others then
       bars.bars_audit.error(l_trace||' '||substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 500));
    end;

    ---------------------------------------------------------------
    --  RECREATE_INTERFACE_JOB
    --
    --   ������������ ������������� ������� �� ��������� ���������� � upl_autojob_params
    --
    -----------------------------------------------------------------
    procedure recreate_interface_job(p_jobname varchar2)
    is
       --l_region_prfx       varchar2(100);
       l_jobname           varchar2(300);
    begin
       --bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���

       bars_upload.init_params(p_force => 1);

       ---- �������� ������� ��� ����� �� ������������ ��
       --l_region_prfx := bars_upload.get_param('REGION_PRFX');

       -- ���������� ��� ����� � ������ �������
       l_jobname := p_jobname;

       create_interface_job ( p_jobname  => l_jobname,
                              p_enabled  => 1,
                              p_sheduled => 1,
                              p_bankdate => null
                            );
    end;


    ---------------------------------------------------------------
    --  ENABLE_INTERFACE_JOB
    --
    --   �������������� ������������ �������
    --
    -----------------------------------------------------------------
    procedure enable_interface_job(p_jobname varchar2)
    is
      --l_region_prfx       varchar2(100);
      l_jobname           varchar2(300);
    begin
      bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���

      -- �������� ������� ��� ����� �� ������������ ��
      --l_region_prfx := bars_upload.get_param('REGION_PRFX');

      -- ���������� ��� ����� � ������ �������
      --l_jobname := G_JOB_OWNER || p_jobname || '_' || l_region_prfx;
      l_jobname := p_jobname;

      dbms_scheduler.enable(l_jobname);
    end;


    ---------------------------------------------------------------
    --  DISABLE_INTERFACE_JOB
    --
    --   ���������������� ������������ �������
    --
    -----------------------------------------------------------------
    procedure disable_interface_job(p_jobname varchar2)
    is
      --l_region_prfx       varchar2(100);
      l_jobname           varchar2(300);
    begin
      bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���

      -- �������� ������� ��� ����� �� ������������ ��
      --l_region_prfx := bars_upload.get_param('REGION_PRFX');

      -- ���������� ��� ����� � ������ �������
      --l_jobname := G_JOB_OWNER || p_jobname || '_' || l_region_prfx;
      l_jobname := p_jobname;

      dbms_scheduler.disable(l_jobname);
    end;


    ---------------------------------------------------------------
    --  GET_PARAM
    --
    --   �������� �������� ���������
    --
    -----------------------------------------------------------------
    function get_param(p_param_name varchar2) return varchar2
    is
    begin
       return  bars_upload.get_param(p_param_name);
    end;

    ---------------------------------------------------------------
    --  GET_JOB_PARAM
    --
    --   �������� �������� ���������
    --
    -----------------------------------------------------------------
    function get_job_param(p_jobname varchar2, p_param_name varchar2) return varchar2
    is
    begin
       return  bars_upload.get_job_param(p_jobname, p_param_name);
    end;


    ---------------------------------------------------------------
    --  CLEAR_LOGS
    --
    --   �������� ������� ������ ��������
    --   p_from_start_time - �� ����� ���� ����������� ��������
    --
    --   20.07.2016 V.Kharin - ������ �������� �� upl_stats ������� � ����� upl_stats_archive
    -----------------------------------------------------------------
    procedure clear_logs(p_from_date date)
    is
        l_trace                varchar2(1000) := G_TRACE||'clear_logs: ';
        l_uplStats_moved_cnt   integer;
    begin
       bars.bars_audit.info(l_trace||'�������� ������� �� '||to_char(p_from_date,'dd/mm/yyyy'));

       insert into barsupl.upl_stats_archive
            ( id, upl_bankdate, group_id, file_id, file_code, sql_id, start_time, stop_time,
              status_id, params, upl_errors, rows_uploaded,
              start_arc_time, stop_arc_time, arc_logmess,
              start_ftp_time, stop_ftp_time, ftp_logmess, parent_id, file_name, job_id, rec_type, kf )
       select id, upl_bankdate, group_id, file_id, file_code, sql_id, start_time, stop_time,
              status_id, params, upl_errors, rows_uploaded,
              start_arc_time, stop_arc_time, arc_logmess,
              start_ftp_time, stop_ftp_time, ftp_logmess, parent_id, file_name, job_id, rec_type, kf
         from barsupl.upl_stats
        where start_time < p_from_date;

       delete from upl_stats         where start_time < p_from_date;
       delete from upl_current_jobs  where start_time < p_from_date;
       delete from upl_file_counters where bank_date  < p_from_date;

       commit;

       exception
         when others then
              bars.bars_audit.error(l_trace||' '||substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 500));
              rollback;
              raise;
    end;


    -----------------------------------------------------------------
    --  UPLOAD_FILE
    --
    --   ��������� ����  �� ����������� �������� UPL_FILES
    --
    --    p_filecode    --  ������������� ��� ����� �� ����������� (UPL_FILES)
    --    p_sqlid       --  ���� ����� ���� ����������� � ��������� ����������� ������� (����� ������� ������ ��-��������� �� upl_files.sql_id)
    --    p_param1      --  ��������� �������� ��������� 1 (������ �������� ����� ������������ ��� bind ���������� � �������� �� ��������)
    --    p_param2      --  ��������� �������� ��������� 2
    --
    -----------------------------------------------------------------
    procedure upload_file( p_filecode   upl_files.file_code%type,
                           p_sqlid      number,
                           p_param1     varchar2,
                           p_param2     varchar2
                          )
    is
    begin
       bars_upload.init_params (p_force => 1); --�������������� ������������� ����������

       bars_upload.upload_file(
                 p_filecode  => p_filecode,
                 p_sqlid     => p_sqlid,
                 p_param1    => p_param1,
                 p_param2    => p_param2
                );
    end;


    -----------------------------------------------------------------
    --  SET_LAST_WORK_DATE, GET_LAST_WORK_DATE
    --
    --   �������� ���� ���������� �������� ���, ������� ������ ���� ������� ��������
    --
    --    p_bankdate     --  ���� ������� ��������
    -----------------------------------------------------------------
    procedure set_last_work_date (p_bankdate date default null)
    is
       l_trace              varchar2(1000) := g_trace||'set_last_work_date: ';
    begin
       bars_upload_utl.check_kf(); --������������ ������ ���� �� ������ ���
       G_UPL_D0 := case when p_bankdate is null then bars.gl.bd else p_bankdate end;

       begin
           select max(f.fdat)
             into G_UPL_D1
             from bars.fdat f
            where f.fdat < G_UPL_D0
              and f.fdat not in (select holiday from bars.holiday h);
       exception when no_data_found then
           G_UPL_D1 := G_UPL_D0 - 1;
       end;
       --suda;
    end set_last_work_date;

    function get_last_work_date (p_bankdate date) return date RESULT_CACHE --DETERMINISTIC
    is
    begin
      if G_UPL_D1 is null or p_bankdate is null or G_UPL_D0 != p_bankdate then
         set_last_work_date(p_bankdate);
      end if;
      return G_UPL_D1;
    end get_last_work_date;

    -----------------------------------------------------------------
    --  IS_HOLIDAY
    --
    --  �������� �� ���� �������� �������� ��� ����������� ����
    --
    --    p_bankdate     --  ���������� ���� ��������
    --    p_sysdate      --  ��������� ���� ��������
    --    (������ ���� ���� �� ����������)
    --    p_group_id     --  ������ ��������
    -----------------------------------------------------------------
    function is_holiday (p_bankdate date default null, p_sysdate date default null, p_group_id number)
      return number
    is
      l_trace      varchar2(1000) := g_trace||'is_holiday: ';
      l_holiday    number;
      l_upl_date   date;
      l_tmp_sql    varchar2(1000);
    begin
      bars_upload_utl.check_kf(); --������������ ���������� �� ������ ���

      if p_bankdate is not null
      then
        begin
          -- ��������� ���� ��������
          select start_time
            into l_upl_date
            from upl_current_jobs
           where bank_date = p_bankdate
             and group_id = p_group_id;
        exception
          when no_data_found then
            l_holiday := 0;
            return l_holiday;
        end;
      end if;

      l_upl_date := case when p_bankdate is null then trunc(p_sysdate) else trunc(l_upl_date) end;

      -- �������� �� �������� ����
      select sign(count(1))
        into l_holiday
        from BARS.HOLIDAY
       where holiday = l_upl_date;

      return l_holiday;

    end is_holiday;


end bars_upload_usr;
/
 show err;
 
PROMPT *** Create  grants  BARS_UPLOAD_USR ***
grant EXECUTE                                                                on BARS_UPLOAD_USR to BARS;
grant EXECUTE                                                                on BARS_UPLOAD_USR to BARS_ACCESS_USER;
grant EXECUTE                                                                on BARS_UPLOAD_USR to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSUPL/package/bars_upload_usr.sql =========*** 
 PROMPT ===================================================================================== 
 