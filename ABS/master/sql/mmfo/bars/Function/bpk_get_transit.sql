
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_get_transit.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_GET_TRANSIT (
  p_tran_type    varchar2,
  p_nls_transit  varchar2,
  p_nls_pk       varchar2,
  p_kv           number ) return varchar2
is
  l_nls  varchar2(14);
  l_acc  number;
begin

  begin
     begin 
        select acc into l_acc
        from accounts
        where nls = p_nls_pk and kv = p_kv and tip like 'W4%';
     exception when no_data_found then
        select acc into l_acc
        from accounts
        where nlsalt = p_nls_pk and kv = p_kv and tip like 'W4%';
     end ;
     l_nls := bars_ow.get_transit(l_acc);
     if l_nls is not null and l_nls = p_nls_transit then
        l_nls := p_nls_pk;
     end if;
  exception when no_data_found then
     l_nls := p_nls_pk;
  end;

  if l_nls is null then
     bars_error.raise_nerror('BPK', 'TRANSITACC_NOT_FOUND', p_tran_type);
  end if;

  return l_nls;

end;
/
 show err;
 
PROMPT *** Create  grants  BPK_GET_TRANSIT ***
grant EXECUTE                                                                on BPK_GET_TRANSIT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BPK_GET_TRANSIT to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_get_transit.sql =========*** En
 PROMPT ===================================================================================== 
 