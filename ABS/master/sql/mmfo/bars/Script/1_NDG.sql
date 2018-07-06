declare   oo oper%rowtype;  ow operW%rowtype;
begin ---------------анализ по всем РУ на предмет Нулевых остатков по всем 4-м дисконтам и невызнаным  по ГЕН/дог
/*
Осуществить корректирующими проводками автоматический перенос остатков со счетов SDI на счета процентных доходов, 
маркируя соответствующие документы номером (ND) с префиксом «FRS9» и датой валютирования (DATN).

Для индивидуального случая (счет типа SDF на ЦА, acc = 1691981201) необходимо выполнить корректирующую проводку по следующим правилам:
- счет по дебету 20663881014862
- счет по кредиту 20466738058208
- дата валютирования DATN 27.04.2018
- сумма проводки 502 487.50

*/

  ------------------------
  ------------------------
  for k in (select * from mv_kf)
  loop bc.go ( k.KF);
     --------------------------------------------------------------------------------------------------------------
     For x in (select d.rnk, d.ndg, d.nd, a.nls, a.kv, a.ostc, a.tip , a.nms, c.nmk , a.acc 
               from nd_acc n, accounts a, cc_deal d, customer c
               where a.dazs is null and a.tip in  ('SDI', 'XDI') -------, 'SDA', 'XDA', 'SDM', 'XDM' , 'SDF', 'XDF', 'SNA', 'XNA') 
                 and a.acc= n.acc and n.nd = d.nd and d.nd = d.ndg 
                 and d.rnk = c.rnk 
               )
     loop  If x.OSTC <> 0 then 
              oo.tt   := '013' ;
              oo.vob  := 96 ;
              oo.vdat := to_date ('27/06/2018', 'dd/mm/yyyy') ;
              oo.ND   := 'FRS9_ZO1' ;

              oo.kv    := x.KV ;  -------------------\
              oo.NLSA  := x.NLS;  -------------------| Счет дисконта
              oo.nam_a := substr(x.nms,1,38) ; ----- /

              oo.KV2   := GL.baseval;
              oo.NLSB  := Get_NLS60 ( p_kv => oo.KV,  p_nls => oo.NLSA ) ;
              oo.nam_b := Substr ( 'Прц.дох. для угоди '|| x.NDG ,1,38) ;

              gl.ref (oo.REF)  ;

              ow.ref   := oo.Ref ;         ---\
              ow.kf    := gl.aMfo;         ---|
              ow.tag   := 'DATN' ;         ---| Доп.рекв
              ow.value := '31.05.2018' ;   ---|


   
              If x.OSTC > 0 then oo.dk := 1; oo.s :=   x.OSTC ;
              Else               oo.dk := 0; oo.s := - x.OSTC ;
              end if;

              oo.S2 := gl.p_icurval( x.KV, oo.S, to_date (ow.value, 'dd.mm.yyyy') );

              gl.in_doc3 (ref_=>oo.REF, tt_=> oo.tt, vob_=> oo.vob, nd_ =>oo.nd , pdat_=>SYSDATE, vdat_ =>oo.vdat, 
                          dk_ =>oo.dk , kv_=> oo.kv, s_  => oo.S  , kv2_=>oo.kv2, s2_ =>oo.S2, sk_=> null,data_=>gl.bdate,datp_=>gl.bdate,
                       nam_a_ => oo.nam_a, nlsa_ => oo.nlsA, mfoa_ => gl.aMfo,
                       nam_b_ => oo.Nam_B, nlsb_ => oo.nlsB, mfob_ => gl.aMfo,
                        nazn_ => Substr( 'Згорнення складової '||x.TIP||'* ген/угоди '||x.NDG || '*' ||x.NMK ,1,160),
                        d_rec_=> null, id_a_=> null, id_b_=>null, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null 
                           );
              insert into operw values ow; ---/

              gl.payv(0, oo.REF, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsA, oo.s, oo.kv2, oo.nlsB, oo.s2);
              gl.pay (2, oo.ref, gl.bdate);  -- по факту

           end if ; -- x.OSTC <> 0 

           update accounts set dazs =  DAT_NEXT_U (gl.bdate, +1 ) where acc = x.ACC ;

     end loop; --x
     commit ;

  end loop ; --k
end;
/


