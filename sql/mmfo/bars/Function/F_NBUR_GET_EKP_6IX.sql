Prompt ***** Start create function F_NBUR_GET_EKP_6IX *****

create or replace function F_NBUR_GET_EKP_6IX(p_datez date
                                             ) return number
is
  l_kodf        varchar2(3) := '6IX';
  l_ekp_cur     varchar2(6 char) := null;
  l_sql         clob := '';
  l_txt         varchar2(30000 char);
  l_R020        clob := '';
  l_DDD         clob := '';
  l_pos         number;

begin
  for l_cur1 in (select ekp, desc_ekp
                 from NBUR_REF_EKP2
                 where file_code = l_kodf 
                 order by ekp)
  loop
    l_ekp_cur := l_cur1.ekp;
    l_txt :=  substr(trim(l_cur1.desc_ekp), 1, 30000);
     
    for l_cur1 in (select ltrim(ltrim(txt, chr(13)), chr(10)) txt 
                   from xmltable('ora:tokenize($txt,";")'
                        passing l_txt as "txt"
                        columns txt varchar2(3000) path '.')
                    where txt is not null)
    loop
        if instr(l_cur1.txt, 'DDD')>0 then
           l_pos := nvl(instr(l_cur1.txt, '('), 4);
           l_DDD := REGEXP_SUBSTR(l_cur1.txt, '\d{1,}', l_pos+1);
        end if;
        
        if instr(l_cur1.txt, 'R020')>0 then
           l_pos := nvl(instr(l_cur1.txt, '('), 4);
           l_R020 := replace(regexp_replace(l_cur1.txt, '(\w\w\w\w)', '''\1''', l_pos), 'R020', 'and a.R020 in ');
        end if;
    end loop;  

    if  trim(l_R020) is not null then
       l_sql := 'insert into NBUR_TMP_DESC_EKP2(EKP, SEG, R020) '||
                 'select unique ''' || l_cur1.ekp || ''', ''' || l_DDD || ''', a.r020 '||
                 'from kl_r020 a '||
                 'where a.d_open <= :dat_ and
                        (a.d_close is null or a.d_close >= :dat_) '||l_R020;
    elsif trim(l_DDD) is not null then
       l_sql := 'insert into NBUR_TMP_DESC_EKP2(EKP, SEG, R020) '||
                 'select unique ''' || l_cur1.ekp || ''', ''' || l_DDD || ''', null '||
                 'from dual where :dat=:dat';
    else null;
    end if;
    l_r020 := null;
    l_DDD := null;
    if trim(l_sql) is not null then
        begin
            execute immediate l_sql using p_datez, p_datez;
        exception
            when others then
                raise_application_error(-20000, 'SqlErrm = ' || SqlErrm ||' for '||l_sql||' ekp = '||l_cur1.ekp);
        end;
     end if;
  end loop;
  return 0;
end;
/

show errors;
Prompt ***** End create function F_NBUR_GET_EKP_6IX *****
