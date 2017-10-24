
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getnameinablativecase.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETNAMEINABLATIVECASE (
  p_fio     varchar2,          /* f/i/o       */
  p_numname number,            /* f=1 i=2 o=3 */
  p_gender  number,            /* m=1 f=0     */
  p_lang    char default 'U'   /* lang (U/R)  */
) return varchar2 is

  type t_oldending is table of varchar2(100);

  l_consonant t_oldending := t_oldending('�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�','�');
  l_sibilant  t_oldending := t_oldending('�','�','�','�');
  l_deaf      t_oldending := t_oldending('�','�','�');
  l_vowel     t_oldending := case when p_lang = 'U'
                               then t_oldending('�','�','�','�','�','�','�','�','�','�')
                               else t_oldending('�','�','�','�','�','�','�','�','�','�')
                             end;

  l_fio varchar2(100);
  r_fio varchar2(100);

function ReplaceEnding (
  p_Word      in out varchar2,
  p_OldEnding        varchar2,
  p_NewEnding        varchar2
) return number is
  l_Word      varchar2(100) := null;
  l_replace   number := 0;
begin
  l_Word := trim(p_Word);

  if substr(l_Word, -length(p_OldEnding)) = p_OldEnding then
     l_Word := substr(l_Word, 1, length(l_Word)-length(p_OldEnding));
     l_Word := l_Word || p_NewEnding;
     l_replace := 1;
  end if;

  p_Word := l_Word;
  return l_replace;
end;

function ReplaceEnding (
  p_Word      in out varchar2,
  p_Symb             t_oldending,
  p_OldEnding        varchar2,
  p_NewEnding        varchar2
) return number is
  l_Word      varchar2(100) := null;
  l_replace   number := 0;
begin
  l_Word := trim(p_Word);

  if l_Word is not null then
     for i in p_Symb.first .. p_Symb.last loop
         l_replace := ReplaceEnding(l_Word, p_Symb(i) || p_OldEnding, p_Symb(i) || p_NewEnding);
         if l_replace = 1 then
            exit;
         end if;
     end loop;
  end if;

  p_Word := l_Word;
  return l_replace;
end;

begin
  l_fio := lower(p_fio);
  r_fio := l_fio;

  if    p_numname = 1 then
     if p_gender = 1 then
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              '��',   '��'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��',   '��'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '���', '���' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��',   '���'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��',   '��'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��',   '���'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',     '��'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '���',  '���'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_vowel,     '���',  '����'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_sibilant,  '�',    '��'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',    '��'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',    '��'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',    '��'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',    '��'      ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio,              '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '���' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_vowel,     '��', '���' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',   '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_sibilant,  '�',  '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,      '�',  '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�' , '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',  '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',  '�'   ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, l_sibilant, '�',   '�'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '��',  '���'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '��',  '���'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '���', '����'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '���', '����'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '���', '�����' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '��',  '��'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '�',   '�'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '�',   '�'     ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_sibilant, '�',   '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,     '�',   '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '��',  '���' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '��',  '���' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '��',  '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '�',   '�'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '�',   '�'   ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;
  elsif p_numname = 2 then
     if p_gender = 1 then
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              '�',  '��'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',  '��'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',  '��'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',  '��'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '���'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',  '��'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '����' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',   '��'   ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio,              '�', '�' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�', '�' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�', '�' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�', '�' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',  '�' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              '�',  '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '���' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��', '���' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '�',  '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '���',  '����'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '��',  '`�'  ) = 1 then r_fio := l_fio;
--                  elsif ReplaceEnding( l_fio, l_consonant, '',   '�'  ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_sibilant, '�',  '�'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,     '�',  '�'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '�',  '�'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '�',  '�'  ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;
  elsif p_numname = 3 then
     if p_gender = 1 then
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, l_consonant, '',  '��' ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_consonant, '',  '�' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, '��', '���'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, '��', '���' ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, '��', '��'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, '��', '���' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;
  end if;
  return initcap(r_fio);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getnameinablativecase.sql =======
 PROMPT ===================================================================================== 
 