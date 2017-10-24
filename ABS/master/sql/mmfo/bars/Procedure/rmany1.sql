

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RMANY1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RMANY1 ***

  CREATE OR REPLACE PROCEDURE BARS.RMANY1 
(p_REF1 number , -- ��� ��������� ������ �� �������
 p_REF2 number  -- ��� ��������� ������ �� �������/�����������
) is
-- v.1.1  22/11-12
  Id_    cp_deal.id%type  ;
  l_vdat date   ;
  SUMB_ NUMBER  ; -- ���.����� �������
  n0_   NUMBER  ; -- ������� ��������
  n_    NUMBER  ; -- ������� ��������
  N1_   number  := 0 ; -- ������� � ��������� � ��������� ����
  -------------
  DATE_       cp_kod.DAT_em%type    ;
  DATP_       cp_kod.DATP%type      ;
  CENA_       cp_kod.CENA%type      ;
  PERIOD_KUP_ cp_kod.PERIOD_KUP%type;
  DOK_        cp_kod.DOK%type       ;
  KY_         cp_kod.KY%type        ;
  IR_         cp_kod.IR%type        ;
  ---------------------------------
  nKol_  int    ;
  nInt1_ number ;
  ----------------


BEGIN
  -- � ���� �� ��� ������ ������ ?
  begin
     -- ���� �� �������
     select e.id ,  o.vdat,  O.s,   ( fost(e.acc,o.vdat) - fost(e.acc,(o.vdat-1)) ) , fost(e.acc,o.vdat)
     into     ID_,  l_vdat, SUMB_, N0_,    N_
     from  cp_deal e, oper o
     where o.ref  = p_REF2 and  e.ref = p_REF1  and fost( e.acc, o.vdat) < 0 ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN ;
  end;
  -----------
  --���� �� ��������� ���� � ������� �������� �������� ?
  begin
    select k.PERIOD_KUP ,k.dok ,k.KY ,k.cena ,nvl(k.IR,0), k.datp, k.dat_em
    into     PERIOD_KUP_,  DOK_,  KY_,  CENA_,  IR_,  DATP_, DATE_
    from  cp_kod k, cp_dat d
    where k.id=ID_ and d.id=k.ID and d.dok=k.DATP;
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-(20000+333),
    '\ ��� ������� �������� �������� ��� �� id=' || ID_ ||' , ref='||p_REF1,TRUE);
  end;

  --����������� � �����
  insert into CP_MANY_upd (REF,FDAT,SS1,SDP,SN2)  select REF,FDAT,SS1,SDP,SN2 from cp_many where ref=p_REF1;

  -- �������� �� ������� ������� ����������� ��������
  delete from cp_many where ref=p_ref1 and fdat >= l_vdat;

  --���������� ������ ���.������
  nKol_ := Abs(N_ /(100*CENA_)); -- �������� ����

  -- ����� ���.���� �� % ������ � ����� (���� 28.67)
  If KY_ > 0          then nInt1_ := Round( CENA_*IR_/KY_,0) / 100;
  ElsIf PERIOD_KUP_>0 then nInt1_ := Round( CENA_*IR_*PERIOD_KUP_/365,0) / 100;
  Else                     nInt1_ := 0;
  end if;

  -- ������� � ��������� � ��������� ����  � ���� ��.��
  select -N_/100 - sum(nvl(a.nom,0)) * nkol_  into N1_ from cp_dat A  where a.id=ID_ and a.DOK > l_VDAT;


  -- ���� ���� ������� (� ���)
  insert into cp_many(REF ,FDAT  , SS1             , SDP   , SN2          )
             select p_REF1,l_VDAT, N0_/100        , (SUMB_-N0_)/100, 0           from dual    -- ����-1 ("������" �������) ���������� �����.
   union all select P_REF1,DOK   , nKol_*nvl(nom,0), 0     , nKol_*Nvl (KUP,nInt1_) from cp_dat  where id=ID_ and DOK>l_VDAT and DOK<DATp_ -- ����-i ����� ������ � ����.��������
   union all select P_REF1,DOK   , N1_             , 0     , nKol_*Nvl (KUP,nInt1_) from cp_dat  where id=ID_ and dOK=DATp_ ;-- ����-� ����� ����.������ � ���.��������

END RMany1;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RMANY1.sql =========*** End *** ==
PROMPT ===================================================================================== 
