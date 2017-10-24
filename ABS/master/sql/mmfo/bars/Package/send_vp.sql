CREATE OR REPLACE PACKAGE BARS.Send_VP IS   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1.0 08.11.2016 Пiдкрiплення Вал.Поз';
  procedure PUT      ( p_acc number, p_n number, p_k number, p_q number, p_FF int, p_FT int  ) ;
  procedure PAY      ( p_Nazn varchar2) ;
  procedure PAY_RATE ( p_Nazn varchar2) ;

  function header_version return varchar2;
  function body_version   return varchar2;
  -------------------
END Send_VP;
/
---------------------------------------------
CREATE OR REPLACE PACKAGE BODY BARS.Send_VP IS   G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1.0 08.11.2016 Пiдкрiплення Вал.Поз';
 g_errN number := -20203 ;
 g_errS varchar2(8) := 'Send_VP:'  ;
 nlchr char(2) := chr(13)||chr(10) ;
 ------------------------------------
procedure PUT ( p_acc number, p_n number, p_k number, p_q number, p_FF int, p_FT int  ) is
begin     PUL.PUT('NTAG',1) ;

    If    p_FT = 1 and p_FF = 1    then  raise_application_error(g_errn, g_errS||'Рахунок "From" НЕ може бути рівним рахунку "To" ! ')  ;
    ElsIf p_FT = 1 and
       (p_n>0 or p_k >0 or p_q >0) then  raise_application_error(g_errn, g_errS||'Суми, курс передачі НЕсумісні з рахунком "To" ! ')  ;
    ElsIf p_FT = 1                 then  PUL.PUT('ACCT',to_char( p_acc) );

    ElsIf              p_FF = 1    then  PUL.PUT('ACCF',to_char( p_acc) );
                                         PUL.PUT('N'   ,to_char( p_N  ) );
                                         PUL.PUT('K'   ,to_char( p_K  ) );
                                         PUL.PUT('Q'   ,to_char( p_Q  ) );
    Else                                 raise_application_error(g_errn, g_errS||'Не вибрано ні "From" ні "To" ! ')  ;
    end if ;

    If PUL.GET( 'ACCT' ) = PUL.GET( 'ACCF' ) then
       raise_application_error(g_errn, g_errS||'Рахунок "From" НЕ може бути рівним рахунку "To" ! ')  ;
    end if;

end PUT;

procedure PAY ( p_Nazn varchar2) is
  oo oper%rowtype ;
  l_N number ;
  l_K number ;
  l_Q number ;
  l_VPF accounts.nls%type;
  l_VPT accounts.nls%type;
begin
  l_N   := To_number( PUL.get('N') )*100 ;
  l_K   := To_number( PUL.get('K') )     ;
  l_Q   := To_number( PUL.get('Q') )*100 ;

  If Nvl(l_N,0) <=  0                                then raise_application_error(g_errn, g_errS||' НЕ введено суму Валюти !')       ; end if ;
  If Nvl(l_K,0) <=  0 and Nvl(l_Q,0) <= 0            then raise_application_error(g_errn, g_errS||' НЕ введено суму(курс) Грн !')    ; end if ;
  If Length(p_Nazn) < 5                              then raise_application_error(g_errn, g_errS||' НЕ введено Підставу операції !') ; end if ;
  If l_K > 0 and l_Q > 0 and l_Q <> Round(l_N*l_K,0) then raise_application_error(g_errn, g_errS||' Сума грн НЕ відповідає курсу !') ; end if ;

  If    l_K > 0 and l_Q > 0 then null;
  ElsIf l_K > 0             then l_Q := Round(l_N*l_K,0);
  ElsIf             l_Q > 0 then l_K := l_Q/l_N;
  end if;

  Begin oo.KV := To_number(PUL.get('KV')) ; oo.kv2 := gl.BaseVal;
        select a.nls, Substr(a.nms,1,38)  , b.nls  , Substr(b.nms,1,38)
        into oo.nlsA, oo.nam_a            , oo.nlsB, oo.nam_B
        from accounts a,   accounts b
        where a.kv = oo.KV  and a.ob22 = '06' and a.nbs = '3739'
          and b.kv = oo.Kv2 and b.ob22 = '06' and b.nls = a.nls  and a.branch = b.branch   and a.dazs is null and b.dazs is null
          and ( length(a.branch) = 8 or a.branch like '/'||gl.aMfo||'/000000/')
          and rownum= 1 ;
  EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||' НЕ знайдено м/вал транзитний рахунок 3739/06 !') ;
  end;

  oo.nazn := p_Nazn   ;
  oo.vob  := 16       ;
  oo.tt   := '38V'    ;
  oo.s    := l_N      ;
  oo.s2   := l_Q      ;
  oo.vdat := gl.bdate ;

  Begin select f.nls, t.nls into l_VPf, l_VPt  from accounts f, accounts t where f.acc = To_number(PUL.get('ACCF'))  and t.acc = To_number(PUL.get('ACCT'))    ;
  EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||' НЕ знайдено вал/поз "From->To" !') ;
  end;

  PUL.PUT('REFF', null );
  PUL.PUT('REFT', null );

  ----| From  --- >
  PUL.PUT('VP', l_VPF );
  oo.dk := 0 ;
  gl.ref (oo.REF);
  oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
  gl.in_doc3 (ref_=>oo.REF  ,  tt_ =>oo.tt  ,  vob_=>oo.vob  ,  nd_  =>oo.nd   , pdat_=>SYSDATE, vdat_=>oo.vdat ,  dk_ => oo.dk,
               kv_=>oo.kv   ,  s_  =>oo.S   ,  kv2_=>oo.kv2  ,  s2_  =>oo.S2   , sk_  => null  , data_=>gl.BDATE, datp_=> gl.bdate,
            nam_a_=>oo.nam_a, nlsa_=>oo.nlsa, mfoa_=>gl.aMfo , nam_b_=>oo.nam_b, nlsb_=>oo.nlsb, mfob_=>gl.aMfo ,
             nazn_=>oo.nazn ,d_rec_=>null   , id_a_=>gl.aOkpo, id_b_ =>gl.aOkpo, id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
  gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2,  oo.nlsb, oo.s2);
  PUL.PUT('REFF', oo.ref );

  ---->  To  |---
  PUL.PUT('VP', l_VPT );
  oo.dk := 1 ;
  gl.ref (oo.REF);
  oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
  gl.in_doc3 (ref_=>oo.REF  ,  tt_ =>oo.tt  ,  vob_=>oo.vob  ,  nd_  =>oo.nd   , pdat_=>SYSDATE, vdat_=>oo.vdat ,  dk_ => oo.dk,
               kv_=>oo.kv   ,  s_  =>oo.S   ,  kv2_=>oo.kv2  ,  s2_  =>oo.S2   , sk_  => null  , data_=>gl.BDATE, datp_=> gl.bdate,
            nam_a_=>oo.nam_a, nlsa_=>oo.nlsa, mfoa_=>gl.aMfo , nam_b_=>oo.nam_b, nlsb_=>oo.nlsb, mfob_=>gl.aMfo ,
             nazn_=>oo.nazn ,d_rec_=>null   , id_a_=>gl.aOkpo, id_b_ =>gl.aOkpo, id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
  gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2,  oo.nlsb, oo.s2);
  PUL.PUT('REFT', oo.ref );

  PUL.PUT('ACCF',null );
  PUL.PUT('ACCT',null );
  PUL.PUT('N'   ,null );
  PUL.PUT('K'   ,null );
  PUL.PUT('Q'   ,null );

end PAY;

procedure PAY_RATE ( p_Nazn varchar2) is
  l_KV int  ;
  l_QV number;
  l_NO number;
begin
  l_KV := To_number( PUL.get('KV') );
  l_NO := To_number( PUL.get('N' ) )*100 ;
  l_QV := gl.p_icurval (l_KV, l_NO, gl.bdate) /100 ;
  PUL.PUT('Q', L_QV );

  Send_VP.PAY( p_Nazn );

end PAY_RATE;

function header_version return varchar2 is begin  return 'Package header Send_VP '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body Send_VP '  ||G_BODY_VERSION  ; end body_version;
---Аномимный блок --------------
begin  Null;
END Send_VP;
/