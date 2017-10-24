
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/k_file_name.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.K_FILE_NAME (sFdat1 date ,KODK number) return varchar2 is
l_tag varchar2(1000);
begin
SELECT  unique 'K'||substr(r.val||substr(    getchr(substr(to_char(sFdat1,'DD/MM/YYYY'),-2,2))|| getchr(substr(to_char(sFdat1,'DD/MM/YYYY'),4,2))|| getchr(substr(to_char(sFdat1,'DD/MM/YYYY'),1,2))|| '.'||lpadchr(KODK,'0',2)||'1', 1,8),1,50) FILENAME into l_tag  FROM   params$base r where   r.par = 'KFILE'  and r.kf=(select f_ourmfo from dual);
return l_tag;
end;
/
 show err;
 
PROMPT *** Create  grants  K_FILE_NAME ***
grant EXECUTE                                                                on K_FILE_NAME     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/k_file_name.sql =========*** End **
 PROMPT ===================================================================================== 
 