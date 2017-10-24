
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_w4crv_get_transit.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_W4CRV_GET_TRANSIT (
  p_nls_pk varchar2,
  p_kv     number ) return varchar2
is
  l_nls  varchar2(14);
  l_acc  number;
  l_tip  varchar2(3);
begin

  begin

     select acc, tip into l_acc, l_tip
       from accounts
      where nls = p_nls_pk and kv = p_kv;

     -- счет нового процессинга
     if substr(l_tip,1,2) = 'W4' then
        l_nls := bars_ow.get_transit(l_acc);
     -- счет старого процессинга/некарточный счет
     else
        l_nls := null;
     end if;

  exception when no_data_found then

     l_nls := null;

  end;

  if l_nls is null then
     bars_error.raise_nerror('BPK', 'TRANSITACC_NOT_FOUND');
  end if;

  return l_nls;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_w4crv_get_transit.sql =========
 PROMPT ===================================================================================== 
 