
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_read_sp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_READ_SP (
  spid_    number,
  acc_     number
  ) return varchar2 is

ern         CONSTANT POSITIVE := 100;
err         EXCEPTION;
erm         VARCHAR2(512);
name_       varchar2(60);
tabname_    varchar2(60);
type_       varchar2(1);
tag_        varchar2(8);
hist_       number(1);
ssql        varchar2(4000);
sValue      varchar2(4000);
begin
  begin
    select name,tabname,type,tag,hist into name_,tabname_,type_,tag_, hist_ from sparam_list where spid=spid_;
  exception when no_data_found then
    erm := '1 - Спецпараметр spid='||spid_||' не найден.';
    raise err;
  end;

  ssql := 'SELECT ';
  if upper(type_) = 'D' and tag_ is null
    then name_ := 'TO_CHAR(' || name_ || ',''DD/MM/YYYY'')';
  end if;
  ssql := ssql || name_ || ' FROM ' || tabname_ || ' WHERE acc=:acc_';

  if hist_ = 1 then
    ssql := ssql || ' and parid='||spid_||' and bankdate between dat1 and dat2';
  elsif(tag_ is not null)
  then
    ssql := ssql || ' and tag='''||tag_||'''';
  end if;

  begin
    execute immediate ssql into sValue using acc_;
  exception when no_data_found then sValue := '';
  end;

  return sValue;
exception
 when err    then raise_application_error(-(20000+ern), '\'||erm, TRUE);
 when OTHERS then raise_application_error(-(20000+ern), SQLERRM || '[' || ssql || ']',  TRUE);
end f_read_sp;
/
 show err;
 
PROMPT *** Create  grants  F_READ_SP ***
grant EXECUTE                                                                on F_READ_SP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_READ_SP       to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_READ_SP       to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_read_sp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 