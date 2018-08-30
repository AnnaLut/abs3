CREATE OR REPLACE function BARS.F_NBUR_GET_EKP_08X(p_datez date
                                             ) return number
is
  l_kodf        varchar2(3) := '08X';
  l_ekp_cur     varchar2(6 char) := null;
  l_sql         clob := '';
  l_rezult      number;
begin
  for l_cur1 in (select ekp, desc_r020
                 from NBUR_REF_EKP_R020
                 where file_code = l_kodf and
                       date_start <= p_datez
                 order by ekp)
  loop
     l_ekp_cur := l_cur1.ekp;
     
     l_sql := f_nbur_get_where(l_cur1.desc_r020);  
     
     if trim(l_sql) is not null then
        l_sql := 'insert into NBUR_TMP_DESC_EKP(EKP, I010, T020, R020) '||
                 'select unique ''' || l_cur1.ekp || ''', a.i010, b.t020, a.r020 '||
                 'from kl_r020 a, '||
                 '(select ''1'' t020 from dual 
                    union all 
                   select ''2'' t020 from dual
                    union all 
                   select ''5'' t020 from dual
                    union all 
                   select ''6'' t020 from dual
                  ) b
                  where a.d_open <= :dat_ and
                        (a.d_close is null or a.d_close >= :dat_) and '||l_sql;
        
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



