------------------------------------
--RU
------------------------------------
update tts 
set nlsk='#(get_proc_nls(''T00'',#(KVA)))'
where tt in('CL0', 'CLS', 'CLB');
/
commit
/
