PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/table/ewa_request_log.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ewa_request_log ***
begin 
  execute immediate  
    'begin  
       bpa.alter_policy_info(''EWA_REQUEST_LOG'', ''FILIAL'' , null, null, null, null);
       bpa.alter_policy_info(''EWA_REQUEST_LOG'', ''WHOLE'' , null, null, null, null);
     end; 
    '; 
end; 
/

PROMPT *** Create  table ewa_request_log ***
begin 
  execute immediate '
    create table ewa_request_log
    (
      insert_dttm  timestamp(9) default localtimestamp constraint cc_ewa_req_log_insert_dttm_nn not null,
      create_date  date         default trunc(sysdate) constraint cc_ewa_req_log_create_date_nn not null,
      ewa_id       number(38),
      req_type     varchar2(4)  constraint cc_ewa_req_log_req_type check(req_type in (''PAYM'',''DEAL'',''PURP'')) not null,
      errm         varchar2(4000),
      sec_audit_id number(38),
      req_data     clob,
      xml_data     clob
    )
    tablespace BRSDYND
      pctfree 10
      initrans 1
      maxtrans 255
      nocache
      nologging
    LOB(req_data,xml_data) store as securefile
    (
        compress medium
        chunk 4096
        nocache
        nologging
    )
    partition by range (create_date)
    interval(numtoyminterval(1, ''MONTH''))
      (partition no_drop values less than ( to_date(''01.01.2019'',''dd.mm.yyyy'')))';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Create comment on table ewa_request_log ***
comment on table ewa_request_log is 'Історія запитів EWA';
comment on column ewa_request_log.ewa_id   is 'id EWA';
comment on column ewa_request_log.create_date is 'Дата створення операції';
comment on column ewa_request_log.insert_dttm is 'Дата та час створення запису';
comment on column ewa_request_log.req_type is 'Тип запиту EWA ("PAYM" - pay_isu - створення платежу, "DEAL" - create_deal - створення договору, "PURP" - get_purpose - отримання призначення платежу)';
comment on column ewa_request_log.errm is 'Текст помилки';
comment on column ewa_request_log.sec_audit_id is 'id запису в журналі аудиту';
comment on column ewa_request_log.req_data is 'Текст запиту в форматі json';
comment on column ewa_request_log.xml_data is 'Текст запиту конвертований в в форматі xml';


PROMPT *** Create local index i_ewa_request_log_create_date ***
begin
  execute immediate 'create index i_ewa_request_log_create_date ON ewa_request_log (create_date) local tablespace BRSDYNI';
exception 
  when others then 
    if sqlcode = -955 or sqlcode = -1408 then 
      null; 
    else 
      raise; 
    end if; 
end;
/ 

PROMPT *** Create local index i_ewa_request_log_insert_dttm ***
begin
  execute immediate 'create index i_ewa_request_log_insert_dttm on ewa_request_log (insert_dttm) local tablespace BRSDYNI';
exception 
  when others then 
    if sqlcode = -955 or sqlcode = -1408 then 
      null; 
    else 
      raise; 
    end if; 
end;
/ 

PROMPT *** Create local index i_ewa_request_log_ewa_id ***
begin
  execute immediate 'create index i_ewa_request_log_ewa_id on ewa_request_log (ewa_id) local tablespace BRSDYNI';
exception 
  when others then 
    if sqlcode = -955 or sqlcode = -1408 then 
      null; 
    else 
      raise; 
    end if; 
end;
/ 

PROMPT *** Create local index i_ewa_request_log_sec_audit_id ***
begin
  execute immediate 'create index i_ewa_request_log_sec_audit_id on ewa_request_log (sec_audit_id) local tablespace BRSDYNI';
exception 
  when others then 
    if sqlcode = -955 or sqlcode = -1408 then 
      null; 
    else 
      raise; 
    end if; 
end;
/ 


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/table/ewa_request_log.sql =========*** End
PROMPT ===================================================================================== 
