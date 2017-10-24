
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_namearray.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_NAMEARRAY (p_fio varchar2)
return t_finmon_table is
-- разбиваем ФИО (p_fio) на составляющие (l_name),
-- преобразуем soundex(l_name),
-- исключаем повторяющиеся имена,
-- пишем l_name в массив (m_tmp)
  l_fio       varchar2(2000);
  l_name      varchar2(350);
  m_tmp       t_finmon_table := t_finmon_table();
  l_namecount number;
  l_pos       number;
  l_like      varchar2(2000) := ' ';
begin
  l_fio := trim(p_fio);

  l_namecount := 1;
  l_pos := instr(l_fio, ' ');
  while l_pos > 0 loop
     l_name := trim(substr(l_fio, 1, l_pos-1));
     l_name := f_soundex(l_name);

     if length(l_name) > 1 then

        -- не проверяем повторяющиеся имена:
        -- если в оригинальном имени есть неск. одинак. имен, проверяем только одно
        -- и считаем за одно совпадение
        -- (это возможно, когда в наим. получ. и плательщика присутств., напр., "Банк")
        if ( instr(l_like, ' ' || l_name || ' ') = 0 ) then

           -- новая строка
           m_tmp.extend;
           m_tmp(l_namecount) := l_name;

           -- счетчик имен
           l_namecount := l_namecount + 1;

           -- запоминаем, какое имя уже проверили, чтоб не проверять еще раз
           l_like := l_like || l_name || ' ' ;

        end if;

     end if;

     l_fio  := trim(substr(l_fio, l_pos+1));
     l_pos := instr(l_fio, ' ');

  end loop;

  l_name := trim(substr(l_fio, 1));
  l_name := f_soundex(l_name);

  if length(l_name) > 1 then
      -- если в оригинальном имени есть неск. одинак. имен, проверяем только одно
      -- и считаем за одно совпадение
      -- (это возможно, когда в наим. получ. и плательщика присутств., напр., "Банк")
      if ( instr(l_like, ' ' || l_name || ' ') = 0 ) then
         -- новая строка
         m_tmp.extend;
         m_tmp(l_namecount) := l_name;
      end if;
  end if;

  return m_tmp;
end f_get_namearray;
/
 show err;
 
PROMPT *** Create  grants  F_GET_NAMEARRAY ***
grant EXECUTE                                                                on F_GET_NAMEARRAY to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_namearray.sql =========*** En
 PROMPT ===================================================================================== 
 