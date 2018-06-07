-- Created on 05-Jun-18 by VOLODYMYR.POHODA 
declare 
  -- Local variables here
  v_rec oper%rowtype;
  procedure CreateDoc (p_rec IN OUT oper%rowtype ) is 
  begin 
       gl.ref (p_rec.REF);

       gl.in_doc3 (ref_   => p_rec.REF  , 
                   tt_    => '024'  , 
                   vob_   => 6      ,   
                   nd_    => '8999'  , 
                   pdat_  => SYSDATE, 
                   vdat_  => gl.bdate, 
                   dk_    => p_rec.dk ,
                   kv_    => p_rec.kv   , 
                   s_     => p_rec.S   , 
                   kv2_   => p_rec.kv  ,   
                   s2_    => p_rec.S    , 
                   sk_    => null  , 
                   data_  => trunc(sysdate),
                   datp_  => gl.bdate,
                   nam_a_ => p_rec.nam_a,
                   nlsa_  => p_rec.nlsa,
                   mfoa_  => gl.aMfo, 
                   nam_b_ => 'Контрарахунок для 8999',
                   nlsb_  => p_rec.nlsb, 
                   mfob_  => gl.aMfo ,
                   nazn_  =>'Вирівнювання залишків на позасистемних рах.8999*LIM',
                   d_rec_ => null,
                   id_a_  => null, 
                   id_b_  => null,
                   id_o_  => null, 
                   sign_  => null,
                   sos_   => 1,
                   prty_  => null,
                   uid_   => null);

--     update accounts set pap = 3 where nls = oo.nlsa and kv = oo.kv;
--     update accounts set pap = 3 where nls = oo.nlsb and kv = oo.kv;

     gl.payv(0, 
             p_rec.ref, 
             gl.bdate, 
             '024', 
             p_rec.dk, 
             p_rec.kv, 
             p_rec.nlsa , 
             p_rec.s, 
             p_rec.kv, 
             p_rec.nlsb, 
             p_rec.s);

     gl.pay (2, p_rec.ref, gl.bdate);  -- по факту
     logger.info('LIM_update проводки: ref = '||p_rec.ref);
  end CreateDoc ;
begin
  for br in (select * from mv_kf)
  loop
    bc.go(br.kf);
    v_rec := null;
    logger.info('LIM_update start branch '||br.kf);
    for r in (select ss.acc, ss.ostc, lim.acc l_acc, lim.ostc l_ostc
                from cc_deal c,
                     nd_acc nss,
                     accounts ss,
                     nd_acc nlim,
                     accounts lim,
                     cc_deal cm
                where c.kf = br.kf
                  and c.nd = nss.nd
                  and nss.acc = ss.acc
                  and ss.tip in ('SS ','SP ')
                  and c.nd = nlim.nd
                  and nlim.acc = lim.acc
                  and lim.tip = 'LIM'
                  and nvl(ss.accc,-1) != lim.acc
                  and cm.vidd in (2,3)
                  and cm.nd = nvl(cm.ndg,-1)
                  and cm.ndg = c.ndg)
                  
    loop
      update accounts 
        set accc = r.l_acc
        where acc = r.acc;

      logger.info('LIM_update SS  : acc = '||r.acc||', accc = '||r.l_acc);      
  /*    if r.ostc != r.l_ostc then
        v_rec.dk := 1;
        v_rec.s  := abs(r.ostc) - abs(r.l_ostc);
        if v_rec.s <0 then 
          v_rec.dk := 0;
        end if;
        v_rec.nlsa   := r.nls;
        v_rec.nam_a  := r.nms;
        v_rec.nlsb   := r.nlsb;
        v_rec.kv     := r.kv;
      end if;
  logger.info('LIM_update SUB : nlsa = '||v_rec.nlsa||', nlsb = '||v_rec.nlsb||', s = '||v_rec.s);
      CreateDoc(v_rec);*/
    end loop;


    for r in (select lim.nls, substr(lim.nms,1,38) nms,
                     (select nls from accounts ak where ak.nbs = '8006' and ak.dazs is null and ak.kv = lim.kv and rownum = 1) nlsb,
                     lim.ostc,
                     lim.kv,
                     (select sum(ostc) from accounts ss where ss.accc = lim.acc and ss.tip in ('SS ','SP ')) sum_p
                from cc_deal c,
                     nd_acc nlim,
                     accounts lim,
                     cc_deal cm
                where c.kf = br.kf
                  and c.nd = nlim.nd
                  and nlim.acc = lim.acc
                  and lim.tip = 'LIM'
                  and c.nd != nvl(c.ndg,c.nd)
                  and cm.vidd in (2,3)
                  and cm.nd = cm.ndg
                  and c.ndg = cm.ndg
              )
    loop
      if r.ostc != r.sum_p then
        v_rec.dk := 1;
        v_rec.s  :=  r.ostc - r.sum_p;
        if v_rec.s <0 then 
          v_rec.dk := 0;
          v_rec.s := 0-v_rec.s;
        end if;
        v_rec.nlsa   := r.nls;
        v_rec.nam_a  := r.nms;
        v_rec.nlsb   := r.nlsb;
        v_rec.kv     := r.kv;
  logger.info('LIM_update SUB : nlsa = '||v_rec.nlsa||', nlsb = '||v_rec.nlsb||', s = '||v_rec.s);
      CreateDoc(v_rec);
      end if;
    end loop;


    v_rec.s := 0;
    
    for r in (select ml.acc accc, sl.acc
                from cc_deal m,
                     nd_acc ma,
                     accounts ml,
                     cc_deal s,
                     nd_acc sa,
                     accounts sl
                where m.kf = br.kf
                  and m.nd = m.ndg
                  and ma.nd = m.nd
                  and s.nd != s.ndg
                  and s.ndg = m.nd
                  and sa.nd = s.nd
                  and ml.acc = ma.acc
                  and ml.tip = 'LIM'
                  and sl.acc = sa.acc
                  and sl.tip = 'LIM'
                  and nvl(sl.accc,-1) != ml.accc)
    loop
      update accounts
        set accc = r.accc
        where acc = r.acc;
    end loop;
                  
    
    for r in (select a.nls, a.acc, substr(a.nms,1,38) nms, a.ostc, (select round(sum(gl.p_Ncurval(a.kv,gl.p_icurval(l.kv,ostc,gl.bdate),gl.bdate)),0) from accounts l where l.accc = a.acc) lims, 
                     (select nls from accounts ak where ak.nbs = '8006' and ak.dazs is null and ak.kv = a.kv and rownum = 1) nlsb,
                     a.kv
                from cc_deal c,
                     nd_acc n,
                     accounts a
                where c.kf = br.kf
                  and n.nd = c.ndg
                  and n.acc = a.acc
                  and a.tip = 'LIM')
    loop
      if r.ostc != r.lims then
        v_rec.nlsa  := r.nls;
        v_rec.nam_a := r.nms;
        v_rec.nlsb  := r.nlsb;
        v_rec.s     := r.ostc - r.lims;
        v_rec.kv    := r.kv;
        if v_rec.s < 0 then
          v_rec.dk := 0;
          v_rec.s := 0- v_rec.s;
        else 
          v_rec.dk := 1;
        end if;
        logger.info('LIM_update MAIN: nlsa = '||v_rec.nlsa||', nlsb = '||v_rec.nlsb||', s = '||v_rec.s);
        CreateDoc(v_rec);
      end if;
    end loop;
    commit;
  end loop;
  bc.home;
end;
/