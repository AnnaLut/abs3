
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/xoz.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.XOZ IS
  g_header_version   CONSTANT VARCHAR2 (64) := 'version 4.1  17.10.2017';
--============ �������� ���.������������� �� ���.������������ �����  ===============----------------
/*
17.10.2017 Sta ���� ���� �������� ���������� ��� �������� 2-� � ����� ���������,� ���� ���� ����� ����� � ���, �������� �� ���� ������ ������� 
29.09.2017 ����-�������� �� �������� �������� XOZ.CLS (0)
14.08.2017 ������. �������� �������� ��������. �������� ������������� �����
27.07.2017 Sta ��������� ������� "����" ��� ������������� ��������������� procedure Balancing
19.07.2017 ������. 1) ������ ����� ��� ����� W4X ��� ���.������ 3550, 3551 ( ���.��� ��� ��)
                   2) � ������ ���.��� ������� ������������ ���� ������ XOZ � W4X
12.07.2017 Sta ������� ��������� (������ ������) ��� 0 ������� � ��������� ���������� ������������
06.07.2017 Sta ���������� ���� XOZ ���  ��������� ������������ ���������
16.06.2017 Sta �������� ����� �� ���������� ���� ���������� ��� ���������� ��������
19.05.2017 Sta ��������� STOP_T0. �������� �� ������������������ ��������� � ��������
15.05.2017 Sta V_XOZ7_CA.������ ��. �������� ��, �� ������� � ��
27.02.2017 Sta ����� ������ ( ��� ���� ) ������ � ���� ����� ������ � ��������
26.04.2016 Sta ��� ��� ����� � ���� 441 �� �� ���� ���.���
25.04.2016 Sta �������� ���/��� ������� ���������� � ������� �����-3
22.02.2016 Sta ����������� ���.������������� � ������ ���� ��� ������� ��������
OPER_XOZ     = ������ ��������� ������������� � ������� XOZ
OPER_XOZ_ADD = ������������ ����������� ������� ���������  XOZ
*/
-----------------------------------------------
procedure CLS  (p_acc number ) ; --- ����-�������� �� �������� ��������
procedure Del_KWT   (p_REF1 number, p_STMT1 number, p_REF2 number ) ; --- ��������� �������� ������������� �����
procedure Balancing (p_acc  number ) ; --- ��������� ������� "����" ��� ������������� ���������������
procedure NOT_RD    (p_acc  number, p_DV1 date, p_DV2 date ) ;

procedure STOP_T0
  ( p_mode int,    -- �����. ������
    p_dat31 date   -- �������� ����,  ���� ���� 31 ����� 31.MM.YYYY
   ) ;
-------------------
procedure XOZ7   ( p_mode int,  -- 2 - �������� ��� ��������. 77 - �������� ������� � ������
                   p_ri   varchar2,
                   p_nls7 varchar2,
                   p_s7   number  ,
                   p_nazn varchar2,
                   p_kodz varchar2,
                   p_ob40 varchar2 ) ;

procedure START1 ( p_acc XOZ_ref.acc%type );                                 --��������� ������������ ��������� ����� �������
procedure START2 ( p_acc XOZ_ref.acc%type, p_dat0 date, p_fdat date ) ;      --���������� �����-��������� ��� ������ ���.XOZ �� ������ ����
procedure BEK_441( p_ref2 number);
procedure PULX( p_ref1 number,  p_stmt1 number);                             -- �������� ������� ��� ����� ������� ���� �� �����-3
procedure xozU ( p_mode int, p_rec number  ,  p_nls varchar2,    p_s   number , p_RI varchar2 ) ;
FUNCTION  MDATE(p_acc  opldok.acc%type,  p_fdat opldok.fdat%type  ) return xoz_ref.mdate%type;
FUNCTION  DREC (p_drec varchar2, p_tag  varchar2 ) return varchar2 ;         --����������� ���.���� �� DREC

procedure INS_REF1( p_ref1  XOZ_ref.ref1%type,  p_stmt1 XOZ_ref.stmt1%type ); --������� � ��������� ���������

 --���� � ��������� ���������
procedure UPD_REF1( p_ref1  XOZ_ref.ref1%type ,
                    p_stmt1 XOZ_ref.stmt1%type,
                    p_fdat  XOZ_ref.mdate%type, --���� �������������
                    p_MDATE XOZ_ref.mdate%type, --����-���� ��������
                    p_NOTP  XOZ_ref.NOTP%type   --������� "���.���". 1 = � ���-23 �� ��������� ��������� �� ����, ��� ���������
                   ) ;
--------------------------------
procedure OPL_REF_H2
  ( p_acc   XOZ_ref.acc%type   ,
    p_ref1  XOZ_ref.ref1%type  ,
    p_stmt1 XOZ_ref.stmt1%type ,
    p_DV1   date               ,
    p_S     XOZ_ref.s%type     ,
    p_REF2  XOZ_ref.ref2%type  ,
    p_ZO    int                ,
    p_SP    number             ,
    p_DV2   date               ) ; ----------������ ������  ������� (��� ������, ������ ����_
--------------------------------

--� �������� � �������
procedure OPL_REF2( p_acc   XOZ_ref.acc%type   ,
                    p_ref1  XOZ_ref.ref1%type  ,
                    p_stmt1 XOZ_ref.stmt1%type ,
                    p_DV1   date               ,
                    p_S     XOZ_ref.s%type     ,
                    p_ZO    int                ,
                    p_SP    number             ,
                    p_DV2   date               ,
                    p_nazn  oper.nazn%type     ,
                    p_KDZ1  varchar2           ,
                    p_SDZ1  varchar2           ,
                    p_OB40  varchar2           ,
                    p_nlsa  oper.nlsa%type     ) ;
-----------------------------------------------------
-- ���.����� �� �� �� �� �� ��������
procedure OPL_REFD( p_acc   XOZ_ref.acc%type   ,
                    p_ref1  XOZ_ref.ref1%type  ,
                    p_stmt1 XOZ_ref.stmt1%type ,
                    p_DV1   date               ,
                    p_S     XOZ_ref.s%type     ,
                    p_ZO    int                ,
                    p_SP    number             ,
                    p_DV2   date               ,
                    p_nazn  oper.nazn%type     ,
                    p_KDZ1  varchar2           ,
                    p_SDZ1  varchar2           ,
                    p_OB40  varchar2           ,
                    p_nlsa  oper.nlsa%type     ) ;


-- ������������� �� ³����������� ����� �� �� � �� � �����������  �������  �� ���
procedure OPL_REFK
( p_rec  IN  number  ,
  p_txt  IN  varchar2,
  oo     OUT oper%rowtype
 ) ;

-- �������� ����������� ������� �� �������
procedure OPL_REFK1
( p_rec   number            ,
  p_s     number            ,
  p_nlsa  oper.nlsa%type    ,   -- :A(SEM=��� ���,REF=V_XOZOB22_NLS),
  p_ZO    int               ,   -- :Z(SEM=����=1,TYPE=N),
  p_nazn  oper.nazn%type    ,   -- :T(SEM=ϳ������),
  p_KDZ1  varchar2          ,   -- :X(SEM=��� ��,REF=KOD_DZ),
  p_OB40  varchar2              -- :O(SEM=OB40 ��� �40,REF=KF_OB40)
) ;
----------------------------------------------------
procedure OPL_CA (p_mode int  )  ;  -- �� ������-������ -- ������� ������������� ������� ��, �� �������
----------------------------------------------------

--��������� ������������ ���������
procedure INS0 ( p_acc XOZ_ref.acc%type);

--- ������ ��� �� 23
procedure REZ ( S_DAT01 IN  VARCHAR2, --:s(SEM=��_����_01,TYPE=s),
                p_modeZ IN  int      -- :Z(SEM=�����.� nbu23_rez 1= ��, 0=���)
               );
--------------------------------------------
   FUNCTION header_version   RETURN VARCHAR2;
   FUNCTION body_version     RETURN VARCHAR2;
-------------------
END XOZ;
/
CREATE OR REPLACE PACKAGE BODY BARS.XOZ IS
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 4  29.09.2017-1';
--------------------------------------------

/*29.09.2017 ����-�������� �� �������� �������� XOZ.CLS (0)
  29.08.2017 ������  --����������� ������� � �������� ���� ���2 = oo.ref (�� ����-�������� ����������)
  18.08.2017 ������. ��� ������������������ �� ������
  14.08.2017 ������. �������� �������� ��������. �������� ������������� �����
     ���� ������ REF ��������� �����������, �� ������������� ���������� ����� ������� ������������.
     ���� ������ REF ��������� ������� ��������, �� ���������� ���������� ����� ������� ������������.

  10.08.2017 ��� - ����� ������� �� 100
  28.07.2017 Sta ��������� ������� "����" ��� ������������� ��������������� procedure Balancing
  26.07.2017 Sta ���  � ��������
  24.07.2017 ������. ������ �������� �������  � �������� ���� XOZ
  20.07.2017 ������+��+�� ��������� ���� S0
        ��� ������� � ��������� S0 = S  = ���������   ����� ��������
        ��� �������� ������     S0 = S  = ����������� ����� ��������  =  ���������   ����� ��������
        ��� �������� ���������  S0 = Z  = ����������� ����� ��������  <  ���������   ����� �������� , ������� (S-Z) ����������� � ��.������
        �������� STOP_T0 ������ �������� �� S0
  --------------------------------------------


  19.07.2017 ������. 1) ������ ����� ��� ����� W4X ��� ���.������ 3550, 3551 ( ���.��� ��� ��)
                   2) � ������ ���.��� ������� ������������ ���� ������ XOZ � W4X

  06.07.2017 Sta ���������� ���� XOZ ���  ��������� ������������ ���������
  16.06.2017 Sta ����� �� ���������� ���� ���������� ��� ���������� �������
  15.06.2017 Sta XOZ7
  14.06.2017 Sta XOZ_ob22_cl.DZ = ����� �� ~���.�����~�� ��
                 XOZ_ob22_cl.RD = ����� �� ~������.����~����������
                 �������� � ��������� - �� ����� !   ��������� � ���������� ��� - ���.  26.04.2016 Sta ��� ��� ����� � ���� 441 �� �� ���� ���.���
                 ������� � ��� ������� �����

  09.06.2017 Sta -- ���������� XOZ_ob22_cl ��� ����������� ���� ���������
  02.06.2017 Sta -- ��������� ��������� ��� �������� �������� OPL_REF_H2
  19.05.2017 Sta -- ��������� STOP_T0. �������� �� ������������������ ��������� � ��������
  17.05.2017 Sta �������� ���� �� ��������� �� ��������  �� ����� ����� ������ ��� ����������. �������� ���������� ������ !
               V_XOZ7_CA.������ ��. �������� ��, �� ������� � ��
  19.04.2017 ���.����� �� �� �� �� �� ��������
  03-02-2017 Luda ������������ ������ �� 23 ���������
  23.11.2016 Sta �������� ������� ��� �� XO1 �� oper.tt - ����� �� ������������ �� �������� ��������.
  26.04.2016 Sta ��� ��� ����� � ���� 441 �� �� ���� ���.���
  25.04.2016 Sta �������� ���/��� ������� ���������� � ������� �����-3
  22.03.2016 Sta �������� ������� � ������ �������� - ��������������
  22.02.2016 Sta ����������� ���.������������� � ������ ���� ��� ������� ��������
  31.01.2016 Sta OPER_XOZ     = ������ ��������� ������������� � ������� XOZ
                 OPER_XOZ_ADD = ������������ ����������� ������� ���������  XOZ
  02-07-2014  NVV  ��� ���������� ���� ����������� ������������ ������� ���������� ���� ������������ �����.
  19.06.2014  �� ����������� ������������ � ������� ��. �������� �.�.
  -------------------------------------------------------------------
  -- �� ����������� ������������ ����������� �� ��� ��
  05-05-2014 ���� �������� - �� S180.
  17.04.2014 1) ������������ ������� �������� ������������� � ������������� ���� �������� 441 (������ 420)
                � ���������  ���������� ��������� ��������.
                ������ ��� ��������� �������� 441 � ������.
             2) ��� ������� ������������� �� ���˲������ ��� �������� �������.
             3) ��� ������� ������������� ������ ��������� ��� ����ղ����Ҳ ����������� �� ��������
                ������� �������� �������� �������� � k_dz1,s_dz1,  OB40.
             4) ������������ ���� ������� ��� �������� ������������� ����� ��� �� ��������� ���� - ���������� ����� � �������,
                �� ���������� ����� ������� (���������� ������� ��_22), ������������� �� ����� �����������.
             5) ������������ ������� ����� ������� "���.������ �� ���� �������� �����" � ����� ����'���� ����-���� ���������
               (������������ � �������� ������, ����������, �������� ����� ��������� ������ �� ��.)
               �� ��������� ������������  � ��������� �����������  � ���������.

               ��� ���������( �������- ������ ) -�������� ��������� � �������� ����������-������������ ������������ ������ ��, �������
                �	������- ���������� �����
                �	����� � �� ������� ���������� �� ������ �������� (��.4)
                �	���-�������� ������ ���-��������(�������)
                �	���� �������� ������ ���� ��������.

  17.03.2014 XOZ.OPL_REF2(:ACC,:REF1,:STMT1,:NLSA,:NAZNZ,:S,:MDATE,:NOTP, :PRG, :BU)
  1 � ������� �������
  2 � ������� ����.������� = Branch2 (����� �� Branch)
  3 � �������� ��� �������� �� �������

 02.12.2013 Sta � ���� ���� ��������� ��� �������� STMT
*/
-------------------------------------
nlchr char(2) := chr(13)||chr(10) ;
--------------------------------------------------------------------
procedure CLS  (p_acc number ) is --- ����-�������� �� �������� ��������
begin
  update xoz_ref x 
     set x.ref2  = 0,
         x.datz  = (select dazs from accounts where acc = x.acc )
  where p_acc in ( 0, x.acc) 
    and ref2  is   null
    and exists   ( select 1 from accounts where acc = x.acc and dazs is not null) ;
end  CLS;

procedure Del_KWT   (p_REF1 number, p_STMT1 number, p_REF2 number ) is --- ��������� �������� ������������� �����
begin
   update XOZ_ref set ref2=null, DATZ=NULL, s=s0 where ref1= p_REF1 and stmt1=p_STMT1 and ref2=p_REF2;
end Del_KWT;


procedure Balancing (p_acc number ) is --- ��������� ������� "����" ��� ������������� ���������������
  AA ACCOUNTS%ROWTYPE;
  XX  XOZ_REF%ROWTYPE;
  l_S    number ;

begin
  begin
     SELECT *             into AA  FROM accounts WHERE acc = p_acc ;
     Select Nvl(SUM(s),0) into l_S FROM xoz_ref  WHERE acc = p_acc and s > 0 AND ref2 IS NULL ;
     XX.S := - (aa.Ostc + l_S ) ;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000,'XOZ:�� �������� acc='||p_acc  );
  end ;
  If XX.S <= 0 then RETURN; end if;

  aa.nms := Substr(aa.nms,1,38);
  gl.ref (XX.Ref1);
  INSERT INTO oper (REF ,  tt ,vob,        nd,dk,  PDAT,    VDAT,    DATD,    DATP, nam_a,  nlsa,   mfoa,   kv,   s, nam_b,  nlsb,   mfob,  kv2,  s2, userid, nazn )
         VALUES (xx.ref1,'024',6,'Balans.XOZ',1,SYSDATE,gl.bDATE,gl.bDATE,gl.bDATE,aa.nms,aa.nls,gl.AMFO,aa.KV,xx.s,aa.nms,aa.nls,gl.AMFO,aa.KV,xx.s,gl.aUid,
                                                                                          '������������ ���������� �������, �� �������� ����� ������� � ���������');
  XX.STMT1 := bars_sqnc.get_nextval('s_stmt') ;

  begin     select to_date( value, 'dd-mm-yyyy')     into XX.FDAT from accountsw where acc = p_acc and tag = 'DATVZ' ; -- ���� ���������� ������������� �� �������
  exception when no_data_found then select min(fdat) into XX.FDAT from saldoa    where acc = p_acc;  -- ����������� ���� , ��������� �������
  end ;
  XX.MDATE :=  XOZ_MDATE ( aa.acc, XX.FDAT, aa.nbs, aa.ob22, aa.mdate ) ;

  INSERT INTO XOZ_ref (acc,ref1,stmt1,s,s0,fdat,mdate) values (p_acc, XX.Ref1, XX.STMT1 , XX.S, XX.S, XX.fdat, XX.MDATE );

end Balancing ;

procedure NOT_RD (p_acc number, p_DV1 date, p_DV2 date ) is
  -- �������� ����� �� ���������� ���� ���������� ��� ���������� ��������
  xx xoz_ob22_cl%rowtype;
begin
  If NVL(p_DV2, p_DV1) <> P_DV1 then

     begin select nbs||ob22 into xx.deb from accounts where acc = p_acc;
     EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000,'XOZ/ACC='||p_acc||' ������� �� ��������' );
     end   ;

     begin select 1 into xx.RD from xoz_ob22_cl where deb = xx.deb and RD = 1 ;
     EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000,'XOZ/����.='||xx.Deb||' ��� ����� �� ���������� ���� ���������� ��� �����.�����' );
     end   ;

   end if  ;
end NOT_RD ;

procedure STOP_T0
  ( p_mode int,    -- �����. ������
    p_dat31 date   -- �������� ����,  ���� ���� 31 ����� 31.MM.YYYY
   )  IS
   count_Err int ;
begin
   select  count(*) into count_Err
   from (select acc, OST_KORR(acc,p_dat31,null,nbs) OST  from accounts where tip  IN ('XOZ','W4X')  ) a,
        (select acc, -sum(s0) S   from xoz_ref  where ( ref2 is null  OR  datz > p_dat31 ) group by acc ) x
   where a.acc = x.acc and a.OST < 0 and a.ost <> x.S ;

   If count_Err > 0 then
      raise_application_error(-20000, 'XOZ:'||count_Err || ' ������� � ���������. �� �� = ��������� !' );
   end if;

end STOP_T0;


----- V_XOZ7_CA.������ ��. �������� ��, �� ������� � ��
procedure XOZ7   ( p_mode int,  -- 2 - �������� ��� ��������. 77 - �������� ������� � ������
                   p_ri   varchar2,
                   p_nls7 varchar2,
                   p_s7   number  ,
                   p_nazn varchar2,
                   p_kodz varchar2,
                   p_ob40 varchar2 ) is

   aa arc_rrP%rowtype;
   oo oper%rowtype;

begin

   aa.rec := to_number (pul.get('RECD_CA')  ) ;
   If aa.rec is null  then  RETURN ;  end if  ;

---------------------------------------

If p_mode = 2 then
   If p_ri is null then
      insert into bars.XOZ7_ca ( REC, ACC7,   S7    ,   KODZ,   OB40,   nazn  )
                       select aa.rec, acc , p_s7*100, p_kodz, p_ob40, p_nazn
                       from accounts where kv = gl.baseval and nls =p_nls7 ;
   else
      update bars.XOZ7_ca set
        ACC7 = (select acc from accounts where kv=gl.baseval and nls =p_nls7 ),
          S7 = p_s7*100,   KODZ = p_kodz,   OB40 = p_ob40,     nazn = p_nazn
       where rowid = p_ri;
   end if;

elsIf p_mode = 77 then

   select NVL( sum(s7), 0)  into oo.S from XOZ7_ca x where rec = aa.rec and exists (select 1 from accounts where acc = x.acc7)  ;
   If oo.S <= 0 then raise_application_error(-20000, 'XOZ7: ���� <= 0. ������ ��������� !' );  end if;

   begin select * into aa from arc_rrP  WHERE rec = aa.rec and  dk = 2 ;
   EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20000, 'XOZ7 �� �������� ���.����� '|| aa.rec|| ' �� �� ! ' );
   end;

   If oo.S <> aa.s then
      raise_application_error(-20000, 'XOZ7:�������� ���� '|| TO_CHAR (aa.s/100,'FM999,999,999,999,999,990.00','NLS_NUMERIC_CHARACTERS=''. ''') ||
                                      ' �� ������� ��̲ ������ '|| TO_CHAR (oo.S/100,'FM999,999,999,999,999,990.00','NLS_NUMERIC_CHARACTERS=''. ''') ||
                                      '=в�����='|| TO_CHAR (aa.s/100 - oo.s/100,'FM999,999,999,999,999,990.00','NLS_NUMERIC_CHARACTERS=''. ''') ) ;
   end if;
-------------------------------------------------------
   oo.kv    := gl.baseval ;
   oo.kv2   := gl.baseval ;

   oo.nam_a := aa.nam_b ;  --\  ����������
   oo.nlsa  := aa.nlsb  ;  -- \
   oo.mfoa  := aa.Mfob  ;  -- /
   oo.id_a  := aa.id_b  ;  --/
   oo.nd    := aa.nd    ;

   oo.nam_b := aa.nam_a ;
   oo.nlsb  := aa.nlsa  ;
   oo.mfob  := aa.Mfoa  ;
   oo.id_b  := aa.id_a  ;
   oo.nazn  := aa.nazn  ;
   oo.d_rec := aa.d_rec ;

   oo.vob   := 6 ;
   oo.vdat  := gl.bdate ;
   ----------------
   oo.dk    := 1  ;
   oo.tt := 'MNK' ;
   oo.s     := aa.s ;
   oo.s2    := aa.s ;

   gl.ref(oo.REF) ;
   gl.in_doc3 (ref_  => oo.Ref  , tt_  => oo.tt  , vob_ => oo.vob , nd_  => oo.nd,  pdat_  => SYSDATE,  vdat_ => gl.BDATE,  dk_ => oo.dk ,
                kv_  => oo.kv   , s_   => oo.S   , kv2_ => oo.kv2 , s2_  => oo.S2,  sk_    => null,     data_ => gl.BDATE, datp_=> gl.bdate,
              nam_a_ => oo.nam_a, nlsa_=> oo.nlsa, mfoa_=> oo.Mfoa,
              nam_b_ => oo.nam_b, nlsb_=> oo.nlsb, mfob_=> oo.mfob,
              nazn_  => oo.nazn, d_rec_=> oo.d_rec,
              id_a_  => oo.id_a , id_b_=> oo.id_b, id_o_=> null, sign_=> null ,  sos_  => 1,   prty_ => null,  uid_ => null );
   paytt( 0, oo.REF, gl.bDATE, oo.TT, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.S2);

-------------------------------------------------------
   oo.dk    := 0 ;
   oo.tt    := '441';
   oo.mfob  := gl.aMfo  ;
   oo.id_b  := gl.aOkpo ;

   If p_s7 = 1 then  -- ����
      oo.vob  := 96;
      oo.vdat := dat_next_u( trunc(gl.BDATE,'MM'), -1 );
   end if;

   for k in (select x.rowid RI, a.nms, a.nls,  x.S7, x.KODZ, x.OB40, x.NAZN
             from XOZ7_ca x , accounts a
             where x.rec = aa.rec and x.s7 > 0 and x.acc7 = a.acc
            )
   loop  gl.ref(oo.REF);
         oo.s     := k.s7  ;
         oo.s2    := k.s7  ;
         oo.nam_b := substr(k.nms,1,38) ;
         oo.nlsb  := k.nls ;
         oo.nazn  := NVL( k.nazn, aa.nazn);

         gl.in_doc3 (ref_ => oo.REF  , tt_   => oo.tt   ,  vob_ => oo.vob ,  nd_ => oo.nd, pdat_ =>SYSDATE, vdat_=>oo.vdat ,  dk_ =>oo.dk,
                      kv_ => oo.kv   , s_    => oo.S    ,  kv2_ => oo.kv2 ,  s2_ => oo.S2, sk_   => null  , data_=>gl.BDATE, datp_=>gl.bdate,
                   nam_a_ => oo.nam_a, nlsa_ => oo.nlsa , mfoa_ => oo.mfoa,
                    nam_b_=> oo.nam_b, nlsb_ => oo.nlsb , mfob_ => oo.mfob,
                    nazn_ => oo.nazn , d_rec_=> oo.d_rec,
                    id_a_ => oo.id_a , id_b_ =>oo.id_b  , id_o_ => null   , sign_=> null, sos_ => 1, prty_=>null, uid_=>null );
         gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2,  oo.nlsb, oo.s2);
         If k.KODZ is not null then  BARS.set_operw ( p_ref => oo.ref, p_tag => 'KODDZ',   p_value => k.kodz ) ; end if ;
         If k.OB40 is not null then  BARS.set_operw ( p_ref => oo.ref, p_tag => 'OB40' ,   p_value => k.ob40 ) ; end if ;
         delete from XOZ7_ca  where rowid = k.RI ;
   end loop ; -- k
   delete from tzaproS where rec = aa.rec ;
   pul.put('RECD_CA', null ) ;

end if ;


end XOZ7;
-------------

--��������� ������������ ��������� �� ����� ����� ������ ��� ����������. �������� ���������� ������ !
procedure START1 ( p_acc XOZ_ref.acc%type )  is
BEGIN -- ������� ��� ������ ������� �����

  --06.07.2017 Sta ���������� ���� XOZ ���  ��������� ������������ ���������
  for k2 in (select * from accounts where dazs is null and tip NOT IN ( 'XOZ','W4X')  and (nbs||ob22) in  (select DEB from  XOZ_OB22_CL) )
  LOOP IF K2.TIP LIKE 'W4_' THEN  K2.TIP := 'W4X' ;
       ELSE                       K2.TIP := 'XOZ' ;
       END IF;
       UPDATE  ACCOUNTS SET TIP = K2.TIP  WHERE ACC = K2.ACC ;
  end loop; -- K2
  ----------------


  for a35 in (select * from accounts where dazs is null and pap = 1
--and kv = 980
                and tip IN ('XOZ','W4X') and p_acc in (0,acc) and dazs is null
              )
  loop
     delete  from xoz_ref where acc = a35.acc ;
     If a35.ostc < 0 then
        for x in ( select o.REF, o.stmt, o.s, o.fdat, xoz.MDATE(a35.acc,o.fdat) MDATE
                   from opldok o, saldoa s
                   where s.acc = a35.acc and s.fdat <= a35.dapp and o.acc = s.acc and o.fdat = s.fdat and o.dk = 0 and o.sos = 5 and s.dos >0
                   order by s.fdat DESC, o.ref
                  )
        loop
           If a35.ostc >=  0  then  EXIT; end if;
           a35.ostc := a35.ostc + x.s ;
           INSERT INTO XOZ_ref (acc, ref1, stmt1, s, s0, fdat, mdate) values ( a35.acc, x.REF, x.stmt, x.s, x.s, x.fdat, x.mdate );
        end loop ; -- x

        If a35.ostc  < 0  then  XOZ.Balancing (p_acc =>a35.acc  ); end if;

     end if;
  end loop ;  -- a35
end START1  ;
---------------

procedure START2 ( p_acc XOZ_ref.acc%type, p_dat0 date, p_fdat date )  is     --���������� �����-��������� ��� ������ ���.XOZ �� ������ ����
      l_dat0 date := NVL( p_fdat, p_dat0) ;
begin delete from XOZ_ref where acc = p_acc and fdat >= l_dat0 ;
      INSERT INTO XOZ_ref (acc,   ref1,   stmt1,   s,  s0,   fdat, mdate)
                  select x.acc, x.REF , x.stmt , x.s, x.s, x.fdat, xoz.MDATE(x.acc,x.fdat)
                  from opldok x, saldoa s
                  where s.acc = p_acc and s.fdat >= l_dat0 and x.acc =  s.acc and x.fdat = s.fdat and x.dk = 0 and x.sos >=4 ;
end;
-------------
procedure BEK_441 ( p_ref2 number) is  l_RI varchar2(200);    l_S number ;  l_s0  number;
begin

   begin select x.rowid, (x.S + o.S), x.S0 into l_RI, l_S, l_s0 from xoz_ref x, oper o where o.ref = p_ref2 and o.ref = x.ref2  and o.tt = '441';
   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
   end;

   If l_S  <= l_S0 then    update xoz_ref set ref2 = null, datz = null, s = l_s   where rowid = l_RI ;
   else                    update xoz_ref set ref2 = null, datz = null            where rowid = l_RI ;
   end if;

end BEK_441;


-- �������� ������� ��� ����� ������� ���� �� �����-3
procedure PULX( p_ref1 number,  p_stmt1 number) is
  nTmp_ number;
begin
  begin select 1 into nTmp_ from TMP_ARJK_OPER where ref = p_ref1 and s2= p_stmt1 and rownum = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN insert into TMP_ARJK_OPER (ref,s2,nnd) select p_ref1, p_stmt1, Branch from branch where LENGTH (branch) = 22 and DATE_CLOSED is null;
  end;

  PUL.Set_Mas_Ini( 'REF1' , To_Char(p_REF1 ), 'REF1'  );
  PUL.Set_Mas_Ini( 'STMT1', To_Char(p_STMT1), 'STMT1' );

  null;
end PULX;
------------
procedure xozU ( p_mode int, p_rec number  ,  p_nls varchar2,    p_s   number , p_RI varchar2 ) is
 l_ref oper.ref%type  ;
 l_nls oper.nlsa%type ;
 l_s   oper.s%type    ;
 l_ss  oper.s%type    ;
 l_sos oper.sos%type  ;
 l_tt  oper.tt%type   ;
 l_tip accounts.tip%type;
 l_acc accounts.acc%type;

begin

 If p_mode = 0 then  -- ��������� ���-����������
    PUL.PUT ('REFX', to_char(p_rec) );  PUL.PUT ('NLSX', p_nls );

 elsIf p_mode = 77 then  -- ��������  ����� �� ������� � ������

       l_REF := NVL (  p_rec , to_number ( pul.Get ('REFX') ) ) ;
       l_nls := NVL (  p_nls,               pul.Get('NLSX')   ) ;

       begin select nvl(sum(t.s),0), o.s, o.sos, o.nlsa, o.tt
             into  l_ss, l_s, l_sos , l_nls , l_tt
             from oper o, tmp_oper t             where o.ref= l_ref and o.ref= t.ref and o.sos> 0 and o.s> 0 and o.kv= o.kv2 and o.kv= gl.baseval
             group by o.s, o.sos, o.nlsa, o.tt   having  nvl(sum(t.s),0) = o.s;
       EXCEPTION WHEN NO_DATA_FOUND THEN     raise_application_error(-20000, 'XOZU ���� ��� �� = ��� ������� ��������. ������ ��������� !' );
       end;
       ----------------
       begin select acc, tip into  l_acc, l_tip  from accounts where kv =gl.baseval and nls = l_nls  ;
       EXCEPTION WHEN NO_DATA_FOUND THEN     raise_application_error(-20000, 'XOZU �� �������� ���������� ���=' || l_nls );
       end;
       ----------------

       If l_tip in ('XOZ','W4X')  then delete from xoz_ref where ref1 = l_REF and acc = l_acc ; end if;

       FOR K in (select t.rowid RI, t.nlsa, t.s  from tmp_OPER t where t.ref = l_REF)
       loop  gl.payv (0, l_ref, gl.bdate , l_tt, 1, gl.BASEVAL , k.nlsa, k.s, gl.baseval, l_nls, k.s);
             If l_sos = 5 then    gl.pay  (2, l_ref, gl.bdate ); end if ;
             delete from tmp_OPER where rowid = k.RI ;
       end loop;



 else  -- �C������/���� ������� ����

    l_ref := to_number ( pul.Get('REFX') );
    l_nls :=             pul.Get('NLSX')  ;
    l_s   := p_s * 100;

    If    p_mode = 1 then  insert into tmp_OPER    (  rec, NLSA,ref, s ) values (p_rec, p_nls, l_ref, l_s );
    ElsIf p_mode = 2 then  update      tmp_OPER set   rec   = p_rec, nlsa = p_nls, ref = l_ref, s = l_s where rowid =  p_RI ;
    ElsIf p_mode = 3 then  delete from tmp_OPER where rowid = p_RI ;
    end if;

 end if;

end xozU;
----------------------

FUNCTION MDATE (p_acc  opldok.acc%type,     p_fdat opldok.fdat%type ) return xoz_ref.mdate%type is  l_mdate date;
begin begin select XOZ_MDATE ( acc, p_fdat, nbs, ob22, mdate)  into l_mdate  from accounts where acc = p_acc  ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null  ;
      end;
       RETURN l_mdate;
end MDATE;
--------------------------------------------------------

--����������� ���.���� �� DREC
FUNCTION DREC (p_drec varchar2, p_tag  varchar2 ) return varchar2 is
  n_ int ;
  l_ int ;
  k_ int ;
  l_tag varchar2 (38) ;
  l_rec varchar2 (38) ;
begin
  l_tag := '#C'||p_tag||':'    ;          -- ��� � ����������
  l_    := length  (l_tag)     ;          -- ����� ���� ���.���������

  If l_ > 3 then

     n_ := instr(p_drec, l_tag, 1)  ; -- ������ ���.���������
     If SUBSTR(  p_drec, n_, l_ ) = l_tag then
        n_ := n_ + l_ ;
        k_ := instr(p_drec, '#' , n_)      ; -- �����  ���.���������
        l_ := k_ - n_ ;                               -- ����� ����.���.���������
        l_rec := substr ( p_drec, n_, l_) ;
     end if;
  end if;

  RETURN l_rec;

end;

--������� � ��������� ���������
procedure INS_REF1( p_ref1  XOZ_ref.ref1%type  ,
                    p_stmt1 XOZ_ref.stmt1%type ) is
begin
  INSERT INTO XOZ_ref (acc, ref1, stmt1,s, s0, fdat,    mdate           )
                select acc, ref , stmt, s, s , fdat, xoz.MDATE(acc,fdat)
                from opldok where ref=p_ref1 and stmt = p_stmt1 and dk = 0 ;
end INS_REF1;

--���� � ��������� ���������
procedure UPD_REF1( p_ref1  XOZ_ref.ref1%type ,
                    p_stmt1 XOZ_ref.stmt1%type,
                    p_fdat  XOZ_ref.mdate%type, --���� �������������
                    p_MDATE XOZ_ref.mdate%type, --����-���� ��������
                    p_NOTP  XOZ_ref.NOTP%type   --������� "���.���". 1 = � ���-23 �� ��������� ��������� �� ����, ��� ���������
                   ) is
 xx XOZ_ref%rowtype ;
 aa accounts%rowtype;
begin

 begin select * into xx from xoz_ref  where ref1 = p_ref1 and stmt1 = p_stmt1 and ref2 is null ;
       select * into aa from accounts where acc = xx.acc ;
 EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'XOZ/���.1=' || p_REF1 || ' �� �������� ������� ��' );
 end ;

 If p_fdat > gl.bdate then
    raise_application_error(-20000, 'XOZ/���.1='||p_REF1||' ���� ���������� ��='||to_char(p_fdat,'dd.mm.yyyy')||' > ������� ����.����'|| to_char(gl.bdate,'dd.mm.yyyy') );
 end if;

 If p_mdate < p_fdat  then
    raise_application_error(-20000, 'XOZ/���.1='||p_REF1||' ���� ������ ��='||to_char(p_mdate,'dd.mm.yyyy')||' < ���� ������.��='|| to_char(p_fdat ,'dd.mm.yyyy') );
 end if;

 If p_mdate > aa.mdate and aa.mdate is not null then
    raise_application_error(-20000, 'XOZ/���.1='||p_REF1||' ���� ������ ��='||to_char(p_mdate,'dd.mm.yyyy')||' > ���� ������.���='||to_char(aa.mdate,'dd.mm.yyyy') );
 end if;

 update XOZ_ref set fdat = p_fdat, mdate = p_mdate, notp = p_notp where ref1 = p_ref1 and stmt1 = p_stmt1;

end ;
--------------------------

-- ��������  ����� �������� (��� ���������� ��������)
procedure OPL_REF_H2
  ( p_acc   XOZ_ref.acc%type   ,
    p_ref1  XOZ_ref.ref1%type  ,
    p_stmt1 XOZ_ref.stmt1%type ,
    p_DV1   date               ,  -- ����� ���� ���������
    p_S     XOZ_ref.s%type     ,  -- �������
    p_REF2  XOZ_ref.ref2%type  ,  -- ���-2 ��� 0
    p_ZO    int                ,  -- ���� ����
    p_SP    number             ,  -- ���� ��������
    p_DV2   date               )  -- ���� ���� ��������
IS  l_Ref2 number ; l_datz date ; l_s number ; gl_stmt number; l_DV2 date ; l_POG number;
begin

   If p_s < p_SP then raise_application_error(-20000, 'XOZ/���.1='||p_REF1||'���� ��������='||p_s||' ����� ���� ��������='||p_sp );  end if;

   xoz.NOT_RD (p_acc, p_DV1, p_DV2 )   ;

   If p_REF2 > 0 then l_ref2 := P_ref2 ; -- ��������� �� ������������ ����� ���-2 �� ��������

      begin select o.vdat  into l_datz from oper o, opldok p where o.ref = p_ref2  and p.ref =o.ref and p.acc = p_acc and p.dk =1 and rownum=1 ;  --and p.s <= p_SP*100 
      EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'XOZ/���.2=' || p_REF2 || ' �� ���� ��������� ���.1='|| p_ref1 );
      end ;

   else l_Ref2 := 0 ;
      If p_zo = 1 then l_datz := dat_next_u(trunc(gl.BDATE, 'MM'),-1);
      else             l_datz := gl.BDATE;
      end if;
   end if ;

 ---------------------------------------------------
   If    p_s = nvl(p_SP, p_s) then   null ; -- ����� ��������  (���������)
         update xoz_ref SET ref2 = nvl(p_REF2,0), datz = l_datz  where ref1=p_ref1 and stmt1=p_stmt1;  -- ������ ������ �������
   Else
      l_S := (p_S - p_sp) * 100 ;   -- ���������� �������
      -- ���������� ������ ������ ��� �������
      l_DV2 := NVL( p_DV2, p_DV1) ;-- -- ����� ������ ���������� ���� �������������
      gl_stmt := bars_sqnc.get_nextval('s_stmt') ;
      INSERT INTO XOZ_ref (acc, ref1, stmt1,s, s0, fdat, mdate ) values (p_acc, p_ref1, gl_stmt, l_s, l_s, l_DV2, xoz.MDATE( p_acc,l_DV2 ) );
      update xoz_ref SET ref2 = nvl(p_REF2,0), datz = l_datz, s0 = p_sp*100  where ref1=p_ref1 and stmt1=p_stmt1;  -- ������ ������ �������
   end if;

end OPL_REF_H2 ;
-----------------------------------------------------------------

--������� � �������� � �������
procedure OPL_REF2( p_acc   XOZ_ref.acc%type   ,
                    p_ref1  XOZ_ref.ref1%type  ,
                    p_stmt1 XOZ_ref.stmt1%type ,
                    p_DV1   date               ,
                    p_S     XOZ_ref.s%type     ,
                    p_ZO    int                ,  -- :Z(SEM=����=1,TYPE=N),
                    p_SP    number             ,
                    p_DV2   date               ,
                    p_nazn  oper.nazn%type     ,   -- :T(SEM=ϳ������),
                    p_KDZ1  varchar2           ,   -- :X(SEM=��� ��,REF=KOD_DZ),
                    p_SDZ1  varchar2           ,   -- :Y(SEM=C��� ��),
                    p_OB40  varchar2           ,   -- :O(SEM=OB40 ��� �40,REF=KF_OB40)
                    p_nlsa  oper.nlsa%type         -- :A(SEM=��� ���,REF=V_XOZOB22_NLS),
                  ) is
--XOZ.OPL_REF2(:ACC, :REF1, :STMT1, :VDAT, :S0, :Z, :P, GL.BD, :T, :X,  NULL,  :O, :A )
  oo oper%rowtype;
  l_aaa varchar2 (20);
begin

  xoz.NOT_RD (p_acc, p_DV1, p_DV2 ) ;

  If p_zo = 1 then oo.vob := 96; oo.vdat := dat_next_u(trunc(gl.BDATE, 'MM'),-1);
  else             oo.vob := 06; oo.vdat :=                  gl.BDATE;
  end if;

  if p_nlsa is null or p_nazn is null then    raise_application_error(-20000, 'XOZ/���.1=' || p_REF1 || ' �� ������� ���(��� �������) ��� ��������');  end if;

  -- �������� � �������
  begin  select kv, substr(nms,1,38), nls   into oo.kv2, oo.nam_b,  oo.nlsb  from accounts  where dazs is null and acc = p_acc ;
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20000, 'XOZ/acc=' || p_acc || ' �� �������� ���., ���� ������������');
  end ;

  If    p_nlsa like '%/%' then  l_aaa :=                     p_nlsa ; -- ������ ��� ���
  ElsIf p_nlsa >'4'       then  l_aaa := gl.baseval ||'/'||  p_nlsa ; -- ������ �� ����� ���� ����� 980
  else                          l_aaa :=     oo.kv2 ||'/'||  p_nlsa ; -- ��� �� ���.���
  end if;

  begin  select kv, substr(nms,1,38), nls   into oo.kv, oo.nam_a,  oo.nlsa from accounts  where dazs is null and kv||'/'||nls = l_aaa;
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20000, 'XOZ/���.=' || l_aaa || ' �� �������� ���., �� ���� ����������� '|| oo.nlsb);
  end ;

  If nvl(P_SP, 0) <= 0 then raise_application_error(-20000, 'XOZ/C��� =' || P_SP ) ; end if;


  oo.s2 := P_SP  * 100;


  If    oo.kv =  oo.kv2    then oo.tt := '441' ; oo.s :=                       oo.s2 ;
  ElsIf oo.kv = gl.baseval then oo.tt := 'D07' ; oo.s := gl.p_icurval( oo.kv2, oo.s2 , oo.vdat ) ;
  else  raise_application_error(-20000, 'XOZ/���.=' || oo.kv || ' ������������ ��� ���');
  end if;

  gl.ref (oo.REF);  oo.nd := substr( to_char(oo.REF), 1,10 ) ;  oo.nazn := substr(p_nazn,1,160);
  gl.in_doc3(ref_=> oo.REF  , tt_   => oo.tt   , vob_  => oo.vob , nd_  => oo.nd   , pdat_ => SYSDATE , vdat_ => oo.vdat , dk_ => 1,
           kv_   => oo.kv   , s_    => oo.S    , kv2_  => oo.kv2 , s2_  => oo.s2   , sk_   => null    , data_ => gl.bdate,
           datp_ => gl.bdate, nam_a_=> oo.nam_a, nlsa_ => oo.nlsa, mfoa_=> gl.aMfo , nam_b_=> oo.nam_b, nlsb_ => oo.nlsb ,
           mfob_ => gl.aMfo , nazn_ => oo.nazn , d_rec_=> null   , id_a_=> gl.aOkpo, id_b_ => gl.aOkpo, id_o_ => null    ,
           sign_ => null    , sos_  => 1       , prty_ => null   , uid_ => null   );

  insert into operw (ref, tag, value)
    select oo.REF, tag, value
    from operw
    where ref = p_ref1 and tag not in  ('KODDZ','OB40' ,
                                      'K_DZ1','K_DZ2','K_DZ3','K_DZ4','K_DZ5','K_DZ6','K_DZ7','K_DZ8','K_DZ9',
                                      'S_DZ1','S_DZ2','S_DZ3','S_DZ4','S_DZ5','S_DZ6','S_DZ7','S_DZ8','S_DZ9' );
  gl.payv (0, oo.REF, oo.Vdat, oo.tt, 1, oo.kv, oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.S2);

--gl.pay  (2, oo.ref, gl.bdate ) ;

  insert into operw (ref,tag,value) select oo.REF, 'K_DZ1', p_KDZ1  from dual where p_KDZ1 is not null ;
  insert into operw (ref,tag,value) select oo.REF, 'S_DZ1', p_SDZ1  from dual where p_SDZ1 is not null ;
  insert into operw (ref,tag,value) select oo.REF, 'OB40' , p_OB40  from dual where p_OB40 is not null ;

  -- ����������� ������� � �������� ���� ���2 = oo.ref (�� ����-�������� ����������)
  XOZ.OPL_REF_H2  ( p_acc, p_ref1, p_stmt1,  p_DV1 ,  p_S , oo.ref,  p_ZO , p_SP,  p_DV2  );

  --------------------------------------------------------------------------

end OPL_REF2;
----------------------------------------------------

procedure OPL_REFD( p_acc   XOZ_ref.acc%type   ,
                    p_ref1  XOZ_ref.ref1%type  ,
                    p_stmt1 XOZ_ref.stmt1%type ,
                    p_DV1   date               , -- ������
                    p_S     XOZ_ref.s%type     ,
                    p_ZO    int                , -- ������
                    p_SP    number             , -- ������
                    p_DV2   date               , -- ������
                    p_nazn  oper.nazn%type     , -- ������
                    p_KDZ1  varchar2           , -- ������
                    p_SDZ1  varchar2           , -- ������
                    p_OB40  varchar2           , -- ������
                    p_nlsa  oper.nlsa%type       -- ������
               ) is
  -- ���������� ���.������ �� ��

  oo oper%rowtype          ;
  l_rec  arc_rrp.REC%type  ;
  l_err  int               ;
  aa accounts%rowtype      ;
begin

  begin  select * into aa from accounts where acc = p_acc  ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20000,'�� �������� Acc = '|| p_acc );
  end ;

  begin  select  null into l_err from XOZ_OB22_CL x where x.deb = aa.nbs||aa.ob22 and x.DZ = 1  ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20000,'��� '|| aa.nbs||'.'|| aa.ob22 || ' ������ ����� �� ���.����� �� ��' );
  end ;

  begin  select *    into oo     from oper     where ref = p_ref1 ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20000,'�� �������� Ref = '|| p_ref1 );
  end ;

  oo.s :=  p_S * 100 ;
  oo.mfob := '300465';  oo.nlsb := '35105';  oo.id_b := '00032129';  oo.nam_b := '³����������� ����.���.��������. ��' ;
  oo.dk   := 2 ;        oo.tt   := 'KLI'  ;  oo.vob  := 2 ;

  oo.ref  := null ;
  gl.ref (oo.REF);
  oo.d_rec := '#COB:' || aa.ob22 || '#CF1:' || p_ref1 || '#CFD:' || oo.ref || '#' ;

  gl.in_doc3(ref_=> oo.REF  , tt_   => oo.tt   , vob_  => oo.vob  , nd_  => oo.nd   , pdat_ => SYSDATE , vdat_ => gl.bdate, dk_ => oo.dk,
           kv_   => oo.kv   , s_    => oo.S    , kv2_  => oo.kv   , s2_  => oo.s    , sk_   => null    , data_ => gl.bdate,
           datp_ => gl.bdate, nam_a_=> oo.nam_a, nlsa_ => oo.nlsa , mfoa_=> oo.Mfoa , nam_b_=> oo.nam_b, nlsb_ => oo.nlsb ,
           mfob_ => oo.Mfob , nazn_ => oo.nazn , d_rec_=> oo.d_rec, id_a_=> oo.id_a , id_b_ => oo.id_b , id_o_ => null    ,
           sign_ => null    , sos_  => 1       , prty_ => null    , uid_ => null   );

--- ?? ���.������ - ��� ����
  gl.pay(2, oo.ref, gl.bDATE);
  SEP.in_sep(err_     => l_err, -- OUT INTEGER,-- Return code
             rec_     => l_rec, -- OUT INTEGER, -- Record number
             mfoa_    => gl.aMfo, -- VARCHAR2,  -- Sender's MFOs
             nlsa_    => oo.nlsa, -- VARCHAR2,  -- Sender's account number
             mfob_    => oo.mfob, -- VARCHAR2,  -- Destination MFO
             nlsb_    => oo.nlsb, -- VARCHAR2,  -- Target account number
             dk_      => oo.dk, -- SMALLINT, -- Debet/Credit code
             s_       => oo.s, -- DECIMAL,  -- Amount
             vob_     => oo.vob, -- SMALLINT, -- Document type
             nd_      => oo.nd, -- VARCHAR2, -- Document number
             kv_      => oo.kv, -- SMALLINT, -- Currency code
             data_    => gl.bdate, -- DATE,     -- Posting date
             datp_    => gl.bdate, -- DATE,     -- Document date
             nam_a_   => oo.nam_a, -- VARCHAR2, -- Sender's customer name
             nam_b_   => oo.nam_b, -- VARCHAR2, -- Target customer name
             nazn_    => oo.nazn ,
             naznk_   => null, -- CHAR,     -- Narrative code
             nazns_   => null, -- CHAR,     -- Narrative contens type
             id_a_    => oo.id_a, -- VARCHAR2, -- Sender's customer identifier
             id_b_    => oo.id_b, -- VARCHAR2, -- Target customer identifier
             id_o_    => oo.id_o, -- VARCHAR2, -- Teller identifier
             ref_a_   => substr('000000000' || oo.ref, -9), --VARCHAR2,-- Sender's reference
             bis_     => 0, --  SMALLINT,    -- BIS number
             sign_    => null, -- VARCHAR2,    -- Signature
             fn_a_    => null, -- CHAR,        -- Input file name
             rec_a_   => null, --- SMALLINT,   -- Input file record number
             dat_a_   => null, --  DATE,       -- Input file date/time
             d_rec_   => oo.d_rec,
             otm_i    => 0, -- SMALLINT,    -- Processing flag
             ref_i    => oo.ref, -- INTEGER    DEFAULT NULL, -- PreAssigned Reference
             blk_i    => null, -- SMALLINT   DEFAULT NULL, -- Blocking code
             ref_swt_ => null  -- VARCHAR2 DEFAULT NULL  -- Source REF ($A||#rec or Swift F20)
           );
  update xoz_ref SET refD = oo.ref where ref1 = p_ref1 and stmt1=p_stmt1;  -- ������ ������ ��������

--1) � �� ��������� ������ = ��������� ������� ��� ������ � �������
  Insert into XOZ_RU_CA ( REF1, REFD_RU, RECD_RU, RECD_CA, REFK_CA , REF2) values (p_ref1, oo.ref, l_rec, null, null, null ) ;

end OPL_REFD;
----------------------------------------------------
-- ������������� �� ³����������� ����� �� �� � �� � �����������  �������  �� ���
procedure OPL_REFK
( p_rec  IN  number  ,
  p_txt  IN  varchar2,
  oo     OUT oper%rowtype
 ) IS
  l_rec  arc_rrp.REC%type ;
  l_ref1     number ;
  l_refd_RU  number ;
  l_err      int    ;
begin
  oo.tt   := 'PS2';  oo.dk := 1 ;
  Begin
     select  a.mfob,  a.nlsb,  a.id_b,  a.nam_b,  a.mfoa,  a.nlsa,  a.id_a,  a.nam_a,  a.s,  a.vob,  a.nd,  a.kv,  a.nazn,  a.d_rec
     into   oo.mfoa, oo.nlsa, oo.id_a, oo.nam_a, oo.mfob, oo.nlsb, oo.id_b, oo.nam_b, oo.s, oo.vob, oo.nd, oo.kv, oo.nazn, oo.d_rec
     from arc_rrp a   where rec = p_rec ;

  EXCEPTION WHEN NO_DATA_FOUND THEN     raise_application_error(-20000,'�� �������� REC = '|| p_rec );
  end ;

  oo.ref  := null ;
  gl.ref (oo.REF);
  oo.nazn := NVL( p_txt , oo.nazn);
  oo.d_rec := oo.d_rec || 'CFK:'||oo.ref||'#' ;

  gl.in_doc3(ref_=> oo.REF  , tt_   => oo.tt   , vob_  => oo.vob  , nd_  => oo.nd   , pdat_ => SYSDATE , vdat_ => gl.bdate, dk_ => oo.dk,
           kv_   => oo.kv   , s_    => oo.S    , kv2_  => oo.kv   , s2_  => oo.s    , sk_   => null    , data_ => gl.bdate,
           datp_ => gl.bdate, nam_a_=> oo.nam_a, nlsa_ => oo.nlsa , mfoa_=> oo.Mfoa , nam_b_=> oo.nam_b, nlsb_ => oo.nlsb ,
           mfob_ => oo.Mfob , nazn_ => oo.nazn , d_rec_=> oo.d_rec, id_a_=> oo.id_a , id_b_ => oo.id_b , id_o_ => null    ,
           sign_ => null    , sos_  => 1       , prty_ => null    , uid_ => null   );
  paytt  (0, oo.REF, gl.bDATE, oo.TT, oo.dk , oo.kv, oo.nlsa, oo.s, oo.kv, oo.nlsb, oo.S);

--if nvl(GetGlobalOption('PEDAL_PROFIX'),0)=1 then
     gl.pay(2, oo.ref, gl.bDATE);
---- If oo.mfoa <> oo.mfob then
        SEP.in_sep(err_     => l_err, -- OUT INTEGER,-- Return code
                   rec_     => l_rec, -- OUT INTEGER, -- Record number
                   mfoa_    => oo.Mfoa, -- VARCHAR2,  -- Sender's MFOs
                   nlsa_    => oo.nlsa, -- VARCHAR2,  -- Sender's account number
                   mfob_    => oo.mfob, -- VARCHAR2,  -- Destination MFO
                   nlsb_    => oo.nlsb, -- VARCHAR2,  -- Target account number
                   dk_      => oo.dk, -- SMALLINT, -- Debet/Credit code
                   s_       => oo.s, -- DECIMAL,  -- Amount
                   vob_     => oo.vob, -- SMALLINT, -- Document type
                   nd_      => oo.nd, -- VARCHAR2, -- Document number
                   kv_      => oo.kv, -- SMALLINT, -- Currency code
                   data_    => gl.bdate, -- DATE,     -- Posting date
                   datp_    => gl.bdate, -- DATE,     -- Document date
                   nam_a_   => oo.nam_a, -- VARCHAR2, -- Sender's customer name
                   nam_b_   => oo.nam_b, -- VARCHAR2, -- Target customer name
                   nazn_    => oo.nazn ,
                   naznk_   => null, -- CHAR,     -- Narrative code
                   nazns_   => null, -- CHAR,     -- Narrative contens type
                   id_a_    => oo.id_a, -- VARCHAR2, -- Sender's customer identifier
                   id_b_    => oo.id_b, -- VARCHAR2, -- Target customer identifier
                   id_o_    => oo.id_o, -- VARCHAR2, -- Teller identifier
                   ref_a_   => substr('000000000' || oo.ref, -9), --VARCHAR2,-- Sender's reference
                   bis_     => 0, --  SMALLINT,    -- BIS number
                   sign_    => null, -- VARCHAR2,    -- Signature
                   fn_a_    => null, -- CHAR,        -- Input file name
                   rec_a_   => null, --- SMALLINT,   -- Input file record number
                   dat_a_   => null, --  DATE,       -- Input file date/time
                   d_rec_   => oo.d_rec ,
                   otm_i    => 0, -- SMALLINT,    -- Processing flag
                   ref_i    => oo.ref, -- INTEGER    DEFAULT NULL, -- PreAssigned Reference
                   blk_i    => null, -- SMALLINT   DEFAULT NULL, -- Blocking code
                   ref_swt_ => null  -- VARCHAR2 DEFAULT NULL  -- Source REF ($A||#rec or Swift F20)
                 );

                 l_ref1    := substr(xoz.DREC (oo.D_REC, 'F1'),1, 38) ;
                 l_refd_ru := substr(xoz.DREC (oo.D_REC, 'FD'),1, 38) ;
                 -- 2) � ��  ������������� ������
                 update XOZ_RU_CA set RECD_CA = p_rec, REFK_CA = oo.ref where  REF1 = l_ref1 and REFD_RU = l_refd_ru ;
                 IF SQL%ROWCOUNT = 0 THEN
                    Insert into  XOZ_RU_CA ( REF1, REFD_RU, RECD_RU, RECD_CA, REFK_CA , REF2) values (l_ref1, l_refd_ru, null, p_rec, oo.ref, null ) ;
                 end if;
                 delete from  tzapros where rec = p_rec;
-----end if;   --- mfoa<> mfob
--end if ; ����-����
end;

-- �������� ����������� ������� �� �������
procedure OPL_REFK1
( p_rec   number            ,
  p_s     number            ,
  p_nlsa  oper.nlsa%type    ,   -- :A(SEM=��� ���,REF=V_XOZOB22_NLS),
  p_ZO    int               ,   -- :Z(SEM=����=1,TYPE=N),
  p_nazn  oper.nazn%type    ,   -- :T(SEM=ϳ������),
  p_KDZ1  varchar2          ,   -- :X(SEM=��� ��,REF=KOD_DZ),
  p_OB40  varchar2              -- :O(SEM=OB40 ��� �40,REF=KF_OB40)
) IS
  z_rec number   ;
  oo oper%rowtype;
begin
--- XOZ.OPL_REFK1(:REC, :S, :A,:Z, :T, :X, :O )
  --:A(SEM=��� ���,REF=V_XOZOB22_NLS),
  --:Z(SEM=����=1,TYPE=N),
  --:T(SEM=ϳ������),
  --:X(SEM=��� ��,REF=KOD_DZ),
  --:O(SEM=OB40 ��� �40,REF=KF_OB40)

  begin select rec into z_rec from  tzapros where rec = p_rec;        XOZ.OPL_REFK ( p_rec, p_nazn, oo);
  EXCEPTION WHEN NO_DATA_FOUND THEN null ;
  end;

  begin  select o.* into oo from oper o, xoz_ru_ca x where o.ref = x.refk_ca and x.recd_ca = p_rec ;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'XOZ/��c.=' || p_Rec || ' �� �������� ��� (������������� �� ��)');
  end;

  If p_zo = 1 then oo.vob := 96; oo.vdat := dat_next_u(trunc(gl.BDATE, 'MM'),-1);
  else             oo.vob := 06; oo.vdat :=                  gl.BDATE;
  end if;
  oo.kv:= gl.baseval ;
  If p_S > 0 then   oo.s :=  p_S  * 100 ; end if ;

  --- �������� �� ��������
  begin select substr(nms,1,38), nls into oo.nam_a, oo.nlsa from accounts where dazs is null and kv = oo.kv and nls = p_NLSA ;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20000, 'XOZ/��c.=' || p_Rec || ' �� �������� ���(������) ��� �������� '|| p_nlsa);
  end;

  gl.ref (oo.REF);  oo.nd := substr( to_char(oo.REF), 1,10 ) ;  oo.nazn := substr(p_nazn,1,160);
  gl.in_doc3(ref_=> oo.REF  , tt_   => '441'   , vob_  => oo.vob , nd_  => oo.nd   , pdat_ => SYSDATE , vdat_ => oo.vdat , dk_ => 0,
           kv_   => oo.kv   , s_    => oo.S    , kv2_  => oo.kv  , s2_  => oo.s    , sk_   => null    , data_ => gl.bdate,
           datp_ => gl.bdate, nam_a_=> oo.nam_a, nlsa_ => oo.nlsa, mfoa_=> gl.aMfo , nam_b_=> oo.nam_b, nlsb_ => oo.nlsb ,
           mfob_ => gl.aMfo , nazn_ => oo.nazn , d_rec_=> null   , id_a_=> gl.aOkpo, id_b_ => gl.aOkpo, id_o_ => null    ,
           sign_ => null    , sos_  => 1       , prty_ => null   , uid_ => null   );
  gl.payv (0, oo.REF, oo.Vdat, '441', 1, oo.kv, oo.nlsa, oo.s, oo.kv, oo.nlsb, oo.S);
  gl.pay  (2, oo.ref, gl.bdate ) ;
  insert into operw (ref,tag,value) select oo.REF, 'K_DZ1', p_KDZ1  from dual where p_KDZ1 is not null ;
  insert into operw (ref,tag,value) select oo.REF, 'OB40' , p_OB40  from dual where p_OB40 is not null ;

end OPL_REFK1;

----------------------------------------------------
-- ������� ������������� ������� ��, �� �������
procedure OPL_CA (p_mode int  )  is
  -- �� ������-������
  s_ref1 varchar2(38);    s_refd varchar2(38);
  n_ref1 number      ;    n_refd number      ;
begin
  for oo in (select o.* from oper o
            where o.mfoa = '300465' and o.nlsa = '35105' and o.id_a = '00032129' and vdat >=  gl.bd -1
              and exists (select 1 from opldok p where p.fdat >= gl.bdate -1 and p.ref=o.ref and o.dk = 1 )
           )
   loop s_ref1 := substr(xoz.DREC (oo.D_REC, 'F1'),1, 38) ;
        s_refd := substr(xoz.DREC (oo.D_REC, 'FD'),1, 38) ;
        If s_ref1 is not null and s_refd is not null then
           begin n_ref1 := to_number(s_ref1);
                 n_refd := to_number(s_refd);
                 update xoz_ref   set ref2=oo.ref, datz=gl.bdate where ref1 = n_ref1 and refd    = n_refd and ref2 is null;
                 -- 3) �  �� ������� ���������� ������ �� ��
                 update XOZ_RU_CA set ref2=oo.ref                where REF1 = n_ref1 and REfD_ru = n_refd and ref2 is null;
           exception when others then NULL;
           end ;
        end if ;
   end loop ;

end OPL_CA ;
----------------------------------------------------

--��������� ������������ ��������� -- �� ������������ !!!!!!!!!!!!!!
procedure INS0 ( p_acc XOZ_ref.acc%type  ) is
   -- p_acc  0=��� ���� , >0 - ��� ������
  fdat_ saldoa.fdat%type;
BEGIN
  -- ��������� ����������� ���������� �������
  delete from xoz_ref where p_acc in (0,acc);

  -- ������� ��� ������ ������� �����
  for k in (select * from accounts where dazs is null and pap=1 and kv=980 and nbs like '351_' and p_acc in (0,acc)  )
  loop
    update accounts set tip='XOZ' where acc =k.acc;
    If k.ostc < 0 then
       select nvl(max(fdat), k.daos-1)  into fdat_ from saldoa  where ostf-dos+kos=0 and acc = k.acc;
       for O in (select * from opldok where fdat > FDAT_ and acc =k.acc order by fdat, dk)
       loop
          if o.dk = 0 then
             --������� � ���������
             xoz.INS_REF1(              p_ref1=>O.REF, p_stmt1=>o.stmt ) ;
          else
             --������� � ��������
             update xoz_ref set ref2 = o.REF where ref2 is null and acc = k.acc and fdat <= o.FDAT and s= o.S and rownum=1;
          end if;
       end loop;
    end if;
  end loop;
end INS0;
----------------------

--- ������ ��� �� 23  -- �� ������������ !!!!!!!!!!!!!!
procedure REZ ( S_DAT01 IN  VARCHAR2, --:s(SEM=��_����_01,TYPE=s)
                p_modeZ IN  int      -- :Z(SEM=�����.� nbu23_rez 1= ��, 0=���)
               )  is
 dat01_ date ;
 dat31_ date ;
 zz nbu23_rez%rowtype;
 aa accounts%rowtype ;

 m1_ int; --\
 m2_ int; --/ PET

BEGIN
 RETURN ;

 If trim(s_DAT01) IS NULL THEN    raise_application_error(-20000,'����i�� ��i��� ���� !'); End if ;

 PUL_DAT( s_DAT01, '')  ;

 dat01_  := to_date( s_dat01,'dd.mm.yyyy');
 z23.DAT_BEG := DAT01_  ;

 IF NVL(p_modeZ,0) <> 1     THEN RETURN;  END IF;

/* *******
 --� �i�������� � ��������i
 begin
    select a.kv, a.nls  into aa.kv, aa.nls
    from  accounts a, (select acc, sum (s) S from xoz_ref where ref2 is null and s >0 group by acc) x
    where a.tip='XOZ'  and a.acc = x.acc (+) and  a.ostc+nvl(x.s,0) <>0  and rownum = 1;
    raise_application_error(-20000,'� �i�������� � ��������i,
      ���������, ���.' || aa.kv || '/' || aa.nls);
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end ;

 --� ����������i ���� ���������
 begin
    SELECT a.kv,  a.nls,  x.ref1     into  aa.kv, aa.nls, aa.acc   FROM xoz_ref x, accounts a
    WHERE x.s > 0 and x.ref2 IS NULL AND x.acc = a.acc AND x.fdat < DAT01_ and x.mdate is null and rownum = 1;
    raise_application_error(-20000,'� ����������i ���� ���������,
      ���������, ���.' || aa.kv || '/' || aa.nls|| ', ���.-1'|| aa.acc);
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 end ;
*/

--------------------------------------------
 delete from NBU23_REZ where id like 'XOZ%' and fdat = dat01_;

 dat31_ := dat_next_u(DAT01_, -1) ;

 -- ���� �� ��������� S180
 for aa in (select acc, nls, kv, rnk, nbs, tobo,  ost_korr(acc, dat31_, null,nbs ) OST
            from accounts where tip = 'XOZ' and ost_korr(acc, dat31_, null,nbs ) <0
            )
 loop
    for k in (
         --�� ���� �� ������ ��������
           select  x.ref1, x.STMT1,  x.s, x.fdat, x.mdate, nvl(m.s180,'0') s180, (dat01_ - x.FDAT) k0, (x.MDATE - DAT01_) k1 , x.NOTP
           FROM xoz_ref x, specparam m
           WHERE x.s > 0 and  x.ref2 IS NULL AND x.acc = aa.acc  AND x.fdat < DAT01_  and x.acc = m.acc(+)
           union all
         --������� ���� �� ���� �� ���� ��������� , �� � ������ ����.
           select x.ref1, x.STMT1,  x.s0, x.fdat, x.mdate, nvl(m.s180,'0') s180, (dat01_ - x.FDAT) k0, (x.MDATE - DAT01_) k1 , x.NOTP
           FROM xoz_ref x, specparam m
           WHERE x.s = 0 AND x.acc = aa.acc  AND x.fdat < DAT01_  and x.acc = m.acc(+) and x.datz > dat31_
           )
    loop
      m1_ := 5; m2_ := 5;
      if k.S180 = '6' then  -- ���������
         if    k.k0 between   1 and  90 then m1_ := 1 ;
         elsif k.k0 between  91 and 180 then m1_ := 2 ;
         elsif k.k0 between 181 and 270 then m1_ := 3 ;
         elsif k.k0 between 271 and 360 then m1_ := 4 ;
         end if;

      else  -- k.S180 = '5' �  ������
         if    k.k0 between   1 and  30 then m1_ := 1 ;
         elsif k.k0 between  31 and  90 then m1_ := 2 ;
         elsif k.k0 between  91 and 180 then m1_ := 3 ;
         elsif k.k0 between 181 and 270 then m1_ := 4 ;
         end if;
      end if;
      -------------------------

      If k.NOTP = 1 then         m2_ := 1;
      else
         if    k.k1 >= -  7 then m2_ := 1;
         elsif k.k1 >= - 30 then m2_ := 2;
         elsif k.k1 >= - 90 then m2_ := 3;
         elsif k.k1 >= -180 then m2_ := 4;
         end if;
      end if;

      if      m1_ = m2_  then zz.kat := m1_;
      elsif   m1_ > m2_  then zz.kat := m1_;
      elsif   m1_ < m2_  then zz.kat := m2_;
      end if;

      if    zz.kat = 1 then  zz.k :=  0/10 ;
      elsif zz.kat = 2 then  zz.k :=  2/10 ;
      elsif zz.kat = 3 then  zz.k :=  5/10 ;
      elsif zz.kat = 4 then  zz.k :=  8/10 ;
      elsif zz.kat = 5 then  zz.k := 10/10 ;
      end if;
      zz.BV  := least( -aa.ost, k.S) /100  ;
      zz.PV  := round ( zz.BV * (1- zz.k) ,2) ;
      zz.PVZ := 0;
      zz.ZAL := 0;
      zz.REZ := zz.BV - zz.PV;
      zz.id  := 'XOZ'||aa.acc||'/'|| k.ref1||'/'||k.STMT1 ;
      insert into nbu23_rez (FDAT,ID, RNK,  NBS,  KV,  ND  ,  ACC,  NLS,BRANCH, sdate, wdate,    KAT,   K,ZAL, BV,   PV,PVZ, REZ)
            values (DAT01_,zz.id,aa.rnk,aa.nbs,aa.kv,k.ref1,aa.acc,aa.nls,aa.tobo,k.fdat,k.mdate,zz.kat,zz.k,0,zz.BV,zz.PV,0,zz.REZ);

      aa.ost := aa.ost + zz.bv*100;
      If aa.ost >= 0 then exit; end if;

   end loop; -- k
  end loop ; -- aa
 z23.kontrol1  (p_dat01 =>DAT01_ , p_id => 'XOZ%'  );
 commit;

end REZ;

--------------------------------------------

   FUNCTION header_version RETURN VARCHAR2 is BEGIN RETURN 'Package header XOZ'|| g_header_version; END header_version;
   FUNCTION body_version   RETURN VARCHAR2 is BEGIN RETURN 'Package body XOZ ' || g_body_version;   END body_version;

--------------
END XOZ;
/
 show err;
 
PROMPT *** Create  grants  XOZ ***
grant EXECUTE                                                                on XOZ             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on XOZ             to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/xoz.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 