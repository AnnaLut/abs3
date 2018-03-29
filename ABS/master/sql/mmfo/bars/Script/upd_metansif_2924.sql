update META_NSIFUNCTION
set WEB_FORM_NAME = replace (WEB_FORM_NAME , ':S1', ':DEL')
 where tabid = bars_metabase.get_tabid('V_ATMREF17') and WEB_FORM_NAME like '%:S1%';
 commit
 /