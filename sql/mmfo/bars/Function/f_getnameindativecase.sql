
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_getnameindativecase.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GETNAMEINDATIVECASE (
  p_fio     varchar2,          /* ‘амили€/»м€/ќтчество       */
  p_numname number,            /* ‘амили€=1 »м€=2 ќтчество=3 */
  p_gender  number,            /* ћуж=1 ∆ен=0                */
  p_lang    char default 'U'   /* €зык (U/R)                 */
) return varchar2 is

  type t_oldending is table of varchar2(100);

  l_consonant t_oldending := t_oldending('б','в','г','д','ж','з','к','л','м','н','п','р','с','т','ф','х','ц','ч','ш','щ');
  l_sibilant  t_oldending := t_oldending('ж','ч','ш','щ');
  l_deaf      t_oldending := t_oldending('г','к','х');
  l_vowel     t_oldending := case when p_lang = 'U'
                               then t_oldending('а','Ї','њ','≥','о','у','и','е','ю','€')
                               else t_oldending('а','е','Є','и','о','у','ы','э','ю','€')
                             end;
  l_ending1   t_oldending := t_oldending('ь');

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

  if    p_numname = 1 then      -- ‘јћ»Ћ»я --
     if p_gender = 1 then       -- мужской род --
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              'ай',   'аю'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'юй',   'юю'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ий',   'ому'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ой',   'ому'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'дн≥й', 'дньому' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'Їць',  'йцю'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'мець', 'мцю'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'нець', 'нцю'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '≥й',   '≥ю'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ок',   'ку'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'л€',   'л≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ц€',   'ц≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'да',   'д≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ра',   'р≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ха',   'с≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ка',   'ц≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'га',   'з≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ль',   'лю'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ей',   'ею'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'оз',   'озу'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'к≥',   'к≥'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'их',   'их'     ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'а',    '≥'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'о',    'у'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ь',    'ю'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',     'у'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf      ,'',     'у'      ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_sibilant  ,'',     'у'      ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio,              'ай', 'а€'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ий', 'и€'  ) = 1 then r_fio := l_fio;
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
                  elsif ReplaceEnding( l_fio,              'ь',  '€'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '€',  'и'   ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else                       -- женский род --
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,             'ська','ськ≥й' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'цька','цьк≥й' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'гка', 'гк≥й'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'дн€', 'дн≥'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ка',  'ц≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ца',  'ц≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ра',  'р≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'та',  'т≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'па',  'п≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'да',  'д≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ба',  'б≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'жа',  'ж≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ха',  'с≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ча',  'ч≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'са',  'с≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'га',  'з≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ма',  'м≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ла',  'л≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ша',  'ш≥'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'а€',  '≥й'    ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ва',  'в≥й'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'на',  'н≥й'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '€',   '≥'     ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_sibilant, 'а',   'и'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,     'а',   'и'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'ва',  'вой' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'на',  'ной' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'а€',  'ой'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,     'а',   'ы'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '€',   'и'   ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;

  elsif p_numname = 2 then          -- »ћя --
     if p_gender = 1 then           -- мужской род --
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              'й',  'ю'   ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'рь', 'рю'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ль', 'лю'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'о',  'ов≥' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',   'у'   ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio,              'а', 'ы' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'й', '€' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ь', '€' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '€', 'и' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',  'а' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else                           -- женский род --
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio,              'га', 'з≥' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '≥€', '≥њ' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'о€', 'оњ' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ь€', 'ьњ' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'ка', 'ц≥' ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              'а',  '≥'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,              '€',  '≥'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_consonant, '',   '≥'  ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_sibilant, 'а',  'и'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio, l_deaf,     'а',  'и'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             'а',  'ы'  ) = 1 then r_fio := l_fio;
                  elsif ReplaceEnding( l_fio,             '€',  'и'  ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;

  elsif p_numname = 3 then          -- ќ“„≈—“¬ќ --
     if p_gender = 1 then           -- мужской род --
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, l_consonant, '',  'у' ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, l_consonant, '',  'у' ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     else                           -- женский род --
        case p_lang
             when 'U' then
                  if    ReplaceEnding( l_fio, 'на', 'н≥'  ) = 1 then r_fio := l_fio;
                  end if;
             else
                  if    ReplaceEnding( l_fio, 'на', 'не'  ) = 1 then r_fio := l_fio;
                  end if;
        end case;
     end if;
  end if;

  r_fio := InitCap(r_fio);

  if InStr(r_fio,'''') > 0 then
    r_fio := replace(r_fio,substr(r_fio,InStr(r_fio,'''')+1,1),lower(substr(r_fio,InStr(r_fio,'''')+1,1)));
  elsif
    InStr(r_fio,'"') > 0 then
      r_fio := replace(r_fio,substr(r_fio,InStr(r_fio,'"')+1,1),lower(substr(r_fio,InStr(r_fio,'"')+1,1)));
  end if;

  return r_fio;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_getnameindativecase.sql =========
 PROMPT ===================================================================================== 
 