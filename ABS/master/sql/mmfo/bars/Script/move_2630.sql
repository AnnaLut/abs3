declare
 oo oper%rowtype;
 a2 accounts%rowtype;
begin
bc.go(300465);
   -- курсор по счетам которые нужно закрыть
  for a1 in (select a.* from accounts a  where a.nbs = '2630' and a.ob22 = 'D3' and a.dazs is null and a.branch = '/300465/') 
  loop
     if a1.ostc >0 and a1.ostb = a1.ostc then
        
     -- Находим соответсвенный 2630/46 для переноса остатков(Это самое интересное)  
         begin
            select a.* into a2 
             from accounts a where a.nbs = '2630' 
               and a.ob22 = '46' 
               and a.dazs is null 
               and a.branch = '/300465/' 
               and a.kv = a1.kv
               and substr(a.nls, - 6) = substr(a1.nlsalt, - 6);
         exception when no_data_found then 
          bars_audit.info('move_2630 for NLS 2630/D3 = '||a1.nls||' kv = '||a1.kv||' not found 2630/46');
	  a2.nls := null;
         end;
         
        if a2.nls is not null then
         GL.REF ( oo.REF) ;
         gl.in_doc3(ref_=> oo.REF  , 
                    tt_  =>'024', 
                    vob_=> 6   , 
                    nd_ => oo.REF , 
                    pdat_=> SYSDATE, 
                    vdat_=> gl.BD ,
                    dk_ => 1   , 
                    kv_  => a1.kv, 
                    s_  => a1.ostc, 
                    kv2_=>  a1.kv, 
                    s2_  =>a1.ostc, 
                    sk_  => null, 
                    data_=> gl.BD , 
                    datp_=> gl.bd,
                    nam_a_=> a1.nms, 
                    nlsa_=>  a1.nls,
                    mfoa_=>  GL.AMFO, 
                    nam_b_=> a2.nms, 
                    nlsb_=>  a2.nls, 
                    mfob_=>  GL.AMFO ,
                    nazn_ => 'Перенесення за призначенням з 2630/D3 на 2630/46' ,
                    d_rec_=> null,
                    id_a_=>  null, 
                    id_b_=>  null, 
                    id_o_ => null, 
                    sign_=>  null, 
                    sos_=>1, 
                    prty_=>null, 
                    uid_=>1) ;
         gl.payv( 0, oo.REF, gl.BD , '024', 1, a1.kv, a1.nls, a1.ostc, a1.kv, a2.nls, a1.ostc);
         gl.pay( 2, oo.REF, gl.BD);
        end if;
      end if;
      bars_audit.info('move_2630_close for acc 2630/D3 = '||a1.acc||' a1.ostc = '||a1.ostc||' a1.ostb = '||a1.ostb);
  end loop; 
  
 begin
     for c in (select a.* from accounts a  where a.nbs = '2630' and a.ob22 = 'D3' and a.dazs is null and a.branch = '/300465/' and a.ostc = 0) 
   loop
    update accounts set dazs = gl.BD+1 where acc = c.acc;
   end loop;
  end;

end;
/
commit;


begin
bc.home;
end;
/