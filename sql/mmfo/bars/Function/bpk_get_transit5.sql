
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_get_transit5.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_GET_TRANSIT5 (p_tran_type varchar2,
                                            p_nls       varchar2,
                                            p_kv        number  ,
                                            p_ref       number default null) return varchar2
is
  l_acc    number;
  l_nls    varchar2(14);
  l_d_rec  oper.d_rec%type;
begin
--
--Функция для определения транзитного счета
--для операций СЭП, КЛИЕНТ-БАНК по счетам БПК.
--
  if p_ref is not null then
     select d_rec
     into   l_d_rec
     from   oper
     where  ref=p_ref;
     if l_d_rec like '%#D%' then
       return vkrzn(substr(f_ourmfo,1,5),'2602'||substr(p_nls,5));
     end if;
  end if;
  begin
     begin
        select acc
        into   l_acc
        from   accounts
        where  nls=p_nls and
               kv=p_kv   and
               tip like 'W4%';
     exception when no_data_found then
        select acc
        into   l_acc
        from   accounts
        where  nlsalt=p_nls and
               kv=p_kv   and
               tip like 'W4%';
     end;
     l_nls := bars_ow.get_transit(l_acc);
  exception when no_data_found then
    l_nls := null;
  end;
  return l_nls;
end bpk_get_transit5;
/
 show err;
 
PROMPT *** Create  grants  BPK_GET_TRANSIT5 ***
grant EXECUTE                                                                on BPK_GET_TRANSIT5 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BPK_GET_TRANSIT5 to PYOD001;
grant EXECUTE                                                                on BPK_GET_TRANSIT5 to TOSS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_get_transit5.sql =========*** E
 PROMPT ===================================================================================== 
 