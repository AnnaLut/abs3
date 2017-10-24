
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/function/retrieve_apply_errors.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARSAQ.RETRIEVE_APPLY_ERRORS 
return clob
is
    --
    -- ф-ция возвращает описание ошибок APPLY процесса
    -- и содержимое транзакций с ошибками
    --
  cursor c is
    select local_transaction_id,
           source_database,
           message_number,
           message_count,
           error_number,
           error_message
      from dba_apply_error
      order by source_database, source_commit_scn;
  i      number;
  txnid  varchar2(30);
  source varchar2(128);
  msgno  number;
  msgcnt number;
  errnum number := 0;
  errno  number;
  errmsg varchar2(2000);
  lcr    anydata;
  r      number;
  l_clob clob;
  l_clob_created  boolean := false;
  l_str  varchar2(32767);
begin
  --
  dbms_lob.createtemporary(l_clob, true, dbms_lob.session);
  l_clob_created := true;
  --
  for r in c loop
    errnum := errnum + 1;
    msgcnt := r.message_count;
    txnid  := r.local_transaction_id;
    source := r.source_database;
    msgno  := r.message_number;
    errno  := r.error_number;
    errmsg := r.error_message;
    l_str  := '*************************************************'||chr(10);
    dbms_lob.writeappend(l_clob, length(l_str), l_str);
    l_str  := '----- ERROR #' || errnum ||chr(10);
    dbms_lob.writeappend(l_clob, length(l_str), l_str);
    l_str  := '----- Local Transaction ID: ' || txnid||chr(10);
    dbms_lob.writeappend(l_clob, length(l_str), l_str);
    l_str  := '----- Source Database: ' || source||chr(10);
    dbms_lob.writeappend(l_clob, length(l_str), l_str);
    l_str := '----Error in Message: '|| msgno||chr(10);
    dbms_lob.writeappend(l_clob, length(l_str), l_str);
    l_str := '----Error Number: '||errno||chr(10);
    dbms_lob.writeappend(l_clob, length(l_str), l_str);
    l_str := '----Message Text: '||errmsg||chr(10);
    dbms_lob.writeappend(l_clob, length(l_str), l_str);
    for i in 1..msgcnt loop
      l_str := '--message: ' || i || chr(10);
      dbms_lob.writeappend(l_clob, length(l_str), l_str);
      lcr := dbms_apply_adm.get_error_message(i, txnid);
      dbms_lob.append(l_clob, f_lcr_to_char(lcr));
    end loop;
  end loop;
  return l_clob;
end retrieve_apply_errors;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/function/retrieve_apply_errors.sql =======
 PROMPT ===================================================================================== 
 