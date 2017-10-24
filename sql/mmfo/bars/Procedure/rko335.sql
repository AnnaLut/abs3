CREATE OR REPLACE PROCEDURE BARS.RKO335(P_dat1 DATE,P_dat2 DATE, P_nls varchar2, p_branch varchar2, p_flag varchar2)
IS
DKON_KV     VARCHAR2(22):=f_DKON_KV(P_dat1,P_dat2);
L_DOC_NOPAY NUMBER(5);
L_OPERTIME  CHAR(4);
L_OPERTIME2 CHAR(4);
okpo_       Char(12);
l_nls       VARCHAR2(14);
l_branch    VARCHAR2(30):=SYS_CONTEXT ('bars_context','user_branch');
l_cnt1      INTEGER;        --�-���� ���������� �� ���. ��������  �� ����. �������
l_s1        NUMBER(25);     --���� ���������� �� ���. �������� �� ����. �������
l_cnt2      INTEGER;        --�-���� ���������� �� ���. ��������  ����� ����. �������
l_s2        NUMBER(25);     --���� ���������� �� ���. �������� ����� ����. �������
l_cnt3      INTEGER;        --�-���� ���������� ������-���� �� ����. �������
l_s3        NUMBER(25);     --���� ���������� ������-���� �� ����. �������
l_cnt4      INTEGER;        --�-���� ���������� ������-���� ����� ����. �������
l_s4        NUMBER(25);     --���� ���������� ������-���� ����� ����. �������
l_cnt5      INTEGER;        --�-���� �������� ����������
l_s5        NUMBER(25);     --���� �������� ����������
l_s_all     INTEGER;        --���� �����
kkk_        number(3);      --K�� ����.�������
OprTime1    CHAR(4);
OprTime2    CHAR(4);
n_tarpak    number(6);      --����� ������
BEGIN
   BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE RKO_335';
   END;

FOR k IN (SELECT ACC, BRANCH, NLS
          FROM   ACCOUNTS
          WHERE  NLS like P_nls and KV=980 and DAZS is NULL
            and  ACC in (Select ACC from RKO_LST)
            and branch like decode(p_branch,'�������',sys_context('bars_context','user_branch'), p_branch) ||p_flag
          )

 LOOP


------   ���������� kkk_ - K�� ����.�������  
   BEGIN  
     Select r.KODK  Into  kkk_         
     From   RNKP_KOD r, Accounts a
     Where  a.NLS=k.NLS and a.KV=980 and  a.RNK=r.RNK  and  
            r.RNK is not NULL and r.KODK is not NULL and rownum=1;
   EXCEPTION  WHEN NO_DATA_FOUND THEN
     kkk_:=0;
   END;  


------   ���������� ���������: 



IF      gl.amfo = '302076'  then   --  1. ������� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'  then   ---- 1) ���  ------

          L_OPERTIME2:='1630';  --   ������� ��� ���������.����
          L_OPERTIME :='1700';  --   ������� ����            

   ELSIF  kkk_=2                   then   ---- 2) �������� ---

          L_OPERTIME2:='1600';  --   ������� ��� ���������.����
          L_OPERTIME :='1700';  --   ������� ����             

   ELSE                                   ---- 3) ������ ��.
          L_OPERTIME2:='1600';  --   ������� ��� ���������.����
          L_OPERTIME :='1600';  --   ������� ����.�����

   END IF;


ElsIf   gl.amfo = '313957'  then   --  2. ���������  
------------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'   then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                    then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSIF  kkk_=5                    then  --- 3) ���������

          L_OPERTIME2:='1700';  
          L_OPERTIME :='1700';  
   
          If k.NLS='26008301141401' then
               L_OPERTIME2:='1630';  
               L_OPERTIME :='1630';  
          end if;
   
   ELSE                                   --- 4) ������ ��.

          L_OPERTIME2:='1600';  --   ������� ��� ���������.����
          L_OPERTIME :='1600';  --<-  ������� ����.�����
   
   END IF;


ElsIf   gl.amfo = '323475'  then   --  3. ����������
-------------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'    then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                     then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                    --- 3) ������ ��.
   
          L_OPERTIME2:='1500';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '324805'  then   --  4. ����
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'          then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                          then  --- 2) ��������
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                         --- 3) ������ ��.

          L_OPERTIME2:='1530';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '325796'  then   --  5. �����    
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'    then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSIF  kkk_=2                     then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSIF  kkk_=17                    then  --- 3) �����������

          L_OPERTIME2:='1645';   --   ������� ��� ���������.����
          L_OPERTIME :='1745';   --   ������� ����            

   ELSE                                         --- 4) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '326461'  then   --  6. ��������    
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1500';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1445';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����            

   END IF;


ElsIf   gl.amfo = '328845'  then   --  7. ������    
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
  
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
  
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
  
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1530';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����            

   END IF;


ElsIf   gl.amfo = '331467'  then   --  8. �������  
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
  
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
  
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --<-  ������� ����.�����              
   
   END IF;


ElsIf   gl.amfo = '337568'  then   --  9. ����      
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����.�����              
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����.�����              
   
   END IF;


ElsIf   gl.amfo = '351823'  then   -- 10. �������
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
 
   ELSE                                     --- 3) ������ ��.

         L_OPERTIME2:='1500';    --   ������� ��� ���������.����
         L_OPERTIME :='1600';    --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '353553'  then   -- 11. ��������
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSIF  kkk_=8                      then  --- 3) ������
   
          L_OPERTIME2:='1700';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 4) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1600';   --   ������� ����.�����
   
   END IF;

ElsIf   gl.amfo = '305482'  then   -- 12. ��������������   
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                         --- 3) ������ ��.
           
          L_OPERTIME2:='1700';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '335106'  then   -- 13. ������      
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '311647'  then   -- 14. ������� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '336503'  then   -- 15. ��-����� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.
           
          L_OPERTIME2:='1700';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '304665'  then   -- 16. ������� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '303398'  then   -- 17. ���� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE    
                                            --- 3) ������ ��.
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '333368'  then   -- 18. ����� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '338545'  then   -- 19. ���������
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '312356'  then   -- 20. ������� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1545';   --   ������� ��� ���������.����
          L_OPERTIME :='1645';   --   ������� ����            

   ELSIF  kkk_=5                      then  --- 3) ���������
   
          L_OPERTIME2:='1645';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            

   ELSIF  kkk_=8 or kkk_=11           then  --- 4) ������
                                                --- 5) ���������
          L_OPERTIME2:='1700';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';               
   
   ELSE                                     --- 6) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '352457'  then   -- 21. ������ 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '315784'  then   -- 22. ����������� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '354507'  then   -- 23. �������� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.
          
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   END IF;


ElsIf   gl.amfo = '356334'  then   -- 24. �������� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.
          
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            

   END IF;


ElsIf   gl.amfo = '300465'  then   -- 25. ���   
----------------------------------------------------

   ----  ���������� ���� �������:
   BEGIN
      Select c.OKPO Into okpo_
      From   Accounts a, Customer c
      Where  a.ACC=k.ACC  and  a.RNK=c.RNK and rownum=1;
   EXCEPTION  WHEN NO_DATA_FOUND THEN
      okpo_:='0';
   END;


   IF     okpo_='00035323' or
          kkk_ = 1                 then  --- 1)  ���
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSIF  okpo_='21560766'         then  --- 2)  ����������

          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1730';   --   ������� ����            
   
   ELSIF  okpo_='00100227'         then  --- 3)  ���������
   
          L_OPERTIME2:='1545';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            

   ELSIF  okpo_ in ('21560045',          --- 4)  ��������
                    '01181736',
                    '36282474'
                    )        or
          kkk_ = 2                 then
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSIF  okpo_='20077720'         then  --- 5)  ��������  
   
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1730';   --   ������� ����            
   
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
                    

          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            

   
   ELSIF  okpo_ in ( '00034045',           --- 7)  ������i�����  
                     '20078961',
                     '01073828',
                     '01071315',
                     '01072609',
                     '01074957',
                     '01059900' 
                    )              then
   
          L_OPERTIME2:='1645';   --   ������� ��� ���������.����
          L_OPERTIME :='1745';   --   ������� ����            

   ELSIF  okpo_='36425142'         then    --- 8)  ��������Ͳ 


          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1730';   --   ������� ����            
   
   ELSIF  okpo_='31570412'         then    --- 9)  ������������� 
   
          L_OPERTIME2:='1700';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                    --- 10)  ��� ������ ��.

          L_OPERTIME2:='1530';   --   ������� ��� ���������.����
          L_OPERTIME :='1630';   --   ������� ����            

   END IF;


ElsIf   gl.amfo = '322669'  then   -- 26. ���� 
----------------------------------------------------

   IF     kkk_=1     or
          substr(k.NLS,1,3)='256'     then  --- 1) ���
      
          L_OPERTIME2:='1630';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
    
   ELSIF  kkk_=2                      then  --- 2) ��������
   
          L_OPERTIME2:='1600';   --   ������� ��� ���������.����
          L_OPERTIME :='1700';   --   ������� ����            
   
   ELSE                                     --- 3) ������ ��.
          
          L_OPERTIME2:='1530';   --   ������� ��� ���������.����
          L_OPERTIME :='1630';   --   ������� ����            

   END IF;

End If;


--------------------------------------------------------------

---  ���������� ����� �����A: 

  BEGIN
     SELECT to_number(VALUE)
     INTO   n_tarpak
     FROM   AccountsW 
     WHERE  ACC = k.ACC
        and TAG = 'SHTAR';

  EXCEPTION WHEN NO_DATA_FOUND THEN
     n_tarpak := 0; 
  END;

---------------------------------------------------------------
---
---      ����� ��������������� ����.������� �� �����
---      ---------------------------------------------

 BEGIN      

   SELECT trim(w.VALUE)
   INTO   OprTime1
   FROM   Accounts a, AccountsW w
   WHERE  a.ACC = w.ACC
      and w.TAG = 'OPTIME1'
      and a.ACC = k.ACC ;

   if OprTime1 is not NULL     and 
      to_number(OprTime1)>=800 and to_number(OprTime1)<=2400 then 

         L_OPERTIME:=OprTime1;   --   ������� ����

   end if;

 EXCEPTION WHEN OTHERS THEN
   null; 
 END;


 BEGIN      

   SELECT trim(w.VALUE)
   INTO   OprTime2
   FROM   Accounts a, AccountsW w
   WHERE  a.ACC = w.ACC
      and w.TAG = 'OPTIME2'
      and a.ACC = k.ACC ;

   if OprTime2 is not NULL     and 
      to_number(OprTime2)>=800 and to_number(OprTime2)<=2400 then 

         L_OPERTIME2:=OprTime2;  -- ������� ��� ���������.����

   end if;

 EXCEPTION WHEN OTHERS THEN
   null; 
 END;


BEGIN

---------------------------------------------------------
----  ���������� ���. ���������� ��������:
    SELECT NVL(t.doc_nopay,0)
        INTO L_DOC_NOPAY
        FROM tarif_scheme t,
             accountsw w
        WHERE     w.tag = 'SHTAR'
              AND t.id  = w.VALUE
              AND w.acc = k.acc;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        L_DOC_NOPAY:=0; 
    END;
----------------------------------------------------------



If n_tarpak >= 38 then   ---  + + + + + + + + + + + + + + + + + + + + + + + + + +
                         
  BEGIN                  ---  ���������� - ������ IB1,IB2  !!!
  SELECT nls,
         SUM (bumdo16),
         SUM (s_bumdo16),
         SUM (bumposle16),
         SUM (s_bumposle16),
         SUM (kbdo16),
         SUM (s_kbdo16),
         SUM (kbposle16),
         SUM (s_kbposle16),
         SUM (vxod),
         SUM (s_vxod),
         SUM (s)
    INTO l_nls,
         l_cnt1,
         l_s1,
         l_cnt2,
         l_s2,
         l_cnt3,
         l_s3,
         l_cnt4,
         l_s4,
         l_cnt5,
         l_s5,
         l_s_all
    FROM (SELECT DISTINCT nls,
                          NVL ( (DECODE (FL, 1, CNT)), 0) bumdo16,
                          NVL ( (DECODE (FL, 1, S)), 0) s_bumdo16,
                          NVL ( (DECODE (FL, 0, CNT)), 0) KBDO16,
                          NVL ( (DECODE (FL, 0, S)), 0) S_KBDO16,
                          NVL ( (DECODE (FL, 3, CNT)), 0) bumPOSLE16,
                          NVL ( (DECODE (FL, 3, S)), 0) S_bumPOSLE16,
                          NVL ( (DECODE (FL, 4, CNT)), 0) KBPOSLE16,
                          NVL ( (DECODE (FL, 4, S)), 0) S_KBPOSLE16,
                          NVL ( (DECODE (FL, 2, CNT)), 0) VXOD,
                          NVL ( (DECODE (FL, 2, S)), 0) S_VXOD,
                          s
            FROM (  SELECT nls,
                           BRANCH,
                           fl,
                           COUNT (*) CNT,
                           SUM (S) S
                      FROM (
                            -------------------------------------------------------
                            SELECT nls,
                                   branch,
                                   FL,
                                   S
                              FROM (

                                    SELECT nls,
                                           branch,
                                           FL,
                                           S,
                                           ROWNUM r
                                      FROM (SELECT nls,
                                                   branch,
                                                   FL,
                                                   S,
                                                   REF
                                             FROM (SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 1  --- ��������� ������ (001,002,...)
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 0  --- ��������� ����   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and (t.TT like 'IB%' or t.TT like 'CL%')  ---- **************************
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND TO_CHAR (
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                                        'HH24MI'
                                                                       ) <=
   decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
   -- L_OPERTIME
                                                           AND d.s > 0
                                                   UNION ALL
                                                   SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 3  --- ��������� ������ (001,002,... )
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 4  --- ��������� ����   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and (t.TT like 'IB%' or t.TT like 'CL%')  ---- **************************
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND TO_CHAR (
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                                         'HH24MI'
                                                                        ) > 
   decode((Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
   -- L_OPERTIME
                                                           AND d.s > 0
                                                    ORDER BY REF))
                                     WHERE s > 0 )
                             WHERE r > L_DOC_NOPAY                 --- O���������� ������ L_DOC_NOPAY ��������
                                                                   --------------------------------------------  
--  ================================================================================================================
                                                           UNION ALL
                            SELECT nls,
                                   branch,
                                   FL,
                                   S
                              FROM (

                                    SELECT nls,
                                           branch,
                                           FL,
                                           S,
                                           ROWNUM r
                                      FROM (SELECT nls,
                                                   branch,
                                                   FL,
                                                   S,
                                                   REF
                                             FROM (SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 1  --- ��������� ������ (001,002,...)
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 0  --- ��������� ����   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and t.TT not like 'IB%' and t.TT not like 'CL%'   ---- **************************
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND TO_CHAR ( 
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                                         'HH24MI'
                                                                        ) <=
   decode((Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
   -- L_OPERTIME
                                                           AND d.s > 0
                                                   UNION ALL
                                                   SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 3  --- ��������� ������ (001,002,... )
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 4  --- ��������� ����   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           and t.TT not like 'IB%' and t.TT not like 'CL%'    ---- **************************
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND TO_CHAR (
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                                         'HH24MI'
                                                                        ) > 
   decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
   -- L_OPERTIME
                                                           AND d.s > 0
                                                    ORDER BY REF))
                                     WHERE s > 0)
                           ----- WHERE r > L_DOC_NOPAY             --- O���������� ������ L_DOC_NOPAY ��������
                                                                   --------------------------------------------  
--  ================================================================================================================
                                                           UNION ALL
                                                    SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           2 FL,
                                                            F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.tt = t.tt
                                                           AND t.DK=1
                                                           AND d.DK=1
                                                           AND d.s > 0)     
                     WHERE s > 0
                  GROUP BY NLS, BRANCH, FL))
        GROUP BY nls;
  EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
        l_nls:=null;  --�� ��� ������ � ������� ����������� ���, ������ ��������
  END;


ELSE   ---+ + + + + + + + + + + + + + + + + + + + + + +

                         ---  ���������� - ���  !!!
  BEGIN
  SELECT nls,
         SUM (bumdo16),
         SUM (s_bumdo16),
         SUM (bumposle16),
         SUM (s_bumposle16),
         SUM (kbdo16),
         SUM (s_kbdo16),
         SUM (kbposle16),
         SUM (s_kbposle16),
         SUM (vxod),
         SUM (s_vxod),
         SUM (s)
  INTO l_nls,
       l_cnt1,
       l_s1,
       l_cnt2,
       l_s2,
       l_cnt3,
       l_s3,
       l_cnt4,
       l_s4,
       l_cnt5,
       l_s5,
       l_s_all
    FROM (SELECT DISTINCT nls,
                          NVL ( (DECODE (FL, 1, CNT)), 0) bumdo16,
                          NVL ( (DECODE (FL, 1, S)), 0) s_bumdo16,
                          NVL ( (DECODE (FL, 0, CNT)), 0) KBDO16,
                          NVL ( (DECODE (FL, 0, S)), 0) S_KBDO16,
                          NVL ( (DECODE (FL, 3, CNT)), 0) bumPOSLE16,
                          NVL ( (DECODE (FL, 3, S)), 0) S_bumPOSLE16,
                          NVL ( (DECODE (FL, 4, CNT)), 0) KBPOSLE16,
                          NVL ( (DECODE (FL, 4, S)), 0) S_KBPOSLE16,
                          NVL ( (DECODE (FL, 2, CNT)), 0) VXOD,
                          NVL ( (DECODE (FL, 2, S)), 0) S_VXOD,
                          s
            FROM (  SELECT nls,
                           BRANCH,
                           fl,
                           COUNT (*) CNT,
                           SUM (S) S
                      FROM (SELECT nls,
                                   branch,
                                   FL,
                                   S
                              FROM (SELECT nls,
                                           branch,
                                           FL,
                                           S,
                                           ROWNUM r
                                      FROM (SELECT nls,
                                                   branch,
                                                   FL,
                                                   S,
                                                   REF
                                             FROM (SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 1  --- ��������� ������ (001,002,...)
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 0  --- ��������� ����   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND TO_CHAR ( 
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                                         'HH24MI'
                                                                        ) <=
   decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
   -- L_OPERTIME
                                                           AND d.s > 0
                                                    UNION ALL
                                                    SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           CASE
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=13) THEN 3  --- ��������� ������ (001,002,... )
                                                              WHEN D.TT IN (Select TT from RKO_TTS where DK=0 and NTAR=14) THEN 4  --- ��������� ����   (KL1,KL2,IB1,IB2,PS1,PS2)
                                                           END FL,
                                                           o.REF,
                                                           F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.TT = t.TT
                                                           AND t.DK=0
                                                           AND d.DK=0
                                                           AND TO_CHAR (
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                                         'HH24MI'
                                                                        ) > 
   decode( (Select count(*) from HOLIDAY where trunc(o.PDAT+1)=HOLIDAY and KV=980), 0, L_OPERTIME, L_OPERTIME2 )
   -- L_OPERTIME
                                                           AND d.s > 0
                                                    ORDER BY REF))
                                     WHERE s > 0)
                             WHERE r > L_DOC_NOPAY                 --- O���������� ������ L_DOC_NOPAY ��������
                                                                   --------------------------------------------  
                                                           UNION ALL
                                                    SELECT a.NLS nls,
                                                           a.branch BRANCH,
                                                           2 FL,
                                                            F_TARIF_RKO (
                                                              t.ntar,
                                                              a.kv,
                                                              a.nls,
                                                              d.s,
                                       nvl2((Select 1 From RKO_REF where REF=o.REF), (Select max(DAT) from OPER_VISA where REF=o.REF and GROUPID not in (30,80)), o.PDAT),
                                                              TO_DATE (DKON_KV,'DD/MM/YYYY'),
                                                              o.NLSA,
                                                              o.NLSB,
                                                              o.MFOA,
                                                              o.MFOB,
                                                              t.TT,
                                                              a.ACC,
                                                              o.D_REC, o.REF) S
                                                      FROM oper o,
                                                           opldok d,
                                                           accounts a,
                                                           RKO_TTS t,
                                                           RKO_LST r
                                                     WHERE     a.acc = k.acc
                                                           AND a.acc = r.acc
                                                           AND a.acc = d.acc
                                                           AND d.REF = o.REF
                                                           AND d.sos = 5
                                                           AND d.fdat >= P_dat1
                                                           AND d.fdat <= P_dat2
                                                           AND d.tt = t.tt
                                                           AND t.DK=1
                                                           AND d.DK=1
                                                           AND d.s > 0)     
                     WHERE s > 0
                  GROUP BY NLS, BRANCH, FL))
    GROUP BY nls;
  EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
        l_nls:=null;  --�� ��� ������ � ������� ����������� ���, ������ ��������
  END;


END IF;        ---  END IF   ���������� !!!

---+ + + + + + + + + + + + + + + + + + + + + + + + + + +

 BEGIN
   IF l_nls IS NOT NULL THEN --������ �� ���������
      INSERT INTO RKO_335 (branch,nls,cnt1,s1,cnt2,s2,
                               cnt3,  s3 ,cnt4,s4,cnt5,s5,s_all)
      VALUES (k.branch,l_nls,l_cnt1,l_s1,l_cnt2,l_s2,
              l_cnt3,l_s3,l_cnt4,l_s4,l_cnt5,l_s5,l_s_all);
   END IF;
 END;

 COMMIT;
END LOOP;
END;
/

grant execute on RKO335 to start1;
grant execute on RKO335 to bars_access_defrole;
