
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_job.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_JOB is

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 1.0 05/10/2007';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;

procedure start_job ( p_id number );
procedure stop_job ( p_id number );
procedure broken  ( p_id number, p_broken boolean );

procedure add_jobtolist (
  p_jobcode   jobs_list.job_code%type,
  p_jobname   jobs_list.job_name%type,
  p_jobsysid  jobs_list.job_sysid%type,
  p_jobfilter jobs_list.job_filter%type );

procedure delete_jobfromlist ( p_jobcode jobs_list.job_code%type );

procedure modify_joblist (
  p_jobcode   jobs_list.job_code%type,
  p_jobname   jobs_list.job_name%type,
  p_jobsysid  jobs_list.job_sysid%type,
  p_jobfilter jobs_list.job_filter%type );

procedure set_jobsysid (
  p_jobcode  jobs_list.job_code%type,
  p_jobsysid jobs_list.job_sysid%type);

procedure set_jobfilter (
  p_jobcode   jobs_list.job_code%type,
  p_jobfilter jobs_list.job_filter%type );

end bars_job;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_JOB is

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 05/10/2007';
G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

MODCODE constant varchar2(3) := 'JOB';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header bars_job '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body bars_job '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

procedure start_job (p_id number) is
begin
  broken(p_id, FALSE);
end;

procedure stop_job (p_id number) is
begin
  broken(p_id, TRUE);
end;

procedure broken (p_id number, p_broken boolean) is
begin
  dbms_job.broken(p_id, p_broken);
end;

procedure add_jobtolist (
  p_jobcode   jobs_list.job_code%type,
  p_jobname   jobs_list.job_name%type,
  p_jobsysid  jobs_list.job_sysid%type,
  p_jobfilter jobs_list.job_filter%type ) is
begin
  insert into jobs_list (job_code, job_name, job_sysid, job_filter)
  values (p_jobcode, p_jobname, p_jobsysid, p_jobfilter);
exception
  when dup_val_on_index then
    bars_error.raise_error(MODCODE, 1);
end;

procedure delete_jobfromlist ( p_jobcode jobs_list.job_code%type ) is
begin
  delete from jobs_list where job_code = p_jobcode;
end;

procedure modify_joblist (
  p_jobcode   jobs_list.job_code%type,
  p_jobname   jobs_list.job_name%type,
  p_jobsysid  jobs_list.job_sysid%type,
  p_jobfilter jobs_list.job_filter%type ) is
begin
  update jobs_list
     set job_name   = p_jobname,
         job_sysid  = p_jobsysid,
         job_filter = p_jobfilter
   where job_code   = p_jobcode;
end;

procedure set_jobsysid (
  p_jobcode  jobs_list.job_code%type,
  p_jobsysid jobs_list.job_sysid%type) is
begin
  update jobs_list
     set job_sysid = p_jobsysid
   where job_code  = p_jobcode;
end;

procedure set_jobfilter (
  p_jobcode   jobs_list.job_code%type,
  p_jobfilter jobs_list.job_filter%type ) is
begin
  update jobs_list
     set job_filter = p_jobfilter
   where job_code   = p_jobcode;
end;

end bars_job;
/
 show err;
 
PROMPT *** Create  grants  BARS_JOB ***
grant EXECUTE                                                                on BARS_JOB        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_job.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 