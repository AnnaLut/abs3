

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_LOM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_LOM ***

  CREATE OR REPLACE PROCEDURE BARS.CC_LOM 
(p_Par  int,
 p_Nd   int,
 p_Sum1 number,
 p_Sum2 number,
 p_nazn varchar2

) is

/* 30-09-2010 Шевченко С.И.
   в проводках по ломбардному кред рахунок 3622/53  зам_нити на 3622/23.
*/

ref_  oper.REF%type   ;
tt_   oper.TT%type    := 'LOM';
vob_  oper.VOB%type   := 6;
s_    oper.S%type     ;
p_    oper.S%type     ;
s1_   oper.S%type     ;
s2_   oper.S%type     ;
p1_   oper.S%type     ;
p2_   oper.S%type     ;
isp_  oper.userid%type;
nlsa_ oper.NLSA%type  ;
nlsb_ oper.NLSB%type  ;
nmsa_ oper.NAM_A%type ;
nmsb_ oper.NAM_B%type ;
-------------------------
nlsd_ accounts.NLS%type ;
nlsk_ accounts.NLS%type ;
kv_   accounts.KV%type  ;
Acc_  accounts.nls%type ;
ost_2202  accounts.ostc%type :=0 ;
ost_2208  accounts.ostc%type :=0 ;
ost_9500  accounts.ostc%type :=0 ;
-------------------------
function poisk_nls  ( p_nbs  IN  accounts.NBS%type,   p_ob22 IN  specparam_int.OB22%type,   p_nms  OUT oper.nam_a%type ) return varchar2 is
   nls_ accounts.nls%type;
begin
   nls_ := NBS_OB22(p_NBS, p_OB22);
   select substr(nms,1,38) into p_nms   from accounts where kv=gl.baseval and nls=nls_;
   return nls_;
end poisk_nls;
---------------
BEGIN
  If p_Par < 1 or  p_Par> 4 then RETURN; end if;
  -----------------------------------------------
  kv_   := gl.baseval;
  if gl.aUid = 1 then isp_:=20094; else isp_ := gl.auid; end if;
----------------------------------------------------------------------
  S_    := p_Sum1;
  If    p_Par= 1 then
        nlsa_ := poisk_nls ('3409','04', nmsa_);
        nlsb_ := poisk_nls ('3739','05', nmsb_);
  elsIf p_Par= 2 then
        nlsa_ := poisk_nls ('3407','01', nmsa_);
        nlsb_ := poisk_nls ('3409','04', nmsb_);
  elsIf p_Par= 3 then null;
        nlsa_ := poisk_nls ('3519','07', nmsa_);
        nlsb_ := poisk_nls ('3407','01', nmsb_);
  elsIf p_Par= 4 then null;
        nlsa_ := poisk_nls ('3619','04', nmsa_);
        nlsb_ := poisk_nls ('3519','07', nmsb_);
        --Только сумма ДМ
        p1_ :=round( p_Sum1 * 20/100 ,0 );
        s1_ := p_Sum1;

        p2_ := round( p_Sum2 *20/120,0);
        s2_ := p_Sum2- p2_;

        If S2_ > S1_ then    S_    := S1_ + P1_;
        else                 S_    := S2_ + P2_;
        end if;

  end if;
  -------
  gl.ref (REF_);
  gl.in_doc3(ref_  => REF_,
            tt_    => TT_ ,
            vob_   => VOB_,
            nd_    => substr(to_char(REF_),1,10),
            pdat_  => SYSDATE ,
            vdat_  => gl.BDATE,
            dk_    => 1,
            kv_    => kv_,
            s_     => S_,
            kv2_   => kv_,
            s2_    => S_,
            sk_    => null,
            data_  => gl.BDATE,
            datp_  => gl.bdate,
            nam_a_ => nmsa_,
            nlsa_  => nlsa_,
            mfoa_  => gl.aMfo,
            nam_b_ => nmsb_,
            nlsb_  => nlsb_,
            mfob_  => gl.aMfo,
            nazn_  => p_nazn,
            d_rec_ => null,
            id_a_  => null,
            id_b_  => null,
            id_o_  => null,
            sign_  => null,
            sos_   => 1,
            prty_  => null,
            uid_   => isp_);

     gl.payv(flg_  => 0,
             ref_  => REF_ ,
             dat_  => gl.bDATE ,
             tt_   => TT_  ,
             dk_   => 1    ,
             kv1_  => kv_  ,
             nls1_ => nlsa_,
             sum1_ => s_   ,
             kv2_  => kv_  ,
             nls2_ => nlsb_,
             sum2_ => S_   );

  If    p_Par= 1 then
        update opldok
           set txt ='стягнення на предмет закладу'
         where ref=REF_ and stmt=gl.astmt;

        --2202
        begin
          -- закрыть тело кредита
          select a.nls, -a.ostc, a.acc into nlsk_, ost_2202, ACC_
          from accounts a, nd_acc n
          where n.nd = p_Nd and a.acc=n.acc and a.tip='SS ' and a.ostc <0 ;
          gl.payv(0,REF_,gl.bDATE,TT_,1,kv_,nlsB_,ost_2202,kv_,nlsk_,ost_2202);
          update opldok
             set txt ='Погашення кредиту за рахунок отриманого закладу'
           where ref=REF_ and stmt=gl.astmt;

          --9500
          -- закрыть внебаланс
          select nls, -ostc into nlsk_, ost_9500  from accounts a, cc_accp p
          where p.accs = ACC_ and p.acc = a.acc and ostc <0 ;

          nlsd_ := nbs_ob22('9900','00');
          gl.payv(0,REF_,gl.bDATE,TT_,1,kv_,nlsd_,ost_9500,kv_,nlsk_,ost_9500);
          update opldok
             set txt ='Списання суми закладу'
           where ref=REF_ and stmt=gl.astmt;

        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end ;

        --2208
        begin
          -- закрыть проценты
          select nls, -ostc into nlsk_, ost_2208  from accounts a, nd_acc n
          where n.nd = p_Nd and a.acc=n.acc and a.tip='SN ' and a.ostc <0 ;
          gl.payv(0,REF_,gl.bDATE,TT_,1,kv_,nlsB_,ost_2208,kv_,nlsk_,ost_2208);
          update opldok
             set txt ='Погашення нарахованих %%  за рахунок отриманого закладу'
           where ref=REF_ and stmt=gl.astmt;

        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end ;

        --Перерахування суми податку з доход_в ф_зичних ос_б (15%)
        P_    := Round( (ost_2202 + ost_2208)*15/85, 0 );
        nlsk_ := nbs_ob22('3622','23');
        gl.payv(0,REF_,gl.bDATE,TT_,1,kv_,nlsB_,p_,kv_,nlsk_,p_);
        update opldok
           set txt ='Перерахування суми податку з доходiв фiз.осiб (15%)'
         where ref=REF_ and stmt=gl.astmt;

  elsIf p_Par= 2 then

        update opldok
           set txt ='Вiдправлення ДМ до Держскарбницi'
         where ref=REF_ and stmt=gl.astmt;

        nlsk_ := nbs_ob22('3622','52');
        S_    := round( p_Sum1 * 20/100 ,0 );
        gl.payv( 0, REF_, gl.bDATE, TT_, 1, kv_, nlsa_, s_, kv_, nlsk_,S_ );

        update opldok
           set txt ='Вiдображення суми податкових зобов`язань з ПДВ'
         where ref=REF_ and stmt=gl.astmt;


  elsIf p_Par= 3 then
        update opldok
           set txt ='Визнання деб.заборгованостi згiдно пiдтвердження'
         where ref=REF_ and stmt=gl.astmt;

  elsIf p_Par= 4 then null;
        update opldok
           set txt ='Закриття деб. i кред.заборг.пiсля розрахункiв'
         where ref=REF_ and stmt=gl.astmt;

        If S1_ <> S2_ then
           S_ := s2_ - s1_;
           If S_ > 0 then
              nlsk_:= nbs_ob22('6499','01');
              gl.payv (0,REF_,gl.bDATE,TT_,1,kv_, nlsA_, S_, kv_, nlsk_,S_ );
              update opldok
                 set txt = 'визнання доходiв'
               where ref=REF_ and stmt=gl.astmt;

              P_ := P2_ - p1_;
              If p_ > 0 then
                 nlsk_:= nbs_ob22('3622','52');
                 gl.payv (0,REF_,gl.bDATE,TT_,1,kv_, nlsA_, p_, kv_, nlsk_,p_ );
                 update opldok
                    set txt = 'Перерахунок податкових зобов`язань з ПДВ '
                  where ref=REF_ and stmt=gl.astmt;
              end if;

           else
              nlsd_:= nbs_ob22('7499','17');
              gl.payv (0,REF_,gl.bDATE,TT_,1,kv_, nlsd_, -S_, kv_, nlsB_,-S_ );
              update opldok
                 set txt = 'визнання витрат'
               where ref=REF_ and stmt=gl.astmt;
              P_ := P1_ - p2_;
              If p_ > 0 then
                 nlsd_:= nbs_ob22('3622','52');
                 gl.payv (0,REF_,gl.bDATE,TT_,1,kv_, nlsd_, p_, kv_, nlsB_,p_ );
                 update opldok
                    set txt = 'Перерахунок податкових зобов`язань з ПДВ '
                  where ref=REF_ and stmt=gl.astmt;
              end if;
           end if;

        end if;

        nlsd_ := nbs_ob22('3622','52');
        nlsk_ := nbs_ob22('3622','51');
        gl.payv   (0,REF_,gl.bDATE,TT_, 1,kv_, nlsd_, p2_, kv_, nlsk_,p2_ );
        update opldok
           set txt = 'Вiдображення податкових зобов`язань з ПДВ '
               where ref=REF_ and stmt=gl.astmt;
  end if;

end cc_lom;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_LOM.sql =========*** End *** ==
PROMPT ===================================================================================== 
