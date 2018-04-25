declare
    pk_doesnt_exist exception;
    pragma exception_init(pk_doesnt_exist, -2441);
begin
    execute immediate 'alter table barstrans.transp_send_resp_params drop primary key cascade drop index';
exception
    when pk_doesnt_exist then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -995);
begin
    execute immediate 'create index barstrans.i_transp_send_resp_params on barstrans.transp_send_resp_params (req_id) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/
