declare   
  ow operW%rowtype;
  DAT9_ date ;
  DAT0_ date ;
begin 

/*
 Де-яку частину  дисконтів  SDI було розформовано «під-ноль» , але повторно НЕ сформовано.
 З них  більшість – це ФО, з незначними сумами, які було отримано з FV = 0 – по заявці замовника.
 Але є такі, які НЕ були в FV = 0 , їх потрібно відновити – зеркально до розформування.
 Вважаємо  , що це слід зробити корр.оборотами за червень, oper.VDAT = 27.06.2018
 Однак, маркувати їх треба відповідними звітними датами в ДОД.реквізиті. operW.TAG = ‘VDAT’
 Цей дод.реквізит також треба передбачити в ручних операціях, бо зараз його ще немає.
*/
 ------------------------
  ow.tag  := 'DATN' ;
  ------------------------
  begin   execute immediate ' CREATE INDEX BARS.PK_osa  ON BARS.prvn_osaq (tip, nd) ';
  exception when others then    if sqlcode=-955 then null; else raise; end if; -- ORA-00955: name is already used by an existing object
  end; 

  for k in (select * from mv_kf where kf <> '300465' )
  loop bc.go ( k.KF);
     ------------------------------------------------------------------------------------------------------------------
     ow.kf  := gl.aMfo   ;
     select min(s.fdat) into DAT9_ from saldoa s, accounts a where a.nls like '5031_03' and kv = 980 and a.acc= s.acc 
            and s.fdat >= to_date('22-06-2018', 'dd-mm-yyyy');

     DAT0_  := DAT9_ - 1 ;
     --------------------------------------------------------------------------------------------------------------
     For x in ( select * 
                from ( select (select round(b5*100,0) from prvn_osaq where nd = xx.nd and tip = 3 ) B5, 
                               xx.* 
                       from ( select  d.ndg, d.nd, d.vidd, a.acc, a.kv, a.tip, fost(a.acc, DAT0_) vost ,a.ostc , a.dapp 
                              from accounts a, nd_acc n , cc_deal d 
                              where a.tip in ('SDI') and a.acc = n.acc and N.ND = d.nd and d.vidd in (11,12)
                            ) xx
                       where xx.ostc = 0 and xx.vost <>0  
                      ) 
                where b5 <> 0 
              ) 
     loop  
        for oo in (select p.*  from  oper p, opldok o     
                   where o.ref = p.ref and o.acc = x.acc and o.fdat >= DAT9_ and ( p.ND='FRS9_DG' or p.nd like 'FRS9dA%')
                  )
        loop 
           oo.tt   := '013' ;
           oo.vob  := 96 ;
           ow.value:= to_char( oo.Vdat, 'dd.mm.yyyy' );
           oo.vdat := to_date ('27-06-2018', 'dd-mm-yyyy') ;
           oo.ND   := 'FRS9_ZO2' ;
           oo.DK   := 1-oo.dk ;
           oo.Nazn := Substr ('R='|| oo.REF|| '*' || oo.nazn, 1, 160) ;
           oo.Ref := null ;
           gl.ref (oo.REF)  ;
           gl.in_doc3 (ref_=>oo.REF, tt_=> oo.tt, vob_=> oo.vob, nd_ =>oo.nd , pdat_=>SYSDATE, vdat_ =>oo.vdat, 
                       dk_ =>oo.dk , kv_=> oo.kv, s_  => oo.S  , kv2_=>oo.kv2, s2_ =>oo.S2, sk_=> null,data_=>gl.bdate,datp_=>gl.bdate,
                    nam_a_ => oo.nam_a, nlsa_ => oo.nlsA, mfoa_ => gl.aMfo,
                    nam_b_ => oo.Nam_B, nlsb_ => oo.nlsB, mfob_ => gl.aMfo,
                     nazn_ => oo.NAZN ,
                     d_rec_=> null, id_a_=> null, id_b_=>null, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null 
                      );
           ow.ref := oo.Ref ;
           insert into operw values ow;
           gl.payv(0, oo.REF, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsA, oo.s, oo.kv2, oo.nlsB, oo.s2);
           gl.pay (2, oo.ref, gl.bdate);  -- по факту
        end loop; --- oo
     end loop ; -- x
   commit ;
  end loop ; --k

end;
/


