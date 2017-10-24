
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/correctbdayokpo.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CORRECTBDAYOKPO (bday_ date, okpo_ varchar2)
return date
is
  boutday_  date;
begin
  boutday_ := bday_;
  if bday_ is null or bday_>=trunc(sysdate) then
    if okpo_ is not null      and
       length(trim(okpo_))=10 and
       trim(okpo_) not in ('9999999999','0000000000') then
      begin
        return to_date('31/12/1899','DD/MM/YYYY')+
               to_number(substr(trim(okpo_),1,5));
      exception when others then
        return null;
      end;
    else
      while boutday_>=trunc(sysdate)
      loop
        boutday_ := add_months(boutday_,-1200);
      end loop;
    end if;
  end if;
  return boutday_;
end CorrectBdayOkpo;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/correctbdayokpo.sql =========*** En
 PROMPT ===================================================================================== 
 