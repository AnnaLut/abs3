---========================================================================================

CREATE OR REPLACE FUNCTION BARS.KOMIS_DP1_VIP
                 ( 
                   p_S         NUMERIC,   
                   p_NLSA      VARCHAR2,    
                   p_KV        INTEGER,
                   p_KMVIP     VARCHAR2      
                 )       
----------------------------------------------------------------------------------------
--
--   ������� ������� ����� ������������ �������� KD9  (KD9 - ������������ � DP1)
--
--  ��� ������� ��������, ���� ��������� DP1 �������� ���. �� ����� 2620 VIP-������� 
--  (������� '�������' ��� '������') � ������������ ��������� �����������  KMVIP = 1
--  "������� ����� � VIP-�볺��� (1-���,2-ͳ)" 
--
--  ��������:   �� 2620 - �� 6510/28
----------------------------------------------------------------------------------------

RETURN NUMERIC IS           
   sk_        NUMERIC ;             --  C���� ��������  (� ���)
   rnk_       accounts.RNK%type ;
   vip_       NUMERIC ;
   ern        CONSTANT POSITIVE := 803;
BEGIN

  vip_ := 0;

  Begin

     SELECT RNK  into  rnk_ 
     From   Accounts 
     Where  NLS = p_NLSA  and KV = p_KV ; 

     SELECT  1  into vip_
     FROM  V_CUSTOMER_SEGMENTS
     WHERE RNK = rnk_
       AND CUSTOMER_SEGMENT_FINANCIAL IN ('�������','������')
       AND ROWNUM = 1;

  Exception when NO_DATA_FOUND then

     Return 0;

  End;

      
  If substr(p_NLSA,1,4)='2620' and  vip_ = 1  Then    ---  ��� VIP-�볺�� !

     If     trim(p_KMVIP) ='0' then

    ----    raise_application_error (- (20000 + ern), '\9999   �� VIP-�볺��. ������ ���.������� < ������� ����� � VIP (1-���,2-ͳ) >.  ����� �� ��������: ��� ������ ��������, ����������� ���.������� � ���� �������� �� "��������",  ������ �������� �� ��.��� � ����� ������� ������� �������� (�� ������� �������� �����, �����) ', TRUE);
        raise_application_error (- (20000 + ern), '\9999   �� VIP-�볺��. ������ ���.������� "������� ����� � VIP (1-���,2-ͳ)" �� ����������� �������� ���� (1%, �i�.=20 ���) � ���.�볺���.', TRUE);
                       
     ElsIf  trim(p_KMVIP) ='1' then

        sk_ := F_TARIF(151,980,p_NLSA,p_S);

     ElsIf  trim(p_KMVIP) ='2' then

        sk_ := 0;

     Else

        raise_application_error (- (20000 + ern),  '\9999   �������� ���.�������� "������� ����� � VIP" �� ���� 1 ��� 2', TRUE);

     End If;

  Else 

    sk_ := 0 ;

  End If;
 

  RETURN sk_ ;   
          
END KOMIS_DP1_VIP;
/

grant execute on KOMIS_DP1_VIP to START1;

