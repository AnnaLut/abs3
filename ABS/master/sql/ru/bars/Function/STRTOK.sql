CREATE OR REPLACE FUNCTION "STRTOK"
(
  source    in varchar2,
  delimeter in varchar2,
  item      in integer
)
return varchar2 deterministic
is
  i         integer;
  n         integer;
begin
  -- проверка параметров
  if ( delimeter is null ) then
    return source;
  end if;
  if ( item < 1 ) then
    return null;
  end if;

  -- прогнать до item группы
  n := 1;
  i := 1;
  while n < item loop
    i := instr( source,delimeter,i );
    if ( i = 0 ) then
      return null; -- не нашли столько групп
    end if;
    n := n + 1;
    i := i + length( delimeter );
  end loop;

  -- взять строку
  n := i;
  i := instr( source,delimeter,n );
  if ( i > 0 ) then
    return substr( source,n,i-n );
  end if;
  return substr( source,n );
end;
/

grant execute on strtok to bars_access_defrole;
 
 
 
