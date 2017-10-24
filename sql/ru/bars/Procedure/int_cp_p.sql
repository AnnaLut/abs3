

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INT_CP_P.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INT_CP_P ***

  CREATE OR REPLACE PROCEDURE BARS.INT_CP_P 
(p_METR int   , --��� ��������
 p_Acc  int   , -- ��� �������� �
 p_Id   int   , -- acrn.p_int(nAcc,nId,dDat1,dDat2,nInt,nOst,nMode)
 p_Dat1 date  , --
 p_Dat2 date  , --
 p_Int  OUT NUMBER, -- Interest accrued
 p_Ost  number,
 p_Mode int   )   IS
--  *** v. 1.37d  5/05-15   6/05-14  31/03-14 20/11-13  ***

--  5/05-15 .....
--  6/05-14 �������� ���������� ������� ������� � ���� ����. �-�������
--          �������� �������� - � ��� �-������� ����������� �������� � ������� DK.
-- 28/03-14 �������� �� ���
-- 19/11-13 �������� �� �������� ��������� �������
-- ������ ��
-- 30/09-13 ����� 515 - Australian Floater
-- 13/03-13 ����� ������� �� 0 � ������ ��� l_dat2
-- 14/02-13 �������� ����� ������� (�������)
--  1/11-12 �������� l_kupon
-- 31/10-12 ��������� �� ������ STOP_DAT ��� tip=1
-- 10/10-12 �����  ACR_dat  �� p_dat1  �� �������� '01.01.1900'
--          ��������� remi=0
-- 27/06-12 ���-� ����� � ������ ���������
-- 19/06-12 ���� ����������� %-� �� ����� ������� �������.
-- 18/06-12 ���������� ��� ��� �� ���/���
--          ���������� BR=0  � acr_intN
--  5/06-12 ��������� ���� ���������� ������ ��������� ������.
-- 14/05-12 ���������� ������ �� �� � �����. �������.
--  9/11-11 ��-�� LOG (������ MON_U.to_log)
-- 26/07-11 ������� ��������� ����� ��-�� MONITOR.TO_LOG
--          � ������ ������ ���������� � MONITOR_USER_LOG (+ SEC_AUDIT �� ����)

 ACR_DAT_ int_accn.ACR_DAT%type;
 KOL1_    int ;
 KOL2_    int ;
 REF_     cp_deal.REF%type ;
 D1_    date; D1_P date;
 D2_    date; D2_P date;
 D3_    date;
 De_    cp_kod.DAT_EM%type   ;
 Dp_    cp_kod.DATp%type     ;
 Kup_   cp_dat.kup%type      ;
 Kup1_  number;
 Kup2_  number;

 Ir_      cp_kod.IR%type       ;     l_ir   cp_kod.IR%type;
 ID_      cp_deal.ID%type      ;
 CENA_    cp_kod.cena%type     ;
 l_CENA_kup cp_kod.cena%type   ;   l_CENA_kup0 cp_kod.cena_kup0%type;
 l_pr1_kup cp_kod.pr1_kup%type ;
 l_daos accounts.daos%type;
 l_dat1 date; l_dat2 date;
 l_tip  cp_kod.tip%type;
 l_nbs  accounts.nbs%type;
 l_acra int_accn.ACRA%type;
 l_stpdat int_accn.stp_dat%type;
 l_ostr number; l_ostr2 number;  l_ostr_dok number; l_ostr2_dok number;
 l_ost number;  l_ostaf number;
 l_ISIN cp_kod.cp_id%type;
 l_nazn varchar2(160);
 l_nd varchar2(10);
 l_paket varchar2(20); l_stavka varchar2(20);
 l_nls  accounts.nls%type;
 l_dn int;
 pnt int :=0; l_fl int; fl_pg int;
 l_accr cp_deal.accr%type;
 l_accr2 cp_deal.accr%type;
 l_sint number;  l_sint_dok number;
 l_kupon number;
 l_kv int;
 l_ky int;  l_npp int;   l_pap int;
 l_metr int;  l_dkp int; l_days int;
 l_apl_dat int_accn.apl_dat%type;
 l_dok date; l_dnk date;

 l_nom number;
 l_nom_g number;
 l_CENA_start cp_kod.cena_start%type;
 l_IO cp_kod.IO%type; l_IO_k cp_kod.IO%type;
 l_idt cp_type.idt%type; l_tname cp_type.name%type;
 G_TRACE  constant varchar2(20) := 'INT_CP_P: ';
 G_MODULE constant varchar2(20) := 'CPN';
 l_mdl varchar2(20) := 'CPN';
 l_trace  varchar2(1000):= '';
--------------------------
procedure LOG(p_info char, p_lev char default 'TRACE', p_reg int default 0) is
begin
  MON_U.to_log(p_reg,p_lev,l_mdl,l_trace||p_info);
end;
--------------------------
begin
 l_trace := G_TRACE;
 If p_Dat2 < p_Dat1 then /* ����� �������� */
    LOG('ACC='||p_acc||' '||p_dat1||' '||p_dat2,'TRACE',0);
    RETURN;
 end if;

 l_dat1:=p_dat1;  l_dat2:=p_dat2;

 If p_Mode = 1 then  /* �� ������� �����, �������� �� ���� ����� ���������� */
    begin
    select -- nvl(i.ACR_DAT, a.daos-1),
    decode(i.acr_dat,null,a.daos-1,to_date('01.01.1900','dd.mm.yyyy'),a.daos-1,i.acr_dat),
    a.daos, a.nls,
    substr(a.nls,1,4), i.acra, i.stp_dat,
    a.ostc, a.ostb+a.ostf, a.pap, i.io, i.apl_dat
    into ACR_DAT_, l_daos, l_nls, l_nbs, l_acra, l_stpdat,
         l_ost, l_ostaf, l_pap, l_io, l_apl_dat
    from int_accn i, accounts a
         where a.acc = i.acc and i.acc = p_Acc  and i.acc != i.acra
             and i.id=p_Id;

 LOG('NLS='||l_nls||' '||l_dat1||' '||l_dat2||' stpdat='||l_stpdat,'TRACE',0);

 if p_dat1 = to_date('02.01.1900','dd.mm.yyyy') then
    l_dat1:=l_daos;
  end if;

 LOG('NLS='||l_nls||' '||l_dat1||' '||l_dat2||' acr_dat='||acr_dat_,'INFO',5);

--    LOG('NLS='||l_nls||' ���� OSTC='||l_ost||' ostaf='||l_ostaf);
       If l_Dat1 <=  ACR_DAT_ then  RETURN;   end if;
       if l_ostaf = 0 and l_ost = 0 and ABS(Fost(p_Acc,l_Dat2)) = 0 then
          LOG('NLS='||l_nls||' ���-� ����='||l_ost||' �������='||l_ostaf);
          goto ZAP;
       end if;
       if l_ost = 0 then l_ost:= Fost(p_Acc,l_Dat2); end if;
    EXCEPTION WHEN NO_DATA_FOUND THEN
    LOG('! ������ �� ���� ���� acc='||p_acc||' '||p_id,'ERROR',0);
    RETURN ;
    end;
 end if;

 If p_Metr not in (8,23,515)  then   -- 14/06-11 or p_id <>0 then  /* ��������� ����� */
    LOG('! ���������� ���� acc='||p_acc||' metr='||p_metr,'INFO');
    acrn.p_int(p_Acc, p_id, l_Dat1, l_Dat2, p_Int, p_Ost, p_Mode) ;
    RETURN;
 end if;
 ----------------------------------

 begin
    pnt:=1;
    select d.id , k.cena , k.dat_em, k.datp, k.ir , d.ref,
    nvl(k.PR1_KUP, decode (k.kv,gl.baseval, 2, 1)), k.tip, k.cp_id,
           d.accr, d.accr2, k.idt, k.kv, k.ky, cena_kup, cena_kup0,
           k.metr, cena_start, nvl(k.io,l_io),
           nvl(k.dok,k.dat_em), nvl(k.dnk,k.datp)
    into   ID_, cena_, De_, Dp_, IR_, REF_, l_pr1_kup, l_tip, l_ISIN,
           l_accr, l_accr2, l_idt, l_kv, l_ky, l_cena_kup, l_cena_kup0,
           l_metr, l_cena_start, l_io_k, l_dok, l_dnk
    from  cp_deal d, cp_kod k
    where d.acc = p_Acc and k.id=d.ID;

    if l_metr=515 then null;   -- ���������
    else
    l_metr:=p_metr;
    end if;
    LOG('! ����� ����������� acc='||p_acc||' metr='||l_metr,'TRACE',0);

    if l_tip=1 then
    begin
      l_fl :=0 ;
      select 1 into l_fl from dual
      where exists (select 1 from cp_dat where id = ID_);
    exception when NO_DATA_FOUND then
      log('ISIN='||l_ISIN||' '||ID_||' �� ������� i����i� �����i� ','ERROR',0);
      goto ZAP;
     --return;
    end;
    else     -- l_tip=2
    null; l_fl:=0;
    if nvl(l_cena_kup0,0)=0 then
      log('ISIN='||l_ISIN||' '||ID_||' �� ������� ����� ','ERROR',0);
      goto ZAP;
    end if;   kup_:=l_cena_kup0*100;
    end if;

    pnt := 2 ;
   if l_tip=1 then
 --log ('ISIN='||l_ISIN||' '||DE_||' '||DP_||' pr1_kup='||l_pr1_kup);
    select nvl(max(dok),De_) into D1_ from cp_dat where id=ID_ and dok<= l_dat1;
 --log('ISIN='||l_ISIN||' 2a D1='||D1_);
    select nvl(min(dok),Dp_) into D2_ from cp_dat where id=ID_ and dok>  l_dat1;
 --log('ISIN='||l_ISIN||' 2b D2='||D2_);
    select nvl(max(dok),De_) into D3_ from cp_dat where id=ID_ and dok<= p_dat2;
 --log('ISIN='||l_ISIN||' 2c D3='||D3_);
   D1_P:=D1_; D2_P:=D2_; l_days:=D2_P - D1_P;
   l_dok:=D1_;   -- -1;

    If D1_ <> D3_ then
       LOG('ISIN='||l_ISIN||' '||ID_||' ref='||REF_||' !�� ����������.'||
            ' ��i�� ���.���i��� � ���i��i �����������','INFO',1);
       goto ZAP;
    else
    NULL;
    select decode(nvl(min(npp),0),0,1,min(npp))
    into l_npp
    from cp_dat
    where id=ID_ and l_dat1 < dok;
    end if;
    else     -- ��
    null;

    D1_:=DE_;
    if l_dat1 >= DE_ and l_dat1<DP_ then D1_:=DE_; end if;
    D2_:=DP_;  --D3_:=DP_;
    if l_dat2 > nvl(l_stpdat,DP_) then l_dat2:=nvl(l_stpdat,DP_); end if;

    end if;

 EXCEPTION WHEN NO_DATA_FOUND THEN
           LOG('ISIN='||l_ISIN||' !�� ����������. pnt='||pnt,'INFO',0);
           goto ZAP;
           when others then
             LOG('ISIN='||l_ISIN||' !�� ����������. 2d','ERROR',0);
             goto ZAP;
             -- RETURN ;
 end;

 pnt:=3;
LOG('ISIN='||l_ISIN||' ref='||REF_||' pnt='||pnt);

 --���-��  ���� �� �� ������ ���� ������� ����������.
 KOL1_  := ABS(Fost(p_Acc, l_Dat1))/ 100/f_cena_cp(id_,l_dat1,0);
 --���-��  ���� �� �� ������  ���� ������� ����������.
 KOL2_  := ABS(Fost(p_Acc, p_Dat2))/ 100/f_cena_cp(id_,p_dat2,0);
 LOG('ISIN='||l_ISIN||' pnt='||pnt||' ref='||REF_||' �� ����='||kol1_,'INFO',5);
 pnt:=4;
 If KOL1_ <> KOL2_ then
    LOG('ISIN='||l_ISIN||' ref='||REF_||' !�� ����������.'||
              ' ��i�� �i������i �� � �����i � ���i��i �����������','ERROR',1);
    -- return;
    goto ZAP;
 end if;
--LOG('ISIN='||l_ISIN||' pnt='||pnt||' ref='||REF_||):

begin
   select nvl(ostc,0)  into l_ostr
   from accounts
   where acc=l_acra and ostc=ostb;
EXCEPTION WHEN NO_DATA_FOUND THEN
   LOG('ISIN='||l_ISIN||' '||ID_||' ref='||REF_||
       ' .���������� ���-�� �� ���-�� ������ ','ERROR');
   goto ZAP;
end;

     LOG('ISIN='||l_ISIN||' '||ID_||' ���.����� '||REF_||
         ' .fost R','INFO',0);

l_ostr_dok:=FOST(l_accr,l_dok);
     LOG('ISIN='||l_ISIN||' '||ID_||' ���.����� '||REF_||' dok='||l_dok||
         ' .fost R '||l_ostr_dok,'INFO',5);


l_ostr2:=0;
if l_accr2 is not NULL then
   begin
     select nvl(ostc,0)  into l_ostr2
     from accounts
     where acc=l_accr2 and ostc=ostb;
   EXCEPTION WHEN NO_DATA_FOUND THEN
     LOG('ISIN='||l_ISIN||' '||ID_||' ���.����� '||REF_||
         '.���������� ���-�� �� ���-�� ������ R2','ERROR');
     l_ostr2:=0;
     -- goto ZAP;
   end;
end if;

l_ostr2_dok:=0;
if l_accr2 is not NULL then
 --    LOG('ISIN='||l_ISIN||' '||ID_||' ���.����� '||REF_||' dok='||l_dok||
 --        ' .fost R2','INFO',0);

l_ostr2_dok:=FOST(l_accr2,l_dok);

LOG('ISIN='||l_ISIN||' '||ID_||' ���.����� '||REF_||' dok='||l_dok||
         ' OSTR2 ... '||l_ostr2_dok||' '||l_ostr2_dok,'INFO',5);
end if;

pnt:=5;
--logger.trace (l_trace||'ISIN='||l_ISIN||' pnt='||pnt||' ref='||REF_||' D1='||D1_);
if l_tip=1 then
begin
   select nvl(kup,0)*100 into kup_      --  ���/cnt
   from cp_dat
   where id=ID_    --and dok= decode(D1_,DE_,D2_,D1_)
         and npp= decode(D1_,DE_,1,(select npp+1 from cp_dat where id=ID_ and dok=D1_))
                                                ;
   LOG('ISIN='||l_ISIN||' ref='||REF_||' kup='||kup_/100||' ');
exception when NO_DATA_FOUND then kup_:=0;
   LOG('ISIN='||l_ISIN||' ref='||REF_||' 6 D1='||D1_||' D2='||D2_||' '||kup_,'INFO',1);
end;
end if;

if kup_ =0 and l_kv=980 then
   LOG('ISIN='||l_ISIN||' ref='||REF_||
       '! �����=0 '||' dat1='||l_dat1||' dat2='||l_dat2,'ERROR',1);
   goto ZAP;
end if;

l_kupon:=KUP_ * KOL1_;   -- ���/cnt
  LOG('ISIN='||l_ISIN||' ref='||REF_||
      ' �����(...)= '||l_kupon/100||' dat1='||l_dat1||' dat2='||l_dat2,'INFO',5);

 if l_tip=2 then
    if l_io=1 then D1_ := D1_ + 1; end if;
    if l_dat1 = l_daos and l_io=1 then  l_dat1:=l_dat1+1; end if;
 end if;

l_dkp:=D2_ - D1_;   -- ��� � ���. �����

if l_kv =980 then
   LOG('ISIN='||l_ISIN||' ref='||REF_||' D1='||D1_||' D2='||D2_||' '||kup_,'INFO',5);
   LOG('ISIN='||l_ISIN||' ref='||REF_||' l_dat1='||l_dat1||' p_dat2='||p_dat2,'INFO',5);
-- ���������� l_kupon := ?  ��� ���� �� ��� �� ���
   if l_pr1_kup = 2 then
       Kup1_ := Round( KUP_ * (  (p_Dat2  ) - (D1_-1) ) / (D2_-D1_) , 0);
       Kup2_ := Round( KUP_ * (  (l_Dat1-1) - (D1_-1) ) / (D2_-D1_) , 0);
       p_Int := KOL1_ * (Kup2_ - kup1_);
    else
       Kup1_ := KUP_ * (  (p_Dat2  ) - (D1_-1) ) / (D2_-D1_);
       Kup2_ := KUP_ * (  (l_Dat1-1) - (D1_-1) ) / (D2_-D1_);
       p_Int := Round(KOL1_ * (Kup2_ - kup1_) , 0);      -- ���
   end if;

elsIf l_kv = 36 and l_metr=515 then
   l_ir := ir_;
   l_nom :=  cena_ * kol1_;
   IR_ := IR_/100;
   l_kupon := round((IR_/365) * l_dkp * 100,3);  -- ����� �� ���. �����
--   l_kupon := l_kupon * (l_nom/100);
   l_kupon := l_kupon * l_nom;   -- * 100;   -- !! ���
   LOG('ISIN='||l_ISIN||' ref='||REF_||' ������ �����(036)= '||l_kupon/(100)
              ||' DOK='||D1_||' DNK='||D2_,'INFO',0);

   Kup1_ := (IR_/365) * (  (l_Dat2  ) - (D1_-1) );
   Kup2_ := (IR_/365) * (  (l_dat1-1) - (D1_-1) );
   kup1_ := round(kup1_*100,3);
   kup2_ := round(kup2_*100,3);
   p_int := kup1_*(l_nom/100) - kup2_*(l_nom/100);

   p_int:=p_int*100*(-1);   -- ���  !  act (<0) ����. �� -1  19/06-12
   ir_ := l_ir;

elsIf l_kv = 36 and l_metr in (8,23) then
   l_ir := ir_;
   l_nom :=  cena_ * kol1_;
   LOG('ISIN='||l_ISIN||' ref='||REF_||' cena='||cena_||' kol='||kol1_,'INFO');
-- ���������� l_kupon := ?  ��� 036
   IR_ := IR_/100;
   l_kupon := round((IR_/l_ky) * 100,3);
--   l_kupon := l_kupon * (l_nom/100);
   l_kupon := l_kupon * l_nom;   -- * 100;   -- !! ���/cnt
   LOG('ISIN='||l_ISIN||' ref='||REF_||' �����(036)= '||l_kupon/(100)
              ||' DOK='||D1_||' DNK='||D2_,'INFO',0);

   Kup1_ := (IR_/l_ky) * (  (l_Dat2  ) - (D1_-1) ) / (D2_-D1_);
   Kup2_ := (IR_/l_ky) * (  (l_dat1-1) - (D1_-1) ) / (D2_-D1_);
   kup1_ := round(kup1_*100,3);
   kup2_ := round(kup2_*100,3);
   p_int := kup1_*(l_nom/100) - kup2_*(l_nom/100);

   p_int:=p_int*100*(-1);   -- ���  !  act (<0) ����. �� -1  19/06-12
   ir_ := l_ir;
else
   if l_pr1_kup = 2 then
       Kup1_ := Round( KUP_ * (  (p_Dat2  ) - (D1_-1) ) / (D2_-D1_) , 0);
       Kup2_ := Round( KUP_ * (  (l_Dat1-1) - (D1_-1) ) / (D2_-D1_) , 0);
       p_Int := KOL1_ * (Kup2_ - kup1_);
    else
       Kup1_ := KUP_ * (  (p_Dat2  ) - (D1_-1) ) / (D2_-D1_);
       Kup2_ := KUP_ * (  (l_Dat1-1) - (D1_-1) ) / (D2_-D1_);
       p_Int := Round(KOL1_ * (Kup2_ - kup1_) , 0);      -- ���
   end if;


end if;

if p_int = 0 then
   LOG('ISIN='||l_ISIN||' ref='||REF_||' int='||p_int/100||' ���='||l_dn,'INFO',5);
   goto ZAP;
end if;

 l_dn:= l_dat2 - l_dat1 + 1;
 LOG('ISIN='||l_ISIN||' ref='||REF_||' int='||p_int/100||' ���='||l_dn||' tip='||l_tip,'INFO',5);
if l_tip=2 then
   p_int:=p_int*(-1);
   if l_stpdat is NULL and l_io=1 then l_stpdat := DP_ - 1; end if;
else
   l_stpdat := D2_ - 1;
end if;
LOG('ISIN='||l_ISIN||' ref='||REF_||' tip='||l_tip||' stpdat='||l_stpdat);
l_sint:= abs(l_ostr) + abs(l_ostr2);   -- ?? � ���� R2 - ��'����� �����
l_sint_dok:=0;
l_sint_dok:= l_ostr_dok + l_ostr2_dok;

fl_pg:=1;
if abs(l_sint_dok) >= l_kupon then null;
     fl_pg:=0;  -- ! �� �����
end if;

if l_sint > l_kupon and fl_pg=1 then
   p_int:=0;
   LOG('ISIN='||l_ISIN||' ref='||REF_||' sint='||l_sint/100||' > '||l_kupon/100||
       ' �������� ���� ����� ����������� %-� �������� ���� ������ � �����','ERROR',1);
goto ZAP;
--return;
end if;

   -- ��������� ����������� �� ������� �����
 if p_dat2 = l_stpdat and fl_pg=1 then
    if l_sint + abs(p_int) != l_kupon then
    p_int:= l_kupon - l_sint;
    if l_tip=1 then  p_int:= p_int * (-1); end if;   -- ���� ���������� ��������
    end if;
    LOG('ISIN='||l_ISIN||' ref='||REF_||' int='||p_int/100||' 6a stpdat='||l_stpdat||
        ' ������������ � ���. �����','INFO');
 end if;

 if abs(p_int) + l_sint > l_kupon and fl_pg=1 then
    LOG('ISIN='||l_ISIN||' ref='||REF_||' int='||abs(p_int/100)||' + '||l_sint/100||
        ' �������� ���� %-� �������� ���� ������ � �����','ERROR',1);
    --return;
    p_int:=0;
    goto ZAP;
 end if;

 If p_Mode = 0 then RETURN; end if;
 ----------------------------------

--if l_tip=2 then
begin
-- ryn, vidd, pf
select nd into l_nd from cp_v where ref=REF_;
EXCEPTION WHEN NO_DATA_FOUND THEN l_nd:='';
end;

if l_tip=2 then l_tname:='��';
elsif l_kv=036 then l_tname:='��';
else l_tname:='����';
end if;
l_paket:='';
  if abs(kol1_) >0 then l_paket:=' ����� '||abs(kol1_)||' ��.'; end if;

  if KUP_ is not NULL then l_stavka:='�����='||KUP_/100;
  else l_stavka:='������='||IR_||'%';
  end if;
--end if;   -- tip=2

IF l_tip=2 THEN
   l_nazn := '�����.% �� '||trim(l_tname)||' '||trim(l_ISIN)
          ||' ��.'||l_nd
          ||l_paket
          ||l_stavka
          ||' �� ����� '
          ||to_char(l_dat1,'dd.mm.yyyy')||' - '||to_char(l_dat2,'dd.mm.yyyy')
            ;
  ELSE
--     l_nazn:='';   -- ���� �� ��� ����
   l_nazn := '�����.%(�����) �� ���. '||l_nls||' '||trim(l_tname)||' '||trim(l_ISIN)
          ||' ��.'||l_nd||l_paket||l_stavka||' �� ����� '
          ||to_char(l_dat1,'dd.mm.yyyy')||' - '||to_char(l_dat2,'dd.mm.yyyy');
  END IF;
    l_nazn:=null;   --  ������   25/05-12

<<ZAP>> NULL;
pnt:=7;
 DELETE FROM acr_intN WHERE acc= p_Acc AND id= p_id;
 if p_int != 0 then
 INSERT INTO acr_intN (acc,  id  ,   fdat,   tdat, acrd , ir , br, osts, nazn,remi)
 VALUES               (p_acc,p_id, l_Dat1, p_Dat2, p_Int, ir_, 0, l_ost, l_nazn,0);
pnt:=8;
 end if;
LOG('ISIN='||l_ISIN||' ref='||REF_||' pnt='||pnt||' int='||p_int/100);

end;   -- INT_CP_P
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INT_CP_P.sql =========*** End *** 
PROMPT ===================================================================================== 
