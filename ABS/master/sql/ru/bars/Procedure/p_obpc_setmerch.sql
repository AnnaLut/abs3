

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OBPC_SETMERCH.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OBPC_SETMERCH ***

  CREATE OR REPLACE PROCEDURE BARS.P_OBPC_SETMERCH (
  p_mode       number,  -- 1-insert, 2-update, 3-delete
  p_merch      varchar2,
  p_cardsystem varchar2,
  p_nls        varchar2,
  p_kv         number )
is
  g_modcode  varchar2(3) := 'BPK';
  l_acc      number;
begin

  if p_mode = 1 then
     if p_nls is not null and p_kv is not null then
        begin
           select acc into l_acc
             from accounts
            where nls = p_nls and kv = p_kv;
        exception when no_data_found then
           -- Рахунок не знайдено
           bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', p_nls, to_char(p_kv));
        end;
     else
        l_acc := null;
     end if;
     insert into obpc_merch (merch, kv, card_system, transit_acc)
     values (p_merch, p_kv, p_cardsystem, l_acc);
  elsif p_mode = 2 then
     if p_nls is not null and p_kv is not null then
        begin
           select acc into l_acc
             from accounts
            where nls = p_nls and kv = p_kv;
        exception when no_data_found then
           -- Рахунок не знайдено
           bars_error.raise_nerror(g_modcode, 'ACC_NOT_FOUND', p_nls, to_char(p_kv));
        end;
     else
        l_acc := null;
     end if;
     update obpc_merch
        set kv = p_kv,
            transit_acc = l_acc
      where merch = p_merch and card_system = p_cardsystem;
  elsif p_mode = 3 then
     delete from obpc_merch where merch = p_merch and card_system = p_cardsystem;
  end if;

end p_obpc_setmerch;
/
show err;

PROMPT *** Create  grants  P_OBPC_SETMERCH ***
grant EXECUTE                                                                on P_OBPC_SETMERCH to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_OBPC_SETMERCH to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OBPC_SETMERCH.sql =========*** E
PROMPT ===================================================================================== 
