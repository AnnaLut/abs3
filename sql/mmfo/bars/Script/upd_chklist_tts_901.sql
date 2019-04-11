PROMPT ==== *** change chklist_tts for 901 (visa 7) *** === RUN
--COBUMMFO-9464
update CHKLIST_TTS set SQLVAL = q'[((substr(NLSA,1,4) = '3720' and ( substr(NLSB,1,4) in ('2603','2620','2625') ) and kv<>980 ) or 
(substr(NLSA,1,4) = '3720' and ( substr(NLSB,1,4) = '2603' and f_get_ob22(980, NLSB) = '05' and get_nls_tip(NLSB, 980) in ('NL7','NLZ') ) and kv=980 ))]'
where tt='901' and IDCHK=7;

commit;

show error

PROMPT ==== *** change chklist_tts for 901 (visa 7) *** === END
