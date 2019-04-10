declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop view w4_deal_web_old';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop view w4_dkbo_web_old';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_kind_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table applist_staff_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table staff_chk_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table operlist_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table operapp_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table app_rep_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table groups_staff_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_string_value_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_string_history_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_number_value_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table refapp_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table staff_klf00_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table staff_tts_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table user_messages_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_number_history_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_history_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_date_value_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_date_history_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/

declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_clob_value_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_clob_history_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_blob_value_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
declare
    table_or_view_doesnt_exist exception;
    pragma exception_init(table_or_view_doesnt_exist, -942);
begin
   execute immediate 'drop table attribute_blob_history_bak';
exception
   when table_or_view_doesnt_exist then
        null;
end;
/
