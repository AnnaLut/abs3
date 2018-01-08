

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NLS_KRM.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NLS_KRM ***

  CREATE OR REPLACE PROCEDURE BARS.P_NLS_KRM ( p_ok int, p_acc number)   is
   a26 accounts%rowtype;    a29 accounts%rowtype;     oo  oper%rowtype;
   p4_ int; sTmp_ varchar2(20); nTmp_ int; l_dazs date ;
begin
  If NVL(p_ok,0) <> 1 thEn return ; end if;
  begin select *    into a26     from accounts where acc = p_acc and dazs is null and ostc >= 0 ;
        select okpo into oo.id_a from customer where rnk = a26.rnk ;
  exception when NO_DATA_FOUND THEN return;
  end;
  l_dazs := DAT_NEXT_U ( gl.bdate, +1) ;  update accounts set dazs = l_dazs where acc =a26.acc ;
  If a26.ostc = 0 then RETURN; end if ;
  -------------------------------------
  -----1/ відкрити рахунки 2903 /зеркало/ по всіх рахунках клієнтів згідно списку.
  sTmp_ := to_char( a26.rnk ) ;
  nTmp_ := length ( sTmp_) -2 ;
  sTmp_ := substr ( sTmp_, 1, nTmp_ );
  sTmp_ := Substr ('000000'|| sTmp_, -6) ; -- Счета должны быть открыты по алгоритму –2903К300 – РНК клиента /6 знаков/.,
  a29.nls :=  '2903_300'|| sTmp_ ;
  a29.nls := VKrzn(substr(gl.aMfo,1,5), a29.nls) ;
  a29.branch := '/'|| gl.aMfo||'/000000/' ;
  op_reg_ex ( mod_ => 99,
              p1_  => 0,
              p2_  => 0,
              p3_  => 15, ---a26.grp,
              p4_  => p4_,
              rnk_ => a26.rnk,
              nls_ => a29.nls,
              kv_  => a26.kv,
              nms_ => a26.nms,
              tip_ => 'ODB',
              isp_ => 3674300, -- a26.isp,
             accR_ => a29.acc,
             tobo_ => a29.branch  ---a26.branch
            );
    Accreg.setAccountSParam(a29.Acc, 'OB22', '01');
    Accreg.setAccountSParam(a29.Acc, 'R011', '1');
    Accreg.setAccountSParam(a29.Acc, 'R013', '1');
    Accreg.setAccountSParam(a29.Acc, 'S180', '1');
    Accreg.setAccountSParam(a29.Acc, 'S240', '1');

   -- 2/підготувати проводки по плану із можливістю встановлення дати закриття після візування.
   oo.nazn := 'Перенесення залишку на недіючі рахунки клієнтів згідно Розпор.від 16.06.2017р. № 31/3-22-370';
   oo.tt   := '101' ;
   gl.ref (oo.REF)  ;
   oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
   gl.in_doc3 (ref_ => oo.REF ,  tt_ =>oo.tt   , vob_=>6 ,    nd_ =>oo.nd   , pdat_=>SYSDATE, vdat_=> gl.bdate,  dk_ => 1,
                kv_ => a26.kv ,  s_  =>a26.ostc, kv2_=>a26.kv,s2_ =>a26.ostc, sk_  => null  , data_=> gl.BDATE, datp_=>gl.bdate,
             nam_a_ => substr(a26.NMS,1,38), nlsa_=>a26.nls, mfoa_=>gl.amfo ,
             nam_b_ => substr(a26.NMS,1,38), nlsB_=>a29.nls, mfoB_=>gl.amfo ,
              nazn_ => oo.nazn,d_rec_ => null, id_a_ => oo.id_a , id_b_=>oo.id_a  ,
              id_o_ => null   , sign_ => null,  sos_ => 1, prty_=>null, uid_=>null );
   gl.payv(0, oo.ref, gl.bdate, oo.tt, 1, a26.kv, a26.nls, a26.ostc, a26.kv,  a29.nls, a26.ostc);
   gl.pay (2, oo.ref, gl.bdate);

   update tmp_nls_krm set ref = oo.ref, nls_2903 = a29.nls where nls = a26.nls and kv = a26.kv ;

end p_NLS_KRM;
/
show err;

PROMPT *** Create  grants  P_NLS_KRM ***
grant EXECUTE                                                                on P_NLS_KRM       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NLS_KRM.sql =========*** End ***
PROMPT ===================================================================================== 
