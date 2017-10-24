
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpt_jobs_audit.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DPT_JOBS_AUDIT 
is
  -- ---------------------------------------------------------
  -- ����� ���������������� ���������� �������������� ��������
  -- ---------------------------------------------------------
  -- ��������� ������������ ������
  g_header_version  constant varchar2(64)  := 'version 3.00 06/08/2008';
  g_awk_header_defs constant varchar2(512) := '';
  g_errmsg_dim      constant number(4)     := 3000;
  g_errmsg          varchar2(3000);

  -- ������ �������������� ��������
  procedure p_start_job
  ( p_jobid       in   dpt_jobs_jrnl.job_id%type,
    p_branch      in   dpt_jobs_jrnl.branch%type,
    p_bdate       in   dpt_jobs_jrnl.bank_date%type  default gl.bd,
    p_user        in   dpt_jobs_jrnl.user_id%type    default gl.auid,
    p_run_id      out  dpt_jobs_jrnl.run_id%type );

  -- ������ �������������� ��������
  procedure p_start_job
  ( p_modcode     in   bars_supp_modules.mod_code%type,
    p_jobid       in   dpt_jobs_jrnl.job_id%type,
    p_branch      in   dpt_jobs_jrnl.branch%type,
    p_bdate       in   dpt_jobs_jrnl.bank_date%type  default gl.bd,
    p_user        in   dpt_jobs_jrnl.user_id%type    default gl.auid,
    p_run_id      out  dpt_jobs_jrnl.run_id%type );

  -- ������ � ������ ����������
  procedure p_save2log
  ( p_runid       in  dpt_jobs_log.run_id%type,
    p_dptid       in  dpt_jobs_log.dpt_id%type,
    p_dealnum     in  dpt_jobs_log.deal_num%type,
    p_branch      in  dpt_jobs_log.branch%type,
    p_ref         in  dpt_jobs_log.ref%type,
    p_rnk         in  dpt_jobs_log.rnk%type,
    p_nls         in  dpt_jobs_log.nls%type,
    p_kv          in  dpt_jobs_log.kv%type,
    p_dptsum      in  dpt_jobs_log.dpt_sum%type,
    p_intsum      in  dpt_jobs_log.int_sum%type,
    p_status      in  dpt_jobs_log.status%type,
    p_errmsg      in  dpt_jobs_log.errmsg%type,
    p_contractid  in  dpt_jobs_log.contract_id%type  default null,
    p_rateval     in  dpt_jobs_log.rate_val%type     default null,
    p_ratedat     in  dpt_jobs_log.rate_dat%type     default null );

  -- ������ � ������ ����������
  procedure p_save2log
  ( p_modcode     in   bars_supp_modules.mod_code%type,
    p_runid       in  dpt_jobs_log.run_id%type,
    p_dptid       in  dpt_jobs_log.dpt_id%type,
    p_dealnum     in  dpt_jobs_log.deal_num%type,
    p_branch      in  dpt_jobs_log.branch%type,
    p_ref         in  dpt_jobs_log.ref%type,
    p_rnk         in  dpt_jobs_log.rnk%type,
    p_nls         in  dpt_jobs_log.nls%type,
    p_kv          in  dpt_jobs_log.kv%type,
    p_dptsum      in  dpt_jobs_log.dpt_sum%type,
    p_intsum      in  dpt_jobs_log.int_sum%type,
    p_status      in  dpt_jobs_log.status%type,
    p_errmsg      in  dpt_jobs_log.errmsg%type,
    p_contractid  in  dpt_jobs_log.contract_id%type  default null,
    p_rateval     in  dpt_jobs_log.rate_val%type     default null,
    p_ratedat     in  dpt_jobs_log.rate_dat%type     default null );

  -- ��������� �������������� ��������
  procedure p_finish_job
  ( p_runid       in  dpt_jobs_jrnl.run_id%type,
    p_errmsg      in  dpt_jobs_jrnl.errmsg%type  default null );

  -- ��������� �������������� ��������
  procedure p_finish_job
  ( p_modcode     in  bars_supp_modules.mod_code%type,
    p_runid       in  dpt_jobs_jrnl.run_id%type,
    p_errmsg      in  dpt_jobs_jrnl.errmsg%type  default null );

  -- � �������������� ��������
  function f_jobid
  ( p_procname varchar2
  ) return number;

  -- ������������ ������� ���������� �������.�������� ��� OFFLINE-���������
  procedure p_ins_queue
  ( p_runid       in  dpt_jobs_queue.run_id%type,
    p_jobid       in  dpt_jobs_queue.job_id%type,
    p_branch      in  dpt_jobs_queue.branch%type,
    p_bdate       in  dpt_jobs_queue.bdate%type );

  -- ������� ������� �� ������� ���������� �������.�������� ��� OFFLINE-���������
  procedure p_del_queue
  ( p_runid       in  dpt_jobs_queue.run_id%type,
    p_jobid       in  dpt_jobs_queue.job_id%type,
    p_branch      in  dpt_jobs_queue.branch%type,
    p_bdate       in  dpt_jobs_queue.bdate%type );

  -- �������� ������ �������.������� ��� ���������� �������������
  procedure create_job
  ( p_jobcode     in  dpt_jobs_list.job_code%type,
    p_jobname     in  dpt_jobs_list.job_name%type,
    p_jobproc     in  dpt_jobs_list.job_proc%type,
    p_jobord      in  dpt_jobs_list.ord%type       default null );

  -- ����� � �������.������� �� ����������� ����
  function get_jobid
  ( p_jobcode in dpt_jobs_list.job_code%type
  ) return dpt_jobs_list.job_id%type;

  -- ��������� �������: ���������� ������ ��������� ������
  function header_version return varchar2;

  -- ��������� �������: ���������� ������ ���� ������
  function body_version return varchar2;

end dpt_jobs_audit;
/
CREATE OR REPLACE PACKAGE BODY BARS.DPT_JOBS_AUDIT 
is
modcode         constant varchar2(3)   := 'DPT';
g_body_version  constant varchar2(64)  := 'version 6.00 05/12/2014';
g_awk_body_defs constant varchar2(512) := ''
    ||'-REPL ��� ������ � �������������� ��'
;
/****************************************************************************************
 ��������  : dpt_jobs_audit
 ����������: ����� ���������������� ���������� �������������� ��������
             ������ "������ ���������-WEB"
 --------  ------ -----------------------------------------------------------------------
 05.12.14  BAA    6.00 ������ �������������� ��������� ������������ ������� ��� ���
 06.08.08  ����   5.00 ������ ������ REPL.
                       ��������� create_job � get_jobid. �������������� dpt_jobs_log.
 13.03.08  ����   4.03 � ��������� p_save2log �������� �������� p_dealnum (� ��������).
 17.08.07  ����   4.02 ������������� ������ � dpt_jobs_log- � ������ �������������� ��.
 16.07.07  ����   4.01 ������ ������  ���������� � 500, � �� � 300.
 06.06.07  ����   4.00 �������������� � ����������������.
 06.03.07  ����   3.00 �������������� ������.
 05.12.06  ����   2.00 ???
 04.10.06  ����   1.00 �������� ������.
****************************************************************************************/

--
-- ������ �������������� ��������
--
procedure p_start_job
( p_jobid   in   dpt_jobs_jrnl.job_id%type,
  p_branch  in   dpt_jobs_jrnl.branch%type,
  p_bdate   in   dpt_jobs_jrnl.bank_date%type  default gl.bd,
  p_user    in   dpt_jobs_jrnl.user_id%type    default gl.auid,
  p_run_id  out  dpt_jobs_jrnl.run_id%type
) IS
BEGIN

  p_start_job( p_modcode => 'DPT',
               p_jobid   => p_jobid,
               p_branch  => p_branch,
               p_bdate   => p_bdate,
               p_user    => p_user,
               p_run_id  => p_run_id );

END p_start_job;

--
-- ������ �������������� ��������
--
procedure p_start_job
( p_modcode in   bars_supp_modules.mod_code%type,
  p_jobid   in   dpt_jobs_jrnl.job_id%type,
  p_branch  in   dpt_jobs_jrnl.branch%type,
  p_bdate   in   dpt_jobs_jrnl.bank_date%type  default gl.bd,
  p_user    in   dpt_jobs_jrnl.user_id%type    default gl.auid,
  p_run_id  out  dpt_jobs_jrnl.run_id%type
) IS
  l_run     dpt_jobs_jrnl.run_id%type;
  l_job     dpt_jobs_list%rowtype;
  ------------------------------
  PRAGMA AUTONOMOUS_TRANSACTION;
  ------------------------------
BEGIN

  bars_audit.trace('DPT_JOBS_AUDIT(p_start_job): ��� ������� = %s, ������������� = %s',
                   to_char(p_jobid), p_branch);


  -- �������� �� ������������� �������
  BEGIN
    SELECT * INTO l_job
      FROM dpt_jobs_list
     WHERE job_id = p_jobid;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- ������� � %s �� ������� � ���-�� �������.��������
      bars_error.raise_error(MODCODE, 500, to_char(p_jobid));
  END;

  BEGIN

    CASE
      WHEN (p_modcode = 'DPT')
      THEN

        SELECT bars_sqnc.get_nextval('s_dpt_jobs_jrnl')
          INTO l_run
          FROM dual;

        INSERT INTO dpt_jobs_jrnl
          ( run_id, job_id, branch, start_date, finish_date, bank_date, user_id, status, errmsg )
        VALUES
          ( l_run, p_jobid, p_branch, sysdate, null, p_bdate, p_user, 0, null );

      WHEN (p_modcode = 'DPU')
      THEN

        SELECT bars_sqnc.get_nextval('s_dpu_jobs_jrnl')
          INTO l_run
          FROM dual;

        INSERT INTO dpu_jobs_jrnl
          ( run_id, job_id, branch, start_date, finish_date, bank_date, user_id, status, errmsg )
        VALUES
          ( l_run, p_jobid, p_branch, sysdate, null, p_bdate, p_user, 0, null );

      ELSE

        NULL;

    END CASE;

  EXCEPTION
    WHEN OTHERS THEN
      -- ������ ��� ������ � ������ ���������� ������� � %s - %s
      bars_error.raise_error(MODCODE, 501, to_char(p_jobid), substr(SQLERRM, 1, g_errmsg_dim));
  END;

  p_run_id := l_run;

  COMMIT;

  bars_audit.trace('DPT_JOBS_AUDIT(p_start_job): � ������� = %s', to_char(p_run_id));

END p_start_job;

--
-- ������ � ������ ����������
--
procedure p_save2log
( p_runid      in   dpt_jobs_log.run_id%type,
  p_dptid      in   dpt_jobs_log.dpt_id%type,
  p_dealnum    in   dpt_jobs_log.deal_num%type,
  p_branch     in   dpt_jobs_log.branch%type,
  p_ref        in   dpt_jobs_log.ref%type,
  p_rnk        in   dpt_jobs_log.rnk%type,
  p_nls        in   dpt_jobs_log.nls%type,
  p_kv         in   dpt_jobs_log.kv%type,
  p_dptsum     in   dpt_jobs_log.dpt_sum%type,
  p_intsum     in   dpt_jobs_log.int_sum%type,
  p_status     in   dpt_jobs_log.status%type,
  p_errmsg     in   dpt_jobs_log.errmsg%type,
  p_contractid in   dpt_jobs_log.contract_id%type  default null,
  p_rateval    in   dpt_jobs_log.rate_val%type     default null,
  p_ratedat    in   dpt_jobs_log.rate_dat%type     default null
) IS
begin

  p_save2log( p_modcode    => 'DPT',
              p_runid      => p_runid,
              p_dptid      => p_dptid,
              p_dealnum    => p_dealnum,
              p_branch     => p_branch,
              p_ref        => p_ref,
              p_rnk        => p_rnk,
              p_nls        => p_nls,
              p_kv         => p_kv,
              p_dptsum     => p_dptsum,
              p_intsum     => p_intsum,
              p_status     => p_status,
              p_errmsg     => p_errmsg,
              p_contractid => p_contractid,
              p_rateval    => p_rateval,
              p_ratedat    => p_ratedat );

end p_save2log;

--
-- ������ � ������ ����������
--
procedure p_save2log
( p_modcode    in   bars_supp_modules.mod_code%type,
  p_runid      in   dpt_jobs_log.run_id%type,
  p_dptid      in   dpt_jobs_log.dpt_id%type,
  p_dealnum    in   dpt_jobs_log.deal_num%type,
  p_branch     in   dpt_jobs_log.branch%type,
  p_ref        in   dpt_jobs_log.ref%type,
  p_rnk        in   dpt_jobs_log.rnk%type,
  p_nls        in   dpt_jobs_log.nls%type,
  p_kv         in   dpt_jobs_log.kv%type,
  p_dptsum     in   dpt_jobs_log.dpt_sum%type,
  p_intsum     in   dpt_jobs_log.int_sum%type,
  p_status     in   dpt_jobs_log.status%type,
  p_errmsg     in   dpt_jobs_log.errmsg%type,
  p_contractid in   dpt_jobs_log.contract_id%type  default null,
  p_rateval    in   dpt_jobs_log.rate_val%type     default null,
  p_ratedat    in   dpt_jobs_log.rate_dat%type     default null
) IS
  title     varchar2(60) := 'dpt_jobs_audit(save2log): ';
  l_recid   dpt_jobs_log.rec_id%type;
  l_jobid   dpt_jobs_jrnl.job_id%type;
  ------------------------------
  PRAGMA AUTONOMOUS_TRANSACTION;
  ------------------------------
BEGIN

  bars_audit.trace( '%s � ������� = %s, ����� � = %s, ���.������� � %s, ������������� %s',
		                title, to_char(p_runid), to_char(p_dptid), to_char(p_contractid), p_branch );

  BEGIN

    CASE
      WHEN (p_modcode = 'DPT')
      THEN

        SELECT job_id
          INTO l_jobid
          FROM dpt_jobs_jrnl
         WHERE run_id = p_runid;

      WHEN (p_modcode = 'DPU')
      THEN

        SELECT job_id
          INTO l_jobid
          FROM dpu_jobs_jrnl
         WHERE run_id = p_runid;

      ELSE

        NULL;

    END CASE;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- �� ������� ����������� ������� � %s
      bars_error.raise_error(MODCODE, 502, to_char(p_runid));
  END;

  bars_audit.trace( '%s ��� ������� = %s',  title, to_char(l_jobid) );

  BEGIN

    CASE
      WHEN (p_modcode = 'DPT')
      THEN

        SELECT bars_sqnc.get_nextval('s_dpt_jobs_log')
          INTO l_recid
          FROM dual;

        INSERT INTO dpt_jobs_log
          ( rec_id, run_id, job_id, dpt_id, branch, ref, rnk, nls, kv, dpt_sum, int_sum,
            status, errmsg, contract_id, deal_num, rate_val, rate_dat )
        VALUES
          ( l_recid, p_runid, l_jobid, p_dptid, p_branch, p_ref, p_rnk, p_nls, p_kv, p_dptsum, p_intsum,
            p_status, p_errmsg, p_contractid, p_dealnum, p_rateval, p_ratedat );

      WHEN (p_modcode = 'DPU')
      THEN

        SELECT bars_sqnc.get_nextval('s_dpu_jobs_log')
          INTO l_recid
          FROM dual;

        INSERT INTO dpu_jobs_log
          ( rec_id, run_id, job_id, dpt_id, branch, ref, rnk, nls, kv,
            dpt_sum, int_sum, status, errmsg, deal_num, rate_val, rate_dat )
        VALUES
          ( l_recid, p_runid, l_jobid, p_dptid, p_branch, p_ref, p_rnk, p_nls, p_kv,
            p_dptsum, p_intsum, p_status, p_errmsg, p_dealnum, p_rateval, p_ratedat );

      ELSE

        NULL;

    END CASE;

  EXCEPTION
    WHEN OTHERS THEN
      bars_error.raise_error( MODCODE, 503, to_char(p_runid), to_char(NVL(p_dptid,p_contractid)), SubStr(SQLERRM, 1, g_errmsg_dim) );
  END;

  bars_audit.trace('%s � ������ = %s',  title, to_char(l_recid));

  COMMIT;

END p_save2log;

--
-- ��������� �������������� ��������
--
PROCEDURE p_finish_job
( p_runid      in   dpt_jobs_jrnl.run_id%type,
  p_errmsg     in   dpt_jobs_jrnl.errmsg%type DEFAULT NULL
) IS
BEGIN

  p_finish_job( p_modcode => 'DPT',
                p_runid   => p_runid,
                p_errmsg  => p_errmsg );

END p_finish_job;

--
-- ��������� �������������� ��������
--
PROCEDURE p_finish_job
( p_modcode    in   bars_supp_modules.mod_code%type,
  p_runid      in   dpt_jobs_jrnl.run_id%type,
  p_errmsg     in   dpt_jobs_jrnl.errmsg%type DEFAULT NULL)
IS
  l_status   dpt_jobs_jrnl.status%type;
  l_cnt      number(38);
  l_cnt_bad  number(38);
  l_cnt_nul  number(38);
  l_comment  VARCHAR2(50);
  ------------------------------
  PRAGMA AUTONOMOUS_TRANSACTION;
  ------------------------------
BEGIN

  bars_audit.trace('DPT_JOBS_AUDIT(p_finish_job): � ������� = %s', to_char(p_runid));

  -- ������ ������������ �������
  BEGIN

    CASE
      WHEN (p_modcode = 'DPT')
      THEN

        SELECT status
          INTO l_status
          FROM dpt_jobs_jrnl
         WHERE run_id = p_runid;

      WHEN (p_modcode = 'DPU')
      THEN

        SELECT status
          INTO l_status
          FROM dpu_jobs_jrnl
         WHERE run_id = p_runid;

      ELSE

        NULL;

    END CASE;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- �� ������� ����������� ������� � %s
      bars_error.raise_error(MODCODE, 502, to_char(p_runid));
  END;

  bars_audit.trace('DPT_JOBS_AUDIT(p_finish_job): ������ ������� = %s', to_char(l_status));

  IF (l_status = 1 OR l_status = -1)
  THEN
     -- ������� ��� ��������� (� �������� ��� ���) -> ����������
     bars_audit.trace('DPT_JOBS_AUDIT(p_finish_job): ������� ��� ��������� (� �������� ��� ���)');
     RETURN;
  END IF;

  -- ���-�� ������� �����/� ��������/�� �����������
  CASE
    WHEN (p_modcode = 'DPT')
    THEN

      SELECT count(*),
             sum(decode(status, -1, 1, 0)),
             sum(decode(status,  0, 1, 0))
        INTO l_cnt, l_cnt_bad, l_cnt_nul
        FROM dpt_jobs_log
       WHERE run_id = p_runid;

    WHEN (p_modcode = 'DPU')
    THEN

      SELECT count(*),
             sum(decode(status, -1, 1, 0)),
             sum(decode(status,  0, 1, 0))
        INTO l_cnt, l_cnt_bad, l_cnt_nul
        FROM dpu_jobs_log
       WHERE run_id = p_runid;

    ELSE

      NULL;

  END CASE;

  --
  CASE
    WHEN (p_errmsg IS NOT NULL)
    THEN

       l_status  := -1;
       l_comment := '���� ����� ������';

    WHEN (l_cnt = 0)
    THEN

       l_status  :=  1;
       l_comment := '���������� �������';

    WHEn (l_cnt_bad > 0)
    THEN

       l_status  := -1;
       l_comment := '���� ���� ���� ������';

    WHEN (l_cnt_nul > 0)
    THEN

      l_status  :=  0;
      l_comment := '���� �������������� �����';

    ELSE

      l_status  :=  1;
      l_comment := '��������� ��� ������';

  END CASE;

  bars_audit.trace('DPT_JOBS_AUDIT(p_finish_job): '||l_comment);

  CASE
    WHEN (p_modcode = 'DPT')
    THEN

      UPDATE dpt_jobs_jrnl
         SET finish_date = sysdate,
             status = l_status,
             errmsg = p_errmsg
       WHERE run_id = p_runid;

    WHEN (p_modcode = 'DPU')
    THEN

      UPDATE dpu_jobs_jrnl
         SET finish_date = sysdate,
             status = l_status,
             errmsg = p_errmsg
       WHERE run_id = p_runid;

    ELSE

      NULL;

  END CASE;

  IF (SQL%ROWCOUNT = 0)
  THEN
    -- ������ ��� �������� ��������� ���������� ������� � %s - %s
    bars_error.raise_error(MODCODE, 504, to_char(p_runid), substr(SQLERRM, 1, g_errmsg_dim));
  END IF;

  bars_audit.trace('DPT_JOBS_AUDIT(p_finish_job): ��������� ������� � = %s', to_char(p_runid));

  COMMIT;

END p_finish_job;

--
-- � �������������� ��������
--
FUNCTION f_jobid (p_procname VARCHAR2) RETURN NUMBER
IS
   l_job dpt_jobs_list.job_id%type;
BEGIN

  BEGIN
    SELECT job_id INTO l_job
      FROM dpt_jobs_list
     WHERE upper(job_proc) = trim(upper(p_procname));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN l_job := 0;
  END;

  RETURN l_job;

END  f_jobid;

--
-- ������������ ������� ���������� �������.�������� ��� OFFLINE-���������
--
PROCEDURE p_ins_queue
 (p_runid  IN  dpt_jobs_queue.run_id%type,
  p_jobid  IN  dpt_jobs_queue.job_id%type,
  p_branch IN  dpt_jobs_queue.branch%type,
  p_bdate  IN  dpt_jobs_queue.bdate%type)
IS
  BEGIN

  bars_audit.trace('DPT_JOBS(p_ins_queue): � ������� = %s, ��� ������� = %s, '||
                   '������������� %s, ����.���� ������� = %s',
		   to_char(p_runid), to_char(p_jobid),
		   p_branch, to_char(p_bdate,'dd/mm/yyyy'));

  BEGIN
    INSERT INTO dpt_jobs_queue
      (run_id, job_id, branch, bdate)
    VALUES
      (p_runid, p_jobid, p_branch, p_bdate);
  EXCEPTION
    WHEN OTHERS THEN
      -- ������ ������������ ������� ���������� �������.�������� ��� OFFLINE-���������
      bars_error.raise_error(MODCODE, 505, substr(SQLERRM, 1, g_errmsg_dim));
  END;

  bars_audit.trace('DPT_JOBS(p_ins_queue): ������� ��������� � �������');

END;

--
-- ������� ������� �� ������� ���������� �������.�������� ��� OFFLINE-���������
--
PROCEDURE p_del_queue
 (p_runid  IN  dpt_jobs_queue.run_id%type,
  p_jobid  IN  dpt_jobs_queue.job_id%type,
  p_branch IN  dpt_jobs_queue.branch%type,
  p_bdate  IN  dpt_jobs_queue.bdate%type)
IS
BEGIN

  bars_audit.trace('DPT_JOBS(p_del_queue): � ������� = %s, ��� ������� = %s, '||
                   '������������� %s, ����.���� ������� = %s',
		   to_char(p_runid), to_char(p_jobid),
		   p_branch, to_char(p_bdate,'dd/mm/yyyy'));

  DELETE FROM dpt_jobs_queue
   WHERE run_id = p_runid
     AND job_id = p_jobid
     AND branch = p_branch
     AND bdate  = p_bdate;

  IF SQL%ROWCOUNT = 0 THEN
     -- �� ������� �������.������� � %s ��� OFFLINE-��������� � %s
     bars_error.raise_error(MODCODE, 506, to_char(p_runid), p_branch);
  END IF;

  bars_audit.trace('DPT_JOBS(p_del_queue): ������� ������� �� �������');

END p_del_queue;

--
-- �������� ������ �������.������� ��� ���������� �������������
--
procedure create_job
  (p_jobcode  in  dpt_jobs_list.job_code%type,
   p_jobname  in  dpt_jobs_list.job_name%type,
   p_jobproc  in  dpt_jobs_list.job_proc%type,
   p_jobord   in  dpt_jobs_list.ord%type default null)
is
  l_jobid    dpt_jobs_list.job_id%type;
  l_jobord   dpt_jobs_list.ord%type;
begin

  select nvl(max(job_id), 0) + 1, nvl(max(ord), 0) + 1
    into l_jobid, l_jobord
    from dpt_jobs_list;

  l_jobord := nvl(p_jobord, l_jobord);
  insert into dpt_jobs_list
     (job_id, job_code, job_name, job_proc, ord)
  values
     (l_jobid,
      substr(p_jobcode, 1, 8),
      substr(p_jobname, 1, 100),
      substr(p_jobproc, 1, 128),
      l_jobord);

exception
  when dup_val_on_index then

    update dpt_jobs_list
       set job_name = substr(p_jobname, 1, 100),
           job_proc = substr(p_jobproc, 1, 128)
     where job_code = p_jobcode;

end create_job;

--
-- ����� � �������.������� �� ����������� ����
--
function get_jobid (p_jobcode in dpt_jobs_list.job_code%type)
  return dpt_jobs_list.job_id%type
is
  l_jobid dpt_jobs_list.job_id%type;
begin
  select job_id into l_jobid
    from dpt_jobs_list
   where upper(job_code) = trim(upper(p_jobcode));
  return l_jobid;
exception
  when no_data_found then
    return null;
end get_jobid;

--
-- ��������� ������� - ���������� ������ ��������� ������
--
function header_version return varchar2
is
begin
  return 'Package header DPT_JOBS_AUDIT '|| g_header_version|| '.'||chr(10)
      || 'AWK definition: '  ||chr(10)   || g_awk_header_defs;
end header_version;
--
-- ��������� ������� - ���������� ������ ���� ������
--
function body_version return varchar2
is
begin
  return 'Package body DPT_JOBS_AUDIT '  || g_body_version||'.' ||chr(10)
      || 'AWK definition: '  ||chr(10)   || g_awk_body_defs;
end body_version;

end dpt_jobs_audit;
/
 show err;
 
PROMPT *** Create  grants  DPT_JOBS_AUDIT ***
grant EXECUTE                                                                on DPT_JOBS_AUDIT  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_JOBS_AUDIT  to DPT_ADMIN;
grant EXECUTE                                                                on DPT_JOBS_AUDIT  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpt_jobs_audit.sql =========*** End 
 PROMPT ===================================================================================== 
 