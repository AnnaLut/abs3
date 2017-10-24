

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CREATE_LKL_RRP_FILE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CREATE_LKL_RRP_FILE ***

  CREATE OR REPLACE PROCEDURE BARS.P_CREATE_LKL_RRP_FILE (p_clob out clob, p_namefile out varchar2) is
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
show err;

PROMPT *** Create  grants  P_CREATE_LKL_RRP_FILE ***
grant EXECUTE                                                                on P_CREATE_LKL_RRP_FILE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CREATE_LKL_RRP_FILE.sql ========
PROMPT ===================================================================================== 
