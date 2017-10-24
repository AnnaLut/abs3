
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_bpk_like_fio.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BPK_LIKE_FIO (
  p_fio1   varchar2,          -- ÔÈÎ-1
  p_fio2   varchar2,          -- ÔÈÎ-2
  p_count  number default 1   -- êîëè÷åñòâî èìåí, êîò. äîëæíû ñîâïàäàòü
) return number
is
  type t_fio is table of varchar2(100);
  l_arr_fio1  t_fio := t_fio();
  l_arr_fio2  t_fio := t_fio();
  i       number;
  j       number;
  l_like  number;

function get_arr (p_fio varchar2) return t_fio
is
  l_arr_fio  t_fio := t_fio();
  l_tr1   varchar2(100) := 'TPHKCBMAOE?1ßÎÓÈI²¯ÉÛÅªÝ¨¥';
  l_tr2   varchar2(100) := 'ÒÐÍÊÑÂÌÀÀÀÀÀÀÀÀÀÀÀÀÀÀÀÀÀÀÃ';
  l_fio   varchar2(254);
  l_name  varchar2(254);
  l_name2 varchar2(254);
  l_pos   number;
begin
  l_fio := p_fio;
  l_fio := substr(upper(trim(l_fio)), 1, 254);
  l_fio := translate(l_fio, l_tr1, l_tr2);
  l_fio := replace(l_fio, 'Ï-ÖÜ-', '');
  l_fio := replace(l_fio, 'Ï-ÖÜ ', '');
  l_fio := replace(l_fio, 'ÁÏÊ-',  '');
  l_fio := replace(l_fio, 'ÁÏÊ ',  '');
  l_fio := replace(l_fio, 'ÏÏ-',   '');
  l_fio := replace(l_fio, 'ÏÏ ',   '');
  l_fio := replace(l_fio, 'ÑÏÄ-',  '');
  l_fio := replace(l_fio, 'ÑÏÄ ',  '');
  l_fio := replace(l_fio, 'ÔÎÏ-',  '');
  l_fio := replace(l_fio, 'ÔÎÏ ',  '');
  l_fio := replace(l_fio, 'Ü',  '');
  l_fio := replace(l_fio, 'Ú',  '');
  l_fio := replace(l_fio, '`',  '');
  l_fio := replace(l_fio, '-',  '');
  l_fio := replace(l_fio, '''',    '');
  l_fio := replace(l_fio, '"',     '');
  l_fio := replace(l_fio, '  ',   ' ');

  -- óáèðàåì ïîâòîðÿþùèåñÿ áóêâû
  l_name  := upper(l_fio);
  l_name2 := null;
  while length(l_name) > 0 loop
     if substr(l_name,1,1) <> substr(l_name,2,1) or length (l_name) = 1 then
        l_name2 := l_name2 || substr(l_name,1,1);
     end if;
     l_name := substr(l_name,2);
  end loop;
  l_fio := l_name2;

  l_fio := l_fio || ' ';

  i := 1;
  l_pos := instr(l_fio, ' ');
  while l_pos > 0 loop
     l_name := trim(substr(l_fio, 1, l_pos-1));

     if length(l_name) > 1 then

        l_arr_fio.extend;
        l_arr_fio(i) := l_name;

        i := i + 1;

     end if;

     l_fio := trim(substr(l_fio, l_pos+1));
     l_pos := instr(l_fio, ' ');

  end loop;

  l_name := trim(substr(l_fio, 1));

  if length(l_name) > 1 then

     l_arr_fio.extend;
     l_arr_fio(i) := l_name;

     i := i + 1;

  end if;

  return l_arr_fio;

end;

begin

  l_arr_fio1 := get_arr(p_fio1);
  l_arr_fio2 := get_arr(p_fio2);

  l_like := 0;

  for i in 1..l_arr_fio1.count
  loop
     for j in 1..l_arr_fio2.count
     loop
        if l_arr_fio1(i) = l_arr_fio2(j) then
           l_like := l_like + 1;
        end if;
     end loop;
  end loop;

  if l_like >= p_count then
     return 1;
  else
     return 0;
  end if;

end f_bpk_like_fio;
/
 show err;
 
PROMPT *** Create  grants  F_BPK_LIKE_FIO ***
grant EXECUTE                                                                on F_BPK_LIKE_FIO  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BPK_LIKE_FIO  to OBPC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_bpk_like_fio.sql =========*** End
 PROMPT ===================================================================================== 
 