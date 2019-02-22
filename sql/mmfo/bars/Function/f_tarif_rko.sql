CREATE OR REPLACE FUNCTION BARS.f_tarif_rko
                 ( kod_  INTEGER,      -- ��� ������
                   kv_   INTEGER,      -- ������ ��������
                   nls_  VARCHAR2,     -- ���.����� �����
                   s_    NUMERIC,      -- ����� ��������
                   PDAT_ DATE,         -- ����/����� ��������� ����.����
                DKON_KV  DATE,         -- ���� ����.���.��� ��������
                   NLSA_ VARCHAR2,     -- Oper.NLSA
                   NLSB_ VARCHAR2,     -- Oper.NLSB
                   MFOA_ VARCHAR2,     -- Oper.MFOA
                   MFOB_ VARCHAR2,     -- Oper.MFOB
                   TT_   CHAR,         -- Oper.TT
                   ACC_  NUMBER,       -- ACC �����
                 D_REC_  VARCHAR2,
                   REF_  NUMBER        -- REF 
                 )       
                            
RETURN NUMERIC IS       
    
  OprTime   Char(4) ;      
  sk_       NUMERIC ;      
  not15_    Char(4) ;      
  uz_       NUMERIC ;
  kkk_      NUMERIC ;
  peredsv   NUMERIC ;
  ob22_NLSB Char(2) ;     -- OB22 ����� NLSB
  n_tarpak  NUMBER  ;     --  � ��������� ������

  OprTime1  Char(4) ;
  OprTime2  Char(4) ;

  maket_    NUMERIC ;
  okpo_     Char(12);
  vvod_     NUMERIC ;    --  OperW/TAG='VVOD' = 1 - ���� ���� ��������� �� ϳ��������
                         --  ��� �������� 001,002,PKR

  bussl_    Char(12);    --  �������������� �������:   ='1' - ��,  ='2' - ����

--------------------------------------------------------------------------- 
--
--               ������������� F_TARIF_RKO  -  ��� ���� ��               
--                      
--   ��������� PS1, PS2       - ������ ���� �� 205 ������ (�������� ��������).   
--   ��������� 001, 002, PKR  - ����� ���� �� 205 ������ - ��� ������� �����. ���.���������.   
--
--------------------------------------------------------------------------- 
BEGIN

 vvod_ := 0;

 If kod_<>15 and TT_ in ('001','002','PKR') then    ---  "������" ��������� 

    Begin 
      Select 1 into kkk_ 
      from   OperW 
      where  REF=REF_ and TAG='DOG_S' and VALUE='1';
    
      RETURN  F_TARIF(205, kv_, nls_, s_);  --- �������� �������� - �� 205 ������
    
    EXCEPTION  WHEN NO_DATA_FOUND THEN
      null;
    End;
    
    Begin                     ----  ���.���� "���� ���� ��������� �� ϳ��������"
      Select 1 into vvod_      --- ���� ���� ��������� �� ϳ�������� (���� ���� ���� � '001','002')
      from   OperW 
      where  REF=REF_ and TAG='VVOD' and VALUE<>'0';
    EXCEPTION  WHEN NO_DATA_FOUND THEN
      vvod_ := 0;
    End;

 End If;




----  ���������� kkk_ - K�� ����.�������:

 kkk_:=0;            
 BEGIN  
   Select r.KODK  Into  kkk_         
   From   RNKP_KOD r, Accounts a
   Where  a.ACC=ACC_  and  a.RNK=r.RNK  and  
          r.RNK is not NULL and r.KODK is not NULL and rownum=1;
 EXCEPTION  WHEN NO_DATA_FOUND THEN
   kkk_:=0;
 END;  


---  ����������  � ���.������  n_tarpak :

 BEGIN

    SELECT to_number(w.VALUE)
    INTO   n_tarpak
    FROM   Accounts a, AccountsW w
    WHERE  a.ACC = w.ACC
       and w.TAG = 'SHTAR'
       and a.ACC = ACC_ ;

 EXCEPTION WHEN others THEN
    n_tarpak := 0; 
 END;


-----  ��������� PS0,PS1,PS2,PS5,PSG:

 If TT_ like 'PS%' and kod_<>15 then

    if n_tarpak in (14,15)  then        ---  ��������� (�� 14,15)
       sk_:=F_TARIF(283,kv_,nls_,s_);
       RETURN sk_;
    end if;

    sk_:=F_TARIF(205,kv_,nls_,s_);
    RETURN sk_;

 End if;



---  ����������:  �� ������� ����� �� �����, ���� � ������� �����   
---  ������������ �����  (� ��� ��� ���������� �������� ������ ��� 
---  ������ "� �������")


 IF kod_ in (13,14) and ( gl.amfo<>'300465'  OR  gl.amfo='300465' and n_tarpak > 0 )  then   ----  ���������:

    --  �� ����� �� �� �� ����������  (����� ��� � ��������):
    ---------------------------------------------------------
    if substr(NLSB_,1,4) in ('2525','2546','2610','2611','2651','3570','2900','6510','6514' ) and 
       MFOA_=MFOB_  and  kkk_ not in (1,2)  then

       RETURN 0;

    end if;


    --  �� ����� �� �� �� 2600/05, 3739/05,12  (����� ��� � ��������):
    ------------------------------------------------------------------
    if (substr(NLSB_,1,4)='3739' or substr(NLSB_,1,4)='2600') and 
       MFOA_=MFOB_                                            and 
       kkk_ not in (1,2)        then

       Begin 

         Select OB22 into ob22_NLSB 
         from   ACCOUNTS
         where  KV=980 and NLS=NLSB_;

         if substr(NLSB_,1,4)='2600' and ob22_NLSB='05' then  
            RETURN 0;
         end if;

         if substr(NLSB_,1,4)='3739' and ob22_NLSB in ('05','12') then  
            RETURN 0;
         end if;

       EXCEPTION  WHEN NO_DATA_FOUND THEN
         null;
       End;

    end if;

 END IF;


 -----  ����������  "� ����� ��" / "�� ���i ��" :

 IF gl.amfo='300465' THEN       ----  ���:

    ---   � ��� ���������� �����.  �� ����� ��� 29 ������ ������ ���.     
    ---   maket_ = 1  - ����������
    ---   maket_ = 2  - � ����� �� (���)
    ---   maket_ = 3  - �� ���i �� (���)
    
    If   MFOA_ = MFOB_  then
         maket_:=1;
    Else
         if kod_ in (13,14) then   -- ��������� (kod_ = 13,14 )
             Begin
               Select 2  into  maket_
               from   BANKS$BASE where MFO=MFOB_ and BLK=0 and MFOU='300465';
               maket_:=2;                                      -------------
             EXCEPTION  WHEN NO_DATA_FOUND THEN
               maket_:=3;
             END;
         else                       -- ��������  (kod_ = 15 )
             Begin
               Select 2  into  maket_
               from   BANKS$BASE where MFO=MFOA_ and BLK=0 and MFOU='300465';
               maket_:=2;                                      -------------
             EXCEPTION  WHEN NO_DATA_FOUND THEN
               maket_:=3;
             END;
         end if;
    End If;
    
    If maket_ = 3 then 
       uz_ := 1;  ---  "�� ���i ��"
    Else 
       uz_ := 0;  ---  "� ����� ��"
    End If;

 ELSE 
                                ----  ��:
    uz_ :=0;
    If  kod_<>15 and MFOA_<>MFOB_ then    ---  ��������� ������� 
        Begin
          Select 0 into uz_ from BANKS$BASE where MFO=MFOB_ and BLK=0 and MFOU='300465';
          uz_:=0;  ---  "� ����� ��"                                      -------------
        EXCEPTION  WHEN NO_DATA_FOUND THEN
          uz_:=1;  ---  "�� ���i ��"
        END;
    End If;       ---  uz_:=0  -  "� ����� ��"
                  ---  uz_:=1  -  "�� ���i ��"
 END IF;



-------- 1).  ���������� ����.�����:  -------------------------------------- 


---                 � ������ �� - ������ ������� ����.�����


---  ��� ������� ����  ���  ���  ������� ��� ���������.����:
 
 Begin                      --  peredsv=0 - ������� ����           
   Select 1 into peredsv    --  peredsv=1 - ��. ��� ����������.����
   from   HOLIDAY                   
   where  trunc(PDAT_+1)=HOLIDAY and KV=980;   
 EXCEPTION WHEN NO_DATA_FOUND THEN
   peredsv:=0; 
 END;                                    


 IF      gl.amfo = '302076'  then   --  1. ������� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'        then   ---- 1) ���  ------

          if peredsv=1           then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;

   ELSIF  kkk_=2                        then   ---- 2) �������� ---

          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;

   ELSE                                        ---- 3) ������ ��.
          OprTime:='1600';       --<-  ������� ����.�����

   END IF;

 ElsIf   gl.amfo = '313957'  then   --  2. ���������  
 ------------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if    trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1           then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSIF  kkk_=5                          then  --- 3) ���������
   
          If nls_='26008301141401' then
               OprTime:='1630';  
          end if;
   
          If nls_ like '2603%31414%' then
               OprTime:='1700';  
          end if;
   
   ELSE                                         --- 4) ������ ��.
          OprTime:='1600';       --<-  ������� ����.�����
   
   END IF;

 ElsIf   gl.amfo = '323475'  then   --  3. ����������
 -------------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 4) ������ ��.
   
          if peredsv=1   then  
             OprTime:='1500';    --   ������� ��� ���������.����
          else
             OprTime:='1600';    ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '324805'  then   --  4. ����
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if   trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1630';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1530';    --   ������� ��� ���������.����
          else
             OprTime:='1600';    ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '325796'  then   --  5. �����    
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
   
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSIF  kkk_=17                         then  --- 3) �����������
   
          if  peredsv=1  then
               OprTime:='1645';  --   ������� ��� ���������.����
          else
               OprTime:='1745';  --   ������� ����             
          end if;
   
   ELSE                                         --- 4) ������ ��.
          OprTime:='1600';   --<-  ������� ����.�����                
   
   END IF;

 ElsIf   gl.amfo = '326461'  then   --  6. ��������    
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
              OprTime:='1500';  --   ������� ��� ���������.����
          else
              OprTime:='1600';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1445';    --   ������� ��� ���������.����
          else
             OprTime:='1600';    ---<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '328845'  then   --  7. ������    
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
  
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1           then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
  
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
  
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
              OprTime:='1530';    --   ������� ��� ���������.����
          else
              OprTime:='1600';    ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '331467'  then   --  8. �������  
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
  
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
  
   ELSE                                         --- 3) ������ ��.
          OprTime:='1600';   --<-  ������� ����.�����              
   
   END IF;

 ElsIf   gl.amfo = '337568'  then   --  9. ����      
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          OprTime:='1600';  
   
   ELSE                                         --- 3) ������ ��.
          OprTime:='1600';  --<-  ������� ����.�����               
   
   END IF;


   --1). �� �������� ��������� PS1 �� ���� 260323010414 ��������� �� ����� !

     if kod_=15  and  nls_='260323010414' and TT_='PS1' then
        RETURN 0 ;                              
     end if;

   --2). �� ���������� �������� (kod_=15) � 2902*  �� ����� !

     if kod_=15            and  MFOA_=MFOB_          and 
        NLSA_ like '2902%' and  NLSB_ like '26%'     then 
        RETURN 0 ;
     end if;


   --3). �� ���������� �������� ��������� 015  � 2924* �� 26*  �� ����� !

     if kod_=15  and  TT_='015'  and  NLSA_ like '2924%' and  NLSB_ like '26%'  then
        RETURN 0 ;
     end if;


 ElsIf   gl.amfo = '351823'  then   -- 10. �������
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1           then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  to_char(PDAT_,'D')='6'  then
               OprTime:='1600';  --   �������  ( ��� ���������.���� !!! )
          else                                  ------------------------
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1500';    --   ������� ��� ���������.����
          else
             OprTime:='1600';    ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '353553'  then   -- 11. ��������
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1630';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSIF  kkk_=8                          then  --- 3) ������
   
          OprTime:='1700';               
   
   ELSE                                         --- 4) ������ ��.
          OprTime:='1600';    ---<-  ������� ����.�����
   
   END IF;

 ElsIf   gl.amfo = '305482'  then   -- 12. ��������������   
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1           then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
           
          If kod_=13 then     
             OprTime:='1630';    -- �����.���
          else
             OprTime:='1700';    -- ������� ����.�����
          end if;
   
   END IF;

 ElsIf   gl.amfo = '335106'  then   -- 13. ������      
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    --<-  ������� ����.�����             
          end if;
   
   END IF;

   --------------  ��   2560 - 373960003  ����� �� ����� !
   If  ( NLSA_='256023772062' and NLSB_='373960003' )  then 
      RETURN 0 ;
   End If;

   --------------  ��   2560 - 3570/02   ����� �� ����� !
   If  substr(NLSA_,1,4)='2560' and substr(NLSB_,1,4)='3570'  then 
       Begin 
         Select OB22 into ob22_NLSB 
         from   ACCOUNTS
         where  KV=980 and NLS=NLSB_;
   
         if ob22_NLSB='02' then  
            RETURN 0;
         end if;
       EXCEPTION  WHEN NO_DATA_FOUND THEN
         null;
       End;
   End If;



 ElsIf   gl.amfo = '311647'  then   -- 14. ������� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if    trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    ---<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '336503'  then   -- 15. ��-����� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if peredsv=1  then
              OprTime:='1600';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
           
          OprTime:='1700';      --<-  ������� ����.�����
   
   END IF;

 ElsIf   gl.amfo = '304665'  then   -- 16. ������� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    ----<-  ������� ����.�����             
          end if;
   
   END IF;


   if kod_=15 and NLSA_ like '2568%'      then 
      RETURN 0 ;
   end if;


 ElsIf   gl.amfo = '303398'  then   -- 17. ���� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
     ---  if  trunc(PDAT_)=DKON_KV  then
     ---      OprTime:='2400';   --   ����.���.���� ��������
   
          if peredsv=1           then
              OprTime:='1600';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    ---<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '333368'  then   -- 18. ����� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1           then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '338545'  then   -- 19. ���������
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    ----<-  ������� ����.�����             
          end if;
   
   END IF;


   if kod_=15  and TT_='I00' and  Substr(nls_,1,4)<>'2560'  then
      RETURN 0 ;                              
   end if;



 ElsIf   gl.amfo = '312356'  then   -- 20. ������� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1           then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1545';  --   ������� ��� ���������.����
          else
               OprTime:='1645';  --   ������� ����             
          end if;
   
   ELSIF  kkk_=5                          then  --- 3) ���������
   
          if  peredsv=1  then
               OprTime:='1645';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSIF  kkk_=8 or kkk_=11               then  --- 4) ������
                                                --- 5) ���������
          OprTime:='1700';               
   
   ELSE                                         --- 6) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';       -- ������� ��� ���������.����
          else
             OprTime:='1700';  ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '352457'  then   -- 21. ������ 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
     ---  if  trunc(PDAT_)=DKON_KV  then
     ---      OprTime:='2400';   --   ����.���.���� ��������
   
          if peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '315784'  then   -- 22. ����������� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          if peredsv=1   then  
             OprTime:='1600';    --   ������� ��� ���������.����
          else
             OprTime:='1700';    ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '354507'  then   -- 23. �������� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  ----<-  ������� ����.�����
          end if;
   
   END IF;

 ElsIf   gl.amfo = '356334'  then   -- 24. �������� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  ----<-  ������� ����.�����             
          end if;
   
   END IF;

 ElsIf   gl.amfo = '300465'  then   -- 25. ���   
 ----------------------------------------------------

   ----  ���������� ���� �������
   Begin
      Select c.OKPO Into okpo_
      From   Accounts a, Customer c
      Where  a.ACC=ACC_  and  a.RNK=c.RNK ;
   EXCEPTION  WHEN NO_DATA_FOUND THEN
      okpo_:='0';
   End;


   IF     okpo_='00035323' or
          kkk_ = 1                 then  --- 1)  ���
   
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����
          end if;
   
   ELSIF  okpo_='21560766'         then  --- 2)  ����������
   
          if  peredsv=1  then
               OprTime:='1630';  --   ������� ��� ���������.����
          else
               OprTime:='1730';  --   ������� ����
          end if;
   
   ELSIF  okpo_='00100227'         then  --- 3)  ���������
   
          if  peredsv=1  then
               OprTime:='1545';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����
          end if;
   
   ELSIF  okpo_ in ('21560045',          --- 4)  ��������
                    '01181736',
                    '36282474'
                    )        or
          kkk_ = 2                 then
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����
          end if;
   
   ELSIF  okpo_='20077720'         then  --- 5)  ��������  
   
          if  peredsv=1  then
               OprTime:='1630';  --   ������� ��� ���������.����
          else
               OprTime:='1730';  --   ������� ����
          end if;
   
   ELSIF  okpo_ in ('04737111',          --- 6)  ����� 
                    '26008588',
                    '04736991',
                    '34292653',
                    '25975458',
                    '34292669',
                    '34425528',
                    '25956299',
                    '04737022',
                    '04737039',
                    '04736940',
                    '34292695',
                    '04737016',
                    '04736956',
                    '34425486',
                    '34425512',
                    '34425533',
                    '34425575',
                    '34425580',
                    '34425562',
                    '04736962',
                    '34292700',
                    '34292681',
                    '34425554',
                    '34292674',
                    '04737008',
                    '34425549',
                    '34425507',
                    '34292721',
                    '34425491',
                    '34292716' 
                   )               then
                    
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����
          end if;
   
   ELSIF  okpo_ in ( '00034045',           --- 7)  ������i�����  
                     '20078961',
                     '01073828',
                     '01071315',
                     '01072609',
                     '01074957',
                     '01059900' 
                    )              then
   
          if  peredsv=1  then
               OprTime:='1645';  --   ������� ��� ���������.����
          else
               OprTime:='1745';  --   ������� ����
          end if;
   
   ELSIF  okpo_='36425142'         then    --- 8)  ��������Ͳ 
   
          if  peredsv=1  then
               OprTime:='1630';  --   ������� ��� ���������.����
          else
               OprTime:='1730';  --   ������� ����
          end if;
   
   ELSIF  okpo_='31570412'         then    --- 9)  ������������� 
   
          OprTime:='1700';  
   
   ELSE                                   --- 10)  ��� ������ ��.
          if peredsv=1   then
             OprTime:='1530';    --    ������� ��� ���������.����
          else
             OprTime:='1630';    --<-  ������� ����.�����
          end if;
   
   END IF;

 ElsIf   gl.amfo = '322669'  then   -- 26. ���� 
 ----------------------------------------------------

   IF     kkk_=1     or
          substr(nls_,1,3)='256'          then  --- 1) ���
      
          if  trunc(PDAT_)=DKON_KV  then
              OprTime:='2400';   --   ����.���.���� ��������
          elsif peredsv=1  then
              OprTime:='1630';   --   ������� ��� ���������.����
          else
              OprTime:='1700';   --   ������� ����            
          end if;
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          if  peredsv=1  then
               OprTime:='1600';  --   ������� ��� ���������.����
          else
               OprTime:='1700';  --   ������� ����             
          end if;
   
   ELSE                                         --- 3) ������ ��.
          
          if  peredsv=1  then
               OprTime:='1530';  --   ������� ��� ���������.����
          else
               OprTime:='1630';  ----<-  ������� ����.�����             
          end if;
   
   END IF;


 End If;


---=====================  ������ 6757  ========================================

---   ��� ������ ��   (bussl_ = '1'):  ������� �����  
---   ��� ������ ���� (bussl_ = '2'):  �������� 001,002,PKR,MM2 - 14:00
---                                    �������� IB%, CL%        - 17:00

 IF gl.amfo in ('353553','325796') and trunc(PDAT_) >= to_date('01/03/2019','dd/mm/yyyy') Then     ---  �����, ��������
  
    Begin
       Select trim(c.VALUE) Into bussl_
       From   Accounts a, CustomerW c
       Where  a.ACC=ACC_  and  a.RNK=c.RNK  and  c.TAG='BUSSL' ;
    EXCEPTION  WHEN NO_DATA_FOUND THEN
       bussl_ := '2';     ---  ���� �� �����, �� ������� ����
    End;
    
    If bussl_ = '2' then             ----  ����.����� ��� ����:
    
       If  TT_ like 'IB%' or TT_ like 'CL%' then   
           ----OprTime := '1700';                      --  ��-����
           NULL;
       Else 
           OprTime := '1400';                      --  ��
       End If;
    
    End If;

 End If;

---===========================================================================

---  ����������� �� �������.����.����� �� ����� ?  ��� ����� ��������� ��������� !

 BEGIN

   SELECT trim(w.VALUE)
   INTO   OprTime1
   FROM   Accounts a, AccountsW w
   WHERE  a.ACC = w.ACC
      and w.TAG = 'OPTIME1'
      and a.ACC = ACC_ ;

   if OprTime1 is not NULL and  to_number(OprTime1)>=800 and to_number(OprTime1)<=2400 then 
      OprTime:=OprTime1;
   end if;

 EXCEPTION WHEN OTHERS THEN
   null; 
 END;


 If peredsv = 1 then              --  ��� ������� ��� �������������� ���� 
 BEGIN
   SELECT trim(w.VALUE)
   INTO   OprTime2
   FROM   Accounts a, AccountsW w
   WHERE  a.ACC = w.ACC
      and w.TAG = 'OPTIME2'
      and a.ACC = ACC_ ;

      if peredsv=1  and  OprTime2 is not NULL and  to_number(OprTime2)>=800 and to_number(OprTime2)<=2400 then
      OprTime:=OprTime2;
   end if;
 EXCEPTION WHEN OTHERS THEN
      null; 
 END;
 End If;


-- if trunc(PDAT_)=to_date('12/10/2015','dd/mm/yyyy') and 
--    TT_ in ('IB1','IB2')    then
--
--    OprTime:='2400';       
--
-- end if;



-----------------------------------------------------------------------------------
----------------------   2).     ������ ������:  ---------------------------------- 
-----------------------------------------------------------------------------------


 -------    29 ������ ������ ��� :  -------------

 IF n_tarpak = 0  and  gl.amfo = '300465'  then      

   If    nls_ in ('26007302163',                   
                  '26008501800',
                  '26007501942'  )    then 

      if kod_=15  then
         if  maket_=2 then
             RETURN 30;
         else 
             RETURN 0;
         end if;
      elsif  kod_<>15 and maket_=1 then
         RETURN 0;
      end if;

   ElsIf nls_ in ('26005501955'   ,
                  '26009501905712',
                  '26008301862'   ,
                  '260273011177'  ,
                  '260053011177'  ,
                  '260063011206'  ,
                  '260023011262'  ,
                  '26041303861'   ,
                  '260413011102'    ) then

      if kod_=15 and maket_=1 then
          RETURN 0;
      end if;

   ElsIf nls_ in ('260045011114'  ,
                  '26006501901980' )  then

      if kod_=15  then
         if maket_=2 then
            RETURN 30;
         else 
            RETURN 0;
         end if;
      end if;

   ElsIf nls_ = '26004301811'         then

      if kod_<>15 and maket_=1 then
          RETURN 0;
      end if;


   ElsIf nls_ in ('26049301768'   ,
                  '26048302768'   ,
                  '26041301830'   ,
                  '26007301863'   ,
                  '26046501914711',
                  '260483011174'  ,
                  '260313011176'  ,
                  '260033031203'  ,
                  '260023011233'  ,
                  '260033021284'  ,
                  '260023011369'  ,
                  '260003011389'  ,
                  '260003011428'   )  then

      if maket_=1 then
          RETURN 0;
      end if;

   ElsIf nls_ = '26004301811'         then

      if kod_=15 and maket_=1 then
          RETURN 25;
      end if;

   End If;

 END IF;

 -------------------------------------------



 if    kod_=13   then                     --  �����.���i�

       If uz_=1  then   ---  "�� ���i ��"

          if to_char(PDAT_,'HH24MI') <= OprTime  OR  vvod_ = 1  then     
             sk_:=F_TARIF(13, kv_, nls_, s_);    --------------
          else
             sk_:=F_TARIF(16, kv_, nls_, s_);
          end if;

       Else             ---  "� ����� ��"

          if to_char(PDAT_,'HH24MI') <= OprTime  OR  vvod_ = 1  then    
             sk_:=F_TARIF(113, kv_, nls_, s_);   --------------
          else
             sk_:=F_TARIF(116, kv_, nls_, s_);
          end if;

       End If;


 elsif kod_=14  then                      --  ��i���-����   

       If uz_=1  then       ---  "�� ���i ��"

          if to_char(PDAT_,'HH24MI') <= OprTime   then 
             sk_:=F_TARIF(14, kv_, nls_, s_);
          else
             sk_:=F_TARIF(17, kv_, nls_, s_);
          end if;

       Else                 ---  "� ����� ��"

          if to_char(PDAT_,'HH24MI') <= OprTime   then 
             sk_:=F_TARIF(114, kv_, nls_, s_);
          else
             sk_:=F_TARIF(117, kv_, nls_, s_);
          end if;

       End If;


 else              -------  �� ��i��i (kod_ = 15):


       IF    gl.amfo = '302076'             then   --  1. ������� 
       -----------------------------------------------------------
             BEGIN                   -- ���� �� ����� ���������� ����.���. NOT15 = 1
                SELECT  trim(VALUE)  -- "��: �� ����� ����� �� �����.��i��i", �� ��     
                into    not15_       -- ���������� �������� �� ����� !                         
                FROM    AccountsW    
                WHERE   ACC=acc_ and TAG='NOT15';
             EXCEPTION  WHEN NO_DATA_FOUND THEN
                not15_:=NULL;
             END;
             
             if (not15_='1' and MFOA_=MFOB_)               OR 
                NVL(instr(D_REC_,'#T2.1.12.1.1#'),0) > 0   then
                   sk_:=0;
             else
                   sk_:=F_TARIF(15, kv_, nls_, s_);
             end if;


       ELSIF gl.amfo = '336503' and kkk_=1  then   -- 15. ��-�����
       -----------------------------------------------------------

             if to_char(PDAT_,'HH24MI') <= OprTime  then 
                  sk_:=F_TARIF(15, kv_, nls_, s_);
             else
                  sk_:=200;  ---<--  �� ��i��i �� 2560 ��� ����� 17:00
             end if;                                       -----------


       ELSIF gl.amfo = '325796'             then   --  5. �����
       -----------------------------------------------------------

             if NVL(instr(D_REC_,'#T2.1.12.1.1#'),0)>0 then
                sk_:=0;
             else
                if n_tarpak = 0  and  substr(nls_,1,4)='2620' then  -- ��i��i �� 2620/07 
                   if s_<=5000000 then
                      sk_:=s_*1/100;   --  s_ <= 50 ���.��� - 1%, �� �� ������ 5 ��� 
                      if sk_<500 then  
                         sk_:=500;
                      end if;
                   else
                      sk_:=s_*0.5/100; --  s_ >  50 ���.��� - 0.5%
                   end if;
                else
                   sk_:=F_TARIF(15, kv_, nls_, s_);
                end if;
             end if;

       ELSE
       -----------------------------------------------------------

             if NVL(instr(D_REC_,'#T2.1.12.1.1#'),0)>0 then
                sk_:=0;
             else
                sk_:=F_TARIF(15, kv_, nls_, s_);
             end if;
             
       END IF;


 end if;

 RETURN sk_;


END f_tarif_rko ;
/

