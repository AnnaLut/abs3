
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getnameingenitivecase.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETNAMEINGENITIVECASE (
  p_fio     varchar2,          /* f/i/o       */
  p_numname number,            /* f=1 i=2 o=3 */
  p_gender  number,            /* m=1 f=0     */
  p_lang    char default 'U'   /* lang (U/R)  */
) return varchar2 is

  type t_oldending is table of varchar2(100);

  l_consonant t_oldending := t_oldending('б','в','г','д','ж','з','к','л','м','н','п','р','с','т','ф','х','ц','ч','ш','щ');
  l_sibilant  t_oldending := t_oldending('ж','ч','ш','щ');
  l_deaf      t_oldending := t_oldending('г','к','х');
  l_vowel     t_oldending := case when p_lang = 'U'
                               then t_oldending('а','є','ї','і','о','у','и','е','ю','я')
                               else t_oldending('а','е','ё','и','о','у','ы','э','ю','я')
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
                  if    ReplaceEnding( l_fio,              'ай',   'ая'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ий',   'ого'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'дній', 'днього' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ій',   'ія'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'их',   'их'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ок',   'ка'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',     'а'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, 'ець',  'ця'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_vowel,     'єць',  'йця'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_sibilant,  'а',    'і'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'а',    'и'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'о',    'а'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ь',    'я'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'я',    'і'      ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio,              'ай', 'ая'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ий', 'ия'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ый', 'ого' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'их', 'их'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ых', 'ых'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ок', 'ка'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, 'ец', 'ца'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_vowel,     'ец', 'йца' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',   'а'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_sibilant,  'а',  'и'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,      'а',  'и'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'а' , 'ы'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ь',  'я'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'я',  'и'   ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, l_sibilant, 'а',   'і'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ва',  'вої'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'на',  'ної'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'дка', 'дкої'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ька', 'ької'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'дня', 'дньої' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ая',  'ої'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'а',   'и'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'я',   'і'     ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_sibilant, 'а',   'и'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,     'а',   'и'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ва',  'вой' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'на',  'ной' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ая',  'ой'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'а',   'ы'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'я',   'и'   ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;
  elsif p_numname = 2 then
     if p_gender = 1 then
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              'а',  'и'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'й',  'я'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'о',  'а'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ь',  'я'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ія', 'ії'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ья', 'ьї'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'я',  'і'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ів', 'ова' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',   'а'   ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio,              'а', 'ы' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'й', 'я' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ь', 'я' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'я', 'и' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',  'а' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              'а',  'и'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ія', 'ії' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ья', 'ьї' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'я',  'ї'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',   'і'  ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_sibilant, 'а',  'и'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,     'а',  'и'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'а',  'ы'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'я',  'и'  ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;
  elsif p_numname = 3 then
     if p_gender = 1 then
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, l_consonant, '',  'а' ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_consonant, '',  'а' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, 'на', 'ни'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, 'ва', 'вої' ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, 'на', 'ны'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, 'ва', 'вой' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;
  end if;
  return initcap(r_fio);
end;
/
 show err;
 
PROMPT *** Create  grants  F_GETNAMEINGENITIVECASE ***
grant EXECUTE                                                                on F_GETNAMEINGENITIVECASE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GETNAMEINGENITIVECASE to DPT_ROLE;
grant EXECUTE                                                                on F_GETNAMEINGENITIVECASE to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getnameingenitivecase.sql =======
 PROMPT ===================================================================================== 
 