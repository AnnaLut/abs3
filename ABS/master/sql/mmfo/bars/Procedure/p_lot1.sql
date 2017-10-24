

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LOT1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LOT1 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LOT1 ( p_Branch varchar2, p_ob22 varchar2, p_dat2 date) is
  xx branch_opelot%rowtype;    oo oper%rowtype;
  nls_01 accounts.nls%type; s_01 number;  nls_02 accounts.nls%type; s_02 number;  nls_03 accounts.nls%type; s_03 number;
  s_29 number;  zz accounts%rowtype;

/* 15.08.2016 Сухова -Розрахунок з оператором лотерей
  Породжується ДВА  реф.
  В ньому доч.проводки :

  1) 2905-2(бранч 2-го рівня) на 6119/01 \   Розщеплення
  2) 2905-2                   на 3622/51  |  Часткові суми по Бранч-3 для аналізу доходності
  3) 2905-2                   на 6110/60  /
  4) 2905-2                   на 2905-1  акумуляція
  5) 2905-1                   на 2805-2  перекриття з дебіторкою
  6) 2905-1                   на 2905-1  дорезервування (при необхідності)
  7) 2905-1                   на оператора
*/

begin
/*
OBMMFOI
exec bc.go('322669');
2905/03
*/

  oo.dk  := 1;  oo.kv  := gl.baseval;  oo.vob := 6;

  begin select substr( val,1,38) into oo.nam_A FROM params WHERE par = 'NAME';
  EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error (-20000,'Не ЗНАЙДЕНО ГЛ.ПАР.=NAME' );
  end;

  BEGIN  select * into xx from branch_opelot where ob22 = p_OB22  and branch = p_branch ;
  EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error (-20000,'Не ЗНАЙДЕНО оператора ДЛЯ ПЕРЕРАХ З 2905/'||P_OB22 );
  end;

  If xx.DATp > p_DAT2 then
     raise_application_error (-20000,'Дата З='|| to_char(xx.DATp,'dd.mm.yyyy')|| ' є більшою доти ПО='||  to_char(p_DAT2,'dd.mm.yyyy') );
  end if;
  xx.datp :=  xx.DATp +1 ;

  begin select nls into oo.nlsa  FROM accounts where branch= '/'||gl.aMFO||'/000000/' and kv=OO.KV and nbs= '2905' and ob22= p_ob22 and dazs is null and rownum = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error (-20000,'Не ЗНАЙДЕНО РАХ ДЛЯ АККУМ.2905/'||P_OB22 );
  end;

  XX.REF1 := null;
  XX.REF2 := null;
  oo.nd   := '2905/'||p_ob22;
  S_29    := 0 ;
  oo.tt   := 'PS1';
  oo.nazn := '. Період з '||to_char(xx.datp,'dd.mm.yyyy')||' по '||to_char(p_Dat2,'dd.mm.yyyy') ;
  -----------------------------------------------------------------
  for  k in ( SELECT * FROM accounts where branch like xx.branch ||'%' and kv = 980 and nbs = '2905' and ob22 = p_ob22 and ostc > 0 )
  loop k.ostc := least ( Fost (k.acc,p_dat2),k.ostc) ; If k.ostc <= 0 then exit; end if;
       s_01   := round( k.ostc * xx.PR1/100,0 )  ; nls_01 := substr(nbs_ob22_null(xx.BS1,xx.OB1,k.branch),1,14);
       s_02   := round( k.ostc * xx.PR2/100,0 )  ; nls_02 := substr(nbs_ob22_null(xx.BS2,xx.OB2,k.branch),1,14);
       s_03   := round( k.ostc * xx.PR3/100,0 )  ; nls_03 := substr(nbs_ob22_null(xx.BS3,xx.OB3,k.branch),1,14);
       If xx.REF1 is null then   gl.REF(XX.REF1 );
          gl.in_doc3
             (ref_ => XX.REF1 ,  tt_ => oo.tt  , vob_ => oo.vob ,    nd_=> oo.nd  , pdat_=> SYSDATE, vdat_=>gl.bdate, dk_ =>oo.dk,kv_=> oo.kv,
              s_   => k.ostc  , kv2_ => oo.kv  , s2_  => k.ostc ,   sk_ => NULL   , data_=>gl.bdate, datp_=>gl.bdate,
             nam_a_=> oo.nam_a, nlsa_=> oo.NLSa, mfoa_=> gl.aMfo, nam_b_=> oo.nam_a, nlsb_=> oo.NLSa, mfob_=> gl.aMfo,
             nazn_ => xx.nazn1||' '||xx.name||oo.nazn ,
             d_rec_=> NULL   , id_a_=>gl.aOkpo , id_b_=> gl.aOkpo, id_o_ => NULL   , sign_=> NULL   , sos_ => 1      , prty_=>NULL, uid_=> NULL)  ;

       end if;

       If s_01 > 0 then k.ostc := k.ostc - s_01  ;
          gl.payv (0, XX.REF1, gl.bdate, oo.tt, oo.dk, oo.kv, k.nls, s_01  , oo.kv, NLS_01 , s_01  );
          update opldok set txt = 'Відщеплення 6119'  where ref = XX.REF1 and stmt = gl.aStmt;
       end if;
       If s_02 > 0 then k.ostc := k.ostc - s_02  ;
          gl.payv (0, XX.REF1, gl.bdate, oo.tt, oo.dk, oo.kv, k.nls, s_02  , oo.kv, NLS_02 , s_02  );
          update opldok set txt = 'Відщеплення ПДВ'  where ref = XX.REF1 and stmt = gl.aStmt;
       end if;
       If s_03 > 0 then k.ostc := k.ostc - s_03  ; gl.payv (0, XX.REF1, gl.bdate, oo.tt, oo.dk, oo.kv, k.nls, s_03  , oo.kv, NLS_03 , s_03  );
          update opldok set txt = 'Відщеплення 6110'  where ref = XX.REF1 and stmt = gl.aStmt;
       end if;
       If k.ostc > 0 and k.nls <> oo.NLSA then     gl.payv (0, XX.REF1, gl.bdate, oo.tt, oo.dk, oo.kv, k.nls, k.ostc, oo.kv, oo.NLSA, k.ostc);
           update opldok set txt = 'Акумуляція коштів'  where ref = XX.REF1 and stmt = gl.aStmt;
       end if ;
       S_29   := S_29 + k.ostc ;
   end loop; -- k

   ---- Погаш  2805 c общ oo.NLSA
   for  d in ( SELECT * FROM accounts where branch like xx.branch ||'%' and kv = 980 and nbs = '2805' and ob22 = p_ob22 and ostc < 0 )
   loop oo.S    := LEAST ( -Fost (d.acc,p_dat2), -d.ostc, S_29 ) ;
        If oo.s <=  0  then exit ; end if ;
        S_29 := S_29 - oo.s ;
        gl.payv (0, XX.REF1, gl.bdate, oo.tt, oo.dk, oo.kv, oo.NLSA, oo.s, oo.kv, D.nls, oo.s );
        update opldok set txt = 'Перекриття сплачених (деб.заборг.)' where ref = XX.REF1 and stmt = gl.aStmt;
   end loop ; -- d

   -- Формування рез залишку.
   If xx.rez_suM > 0 and xx.rez_ob22 is not null  and s_29 > 0 then
      xx.rez_suM := xx.rez_suM * 100;
      begin select * into zz from accounts where kv = oo.kv and nls = substr(nbs_ob22('2905',xx.REZ_OB22),1,14) and dazs is null and ostc < xx.rez_suM ;
            oo.s :=  LEAST ( xx.rez_suM-zz.OSTC, S_29) ;
            S_29 := S_29 - oo.S;
            gl.payv (0, XX.REF1, gl.bdate, oo.tt, oo.dk, oo.kv, oo.NLSA, oo.s, oo.kv, ZZ.nls, oo.s );
            update opldok set txt = 'Формування постiйного залишку' where ref = XX.REF1 and stmt = gl.aStmt;
      EXCEPTION WHEN NO_DATA_FOUND THEN null ; -- нет проблем с резервом
      end ;
   end if ;

   If S_29 > 0 then  oo.s := s_29 ;
      If xx.MFO <> gl.aMfo then oo.TT := 'PS2' ;   end if ;
      gl.REF ( XX.REF2 );
      gl.in_doc3
             (ref_ => XX.REF2 ,  tt_ => oo.tt  , vob_ => oo.vob ,    nd_=> oo.nd  , pdat_=> SYSDATE, vdat_=>gl.bdate,  dk_  => oo.dk,  kv_ => oo.kv,
              s_   => oo.s    , kv2_ => oo.kv  , s2_  => oo.s   ,   sk_ => NULL   , data_=>gl.bdate, datp_=>gl.bdate,
             nam_a_=> oo.nam_a, nlsa_=> oo.NLSa, mfoa_=> gl.aMfo, nam_b_=> xx.name, nlsb_=> xx.nls , mfob_=> xx.Mfo ,
             nazn_ => xx.nazn2||' '||xx.name||oo.nazn ,
             d_rec_=> NULL   , id_a_=>gl.aOkpo, id_b_=> xx.okpo , id_o_ => NULL   , sign_=> NULL   , sos_ => 1      , prty_=> NULL,    uid_ => NULL)  ;
      PAYTT( 0, XX.REF2, GL.BDATE, oo.tt, oo.dk, OO.KV, OO.NLSA,  oo.S, OO.KV, XX.NLS, oo.s);
      update opldok set txt = 'Перерахування коштів оператору' where ref = XX.REF2 and stmt = gl.aStmt;
   end if;

   Update  branch_opelot set datp = p_DAT2 , ref1 = XX.REF1, ref2 = XX.REF2 where ob22 = p_OB22 and Branch = p_Branch ;

end p_lot1;
/
show err;

PROMPT *** Create  grants  P_LOT1 ***
grant EXECUTE                                                                on P_LOT1          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LOT1.sql =========*** End *** ==
PROMPT ===================================================================================== 
