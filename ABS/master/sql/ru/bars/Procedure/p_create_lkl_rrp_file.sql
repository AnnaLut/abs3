create or replace procedure p_create_lkl_rrp_file (p_clob out clob, p_namefile out varchar2) is
l_txt_clob         clob := ' ';
l_txt              varchar2(4000) := ' ';                                           
BEGIN
    -- Пока пустой файл. Для теста
     p_namefile:='K';
     dbms_lob.createtemporary(l_txt_clob, false);
     dbms_lob.append(l_txt_clob, l_txt);
     dbms_lob.createtemporary(p_clob, false);
     dbms_lob.append(p_clob, l_txt);
     dbms_lob.append(p_clob, l_txt_clob);
END p_create_lkl_rrp_file;
/
grant execute on p_create_lkl_rrp_file to bars_access_defrole;