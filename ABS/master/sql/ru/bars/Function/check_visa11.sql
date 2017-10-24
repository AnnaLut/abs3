
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_visa11.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_VISA11 (p_ref number)
return number is
  l_ret   number := 0;
  l_s     int;
  l_kv    number;
  l_s1    int;
  l_ref   int;
  l_refl  int;
  l_sk    int  := 0;
  l_tt    char(3);
  pragma autonomous_transaction;
Begin

  begin
    select S  , KV  , TT  , nvl(SK,0)
    into   l_s, l_kv, l_tt, l_sk
    from   OPER
    where  ref=p_ref;
  exception when no_data_found then
    l_ret := 0;
  end;

  If l_kv = 980 then

     If l_tt in ('064','066') then

        if l_sk > 0 then  -- Вариант настройки без "ЧЕК" (SK в самой 066)

           if l_sk=59 then
              l_s := 0;   -----  делаем заведомо l_s < 500000
           end if;

        else              -- Вариант настройки с "ЧЕК" (SK в самой "ЧЕК")

           Begin
             l_ref := p_ref;
             begin
               select refl
               into   l_ref
               from   oper
               where  ref=l_ref;
             exception when no_data_found then
               l_ret := 0;
             end;
             loop
               select refl,
                      sk  ,
                      s
               into   l_refl,
                      l_sk  ,
                      l_s1
               from   oper
               where  ref=l_ref;

               if l_sk = 59 then
                  l_s := 0;       ---  делаем заведомо l_s < 500000
               end if;

               if l_refl is null then
                 exit;
               end if;
               l_ref := l_refl;
             end loop;

           End;

        end if;

     end if;


     if l_s >= 50000000 then
        l_ret := 1;
     end if;

  Else

     if GL.P_ICURVAL( l_kv, l_s, SYSDATE ) >= 5000000 then
        l_ret := 1;
     end if;

  End if;


  rollback;

  Return l_ret;

END check_visa11;
/
 show err;
 
PROMPT *** Create  grants  CHECK_VISA11 ***
grant EXECUTE                                                                on CHECK_VISA11    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_visa11.sql =========*** End *
 PROMPT ===================================================================================== 
 