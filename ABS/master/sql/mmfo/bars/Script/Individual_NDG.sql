declare   
  OO OPER%ROWTYPE;   ow operW%rowtype;
  --------------
  procedure  opl IS
  begin
     SELECT SUBSTR( NMS,1,38) INTO OO.NAM_A FROM ACCOUNTS WHERE KV = OO.KV  AND NLS = OO.NLSA;
     SELECT SUBSTR( NMS,1,38) INTO OO.NAM_B FROM ACCOUNTS WHERE KV = OO.KV2 AND NLS = OO.NLSb;
     OO.S2 := OO.S ;
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
  end ;

begin   

/*
Для индивидуального случая (счет типа SDF на ЦА, acc = 1691981201) необходимо выполнить корректирующую проводку по следующим правилам:
- счет по дебету 20663881014862
- счет по кредиту 20466738058208
- дата валютирования DATN 27.04.2018
- сумма проводки 502 487.50

*/

  ------------------------
  ow.tag  := 'DATN' ;
  ow.value:= '27.04.2018';  -- - дата валютирования DATN 27.04.2018
  oo.tt   := '013' ;
  oo.vob  := 96 ;
  oo.vdat := to_date ('27-06-2018', 'dd-mm-yyyy') ;
  oo.ND   := 'FRS9_Инд' ;
  --------------------
  BC.GO ('300465' ) ; -- на ЦА
  ow.kf  := gl.aMfo   ;
 --------------------------------------------------------------------------------------------------------------
  oo.DK   := 1  ;
  OO.KV   := 980;   OO.NLSA := '20663881014862'; --- счет по дебету 20663881014862  
  OO.KV2  := 980;   OO.NLSB := '20466738058208'; --- счет по кредиту 20466738058208
  OO.S    := 50248750;                           --- сумма проводки 502 487.50
  OO.NAZN :=  'Для индивидуального случая (счет типа SDF на ЦА, acc = 1691981201) необходимо выполнить корр.проводку' ; 
  OPL;

  commit ;
end;
/



