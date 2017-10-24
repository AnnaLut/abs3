

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KLIENT_IS_REFT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KLIENT_IS_REFT ***

  CREATE OR REPLACE PROCEDURE BARS.KLIENT_IS_REFT (dat_ date)
-- проверка клиентов на вхождение в справочник террористов
is
   l_id number;
begin
   delete from fm_klient;
   for k in ( select rnk, nmk, nmkk, nmkv
                from customer
               where date_off is null or date_off > bankdate_g )
   loop
      l_id := f_istr(k.nmk);
      if l_id = 0 and k.nmkk is not null then
         l_id := f_istr(k.nmkk);
      end if;
      if l_id = 0 and k.nmkv is not null then
         l_id := f_istr(k.nmkv);
      end if;
      if l_id <> 0 then
         insert into fm_klient (rnk, kod, dat) values (k.rnk, l_id, trunc(sysdate));
      end if;
   end loop;
end;
/
show err;

PROMPT *** Create  grants  KLIENT_IS_REFT ***
grant EXECUTE                                                                on KLIENT_IS_REFT  to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KLIENT_IS_REFT.sql =========*** En
PROMPT ===================================================================================== 
