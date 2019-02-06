PROMPT ===================================================================================== 
PROMPT *** Start *** == Scripts /Sql/BARS/Procedure/p_fin_rnk_okpo_corr.sql ==** Start ** ==
PROMPT ===================================================================================== 

CREATE OR REPLACE procedure BARS.p_fin_rnk_okpo_corr (
  p_mode       number,  -- 1-insert, 2-update, 3-delete
  p_fin        number,
  p_rnk        number,
  p_OKPO       varchar2
                         )
is
  g_modcode  varchar2(4) := 'ќ ѕќ';
  l_rnk      number;
begin

  if p_mode = 1 then
     if p_rnk is not null  then
        begin
           select rnk into l_rnk
             from customer
            where rnk = p_rnk;
        exception when no_data_found then
           --  л≥Їнт  не знайдено
           bars_error.raise_nerror(g_modcode, 'RNK_NOT_FOUND', p_rnk);
        end;
     end if;
     insert into fin_rnk_okpo (fin, rnk, okpo ) values (p_fin, p_rnk, p_okpo);
  elsif p_mode = 2 then
     if p_rnk is not null then
        begin
           select rnk into l_rnk
             from customer
            where rnk = p_rnk;
        exception when no_data_found then
           --  л≥Їнт  не знайдено
           bars_error.raise_nerror(g_modcode, 'RNK_NOT_FOUND', p_rnk);
        end;
     end if;
     update fin_rnk_okpo
        set fin  = p_fin,
            rnk  = p_rnk,
            okpo = p_okpo
      where rnk = p_rnk;
  elsif p_mode = 3 then
     delete from fin_rnk_okpo where rnk = p_rnk;
  end if;

end p_fin_rnk_okpo_corr;
/

show err;

PROMPT *** Create  grants  p_fin_rnk_okpo_corr ***
grant EXECUTE                                                                on p_fin_rnk_okpo_corr          to BARSUPL;
grant EXECUTE                                                                on p_fin_rnk_okpo_corr          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on p_fin_rnk_okpo_corr          to RCC_DEAL;
grant EXECUTE                                                                on p_fin_rnk_okpo_corr          to START1;
grant EXECUTE                                                                on p_fin_rnk_okpo_corr          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** === Scripts /Sql/BARS/Procedure/p_fin_rnk_okpo_corr.sql ===*** End *** ==
PROMPT ===================================================================================== 
