PROMPT ==== *** change chklist_tts for SN1 (visa 1) *** === RUN
begin
--COBUMMFO-5602
update bars.chklist_tts ct set ct.sqlval = 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0 and nlsb like ''100%'''
where ct.tt = 'SN1' and ct.idchk = 1;

end;
/
commit;

show error

PROMPT ==== *** change chklist_tts for SN1 (visa 1) *** === END
