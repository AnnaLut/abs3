create or replace procedure p_interest_txt(p_clob out clob, p_namefile out varchar2)
as
    l_sql varchar2(2000);
    l_clob clob;
    l_txt clob;--varchar2(32000);
    l_chr varchar2(2) := chr(13)||chr(10);
    l_mfo varchar2(6) := f_ourmfo;
    l_reckoning_id     INT_RECKONING.RECKONING_ID%TYPE;
    l_isp  varchar2(70);
    l_buh  varchar2(70);
    l_name varchar2(170);
    l_boss varchar2(70);
    l_sum_INTEREST_AMOUNT number(20,2);
    g_number_format constant varchar2(128) := 'FM999999999999999999999999999990.00';
    g_number_nlsparam constant varchar2(30) := 'NLS_NUMERIC_CHARACTERS = ''. ''';
    /*
        Author  : SERGEY.LITVIN
        Created : 16.11.2017 14:00:57
        Purpose : 
    */
begin

    l_reckoning_id := sys_context('bars_pul', 'reckoning_id');
    l_buh       := SUBSTR (GetGlobalOption('ACCMAN'), 1, 70);
    l_name := GetGlobalOption('NAME');
    l_boss :=  SUBSTR (GetGlobalOption('BOSS'), 1, 70);
    
    BEGIN
       SELECT SUBSTR (fio, 1, 70)
         INTO l_isp
         FROM staff$base
        WHERE id = user_id;
    END;
    

    BEGIN
        SELECT    'PR_'||to_CHAR(SYSDATE, 'DDMM')||'.000'
          INTO p_namefile
          FROM DUAL;
    END;
    
   dbms_lob.createtemporary(l_clob,  true);
   l_txt := 'ВIДОМIСТЬ :                                                                                   '||'Надруковано  '||to_char(sysdate,'dd/mm/yyyy  hh24:mi:ss')||l_chr;
   dbms_lob.append(l_clob, l_txt);

   l_txt := lpad('-',125,'-')||l_chr;
   dbms_lob.append(l_clob, l_txt);

   l_txt := '                                     ВIДОМIСТЬ  НАРАХОВАНИХ ВIДСОТКIВ від: '||to_char( gl.bd,'dd/mm/yyyy')||l_chr||l_chr;
   dbms_lob.append(l_clob, l_txt);

   l_txt := l_mfo||' '||l_name||l_chr;
    dbms_lob.append(l_clob, l_txt);


   l_txt := lpad('-',125,'-')||l_chr;
   dbms_lob.append(l_clob, l_txt);
    
   l_txt := ':   Рахунок     : валюта :  Назва рахунку             :   Перiод початок    :    Перiод кінець    :  Ставка :  Вiдсоткове число :   Нараховано вiдсоткiв :'||l_chr;
   DBMS_LOB.append(l_clob, l_txt);
   
   l_txt := lpad('-',125,'-')||l_chr;
   DBMS_LOB.append(l_clob, l_txt);
   
   l_sum_INTEREST_AMOUNT := 0 ;
   
   for cur in (
                SELECT a.nls,
                       a.nlsalt,
                       t.lcv,
                       a.nms,
                       i.date_from,
                       i.date_to,
                       I.INTEREST_RATE,
                       I.ACCOUNT_REST / 100 as ACCOUNT_REST,
                       I.INTEREST_AMOUNT / 100 as INTEREST_AMOUNT
                  FROM INT_RECKONING i
                       JOIN accounts a ON (i.account_id = a.acc)
                       JOIN tabval$global t ON (a.kv = t.kv)
                 WHERE i.reckoning_id = l_reckoning_id
              )
   LOOP  
         l_txt :=    lpad(cur.nls,15,' ')
                   ||lpad(cur.lcv,9,' ')
                   ||lpad(cur.nms,28,' ')
                   ||lpad(to_char(cur.date_from,'dd/mm/yyyy'),21,' ')
                   ||lpad(to_char(cur.date_to,'dd/mm/yyyy'),21,' ')
                   ||lpad(cur.INTEREST_RATE,9,' ')
                   ||lpad(to_char(cur.ACCOUNT_REST, g_number_format,g_number_nlsparam), 20,' ')
                   ||lpad(to_char(cur.INTEREST_AMOUNT, g_number_format,g_number_nlsparam),25,' ')
                   ||l_chr;
            DBMS_LOB.append(l_clob, l_txt);
               
            l_sum_INTEREST_AMOUNT := cur.INTEREST_AMOUNT + l_sum_INTEREST_AMOUNT;   
   end loop;
   
   l_txt := lpad('-',125,'-')||l_chr;
   dbms_lob.append(l_clob, l_txt);
   
   l_txt := '                                                                                                                            Всього :     '||to_char(l_sum_INTEREST_AMOUNT, g_number_format,g_number_nlsparam)||l_chr;
   dbms_lob.append(l_clob, l_txt);
   
    l_txt := lpad('-',125,'-')||l_chr;
   dbms_lob.append(l_clob, l_txt);
   
   l_txt := '         Начальник відділу:            '||l_chr;
   dbms_lob.append(l_clob, l_txt);
   
   l_txt := '         Відповідальний виконавець:    '||l_isp||l_chr;
   dbms_lob.append(l_clob, l_txt);  
   
   l_txt := '         Перевірив:                    '||l_chr;
   dbms_lob.append(l_clob, l_txt);
   

   
   l_txt := lpad('-',125,'-')||l_chr;
   dbms_lob.append(l_clob, l_txt);

     p_clob := l_clob;
    dbms_lob.freetemporary(l_clob);
   
end p_interest_txt;
/

grant execute on p_interest_txt to bars_access_defrole;