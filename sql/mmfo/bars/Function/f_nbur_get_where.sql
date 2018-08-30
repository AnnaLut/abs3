CREATE OR REPLACE function BARS.f_nbur_get_where(p_clob clob
                                                ) return clob 
is
  l_txt         varchar2(30000 char) := substr(trim(p_clob), 1, 30000);
  l_where       clob := '';
  l_where_I010  clob := '';
  l_where_R020  clob := '';
  l_where_T020  clob := '';
  l_pos         number;
begin
    for l_cur1 in (select ltrim(ltrim(txt, chr(13)), chr(10)) txt 
                   from xmltable('ora:tokenize($txt,";")'
                        passing l_txt as "txt"
                        columns txt varchar2(3000) path '.')
                    where txt is not null)
    loop
        if instr(l_cur1.txt, 'I010')>0 then
           l_pos := nvl(instr(l_cur1.txt, '('), 6);
           l_where_I010 := replace(regexp_replace(l_cur1.txt, '(\w\w)', '''\1''', l_pos), 'I010', 'a.I010 in ');
        end if;
        
        if instr(l_cur1.txt, 'T020')>0 then
           l_pos := nvl(instr(l_cur1.txt, '('), 6);
           l_where_T020 := replace(regexp_replace(l_cur1.txt, '(\w)', '''\1''', l_pos), 'T020', 'b.T020 in ');
        end if;
        
        if instr(l_cur1.txt, 'R020')>0 then
           l_pos := nvl(instr(l_cur1.txt, '('), 6);
           l_where_R020 := replace(regexp_replace(l_cur1.txt, '(\w\w\w\w)', '''\1''', l_pos), 'R020', 'a.R020 in ');
        end if;
    end loop;  
    
    l_where := l_where_I010;
    l_where := l_where || (case when trim(l_where) is not null then ' and ' else '' end)||l_where_T020;
    l_where := l_where || (case when trim(l_where) is not null then ' and ' else '' end)||l_where_R020;
       
    return l_where;
end;
/

