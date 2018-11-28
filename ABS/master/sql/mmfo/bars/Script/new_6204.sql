declare
 a6_old accounts%rowtype;
 a6_new accounts%rowtype;
 oo oper%rowtype;
begin

 -- В депозитарии есть ?
 bc.go ('/');
 begin Insert into SB_OB22   (R020, OB22, TXT) Values   ('6204', '31', 'переоцінка рахунків за операціями  СВОП' );
 exception when others then  if SQLCODE = -00001 then null;   else raise; end if; 
 end;

 bc.go ('300465');

 -- найти старый счет 
 begin select * into a6_old from accounts where acc = 38646401 and dazs is null  FOR UPDATE OF dazs NOWAIT ; 
 EXCEPTION WHEN NO_DATA_FOUND  THEN RETURN; 
 end;

 -- откр новый счет 
 OP_BS_OB1( PP_BRANCH => a6_old.branch, P_BBBOO =>'620431');

 -- найти новый счет 
 begin select * into a6_new from accounts where BRANCH = a6_old.branch and nbs = '6204' and ob22= '31' and dazs is null;
 EXCEPTION WHEN NO_DATA_FOUND  THEN RETURN;  
 end;

 -- обновиить  vp_list
 update vp_list set acc6204 = a6_new.acc where acc6204 = a6_old.acc ;

 -- перебрость остаток
 If a6_old.ostc <> 0   then  
    oo.s  := Abs (a6_old.ostc) ; 
    oo.tt := '013' ; 
    If a6_old.ostc > 0 then oo.dk := 1 ; 
    Else                    oo.dk := 0 ;
    end if ;

    gl.ref (oo.REF);
    gl.in_doc3 (ref_=>oo.REF, tt_=>oo.tt , vob_=>6  , nd_ =>'6204/31', pdat_=>SYSDATE, vdat_=> gl.bdate, dk_ => oo.dk,
                 kv_=>980   , s_ =>oo.S  , kv2_=>980, s2_ =>oo.S, sk_ => null  , data_=>gl.BDATE,datp_=>gl.bdate,
                nam_a_=>Substr(a6_old.nms,1,38),nlsa_=>a6_old.nls, mfoa_=>gl.aMfo,
                nam_b_=>Substr(a6_new.nms,1,38),nlsb_=>a6_new.nls, mfob_=>gl.aMfo,
                nazn_ =>'Перенесення залишку на інший рахунок в зв`язку зі зміною ob22',
                d_rec_=>null,  id_a_=>gl.aOkpo,id_b_ =>gl.aOkpo,id_o_=>null,sign_=>null,sos_=>1,prty_=>null,uid_=>null);
    gl.payv(0, oo.ref, gl.BDATE ,oo.tt, oo.dk, 980, a6_old.nls, oo.s, 980,  a6_new.nls, oo.s ) ;
    gl.pay (2, oo.ref, gl.BDATE ); 
 end if ;

 update accounts set dazs = DAT_NEXT_U( gl.bdate , 1 ) where acc = a6_old.acc ;
 commit ;

 bc.go ('/');

end ; 
/

