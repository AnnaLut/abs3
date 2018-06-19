

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_IRR_BV.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_IRR_BV ***

  CREATE OR REPLACE PROCEDURE BARS.P_IRR_BV (p_ND number, R_DAT date ) is

--   p_ND > 0 -- l_mode := 1; �� �������� ��� + �� ���.��������� ��
--   p_ND < 0 -- l_mode := 2; �� �������� ��� + �� �������� ��

/*
17.12.2014 Sta + ����� �������� ������������� <DubininVO@oschadbank.ua>
1) � ����� �������� �� ���������� ������� �� ��������� ������� ���� (��� �� � �������� �� ��������� ����),
   �.� ��� ��������� � ������� ��� ������ ���� ������
2) ��������� ���� ��� ��������� ����������� ������ ��������� �� �����, ��������� ������� ������� �������������
3) �������� �� ��, ��� ��� ������� ������� ��������� �������, ���� ��������������� �������������� �������� ������ = ����,
   �� ������� ������� ��������� ������� (�� �� �������� ������� �� ��������� ����)
4) ����������� ������ ������� �� ���, ����� ������ ��.������ ���������� ����� ���� ��������� �� ����.

13.12.2014 ��� ������� ����� ����� ����� ��� �� ������/
                     ��������� ��.������ ������� � ����������� � ���.���� accountspv
25.11.2014 ������� ACR_DAT � ���� ACR_DOCS
24.11.2014 �������� R_DAT = ��������� ���� = ���� ��� ����.��.������ �� ���.���������'
����� �
1)� ���. ��������� ��������� ��������� %%+����� ����������� ��������� (��������� ���� ���������� +1) �� ���������� ���������� ���� �� ���������� ����
  17/11/2014 15:38 ����� �������� ������������� <DubininVO@oschadbank.ua>
  12.08.2014 Sta ������ http://jira.unity-bars.com.ua:11000/browse/BRSMAIN-2799
  "������ ��.������ (IRR) �� �������� ��������� ���������� ��������� (BV)" � ������ ���� ��������� ������� :
*/
  l_dat     date := nvl(R_DAT, gl.bdate) ;  -- ��������� ����
  l_mode  int    ;
  l_nd   number  ;
  nlchr char(2)  := chr(13)||chr(10) ;
  Dat_End date   ;
  l_sumG  number ;
  l_mdat  date   ;
  l_Ss    number := 0 ;
  r_MDAT  DATE   ;
  l_sd    number := 0 ; -- ����� ��������
  l_del   number ;
  l_Err  varchar2(50) ;
  l_acr_dat date ;
  l_ADD   number ; --��������� �������
  l_ord   number := 0;
  dTmp_     date ;
  nTmp_   number ;
  l_Irr   number ;
  e_Irr   number ;
  l_tag  SPARAM_LIST.tag%type := 'IRR_ET';
  l_SPID SPARAM_LIST.SPID%type;
  dd cc_deal%rowtype  ;
  a8 accounts%rowtype ;

  TYPE many1 IS RECORD ( SS1 NUMBER, SDP NUMBER, SS2 NUMBER, SN2 NUMBER);
  TYPE MANY  IS TABLE OF many1 INDEX BY VARCHAR2(8);
  tmp MANY  ;
  d8       VARCHAR2(8) ;
  d_today  VARCHAR2(8) ;  -- ������� = R_DAT
  ----------------------
  procedure prot1 ( p_ord IN OUT int, p_txt IN varchar2 ) is
  begin  p_ord := p_ord +1 ; insert into  TMP_OPERW(ord, value) values (p_ord, p_txt) ;
  end prot1;
 --------------
begin
return; -- cobuprvnix-161
  begin select SPID into l_SPID from SPARAM_LIST where tag = l_tag ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20000,'�� ����������� ��. �� ������ ����.'||l_tag  );
  end;
  ---------------------------------------
  delete from  TMP_OPERW;

  If p_ND > 0 and p_ND < 1 then RETURN;
  elsIf p_ND < 0           then l_mode := 2; l_nd := - p_nd           ; -- �� �������� ��� + �� �������� ��
  else                          l_mode := 1; l_nd :=   p_nd           ; -- �� �������� ��� + �� ���.��������� ��
  end if ;

  begin
     select d.* into dd from cc_deal d where d.nd = l_nd and sos < 14 ;
     select a.* into a8 from nd_acc n, accounts a where n.nd = l_nd and n.acc=a.acc and a.tip='LIM';
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20000,'LIM-�� '||l_nd || ' HE �������� ' );
  end;

  if a8.mdate <= l_dat    then
     raise_application_error(-20000,'����i� �i� �� '||l_nd||' ��������� '||to_char(a8.mdate ,'dd.mm.yyyy') );
  end if;
  a8.ostc := fost( a8.acc, l_dat);

  If l_dat = dd.sdate then  ------ a8.ostc = 0 then
     l_mode := 2;
  end if;

  ---- ��������������� �������� �� � ��� ( �� ���� � �� ����)
  select sum (sumG), max(fdat) into l_sumG, Dat_End from cc_lim where nd = l_nd ;

  -- �������� �� ��������� ���� � ���
  If Dat_End <> dd.Wdate then
     raise_application_error(-20000,
       '������� ���� � ��� '||to_char(dat_end,'dd.mm.yyyy')||nlchr||' �� = ���i ������ �� '||to_char(dd.wdate,'dd.mm.yyyy') );
  end if;

  delete from tmp_irr;
  delete from cc_many where nd = l_ND  ;

If l_mode =2  then ------------ �� ������� �� �� ------------------------------------
   l_ss  := - dd.sdog  * 100;
   l_dat := dd.sdate   ;
   If l_ss + l_SumG <> 0 then
      raise_application_error(-20000, '�� ������������ ��� � ���������� ������ �� �� =' || l_nd );
   end if;

   begin select cck_app.to_number2(nvl(TXT,0))*100 into l_sd from nd_txt where nd = l_ND and tag='S_SDI';
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;

   --- 1-) ������
   insert into TMP_IRR (   n,s) values (        1, l_ss+l_sd ) ;
   insert into cc_many (ND,FDAT,SS1, SDP, SN2) values ( l_nd, l_dat, l_ss/100, l_sd/100, 0 );
   --- 2+) ������� ���������
   insert into cc_many (ND,FDAT,SS1,ss2,SDP,SN2)
          select l_nd, fdat, 0, sumg/100, 0, (sumo-sumg-nvl(sumk,0) ) / 100 from cc_lim where nd = l_nd and fdat > l_dat;
   insert into TMP_IRR (  n,s)
          select  fdat-l_dat+1, (sumo-nvl(sumk,0)) from cc_lim where nd=l_nd and fdat > l_dat ;

else  ------------- �� ������� ���������� ��������� ��----------------------------------------

   -- �������� �� ������������ ����� ���� � ���
   select nvl(sum(fost(acc, l_dat )),0) into l_ss   from accounts where accc = a8.acc and tip ='SS '    ; -- ����.��.�������
   select nvl(sum(sumG) ,0)             into l_sumG from cc_lim   where nd   = l_nd   and fdat > l_dat  ; -- ����� �� ������ ����
   l_del := l_ss + l_sumG ; -- �������

   If    l_del < 0 then l_Err := '��������� �� �������.���� �i���������' ;
   elsIf l_del > 0 then l_Err := '������������ ��� �� ���� ������������';
   elsIf l_del = 0 then null;
   End if;

   If l_del <> 0 then
      raise_application_error(-20000, to_char(l_dat, 'dd.mm.yyyy') ||':�� ������������ ��� �� ������� �� =' || l_nd || nlchr ||
      ' ��i������ ���� �������� � ���=' || l_Sumg || nlchr ||
      ' ������� �� �i�� �� �� ���.SS='  || l_SS   || nlchr ||
      ' �����I��� �������� ' || l_Err   || l_del );
   end if;
   -----------------------------------------------------------
   tmp.DELETE;

   -- �������� �������( ������� ������� TMP_IRR) ������ � �������  �� �� ���,  ������� �� ��������� ������������
   for k in (SELECT * from cc_lim where nd = p_nd and fdat > l_dat order by fdat )
   LOOP d8 := TO_CHAR(k.fdat, 'yyyymmdd') ;
        tmp(d8).ss1 := 0 ;
        tmp(d8).sdp := 0 ;
        tmp(d8).ss2 := k.sumg ;
        tmp(d8).sn2 :=(k.sumo-k.sumg-nvl(k.sumk,0) ) ;
   end loop;

   ---- ��� �������� ������� � ������ ��������� ���� l_dat - ��� ����� ������ � ��� �� - ��� ���������
   d_today := TO_CHAR(l_dat ,'yyyymmdd');
   If NOT tmp.EXISTS(d_today) then
      tmp(d_today).ss1 := 0 ;
      tmp(d_today).sdp := 0 ;
      tmp(d_today).ss2 := 0 ;
      tmp(d_today).sn2 := 0 ;
   end if;

   prot1 ( l_ord, '�� ND = '|| l_nd|| ' ������.���� = '|| to_char(l_Dat,'dd.mm.yyyy')  ) ;

   -- ������������� ������ �� ������ BV ( � �� � ��������� ������� �� ���.���� � ����������� ����)  � ������� ���� - ����� ������
   for k in (select a.* from accounts a
             where a.acc in (select acc from nd_acc where nd =l_nd)
---------------and a.dazs is null ----------------------------
               and a.nbs like '2%'
               and a.tip in ( 'SS ' , -- ����.����,
                              'SDI' , -- �������
                              'SPI' , -- ������
                              ------------------
                              'SNO' , -- �������.����,
                              'SN ' , -- ����.���� ( �� ���� ���� + �� ������� ����) ,
                              'SP ' , -- ������������ ����,
                              'SPN' -- �������.����,
                            )
             order by decode( a.tip, 'SS ', 1, 2 )
            )
   loop
      k.ostc := fost ( k.acc, l_dat ) ; -- ����� ������ ��������� ���
      l_ADD  := 0 ;
      prot1 ( l_ord, '���.'|| k.tip|| ', ���.���.= '|| k.ostc  ) ;

      If k.tip = 'SS ' then
         -- ��� ��������� %%, ������� �� ������� � ����� ������ � ��������� ���
         begin  -- �� ����� ���� ��������� %% ?
            select greatest ( k.daos-1,acr_dat) into l_acr_dat from int_accn where acc = k.acc and id = 0 ;
            -- ��� ���� ����� ���������� %%. ���� ����������
            If l_acr_dat > l_dat - 1   then
               select max(int_date) into l_acr_dat from ACR_DOCS where  acc = k.acc and id = 0 and int_date < l_dat;
               If l_acr_dat is null then
                  raise_application_error(-20000, '�� �������� ����, �� ��� �����.%, �� � ����� ������������ ' || to_char(l_dat, 'dd.mm.yy'));
               end if;
            end if;

            If  l_acr_dat < l_dat - 1 then
               acrn.p_int( k.acc, 0, (l_acr_dat+1), (l_dat-1) , l_ADD, NULL, 0);
               l_ADD  := round ( l_ADD,0);
               prot1 ( l_ord, '������.���� = '|| l_ADD || ' �� ���i�� ' || to_char( (l_acr_dat+1), 'dd.mm.yyyy' ) || ' - '
                                                                        || to_char( (l_dat    -1) ,'dd.mm.yyyy' ) ) ;
            else
               prot1 ( l_ord, '������.���� = 0, ��� ���������� �� '|| to_char(l_acr_dat, 'dd.mm.yyyy')  ) ;
            end if;

         EXCEPTION WHEN NO_DATA_FOUND THEN null;
         end;

      Elsif k.tip = 'SDI' then
         -- �� �� ����� � � ������������ ��������/������.
         l_SD   := NORM_SDI  (dd.ND,  (l_dat-1)   ) ;
         l_ADD  := - greatest (  0, k.ostc - l_SD ) ;
         prot1 ( l_ord, '������: '|| pul.Get_Mas_Ini_Val('NORM_SDI')  ) ;
         prot1 ( l_ord, 'NORMA = '|| l_SD || ' �� ' || to_char( (l_dat-1), 'dd.mm.yyyy') || ' ���� ����� = '|| l_ADD );
      end if;

      tmp(d_today).ss1:= tmp(d_today).ss1 + k.ostc + l_ADD ; -- ��� ����� "������"
      ----------------------------------------------------------------------------

      -- ��� ��������� - ��������� - � ��������� ����
      If k.tip = 'SNO' then
         --�������� � ������� ������. ���� k.mdate
         d8:= TO_CHAR(greatest ( nvl(k.mdate,l_dat) ,l_dat) , 'yyyymmdd');
         If NOT tmp.EXISTS(d8) then
            tmp(d8).ss1 := 0;
            tmp(d8).sdp := 0;
            tmp(d8).ss2 := 0;
            tmp(d8).sn2 := 0;
         end if;
         tmp(d8).sn2 := tmp(d8).sn2 - k.ostc  ;

      ElsIf k.tip='SP ' then tmp(d_today).ss2 := tmp(d_today).ss2-k.ostc ;
      ElsIf k.tip='SPN' then tmp(d_today).sn2 := tmp(d_today).sn2-k.ostc ;
      End If;

   end loop;

   prot1 ( l_ord, to_char (l_dat,'dd.mm.yyyy') ||'. �����: ��� ������ ������=' || tmp(d_today).ss1 );
   prot1 ( l_ord, to_char (l_dat,'dd.mm.yyyy') ||', � �.�. �����.����p.����  =' || tmp(d_today).sn2 );
   prot1 ( l_ord, to_char (l_dat,'dd.mm.yyyy') ||', � �.�. �����.����p.���  =' || tmp(d_today).ss2 );
   -----------------------------------------------

   -- ��������� ������ � �������
   d8 := tmp.FIRST; -- ���������� ������ �� ������ ������
   WHILE d8 IS NOT NULL
   LOOP
      dTmp_ := to_date(d8,'yyyymmdd');
      tmp(d8).ss1 := nvl( tmp(d8).ss1/100,0);
      tmp(d8).ss2 := nvl( tmp(d8).ss2/100,0);
      tmp(d8).sdp := nvl( tmp(d8).sdp/100,0);
      tmp(d8).sn2 := nvl( tmp(d8).sn2/100,0);
      nTmp_ := ( tmp(d8).ss1 + tmp(d8).ss2 + tmp(d8).sdp + tmp(d8).sn2 ) * 100 ;
      insert into cc_many (ND,FDAT,SS1,ss2,SDP,SN2) values (l_nd, dTmp_, tmp(d8).ss1, tmp(d8).ss2, tmp(d8).sdp, tmp(d8).sn2);
      insert into TMP_IRR ( n,s) values ( (dTmp_ - l_Dat + 1) , nTmp_ );
      d8 := tmp.NEXT(d8); -- ���������� ������ �� ����.���� ������
   end loop;
end if;

 l_irr:= round(XIRR(10)*100,8);

 -- �������� ��.������ :
 -- ������� (���� ��� ) �������� ��� ��.������
 insert into int_accn (acc,id,metr,basey,freq)
       select a8.acc,-2,0,0,5   from dual   where not exists (select 1 from int_accn where acc = a8.acc and id = -2);

 -- ������� ��� ������� ������ � �������� ����� l_irr
 delete from int_ratn where acc = a8.acc and id = -2 and bdat >= l_DAT;
 insert into int_ratn (acc,id,bdat,ir) values (a8.acc, -2, l_DAT, l_irr );
 prot1 ( l_ord, '�� ���� ' || to_char(l_dat,'dd.mm.yyyy') || ' ����������� ����.��/��.='|| l_irr);

 -- ��������� ��.������ :
    -- ��� �������� ��.������ � 1-� ������ ���� S ����: S = (l_ss+l_sd+l_sn)
    -- ��� ��������� ��.������ ��� ���� ��������� ������ �� �������� �������, �.�. S = (l_ss +l_sn) ��� S := S - l_sd
 update tmp_irr set s = S - l_sd where n = 1;
 e_irr := round( XIRR(10)*100, 8 );
 update cc_deal set ir = e_irr where nd = l_nd  ;
 delete from ACCOUNTSPV where acc = a8.acc and PARID = l_SPID and dat1 >= l_dat ;
 insert into ACCOUNTSPV ( ACC, DAT1, PARID, VAL ) values ( a8.acc, l_dat, l_SPID, to_char(e_irr) );
 prot1 ( l_ord, '�� ���� ' || to_char(l_dat,'dd.mm.yyyy') || ' ����������� ����.��/��.='|| e_irr);

end p_irr_BV;
/
show err;

PROMPT *** Create  grants  P_IRR_BV ***
grant EXECUTE                                                                on P_IRR_BV        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_IRR_BV        to RCC_DEAL;
grant EXECUTE                                                                on P_IRR_BV        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_IRR_BV.sql =========*** End *** 
PROMPT ===================================================================================== 
