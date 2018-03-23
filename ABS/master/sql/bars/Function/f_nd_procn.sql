CREATE OR REPLACE function BARS.f_nd_procn (p_nd integer, p_kv integer, p_dat01 date) RETURN int_ratn.ir%type is

/* Версия 1.0 23-05-2017 
   ном.% ставка по ND
                 
*/

 l_bdat  int_ratn.bdat%type; l_ir    int_ratn.ir%type;
 l_bd    int_ratn.bdat%type; l_ir_nd int_ratn.ir%type;
 l_acc8  number; 
 
begin
   begin
      l_bd := NULL; l_ir_nd := 0;
      for k in (select a.acc from nd_acc n, accounts a  where  n.nd = p_nd and n.acc = a.acc and a.tip in ('SS ','SP ') and a.kv = p_kv)
      LOOP
         begin 
            SELECT bdat,ir into l_bdat, l_ir FROM int_ratn 
            WHERE acc = k.acc AND id=0 AND bdat = (SELECT MAX(bdat) FROM int_ratn  WHERE acc=k.acc AND id=0 AND bdat<=p_dat01);
         exception when NO_DATA_FOUND THEN l_ir := 0; l_bdat := NULL;
         end;
         --logger.info('PROC 1 : ND = ' || P_ND || ' KV = '|| p_KV || ' l_ir = ' || l_ir || ' k.acc = ' || k.acc || ' l_bdat = ' || l_bdat) ;
         if l_ir <>0 THEN
            if (l_bdat > l_bd and l_bdat is not null) or l_bd is null  THEN l_ir_nd := l_ir;  l_bd := l_bdat;  end if;
         end if;
      end LOOP;    
   end;
   return l_ir_nd;

end;
/

 show err;

grant execute on f_nd_procn to bars_access_defrole;
grant execute on f_nd_procn to start1;


