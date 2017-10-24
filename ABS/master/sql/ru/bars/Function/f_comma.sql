
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_comma.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_COMMA (p_table  varchar2,
                                    p_column varchar2,
                                    p_where  varchar2,
                                    p_order  varchar2) RETURN VARCHAR2 IS
  type  cur is ref cursor;
  cur_  cur;
  sql_  varchar2(4000);
  s_    VARCHAR2(4000);
  col_  varchar2(2000);
BEGIN
  s_ := '';
  sql_:='select '||p_column||'
         from   '||p_table ||'
         where  '||p_where ||
                   p_order;
  open cur_ for sql_;
  loop
    fetch cur_ into col_;
    exit when cur_%notfound;
    if length(s_)+length(ltrim(rtrim(col_)))>4000 then
      exit;
    end if;
    s_ := s_||ltrim(rtrim(col_))||',';
  end loop;
  if length(s_)>1 then
    s_ := substr(s_,1,length(s_)-1);
  else
    s_ := '';
  end if;
  RETURN s_;
END f_comma;
/
 show err;
 
PROMPT *** Create  grants  F_COMMA ***
grant EXECUTE                                                                on F_COMMA         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_COMMA         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_comma.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 