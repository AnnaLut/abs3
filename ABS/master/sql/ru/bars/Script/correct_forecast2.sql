set serveroutput on size 10000

exec dbms_stats.gather_table_stats('BARS','TRANSFORM_2017_FORECAST');

prompt ==== прогноз по новооткрытым счетам
exec p_transform_forecast_newacc;

select rec_id, substr(rec_message,1,400) msg from sec_audit where rec_date > sysdate - 1/48 and rec_message like 'T2017.look_for_notmaped:%' order by rec_id desc;

prompt ==== проверка по новооткрытым счетам, чтоб не попали в резерв
exec p_transform_look_for_opened;

select rec_id, substr(rec_message,1,400) msg from sec_audit where rec_date > sysdate - 1/48 and rec_message like 'T2017.look_for_opened:%' order by rec_id desc;

commit;