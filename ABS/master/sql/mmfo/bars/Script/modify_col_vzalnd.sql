update BARS.META_COLUMNS set web_form_name = '/barsroot/viewaccounts/accountform.aspx?type=2'||chr(38)||'acc=:ACC'||chr(38)||'rnk='||chr(38)||'accessmode=1'
where tabid = BARS_METABASE.GET_TABID('V_ZAL_ND') and colname = 'NLS';

commit;