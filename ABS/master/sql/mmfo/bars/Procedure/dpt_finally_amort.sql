

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_FINALLY_AMORT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_FINALLY_AMORT ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_FINALLY_AMORT (p_date date)
is
l_dat_end date;
oo oper%rowtype;
oo1 oper%rowtype;
l_ref number;
        procedure OPl_     ( oo   IN OUT oper%rowtype      ) is
    -- оплата 1 проводки
      begin
         If nvl(oo.s,0) <= 0 then return; end if;

         oo.tt := NVL(oo.TT, '%%1');  oo.vob := nvl(oo.vob,6);

         if oo.ref is null then       gl.ref (oo.REF);
            oo.nd := substr(to_char(oo.ref),1,10);
            gl.in_doc3(ref_ =>oo.ref  ,tt_  => oo.tt   , vob_ =>    6    ,  nd_  => oo.nd , pdat_=>  SYSDATE, vdat_=> gl.bdate,
                       dk_  => oo.dk  ,kv_  => oo.kv   , s_   =>  oo.S   ,  kv2_ =>oo.kv2  , s2_  =>  oo.s   , sk_  => null    ,
                       data_=>gl.bdate,datp_=> gl.bdate,nam_a_=> oo.nam_a, nlsa_ =>oo.nlsa, mfoa_=> gl.aMfo ,nam_b_=> oo.nam_b,
                       nlsb_=>oo.nlsb ,mfob_=> gl.aMfo ,nazn_ => oo.nazn , d_rec_=> null  , id_a_=>  oo.id_a   , id_b_=>oo.id_b,
                       id_o_=>null    ,sign_=>  null   ,  sos_=>  5    ,  prty_=> null  , uid_ =>  null  );
         end if;
         gl.payv( 1, oo.ref, gl.bdate ,oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2, oo.nlsb , oo.s2 );
         update opldok set txt = oo.d_rec where ref = gl.aref and stmt = gl.aStmt;

      end opl_;

begin
  l_dat_end:= dat_next_u(p_date, 1);


  for k in
  (select distinct
        -- 7041-> 2636
        d.deposit_id, d.dat_begin, d.dat_end,d.kf, d.branch, --dpt info
        abs(fost(acc_2636, p_date)) ost,
        DECODE( d.kv, 980, DECODE(0, 0, G67, G67N), DECODE(0, 0, V67, V67N) ) nls7, a7.nms nms7, a7.kv kv7, c7.okpo okpo7,--7041
        a.nls, a.nms,a.kv,c.okpo,--2636
        --3648 -> 2638
        abs(fost(dpi.acc_3648, p_date)) ost3648,
        a2638.nls nls2638,a2638.nms nms2638, a2638.kv kv2638, c2638.okpo okpo2638, --2638
        a3648.nls nls3648,a3648.nms nms3648, a3648.kv kv3648, c3648.okpo okpo3648 --2638
  from dpt_deposit d
  join dpt_accounts da on D.DEPOSIT_ID = DA.DPTID
  join dpt_political_instability dpi on d.deposit_id = dpi.new_dpt_id and d.dat_end <= l_dat_end
  join proc_dr$base p on P.BRANCH = D.BRANCH and p.sour=4 and P.REZID = d.vidd
  join accounts a on a.acc = dpi.acc_2636
  join customer c on a.rnk = c.rnk
  join accounts a7 on a7.nls = DECODE(d.kv, 980, DECODE(1, 0, G67, G67N), DECODE(1, 0, V67, V67N))
  join customer c7 on a7.rnk = c7.rnk
  join accounts a2638 on DA.ACCID = A2638.ACC and a2638.nbs = 2638
  join customer c2638 on a2638.rnk = c2638.rnk
  join accounts a3648 ON a3648.acc = dpi.acc_3648
  join customer c3648 on a3648.rnk = c3648.rnk
  )

  loop
   -- 7041 -> 2636
    begin
        oo.ref := null;
        oo.s :=  p_icurval(k.kv, k.ost, p_date);
        oo.s2 := k.ost;
        oo.kv := k.kv7;
        oo.kv2:= k.kv;
        oo.dk := 1;
        oo.nam_a:= substr(k.nms7,1,38);
        oo.nlsa := k.nls7;
        oo.id_a := k.okpo7;
        oo.nam_b := substr(k.nms,1,38) ;
        oo.nlsb :=k.nls;
        oo.id_b := k.okpo;
        oo.d_rec :='Амортизація рах.(пропорц) ';
        oo.nazn := substr( oo.d_rec||to_char(k.nls)||' з '||to_char(k.dat_begin,'dd/mm/yyyy')||' по '||to_char(k.dat_end,'dd/mm/yyyy')||' вкл',1,160);

        opl_(oo);
        if nvl(oo.ref,0) <> 0 then
            insert into dpt_payments (dpt_id, ref, kf, branch)
            values (k.deposit_id, oo.ref, k.kf, k.branch);
            commit;
        end if;

    end;

    --3648 - 2638

        begin
        oo.ref := null;
        oo.s :=  k.ost3648;
        oo.s2 := k.ost3648;
        oo.kv := k.kv3648;
        oo.kv2:= k.kv2638;
        oo.tt := 'DIR';
        oo.dk := 1;
        oo.nam_a:= substr(k.nms3648,1,38);
        oo.nlsa := k.nls3648;
        oo.id_a := k.okpo3648;
        oo.nam_b := substr(k.nms2638,1,38);
        oo.nlsb :=k.nls2638;
        oo.id_b := k.okpo2638;
        oo.d_rec :='Перенесення винагороди по акційному вкладу ';
        oo.nazn := substr(oo.d_rec||to_char(k.deposit_id)||' від '||to_char(k.dat_begin,'dd/mm/yyyy')||' для виплати вкладнику',1,160);

        opl_(oo);
        if nvl(oo.ref,0) <> 0 then
            insert into dpt_payments (dpt_id, ref, kf, branch)
            values (k.deposit_id, oo.ref, k.kf, k.branch);
            commit;
        end if;
    end;

  end loop;
end dpt_finally_amort;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_FINALLY_AMORT.sql =========***
PROMPT ===================================================================================== 
