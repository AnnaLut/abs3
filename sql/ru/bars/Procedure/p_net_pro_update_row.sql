create or replace procedure p_net_pro_update_row
(
p_rnk  V_FOR_NET_PRO.rnk%type,
p_dat_a V_FOR_NET_PRO.dat_a%type,
p_kva V_FOR_NET_PRO.kva%type,
p_cc_id V_FOR_NET_PRO.cc_id%type,
p_s V_FOR_NET_PRO.s%type
)
is
l_V_FOR_NET_PRO V_FOR_NET_PRO%rowtype;
 name_ CCK_AN_TMP_UPB.name%type :=  'V_FOR_NET_PRO';
begin
 select t.* into l_V_FOR_NET_PRO
 from V_FOR_NET_PRO t
 where  rnk = p_RNK and dat_a = p_dat_a and kva = p_KVa;
 
 
  If    Nvl(l_V_FOR_NET_PRO.s,0) = 1  and  Nvl(p_s,0) = 0 then
     delete from TMP_FX_NETTING                   where rnk = l_V_FOR_NET_PRO.RNK and sdate = l_V_FOR_NET_PRO.dat_a and kv = l_V_FOR_NET_PRO.KVa and name = name_ and userid=user_id;

  elsIf Nvl(l_V_FOR_NET_PRO.s,0) = 0  and  Nvl(p_s,0) = 1 then
     insert into TMP_FX_NETTING (rnk,sdate,kv,s, name, cc_id, userid ) values (l_V_FOR_NET_PRO.RNK,l_V_FOR_NET_PRO.dat_a,l_V_FOR_NET_PRO.KVa, 1 , name_, p_cc_id, user_id);

  elsIf Nvl(l_V_FOR_NET_PRO.s,0) = 1  and  Nvl(p_s,0) = 1 then
     update TMP_FX_NETTING set cc_id = p_cc_id where rnk = l_V_FOR_NET_PRO.RNK and sdate = l_V_FOR_NET_PRO.dat_a and kv = l_V_FOR_NET_PRO.KVa and name = name_ and userid=user_id;
  end if;
 
end p_net_pro_update_row;
/
grant execute on p_net_pro_update_row to bars_access_defrole
/
