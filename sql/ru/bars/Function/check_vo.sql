
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_vo.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_VO return varchar2 is
  l_txt  varchar2(2048);
begin
  select val_service.get_eq(1,'СВ','840808',bankdate,840,'8',.08,'FIOFIOFIO','0101990','AA6') into l_txt from dual;
  if nvl(length(l_txt),0)=0 then
    return 'З''єднання з сервером валютообміну встановлене';
  end if;
exception when others then
  return 'З''єднання з сервером валютообміну відсутнє    (код '||to_char(sqlcode)||')';
end;
/
 show err;
 
PROMPT *** Create  grants  CHECK_VO ***
grant EXECUTE                                                                on CHECK_VO        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CHECK_VO        to BARS_CONNECT;
grant EXECUTE                                                                on CHECK_VO        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_vo.sql =========*** End *** =
 PROMPT ===================================================================================== 
 