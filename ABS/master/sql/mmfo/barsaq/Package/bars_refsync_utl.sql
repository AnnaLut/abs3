
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_refsync_utl.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_REFSYNC_UTL is


  ----------------------------------------------------
  --
  --  ����� ���������������� ������ ���
  --  ��������� ������ ������������� ������������ ����� ORACLE_STREAMS
  --
  ----------------------------------------------------

  G_HEADER_VERSION constant varchar2(64)  := 'version 1.3  07.06.2010';




  ------------------------------------
  -- HEDER_VERSION
  --
  -- ���������� ������ ��������� ������
  --
  function header_version return varchar2;




  ------------------------------------
  -- BODY_VERSION
  --
  -- ���������� ������ ��������� ������
  --
  function body_version return varchar2;



  ------------------------------------
  --   MANAGE_APPLY
  --
  --   �������/������ apply ��������
  --
  --   p_doing  'STOP' ��� 'START'
  --
  procedure manage_apply(p_doing varchar2);




  ------------------------------------
  --   MANAGE_CAPTURE
  --
  --   �������/������ capture ��������
  --
  --   p_doing  'STOP' ��� 'START'
  --
  procedure manage_capture(p_doing varchar2);




  ------------------------------------
  --   CREATE_STREAM_PROCESS
  --
  --   �������� �apture/apply ��������.
  --
  --
  procedure create_stream_process;



  ------------------------------------
  --   REMOVE_STREAM_PROCESS
  --
  --   ��������  �apture/apply ��������.
  --
  --
  procedure remove_stream_process;




    ------------------------------------
  --   RECREATE_STREAM_PROCESS
  --
  --   ������������ �apture/apply ��������.
  --
  --
  procedure recreate_stream_process;



  -------------------------------------------------------
  --   PURGE_REFSYNC_QUEUE
  --
  --   �������� ���������� ������� aq_refsync_ybl
  --
  --   p_dummy number - ����� ����� ��� ������������� � Centura
  --
  procedure purge_refsync_queue(p_dummy number default 0);



  ------------------------------------
  --   STREAMS_GUARD
  --
  --   ��������� ������������ ��������� �������� STREAM
  --   � ������ ��� �������� - ������� �������������� ���
  --
  procedure streams_guard;



  ------------------------------------
  --  JOB_INFO
  --
  --  �������� ��������� � job-�, �������
  --  ������ aq_refsync � ��������� ������� ������� ������� ��� JBOOS
  --
  procedure job_info(
                  p_job        out number,
                  p_status     out varchar2,
                  p_next_date  out date,
                  p_failures   out number);



  ------------------------------------
  --   TAKE_JOB_OFFLINE
  --
  --   ������������ ���� ����������� ������� aq_refsync_tbl
  --   � ������ broken
  --
  procedure take_job_offline(p_dummy number  default 0);



  ------------------------------------
  --   TAKE_JOB_ONLINE
  --
  --   ������������ ���� ����������� ������� aq_refsync_tbl
  --   � ������ online
  --
  procedure take_job_online(p_dummy number  default 0);


  ------------------------------------
  --   POST_GUARD_EMAIL
  --
  --   �������� ��������� �� stream guard
  --
  procedure post_guard_email(p_messcode number, p_errmsg varchar2);

end bars_refsync_utl;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_REFSYNC_UTL is

  ----------------------------------------------------
  --
  --  ����� ���������������� ������ ���
  --  ��������� ������ ������������� ������������ ����� ORACLE_STREAMS
  --
  ----------------------------------------------------


  ----------------------------------------------------
  -- ���������
  ----------------------------------------------------
  G_BODY_VERSION        constant varchar2(64)   := 'version 1.5 20.08.2010';
  G_MODULE_NAME         constant varchar2(3)    := 'SYN';
  G_TRACE               constant varchar2(20)   := 'bars_refsync_utl.';



  G_STREAMS_OK          constant number   :=   0;
  G_APPLY_STOP_ERR      constant number   :=  10;
  G_APPLY_START_ERR     constant number   :=  20;
  G_CAPTURE_STOP_ERR    constant number   :=  30;
  G_CAPTURE_START_ERR   constant number   :=  40;

  G_CAPTURE_WAIT_DICTREDO  constant number   :=  100;
  G_CAPTURE_WAIT_REDO      constant number   :=  200;

  ----------------------------------------------------
  --  HEADER_VERSION
  --
  --  ���������� ������ ��������� ������
  --
  ----------------------------------------------------
  function header_version return varchar2 is
  begin
    return 'Package header vers:'||G_HEADER_VERSION;
  end header_version;



  ----------------------------------------------------
  -- BODY_VERSION
  --
  -- ���������� ������ ���� ������
  --
  ----------------------------------------------------
  function body_version return varchar2 is
  begin
    return 'Package body vers:'||G_BODY_VERSION;
  end body_version;




  ------------------------------------
  --   MANAGE_APPLY
  --
  --   �������/������ apply ��������
  --
  --   p_doing  'STOP' ��� 'START'
  --
  procedure manage_apply(p_doing varchar2)
  is
     l_trace      varchar2(1000):= G_TRACE||'manage_apply: ';
  begin
     case  p_doing
       when  'STOP'  then bars.bars_audit.info(l_trace||'������� apply');
                          dbms_apply_adm.stop_apply ('BARS_APPLY');
       when  'START' then bars.bars_audit.info(l_trace||'����� apply');
                          dbms_apply_adm.start_apply('BARS_APPLY');
       when  'DROP'  then bars.bars_audit.info(l_trace||'�������� apply');
                          dbms_apply_adm.delete_all_errors;
                          dbms_apply_adm.drop_apply('BARS_APPLY');
       else  bars.bars_error.raise_error(G_MODULE_NAME,18007);
     end case;
  exception when others then
     if sqlcode = -26701 then null; -- STREAMS process BARS_APPLY does not exist
     else raise;
     end if;
  end;




  ------------------------------------
  --   MANAGE_CAPTURE
  --
  --   �������/������ capture ��������
  --
  --   p_doing  'STOP' ��� 'START'
  --
  procedure manage_capture(p_doing varchar2)
  is
     l_trace      varchar2(1000):= G_TRACE||'manage_capture: ';
  begin
     case  p_doing
       when  'STOP'  then bars.bars_audit.info(l_trace||'������� capture');
                          begin
                             dbms_capture_adm.stop_capture('BARS_CAPTURE');
                          exception when others then
                             if sqlcode = -26701 then null; --STREAMS process BARS_CAPTURE does not exist
                             else raise;
                             end if;
                          end;

       when  'START' then bars.bars_audit.info(l_trace||'����� capture');
                          begin
                             dbms_capture_adm.start_capture('BARS_CAPTURE');
                          exception when others then
                             if sqlcode = -26666 then null; --ORA-26666: cannot alter STREAMS process BARS_CAPTURE  (allready runing)
                             else raise;
                             end if;
                          end;

       when  'DROP'  then bars.bars_audit.info(l_trace||'�������� capture');
                          begin
                             dbms_capture_adm.drop_capture(capture_name => 'BARS_CAPTURE');
                          exception when others then
                             if sqlcode = -26701 then null; --STREAMS process BARS_CAPTURE does not exist
                             else raise;
                             end if;
                          end;

       else  bars.bars_error.raise_error(G_MODULE_NAME,18007);

     end case;
  end;





  ------------------------------------
  --   DROP_QUEUE
  --
  --   �������� ������� ���������
  --
  --
  procedure drop_queue(p_qname varchar2, p_qtabname varchar2)
  is
     l_trace     varchar2(1000):= G_TRACE||'drop_queue: ';
  begin

     begin
        bars.bars_audit.info(l_trace||'������� ������� '||p_qname);
        dbms_aqadm.stop_queue(queue_name => 'barsaq.'||p_qname);
     exception when others then
        if sqlcode=-24010 then null; else raise; end if;
     end;

     begin
        bars.bars_audit.info(l_trace||'�������� ������� '||p_qname);
        dbms_aqadm.drop_queue (queue_name  => 'barsaq.'||p_qname);
     exception when others then
       if sqlcode=-24010 then null; else raise; end if;
     end;


     begin
        bars.bars_audit.info(l_trace||'�������� ������� ������� '||p_qtabname);
        dbms_aqadm.drop_queue_table( queue_table => 'barsaq.'||p_qtabname,  force => true);
     exception when others then
        if sqlcode=-24002 then null; else raise; end if;
     end;


  end;




  ------------------------------------
  --   CREATE_STREAM_PROCESS
  --
  --   �������� �apture/apply ��������.
  --
  --
  procedure create_stream_process
  is
     l_trace      varchar2(1000):= G_TRACE||'create_stream: ';
     l_dbname                global_name.global_name%type;
     l_table_name            varchar2(30);
     l_evaluation_context    varchar2(61);
     l_start_scn	     number;
     l_num	             number;
  begin

     bars.bars_audit.info(l_trace||'������� ������� STREAMS_QUEUE');
     dbms_streams_adm.set_up_queue
       (queue_table         => 'STREAMS_QUEUE_TABLE',
        storage_clause      => NULL,
        queue_name          => 'STREAMS_QUEUE',
        queue_user          => 'BARSAQ',
        comment             => 'This is general streams queue');

     --execute immediate 'set role dba';
     --execute immediate 'alter trigger BARS.TDDL_CRTAB disable ';


     bars.bars_audit.info(l_trace||'������� �������  ������� aq_refsync_tbl');
      dbms_aqadm.create_queue_table(
         queue_table         => 'barsaq.aq_refsync_tbl',
         queue_payload_type  => 'sys.anydata',
         multiple_consumers  => true,
         secure		    => true,
         message_grouping    => dbms_aqadm.transactional,
         comment             => 'This is queue for manually enqueued LCRs');

     bars.bars_audit.info(l_trace||'�������  ������� aq_refsync');
     dbms_aqadm.create_queue (
         queue_name         => 'barsaq.aq_refsync',
         queue_table        => 'barsaq.aq_refsync_tbl');

     bars.bars_audit.info(l_trace||'����� ������� aq_refsync');
     dbms_aqadm.start_queue(queue_name  => 'barsaq.aq_refsync' );




     bars.bars_audit.info(l_trace||'�������� ������ ������');

     begin
        l_evaluation_context := 'SYS.STREAMS$_EVALUATION_CONTEXT';

        select global_name into l_dbname from global_name;
        dbms_rule_adm.create_rule_set(
            rule_set_name       => 'RULE_SET_BARS_CAPTURE',
            evaluation_context  => l_evaluation_context,
            rule_set_comment    => 'This is rule set for BARS_CAPTURE process');
     exception when others then
        if sqlcode = -24153 then null;  --rule set BARSAQ.RULE_SET_BARS_CAPTURE already exists
        else raise;
        end if;
     end;



     bars.bars_audit.info(l_trace||'�������� capture');
     begin
         select 1 into l_num from dba_capture where rownum=1;
         l_start_scn := dbms_flashback.get_system_change_number;
     exception when no_data_found then
     	l_start_scn := null;
     end;

     begin
        dbms_capture_adm.create_capture(
            queue_name          => 'STREAMS_QUEUE',
            capture_name        => 'BARS_CAPTURE',
            rule_set_name       => 'RULE_SET_BARS_CAPTURE',
            start_scn           => l_start_scn);
     exception when others then
        if sqlcode = -26665 then null; --STREAMS process BARS_CAPTURE already exists
        else raise;
        end if;
     end;



     bars.bars_audit.info(l_trace||'�������� apply');
     begin
        dbms_apply_adm.create_apply(
            queue_name          => 'STREAMS_QUEUE',
            apply_name          => 'BARS_APPLY',
            rule_set_name       => NULL,
            message_handler     => NULL,
            apply_user          => NULL,
            apply_captured      => true);
       dbms_apply_adm.set_parameter(
            apply_name          => 'BARS_APPLY',
            parameter           => 'disable_on_error',
            value               => 'n');
    end;


    manage_capture('START');
    manage_apply('START');


  end;





  -------------------------------------------
  --   REMOVE_STREAM_PROCESS
  --
  --   ��������  �apture/apply ��������.
  --
  --
  procedure remove_stream_process
  is
     l_rule_set_name     dba_rule_sets.rule_set_name%type;
     l_rule_set_owner    dba_rule_sets.rule_set_owner%type;
     l_trace      varchar2(1000):= G_TRACE||'remove_stream: ';
  begin

     bars.bars_audit.info(l_trace||'������ �������� ORACLE STREAMS');

     -- ��� ����������
     bars.bars_audit.info(l_trace||'������� ������ APPLY');
     manage_apply('STOP');
     bars.bars_audit.info(l_trace||'������� ������ CAPTURE');
     manage_capture('STOP');


     bars.bars_audit.info(l_trace||'�������� �������� APPLY');
     manage_apply('DROP');
     bars.bars_audit.info(l_trace||'�������� �������� CAPTURE');
     manage_capture('DROP');


     -- ������� ����������� ������� ��� JBOSS
     for c in ( select table_name from v_subscribed_tables) loop
         bars.bars_audit.info(l_trace||'�������� ������� '||c.table_name);
         bars_refsync.remove_table(c.table_name);
     end loop;

     -- ������� �����������
     for c in (select name from barsaq.aq_subscribers) loop
         bars.bars_audit.info(l_trace||'�������� ����������� '||c.name);
         bars_refsync.remove_subscriber(c.name);
     end loop;


     bars.bars_audit.info(l_trace||'�������� ������� aq_refsync');
     drop_queue('aq_refsync','AQ_REFSYNC_TBL');

     bars.bars_audit.info(l_trace||'�������� ������� streams_queue');
     drop_queue('streams_queue','STREAMS_QUEUE_TABLE');

  end;




  ------------------------------------
  --   RECREATE_STREAM_PROCESS
  --
  --   ������������ �apture/apply ��������.
  --
  --
  procedure recreate_stream_process
  is
     l_rule_set_name     dba_rule_sets.rule_set_name%type;
     l_rule_set_owner    dba_rule_sets.rule_set_owner%type;
     l_trace      varchar2(1000):= G_TRACE||'recreate_stream: ';
  begin
     null;
  end;




  -------------------------------------------------------
  --   PURGE_REFSYNC_QUEUE
  --
  --   �������� ���������� ������� aq_refsync_ybl
  --
  --   p_dummy number - ��� ������������� � Centura
  --
  procedure purge_refsync_queue(p_dummy number  default 0)
  is
     l_purge_opt   dbms_aqadm.aq$_purge_options_t;
  begin
     l_purge_opt.block         := false;
     l_purge_opt.delivery_mode := dbms_aq.persistent;

     manage_apply('STOP');
     manage_capture('STOP');

     dbms_aqadm.purge_queue_table(
          queue_table        => 'barsaq.aq_refsync_tbl',
          purge_condition    => '',
          purge_options      => l_purge_opt);

     manage_capture('START');
     manage_apply('START');

  end;


  ------------------------------------
  --   POST_GUARD_EMAIL
  --
  --   �������� ��������� �� stream guard
  --
  procedure post_guard_email(p_messcode number, p_errmsg varchar2)
  is
     l_message  varchar2(2000);
     l_trace    varchar2(2000) := G_TRACE||'stream_guard_mail:;' ;
  begin

     -- ���� ���� �� ��� ���������� ����� �������� 2 ���� � ����
     for c in (select email_adr, name, post_msgcode, post_date
                 from bars.xml_streamguard_recip)
     loop

         if p_messcode = c.post_msgcode and sysdate < c.post_date + (5*1)/24    then
            -- ���� ��� ��������� �������� ������ 5-�� �����
            bars_audit.info(l_trace||' �������� '||p_messcode||' ��� ���� ������� � '||to_char(c.post_date,'dd/mm/yyyy hh24:mi:ss') );
	    return;


         else
	    l_message := '������� CAPTURE ���������� � ���������� ����.';

	    case p_messcode
               when   G_STREAMS_OK       then
                   l_message := l_message ||' � ������������� ����� ������ ������� ���� ���������.';
	       when   G_APPLY_STOP_ERR   then
	           l_message := '��� ����� �������� ������ �������, �������� ������� ��� ������� APPLY: '||p_errmsg;
               when  G_APPLY_START_ERR   then
	           l_message := '��� ����� �������� ������ �������, �������� ������� ��� ����� APPLY: '||p_errmsg;
               when  G_CAPTURE_STOP_ERR  then
	           l_message := '��� ����� �������� ������ �������, �������� ������� ��� ������� CAPTURE: '||p_errmsg;
	       when  G_CAPTURE_START_ERR then
	           l_message := '��� ����� �������� ������ �������, �������� ������� ��� ����� CAPTURE: '||p_errmsg;
  	       when  G_CAPTURE_WAIT_DICTREDO  then
  	           l_message := '³������� ����������� ������ �� �� ���������, ������� ���������� ������(log file), '||
		                '� ����� ����������� dictionary build - �������. ������� ������������ �������. �������:'||p_errmsg;
               when  G_CAPTURE_WAIT_DICTREDO  then
  	           l_message := '³������� ����������� ������ �� �� ���������, ������� �� �������� ������(log file). '||
		                '������� ������������ ������� ��� �������� ��������� ������(log file) �������:'||p_errmsg;
	     end case;

	    bars.bars_mail.put_msg2queue(
                  p_name     =>  c.name,
                  p_addr     =>  c.email_adr,
                  p_subject  =>  '����������� �� ������� ������������ �������� ORACLE_STREAMS',
                  p_body     =>  l_message );

	     bars_audit.error(l_trace||l_message);

	     update bars.xml_streamguard_recip
	        set post_msgcode = p_messcode, post_date = sysdate
	      where email_adr = c.email_adr;

         end if;


     end loop;
  end;



  ------------------------------------
  --   STREAMS_GUARD
  --
  --   ��������� ������������ ��������� �������� STREAM
  --   � ������ ��� �������� - ������� �������������� ���
  --
  procedure streams_guard
  is
     l_status    varchar2(2000);
     l_state     varchar2(2000);
     l_message   varchar2(2000);
     l_trace     varchar2(1000):= G_TRACE||'streams_guard: ';
  begin
     execute immediate 'alter session set current_schema=barsaq';
     select d.status, s.state
       into l_status, l_state
       from dba_capture d,  v$streams_capture s
      where d.capture_name = s.capture_name(+)
        and d.capture_name = 'BARS_CAPTURE';



     -- CAPTURE �������� ������
     if l_status <> 'ENABLED' then
	begin
           manage_apply('STOP');
        exception when others then
           post_guard_email(G_APPLY_STOP_ERR, sqlerrm);
           return;
        end;

        begin
	   manage_capture('STOP');
        exception when others then
           post_guard_email(G_CAPTURE_STOP_ERR, sqlerrm);
           return;
        end;

        begin
	   manage_capture('START');
        exception when others then
           post_guard_email(G_CAPTURE_START_ERR, sqlerrm);
           return;
        end;

        begin    manage_apply('START');
        exception when others then
           post_guard_email(G_APPLY_START_ERR, sqlerrm);
           return;
        end;
     -- CAPTURE �������
     else
        if instr(l_state, 'WAITING FOR DICTIONARY REDO') > 0 then
           post_guard_email(G_CAPTURE_WAIT_DICTREDO, l_state);
           return;
        end if;

        if instr(l_state, 'WAITING FOR REDO') > 0 then
           post_guard_email(G_CAPTURE_WAIT_REDO, l_state);
           return;
        end if;

        null;
	bars_audit.info(l_trace||'������� � ������� ���������');
	-- ������� �������, ������ ������ �� �����
        return;

     end if;

     post_guard_email(G_STREAMS_OK, null);

   /* INITIALIZING
      CAPTURING CHANGES
      EVALUATING RULE
      ENQUEUING MESSAGE
      SHUTTING DOWN
      ABORTING
      CREATING LCR
      WAITING FOR DICTIONARY REDO
      WAITING FOR REDO
      PAUSED FOR FLOW CONTROL
      DICTIONARY INITIALIZATION
  */


  end;


  ------------------------------------
  --   GET_JOBID
  --
  --   �������� ����� �����, �������
  --   ������ aq_refsync � ��������� ������� ������� ������� ��� JBOOS
  --
  function get_jobid return number
  is
     l_jobid number;
  begin

     select job
       into l_jobid
       from dba_jobs
      where lower(what) like  ('%bars_xmlklb_ref.post_incref_for_all%')
        and log_user='JBOSS_USR' and rownum=1;
      return l_jobid;

  exception when no_data_found then
     return -1;
  end;




  ------------------------------------
  --  JOB_INFO
  --
  --  �������� ��������� � job-�, �������
  --  ������ aq_refsync � ��������� ������� ������� ������� ��� JBOOS
  --
  procedure job_info(
                  p_job        out number,
                  p_status     out varchar2,
                  p_next_date  out date,
                  p_failures   out number)
  is
     l_jobid number;
  begin

     l_jobid := get_jobid;

     select job,  next_date, decode(broken,'Y','broken','worked') status, failures
       into p_job,  p_next_date, p_status, p_failures
       from dba_jobs
      where job = l_jobid;

  exception when no_data_found then
     p_job    := -1;
     p_status := 'not exists';
  end;




  ------------------------------------
  --   TAKE_JOB_OFFLINE
  --
  --   ������������ ���� ����������� ������� aq_refsync_tbl
  --   � ������ broken
  --
  procedure take_job_offline(p_dummy number  default 0)
  is
  begin
     sys.dbms_job.broken
      ( job       => get_jobid,
        broken    => true,
        next_date => sysdate + 1
      );

  end;



  ------------------------------------
  --   TAKE_JOB_ONLINE
  --
  --   ������������ ���� ����������� ������� aq_refsync_tbl
  --   � ������ online
  --
  procedure take_job_online(p_dummy number  default 0)
  is
     l_cnt number;
  begin

     select count(*) into l_cnt
     from barsaq.aq_refsync_tbl;

     if l_cnt > 10000 then
        bars.bars_error.raise_error(G_MODULE_NAME, 18009);
     end if;

     sys.dbms_job.broken
      ( job       => get_jobid,
        broken    => false,
        next_date => sysdate + (5/(24*60))
      );

  end;




end bars_refsync_utl;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/bars_refsync_utl.sql =========*** 
 PROMPT ===================================================================================== 
 