SET DEFINE OFF;
Insert into TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM)
 Values
   ('ORDERM', 'UBMTYPE', 'select substr(t.name,1,10) from operw w, v_bank_metals_branch m, bank_metals_type t where w.ref=:nRecID and w.tag in (''N_BMK'', ''N_BMP'')and to_number(substr(value, 1, 4))=m.kod and t.kod=m.type_', NULL);
Insert into TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM)
 Values
   ('ORDERM', 'UBMVAG', 'select trim(substr(w.value,1,10))||decode(nvl(ves_un,0),0,'' гр.'' ,'' тр.унц'') from operw w, v_bank_metals_branch m where w.ref=:nRecID and w.tag in (''B_SLC'')and m.kod = (select to_number(substr(value, 1, 4)) from operw where ref =:nRecID and tag in (''N_BMK'', ''N_BMP''))', NULL);
Insert into TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM)
 Values
   ('ORDERM', 'UNAMKV', 'select substr(t.name,1,10) from oper o, tabval t where o.ref =:nRecID and t.kv=o.kv', NULL);
Insert into TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM)
 Values
   ('ORDERM', 'UPROBA', 'select substr(to_char(m.proba),1,10) from operw w, v_bank_metals_branch m where w.ref =:nRecID and w.tag in (''N_BMK'', ''N_BMP'') and to_number(substr(value, 1, 4))=m.kod', NULL);
Insert into TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM)
 Values
   ('ORDERM', 'USL_KOL', 'SELECT trim(to_char (s/power(10,DIG),''999999'')||'' шт.'')FROM oper o, tabval t WHERE o.ref=:nRecID and o.kv=t.kv', 'Количество слитков/монет');
Insert into TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM)
 Values
   ('ORDERM', 'USL_KURS', 'SELECT trim(to_char(to_number(w.value,''999990D999''),''999990D999'')) FROM operw w WHERE w.ref=:nRecID AND w.tag in(''KBM_P'',''KBM_K'')', 'Курс покупки/продажи  слитков/монет');
Insert into TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM)
 Values
   ('ORDERM', 'USL_VES', 'SELECT DECODE(NVL(s.ves_un,0),0,to_char(s.ves)||'' гр.'', to_char(S.VES_UN,''99990D999'')||'' унц. '') FROM operw w ,oper o,v_bank_metals_branch s WHERE w.ref=:nRecID and o.ref=w.ref AND w.tag in(''N_BMP'',''N_BMK'') AND (N_BMP(s.kod)=w.value or N_BMK(s.kod)=w.value) AND o.branch=s.BRANCH', 'Вес  слитков/монет');
COMMIT;
