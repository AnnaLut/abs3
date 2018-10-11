--COBUMMFO-8390 изменение условия по 7й визе для операции OW4
update chklist_tts set sqlval = '(substr(NLSA,1,4) = ''2625'' or (substr(NLSA,1,4) = ''2620'' and nvl(f_get_ob22(KV, NLSA), ''36'')=''36'')) and kv<>980 and F_CHECK_NLS_OKPO(KV,NLSA,NLSB)=1' 
where tt='OW4' and idchk=7;

commit;