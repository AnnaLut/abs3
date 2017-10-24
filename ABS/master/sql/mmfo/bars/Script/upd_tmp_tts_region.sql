update tmp_tts_region
set kf='322669'
where tt in ('GOB','GOP','IME') and nls_type='NLSK' and kf='0';
/
commit;
/
