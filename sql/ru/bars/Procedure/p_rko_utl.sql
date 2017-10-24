create or replace procedure bars.p_rko_utl(p_mode in integer, -- 1 - insert, 2 - update
                                           p_nls in accounts.nls%type,
                                           p_kv in accounts.kv%type,
                                           p_dat0a rko_lst.dat0a%type,
                                           p_dat0b rko_lst.dat0b%type,
                                           p_s0 rko_lst.s0%type,
                                           p_nls_sp in accounts.nls%type,
                                           p_kv_sp in accounts.kv%type) is
  l_acc accounts.acc%type;
  l_acc_sp accounts.acc%type := null;
begin
  -- Рахунок нарахування
  begin
    select a.acc into l_acc from accounts a, rko_nbs r where a.nbs = r.nbs and a.nls = p_nls and a.kv = p_kv;
  exception
    when no_data_found then raise_application_error(-20000,'Рахунок '||p_nls||'('||p_kv||') не знайдено, або він не відповідає RKO_NBS.');
  end;

  -- Рахунок стягнення
  if p_nls_sp is not null and p_kv_sp is not null then
    begin
      select a.acc into l_acc_sp from accounts a, rko_nbs r where a.nbs = r.nbs and a.nls = p_nls_sp and a.kv = p_kv_sp;
    exception
      when no_data_found then raise_application_error(-20000,'Рахунок списання '||p_nls_sp||'('||p_kv_sp||') не знайдено.');
    end;
  end if;

  -- insert
  case when p_mode = 1 then
    insert into rko_lst
      (acc, accd, dat0a, dat0b, s0)
    values
      (l_acc, l_acc_sp, p_dat0a, p_dat0b, nvl(p_s0, 0)*100);
  -- update
  when p_mode = 2 then
    update rko_lst
       set accd = l_acc_sp, dat0a = p_dat0a, dat0b = p_dat0b, s0 = nvl(p_s0, 0)*100
     where acc = l_acc;
  end case;
end p_rko_utl;
/

show errors;

grant execute on p_rko_utl to bars_access_defrole;
