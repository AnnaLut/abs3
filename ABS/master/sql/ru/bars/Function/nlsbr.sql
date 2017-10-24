
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nlsbr.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NLSBR ( NLS_ accounts.NLS%type )  return varchar2 is
   br_ accounts.BRANCH%type := null ;
begin

 -- 17-05-2010. Сухова.
 -- Функция определения бранча по счету.
 -- Удобно использовать в формулах счета в TTS.
 -- Пример тому - регулярные платежи.
 -- Комиссия падает на бранч осн.счета, а не на бранч юзера,
 -- кот.исполняет рег.пл.

 begin
   select branch
   into   br_
   from (select branch from accounts where  nls = NLS_  and  dazs is null
         order by decode(kv,980,0,1)
        )
   where rownum = 1;
 exception when no_data_found then null;
 end;
 return br_ ;
end NLSBR;
/
 show err;
 
PROMPT *** Create  grants  NLSBR ***
grant EXECUTE                                                                on NLSBR           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NLSBR           to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nlsbr.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 