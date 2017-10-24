
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nru.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NRU IS   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1.0 14.11.2016 ������� ��';
 function  NOK2    ( p_NLS varchar2, p_dat date) return varchar2 ;
 procedure OPL1    ( oo IN OUT oper%rowtype) ;  -- ������ 1 ��������
 procedure ACC1    ( p_acc number, p_dat date ) ;  -- ��������� ����� ������ (������ )
 procedure ACC_all ( p_acc number, p_dat date ) ;  -- ��������� ��� ����� � �������
 procedure OK1     ( p_acc number, p_NLS varchar2 , p_fl int, p_dat date ) ; -- �������� ����� ������ �� ������������ �� ���������
 procedure OK_ALL  ( p_ACC number, p_fl int , p_Dat date ) ;   -- �����/��������� � ��������� ������
 ----------------------------------------
 function header_version return varchar2;
 function body_version   return varchar2;
  -------------------
END NRU;
/
CREATE OR REPLACE PACKAGE BODY BARS.NRU IS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.3  21.12.2016 COBUSUPABS-4916. ������� ��';

--21.12.2016 2608, 2518, 2528, 2538, 2548, 2558, 2568, 2658, 3570, 3579

 g_errN number := -20203 ; g_errS varchar2(8) := 'NRU:'  ; nlchr char(2) := chr(13)||chr(10) ;
 gn_2903 accounts.nls%type;
 gs_2903 accounts.nms%type;
 ------------------------------------

function NOK2( p_nls varchar2, p_dat date) return varchar2 is
  z_dat date          ;  z_dat3 date ;   l_Err varchar2(35)  ;
begin
  If p_dat is not null then z_dat := p_dat ;  PUL.PUT ( 'DAT', to_char(p_dat,'dd.mm.yyyy') );
  else                      z_dat := to_date( PUL.GET ( 'DAT'),'dd.mm.yyyy')  ;
  end if ;
  z_dat3  := add_months ( z_dat, -36 )   ;
  ---------------------------------

  for aa in (select * from accounts where dazs is null and nls = p_nls)  -- �������� ����������� ��������� ������ ��������� ������� �� ���������,
  loop
     -- ��� ����� �����������, ���� ������ ���� � ���� �  ���� :
     -- 1) �������� ������ �� ������� � ������� ��������;
     -- 2) ���������� ������� ������� 2605, 2655;
     -- 3) ���������� ������� ������� 2604 �� ������� �������
     -- 4) ���� + 9***� �����. = �������� ������ �� ������� � �������� �������� �� �������� ��� 9 �� (������ !) � �������� ;

     If nvl(aa.dapp, aa.daos) > z_dat3                     then l_err := '����� 3-����';
     ElsIf  aa.ostc < 0                                    then l_err := '������� < 0';
     ElsIf  aa.nbs in ('2605','2655')                      then l_err := '���.���='||aa.nbs  ;
     ElsIf  aa.nbs  = '2604' and aa.ostc <> 0              then l_err := '��=2604 + �������' ;
     ElsIf  aa.blkd > 0 or aa.lim < 0 then
        If  aa.OSTC > 0  then l_err := '���� + �������'    ;
        Else
            begin select '���� + 9* ���.'  into l_Err from accounts where nbs like '9%' and ostc <> 0 and rnk = aa.rnk and rownum = 1;
            exception when no_data_found then null ;
            end ;
        end if;
     end if;

     If l_err is not null then     RETURN aa.kv||'*'||l_err;    end if;
  end loop;

  RETURN '' ;
end NOK2 ;

-----------------
procedure OPL1  ( oo IN OUT oper%rowtype) is  -- ������ 1 ��������
begin
   If oo.ref is null then   gl.ref (oo.REF);    oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
      gl.in_doc3 (ref_=>oo.REF  ,   tt_ =>oo.tt  ,  vob_=> 6     ,  nd_  =>oo.nd   , pdat_=>SYSDATE, vdat_=>gl.BDATE,  dk_ =>oo.dk,
                   kv_=>oo.kv   ,   s_  =>oo.S   ,  kv2_=>oo.kv  ,  s2_  =>oo.S    , sk_  => null  , data_=>gl.BDATE, datp_=>gl.bdate,
                nam_a_=>oo.nam_a,  nlsa_=>oo.nlsa, mfoa_=>gl.aMfo, nam_b_=>oo.nam_b, nlsb_=>oo.nlsb, mfob_=>gl.aMfo ,
                 nazn_=>oo.nazn , d_rec_=>null   , id_a_=>oo.id_a,  id_b_=>gl.aOkpo, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null);
   end if;
   gl.payv(0, oo.ref, gl.BDATE, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv,  oo.nlsb, oo.s);
   gl.pay (2, oo.ref, gl.BDATE ) ;
end OPL1;
-------------

procedure ACC1   ( p_acc number, p_dat date  ) is  -- ��������� ����� ������ (������ )
   aa accounts%rowtype ; oo oper%rowtype ;  rr NRU_OK%rowtype;   z_dat date ;    Fl_Kl  int := 0;
   ------------------
   code_   NUMBER;
   erm_    VARCHAR2(2048);
   tmp_    VARCHAR2(2048);
   status_ VARCHAR2(10);
   l_recid number;
  --------------------

   Function XXX (p_nbs accounts.nbs%type, p_ob22 accounts.ob22%type) return int is          l_ret int := 0 ;
   begin  begin select 1 into l_Ret from NRU_BAL nn where nn.nbs = p_nbs and p_ob22 = NVL(nn.ob22, p_ob22) ;
          exception when no_data_found then null ;
          end;
          RETURN l_ret ;
   end XXX ;

 begin

   If p_dat is not null then z_dat := p_dat ;  PUL.PUT ( 'DAT', to_char(p_dat,'dd.mm.yyyy') );
   else                      z_dat := to_date( PUL.GET ( 'DAT'),'dd.mm.yyyy')  ;
   end if ;

   begin select * into rr from nru_ok   where acc = p_acc and serr is null;
         select * into aa from accounts where acc = p_acc ;
   exception when no_data_found then RETURN ;
   end;

   If nru.NOK2( aa.nls, z_dat )  is not null then RETURN ; end if ;
   ---------------------------------------------------------------
   -- ������ ���������� �� ��������� ������� ����������
   -------------------------
   SAVEPOINT do_OPL ;
   ------------------
   begin     oo.ref := null   ;
      for k in (select * from accounts where rnk = aa.rnk and dazs is null )
      loop
         -- ��� ����� �������.
         If k.nbs not in ('2608', '2518', '2528', '2538', '2548', '2558', '2568', '2658', '3570', '3579')
                  and k.nls <> aa.nls         OR
            k.nbs in ('2605','2655')          OR
            k.nbs  = '2604' and k.ostc <> 0   OR
            k.ostc < 0                        OR
           (k.ostc > 0 and k.blkd > 0 )       OR
            k.lim  < 0                        OR
            k.ostc <> 0 and k.nbs like '9%'   Or
            nvl(k.dapp, k.daos) > add_months(z_dat,-36)  then
            Fl_Kl  := 1 ;   goto Rec_next  ;  -- ������� ��������� �� �����
         end if;
         ---------------------------------------------------------
         If k.ostc > 0 and k.nls < '4' then   -- ����.����� = ����������� �� ����� 2903
            begin select nmk, okpo into oo.nazn , oo.id_a from customer where rnk = aa.RNK;
            exception when no_data_found then RETURN ;
            end;
            oo.tt   := '024' ;      oo.kv := k.kv ;
            oo.nlsa := k.nls ;                             oo.nam_a :=  substr(k.nms,1,38);
            oo.nlsb := Vkrzn(substr(gl.aMfo,1,5),'29030'); oo.nam_b := '������� ������� ��������� ���.��' ;
            oo.nazn := Substr( oo.nazn||'. '||  to_char (nvl(k.dapp,k.daos),'dd.mm.yyyy')||
                            '. ����������� ������� ����� �� ������� ����� ����-� �����-� �����' , 1 , 160 ) ;
            If k.ostc > 0 then oo.dk := 1; oo.s :=   k.ostc ;
            else               oo.dk := 0; oo.s := - k.ostc ;
           end if ;
            NRU.opl1 ( oo ) ;
         end if ;
         --- �) �������� ���������� �� �� �� �� ��� �������,
         --- �) ��� ������� ���������� ����������� ��� �������� �������� �������
         Update accounts set blkd=1, blkk = 1, dazs = DAT_NEXT_U( gl.bdate, 1 ) where acc = k.acc;
         -- ��� ����� ���������� ��� ����� �ϲ ��� �������� ������� ��������� � ����� �������� �5� - ���� ������� (������� ������� �� �� ���������� �볺���).
         -- ��� �������� ����� (update DAZS) ����������� ������� TBU_ACCOUNTS_TAX.   �� ��������(�� ���) ������ �� ����� ����� �
         update REE_TMP set OT = 5 where mfo = gl.amfo and nls = k.nls AND kv = k.kv ;
         -- �) �������� �� �������� �볺��� �������� ��������� �� ��������� � �� ������������ ������������ ���� �������� �������.
         accreg.setAccountwParam (  p_acc => k.acc,  p_tag  =>'PRIM_CL',  p_val =>'�������� �� ���������');
         ---------------
         <<Rec_next>> null;
      end loop  ;  -- k
      ---------------------------
      delete from NRU_OK where acc = aa.acc;
      --- �) ������� ������� ���, �� �� ����� ������� �������.
      Update customer x  set DATE_OFF = DAT_NEXT_U(gl.bdate,1) where x.rnk = aa.rnk and not exists (select 1 from accounts where rnk = aa.rnk and dazs is null)  ;
      -- 3) ������������ 2903 � ��� �볺��� - ���� ������� ������ ����������� ������� 2903/01 � ��� �볺��� �� ��� �����, �� ������� ������� ��� �볺��� ��� ��������� ������� ������� �� �����.
   exception when others then    ROLLBACK TO do_OPL;
      BARS_AUDIT.error(   p_msg    => 'NRU-err*'|| SQLERRM,
                          p_module =>  null,
                          p_machine => null,
                          p_recid   => l_recid
                       );
      deb.trap(SQLERRM,code_,erm_,status_);
      IF code_<=-20000 THEN  bars_error.get_error_info( SQLERRM,erm_,tmp_,tmp_ );  END IF;
      update  NRU_OK set serr = substr(l_recid||'*'||erm_,1,70) where acc = aa.acc;
   end  ;
   commit ;
 end ACC1 ;
 ----------

 procedure ACC_all ( p_acc number, p_dat date ) is  -- ��������� ��� ����� � �������
   z_dat date ;
 begin
   If p_dat is not null then z_dat := p_dat ;  PUL.PUT ( 'DAT', to_char(p_dat,'dd.mm.yyyy') );
   else                      z_dat := to_date( PUL.GET ( 'DAT'),'dd.mm.yyyy')  ;
   end if ;

   for rr in (select *  from nru_ok   where serr is null)
   loop  NRU.ACC1   ( rr.acc, z_dat ) ; end loop ;   -- ��������� ����� ������ (������ )
 end ACC_all ;
 -------------

 procedure OK1  ( p_acc number, p_NLS varchar2 , p_fl int, p_dat date ) is -- �������� ����� ������ �� ������������ �� ���������
   z_dat date;
 begin
   delete from NRU_OK  where acc  = p_acc  ;

   If p_fl = 1 then
      If p_dat is not null then z_dat := p_dat ;  PUL.PUT ( 'DAT', to_char(p_dat,'dd.mm.yyyy') );
      else                      z_dat := to_date( PUL.GET ( 'DAT'),'dd.mm.yyyy')  ;
      end if ;
      insert into NRU_OK (acc, serr) values ( p_acc , NRU.NOK2( p_NLS, z_dat )  ) ;
   end if ;

 end OK1  ;
 ----------

 procedure OK_ALL ( p_ACC number, p_fl int , p_Dat date ) is   -- �����/��������� � ��������� ������
    z_dat  date;  z_dat3 date;
 begin
   If p_dat is not null then z_dat := p_dat ;  PUL.PUT ( 'DAT', to_char(p_dat,'dd.mm.yyyy') );
   else                      z_dat := to_date( PUL.GET ( 'DAT'),'dd.mm.yyyy')  ;
   end if ;
   z_dat3 := add_months (z_dat, - 36 );

   for k in (select a.acc, a.nls  from accounts a, nru_bal b where  a.dazs is null and nvl(a.dapp, a.daos) <= z_dat3
                       and a.nbs = B.NBS and a.ob22 = decode (a.nbs, '2650', b.ob22, a.ob22)              )
   loop   NRU.OK1  (k.acc, k.nls,  p_FL, p_Dat ) ; end loop ;
 end OK_ALL;
 ----------

function header_version return varchar2 is begin  return 'Package header NRU '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body NRU '  ||G_BODY_VERSION  ; end body_version;

---��������� ���� --------------
begin  Null;
   gn_2903 := Vkrzn(substr(gl.aMfo,1,5),'29030');
   gs_2903 := '������� ������� ��������� ���.��' ;

   declare  p4_ int; accR_ number;
   begin
      For x in (select kv from tabval where d_close is null )
      loop  op_reg ( 99,0, 0,0, p4_, gl.aRnk, gn_2903, x.kv, gs_2903, 'NLU', gl.aUid, accR_ );
            Accreg.setAccountSParam(accR_, 'OB22', '01' ) ;
      end loop;
   end;
   commit;

END NRU;
/
 show err;
 
PROMPT *** Create  grants  NRU ***
grant EXECUTE                                                                on NRU             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NRU             to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nru.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 