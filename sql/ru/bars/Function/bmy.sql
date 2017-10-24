
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bmy.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BMY (mode_ int ) RETURN number IS
  sTmp_ varchar2(80);
  kod_    number ;
  kol_    number ;
  nom_    number ;
  cena1_  number ;
  cena2_  number ;
  cenaf1_ number ;
  cenaf2_ number ;

  ---------------
  NOMI_   number :=0;
  KUPM_   number :=0;
  KUPN_   number :=0;
  KUPP_   number :=0;
  PDVM_   number :=0;
  PDVN_   number :=0;
  DEBM_   number :=0;
  KUPF_   number :=0;
  PDVF_   number :=0;
  DEBF_   number :=0;
  PDV_    number :=0;
  PROD_   number :=0;
  PRODF_ number :=0;
  DOX_    number :=0;
  S_      number :=0 ;
  DOXP_   number :=0;
/*

16-09-2013 NVV    DEBM_ - ������� ������� �������
              �������� ����������  BMF �������-����(for BMY)-
			     ����              ����.���.(for BMY)


13-05-2013 EAY ��������� ������� ��� ... ���������� �����, ����������
�� ��� ��� ����������

1    �� 1001 �� 2909 ���� ���������
2    �� 9910 �� 9819 �� ���� ��������� �������
3    �� 3522 �� 2909 �� ���� ����������� ������� � ���
4    �� 2909 �� 3622 �� ���� ����������� �����"������ � ���
5    �� 2909 �� 1919 �� ���� �������� ���� ��� � ���
6    �� 2909 �� 6399 �� ���� ������ �������� ����� �� ���������


10-11-2010 Sta ������������ ������� ���������� �� ���.�������������
              --2.BMU �������-����(for BMY)--D:2909/23  K:3500/07

08-11-2010 Sta  �����.�����

--���� ������������ ������     500,00     cena1
--���� ������������ �� �������      10,00  cenaf1
--������� ������           20,00     nom_mon
--���� ������� ������         1421,00     cena2
--���� ������� �� �������      10,00     cenaf2

1. ������������ ����� - ���������� �����
�����         ������        �����
3906/2        3900        500+10=510 ( cena1+ cenaf1 )

2. ������������� - �������� ������
�����         ������        �����
1001        3906/2        20,00    �������= nom_
3500/07        3906/2        400,00    �������= cena1+ PDVM-nom
3400/19        3906/2        8,33    ������ = cenaf1 - PDVF
3522/51        3906/2        81,67    ���    = PDVM   + PDVF

3. ���������� ������ � ��������
N TT    �����         ������        �����
0.BMY    1001        2909/23        1431,00              = cena2  + cenaf2
3.BM3   2909/23            3622/51        235,17    ���       = [(cena2+cenaf2-nom)/6]
4.BM4   2909/23         6399/14        767,50    �����     = �����
1.BMC   2909/23         1001        20,00    �������   = nom
5.BMF   2909/23         3400/19        8,33    �������-� = cenaf1 - PDVF
2.BMU   2909/23         3500/07        400,00    �������-M = cena1  + PDVM-nom
6.BMV   2909/23         3400/...        400,00    �������-M = cena1  + PDVM-nom


*/
begin
  -- ������� ������ ���������� ��� �������� BMY
  begin
     select value into sTmp_ from operw  where ref=gl.aREF and tag ='BM__C';
     kod_ := Nvl(to_number(sTmp_),0);

     select value into sTmp_ from operw  where ref=gl.aREF and tag ='BM__K';
     kol_ := Nvl(to_number(sTmp_),0);

     select s into s_ from oper  where ref=gl.aREF ;

     select Nvl(nom_mon,0),Nvl(cena2,0),Nvl(cenaf2,0),Nvl(cena1,0),Nvl(cenaf1,0)
     into       nom_ ,         cena2_,      cenaf2_,      cena1_  ,    cenaf1_
     from  v_MON1  where kod=kod_;

     ----------------------------------------
     --1.BMC �������(for BMY)     --D:2909/23  K:1001      20,00= nom
     NOMI_  := nom_  *100*kol_    ;
     NOMI_  := round(greatest(NOMI_,0))  ;

 --    logger.info('BMY  NOMI_='||NOMI_);


     ----------------------------------------
     --2.BMU �������-����(for BMY)--D:2909/23  K:3500/07  400,00= cena1+PDVM-nom
     IF  NOM_<>0 THEN
         KUPM_  := (cena1_-nom_)*100*kol_ ;
         PDVM_  := round(KUPM_/6,0)   ;
         DEBM_  := KUPM_ - PDVM_;--- CENAF2_*100*kol_;
         DEBM_  :=round(greatest(DEBM_,0) ) ;
        ELSE KUPM_  := 0;
     END IF;
 --    logger.info('BMY  DEBM_='||DEBM_);
     ----------------------------------------
     --3.BM3 ��� ��������(for BMY)--D:2909/23  K:3622/51  235,17=[(cena2+cenaf2-nom)/6]
     PROD_  := (cena2_-nom_)*100*kol_;
     PRODF_  := cenaf2_*100*kol_;
     PDV_   := round( (PROD_ + PRODF_)/6,0) ;
     PDV_   := greatest(PDV_, 0)  ;

--  logger.info('BMY  PDV_='||PDV_);
     ----------------------------------------
     --5.BMF �������-����(for BMY)--D:2909/23  K:3400/19    8,33=cenaf1-PDVF
     KUPF_  := (cenaf1_)*100*kol_ ;
     PDVF_  := round(KUPF_/6,0)   ;
     DEBF_  := KUPF_ - PDVF_      ;
     DEBF_  := round(greatest(DEBF_,0)) ;

--  logger.info('BMY  DEBF_='||DEBF_);
          ----------------------------------------
     --4.BM4 ����.���.(for BMY)   --D:2909/23  K:6399/14  767,50 =
     DOX_   := PROD_ + PRODF_ - DEBM_ - DEBF_ -PDV_;
     DOX_   := round(greatest(DOX_, 0)) ;
--logger.info('BMY  PROD_ - DEBM_ - DEBF_ -PDV_='||PROD_||' - '||DEBM_||' - '||DEBF_ ||' - '||PDV_);
--logger.info('BMY  DOX_='||DOX_);
     ----------------------------------------
     --6.BKC �������-����(for BKY)--D:2909/23  K:1919/06  400,00= cena1
         KUPP_  := (cena1_+cenaf2_)*100*kol_ ;
      ----------------------------------------
     --7 BKN ��������� ������(for BKY)--D:3522/,,,  K:2909/23
         KUPN_  := (cena1_+cenaf2_-nom_)*100*kol_ ;
         PDVN_  := round((KUPN_)/6,0)   ;
     ----------------------------------------
     --8 BKB ������ �����  --D:2909/23  K:6399/14  767,50 =
     DOXP_   := PROD_ - DEBM_ - DEBF_ -PDV_;
     DOXP_   := round(greatest(DOX_, 0)) ;
     ----------------------------------------

     If mode_= 1 then Return NOMI_; end if;
     If mode_= 2 then
        DEBM_:= DEBM_ + (S_ - NOMI_ - DEBM_ - DEBF_ - PDV_ - DOX_);
        Return DEBM_;
     end if;
     if mode_= 3 then Return PDV_ ; end if;
     If mode_= 4 then Return DOX_ ; end if;
     If mode_= 5 then Return DEBF_; end if;
     If mode_= 6 then Return KUPP_; end if;
     If mode_= 7 then Return PDVN_; end if;
     If mode_= 8 then Return DOXP_ ; end if;
  EXCEPTION  WHEN NO_DATA_FOUND THEN null;
  end;
  return S_;
end BMY;
/
 show err;
 
PROMPT *** Create  grants  BMY ***
grant EXECUTE                                                                on BMY             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BMY             to PYOD001;
grant EXECUTE                                                                on BMY             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bmy.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 