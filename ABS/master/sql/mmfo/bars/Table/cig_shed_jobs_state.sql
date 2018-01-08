PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/cig_shed_jobs_state.sql =========*** Run *** ==
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to CIG_SHED_JOBS_STATE ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_SHED_JOBS_STATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_SHED_JOBS_STATE'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CIG_SHED_JOBS_STATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_SHED_JOBS_STATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_SHED_JOBS_STATE 
   (	job_name   varchar2(128) constraint pk_cigshedjobs_state primary key, 
	    last_start_date date, 
     	this_start_date date,
      next_start_date date,
      total_time varchar2(64),
      broken     varchar2(1),
      interval   varchar2(4000),
      failures   number(38),
      what       varchar(4000),
      branch     varchar2(30) default sys_context(''bars_context'',''user_branch'')
  ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to CIG_SHED_JOBS_STATE ***
 exec bpa.alter_policies('CIG_SHED_JOBS_STATE');


COMMENT ON TABLE BARS.CIG_SHED_JOBS_STATE IS 'Довідник стану виконання завдань';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.job_name IS 'Найменування';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.last_start_date IS 'Дата та час останього запуску';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.this_start_date IS 'Дата та час поточного запуску';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.next_start_date IS 'Дата та час наступного запуску';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.total_time      IS 'Час виконання';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.broken          IS	'Флаг активності';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.interval        IS 'Інтервал виконання';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.failures        IS 'Кількість невдалих запусків';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.what            IS 'Текст, що виконується';
COMMENT ON COLUMN BARS.CIG_SHED_JOBS_STATE.branch          IS 'Відділення';

PROMPT *** Create  grants  CIG_SHED_JOBS_STATE***
grant SELECT,UPDATE  on CIG_SHED_JOBS_STATE to BARS_ACCESS_DEFROLE;
/
grant SELECT         on CIG_SHED_JOBS_STATE to BARS_DM;
/
grant SELECT,UPDATE  on CIG_SHED_JOBS_STATE to CIG_ROLE;
/
PROMPT *** add data CIG_SHED_JOBS_STATE***
begin
   delete from cig_shed_jobs_state;
  
   insert into cig_shed_jobs_state value
    (
    select s.job_name job,
            s.last_start_date,
            NULL,
            s.next_run_date,
            TO_CHAR(s.last_run_duration) AS total_time,
            CASE
              WHEN s.enabled = 'FALSE' THEN
               'Y'
              ELSE
               'N'
            END broken,
            s.repeat_interval interval,
            s.FAILURE_COUNT failures,
            s.job_action what,
            case
              when s.job_name = 'J2248' then
               '/300465/'
              when s.job_name = 'J2249' then
               '/322669/'
              when s.job_name = 'J2250' then
               '/324805/'
              ELSE
               NULL
            end as branch
       from all_scheduler_jobs s
      where s.job_name in ('J2249', 'J2248', 'J2250')
      );
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_STATES.sql =========*** End *** ==
PROMPT ===================================================================================== 
