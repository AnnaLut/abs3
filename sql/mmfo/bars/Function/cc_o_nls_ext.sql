CREATE OR REPLACE FUNCTION BARS.CC_O_NLS_EXT
  (bal_     in varchar2,  
   RNK_     in int,
   sour_    in int,
   ND_      in int,
   kv_      in int,
   tip_bal_ in varchar2,
   tip3_    in varchar2, -- ��� �������� �����
   PROD_    in varchar2,
   TT_      in out varchar2
  )
RETURN number IS

 -- 08.06.2018 Sta  ��������� ��  ³����� �������� <viktoriia.semenova@unity-bars.com>

  ID_  int    := 0;   -- id ���� ��������
  ACC_ number :=null ; -- ���������� 
  a2 accounts%rowtype;
  kk cck_ob22%rowtype;
  a6 accounts%rowtype;

BEGIN

   TT_     := substr( rtrim( ltrim(nvl(TT_,'%%1'))),1,3);
   A2.TIP  := rtrim ( ltrim( tip_bal_));  -- ��� �������� �����  

   if tip3_ like 'SD_' then  
      ID_ := nvl(to_number(ltrim(substr(tip3_,3,1))) ,0);  
   end if;

   ---- 1
   IF tip3_   ='SN ' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.kv=kv_ and a.tip='SN ' and a.dazs is null );
   ELSIF tip3_='SK0' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.tip='SK0' and a.dazs is null);
   ELSIF tip3_='SN8' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='SN8' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9N' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9N' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9K' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9K' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ElsIf tip3_ like 'SD_' then    ------------------------����� 6 ��====
      ----------------2
      Begin
         -- 3   ����� ���� ������� �� ����
         IF ID_ = 2 and ( A2.tip in ('SP','SL','SPN','SLN','SK9','SN8') or A2.tip is null)  THEN
            select a.acc ,'%%1'   into A6.ACC, tt_   from accounts a where a.tip='SD8' and a.nbs='8006' and a.kv=KV_    and rownum=1;
         Else -- ���������
            select substr(prod,1,4), substr(prod,5,2), branch   into  a2.NBS, a2.OB22, a2.Branch from cc_deal where nd = nd_;
            select * into kk from cck_ob22 where nbs = A2.NBS and ob22 = A2.OB22 ;
            A6.NBS := null ; A6.OB22:= Null ; A6.Branch := Substr( A2.branch, 1, 15 ); 

            -- 4 ���� ������� ��� �������� ������������  (���������� ��� �������� ����� � ����� SK0),  � �.� ��� �������� ������� ������� � ��������� � ��
            IF ID_ = 2 and bal_ = '8999' and cck_ui.check_product_6353(prod_) = 0   THEN
               If A2.NBS like '9%' then   A6.NBS  := '6518'    ;
               else                       A6.NBS  := '6511'    ;
               end If ;                   A6.Ob22 := kk.SD_SK0 ;

            ELSIF ID_ = 0 and A2.tip in ('SL','S9N','S9K')                          THEN A6.NBS := '8990' ; A6.ob22 := '00'       ;  --- ���� ������� ��� ������������(���������)
            ELSIF ID_ = 0 and (substr(bal_,1,1) = '9' or A2.tip = 'CR9')            THEN A6.NBS := '6518' ; A6.ob22 := kk.SD_9129 ;  --- ���� ������� ��� ��� 9129
            ELSIF ID_ = 4                                                           THEN A6.NBS := '6510' ; A6.ob22 := kk.SD_SK4  ;  --- ���������� ���������
            Else   ---------------------------------------------------------------------------------------------------------- ����������/���������.������
               Select  nbs6 into A6.NBS from NBS_SS_SD where nbs2 = a2.NBS;
               ------------------------------------------------------------------------------------------
               If    KV_ = gl.baseval and ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_M ;   --������� ���
               ElsIf                    ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_J ;   --������� ���
               ElsIf KV_ = gl.baseval                                                 THEN A6.OB22 := kk.SD_N ;   --���.���� ���
               Else                                                                      A6.OB22 := kk.SD_I ;   --���.���� ���
               end if ;

            End if ; --4 ���� ������� ��� �������� ������������  (���������� ��� �������� ����� � ����� SK0),  � �.� ��� �������� ������� ������� � ��������� � ��

         end if;  -- 3   ����� ���� ������� �� ����
                     if  A6.ACC is null then
							--begin
								 select a.acc into ACC_
									 from accounts a
									 where a.nls = NBS_OB22_BRA ( A6.NBS, A6.OB22, a6.BRANCH );
							--exception when no_data_found then null;end;
					else
							ACC_ := A6.ACC;   --COBUMMFO-8054
					end if;
	 --exception when no_data_found then null;
      end;  ---2

   end if;  -- 1    ---tip3_   ='SN '

   RETURN ACC_;
   
    exception
	  when no_data_found then
         bars_audit.error('<br/><b>cc_o_nls_ext. '||'�� ������� ������ acc ��� nbs = '||A6.NBS||' ,ob22 ='||A6.OB22||' ,branch ='
				 ||a6.BRANCH||' nbs = '||a2.nbs||', ob22 = '||a2.ob22||chr(10)||'</b><br/>'||sqlerrm||chr(10) || dbms_utility.format_error_stack());
		RETURN ACC_;
    when others then
         bars_audit.error('<br/><b>cc_o_nls_ext. '||'������� � cc_o_nls_ext. nbs = '||A6.NBS||' ,ob22 ='||A6.OB22||' ,branch ='
				 ||a6.BRANCH||' nbs = '||a2.nbs||', ob22 = '||a2.ob22||chr(10)||'</b><br/>'||sqlerrm||chr(10) || dbms_utility.format_error_stack());
	    RETURN ACC_;

END CC_O_NLS_EXT;
/
show err ;

 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_o_nls_ext.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_O_NLS_EXT 
  (bal_     in varchar2,  
   RNK_     in int,
   sour_    in int,
   ND_      in int,
   kv_      in int,
   tip_bal_ in varchar2,
   tip3_    in varchar2, -- ��� �������� �����
   PROD_    in varchar2,
   TT_      in out varchar2
  )
RETURN number IS

 -- 08.06.2018 Sta  ��������� ��  ³����� �������� <viktoriia.semenova@unity-bars.com>

  ID_  int    := 0;   -- id ���� ��������
  ACC_ number :=null ; -- ���������� 
  a2 accounts%rowtype;
  kk cck_ob22%rowtype;
  a6 accounts%rowtype;

BEGIN
   TT_     := substr( rtrim( ltrim(nvl(TT_,'%%1'))),1,3);
   A2.TIP  := rtrim ( ltrim( tip_bal_));  -- ��� �������� �����  

   if tip3_ like 'SD_' then  
      ID_ := nvl(to_number(ltrim(substr(tip3_,3,1))) ,0);  
   end if;

   ---- 1
   IF tip3_   ='SN ' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.kv=kv_ and a.tip='SN ' and a.dazs is null );
   ELSIF tip3_='SK0' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.tip='SK0' and a.dazs is null);
   ELSIF tip3_='SN8' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='SN8' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9N' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9N' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9K' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9K' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ElsIf tip3_ like 'SD_' then    ------------------------����� 6 ��====
      ----------------2
      Begin
         -- 3   ����� ���� ������� �� ����
         IF ID_ = 2 and ( A2.tip in ('SP','SL','SPN','SLN','SK9','SN8') or A2.tip is null)  THEN
            select a.acc ,'%%1'   into A6.ACC, tt_   from accounts a where a.tip='SD8' and a.nbs='8006' and a.kv=KV_    and rownum=1;
         Else -- ���������
            select substr(prod,1,4), substr(prod,5,2), branch   into  a2.NBS, a2.OB22, a2.Branch from cc_deal where nd = nd_;
            select * into kk from cck_ob22 where nbs = A2.NBS and ob22 = A2.OB22 ;
            A6.NBS := null ; A6.OB22:= Null ; A6.Branch := Substr( A2.branch, 1, 15 ); 

            -- 4 ���� ������� ��� �������� ������������  (���������� ��� �������� ����� � ����� SK0),  � �.� ��� �������� ������� ������� � ��������� � ��
            IF ID_ = 2 and bal_ = '8999' and cck_ui.check_product_6353(prod_) = 0   THEN
               If A2.NBS like '9%' then   A6.NBS  := '6518'    ;
               else                       A6.NBS  := '6511'    ;
               end If ;                   A6.Ob22 := kk.SD_SK0 ;

            ELSIF ID_ = 0 and A2.tip in ('SL','S9N','S9K')                          THEN A6.NBS := '8990' ; A6.ob22 := '00'       ;  --- ���� ������� ��� ������������(���������)
            ELSIF ID_ = 0 and (substr(bal_,1,1) = '9' or A2.tip = 'CR9')            THEN A6.NBS := '6518' ; A6.ob22 := kk.SD_9129 ;  --- ���� ������� ��� ��� 9129
            ELSIF ID_ = 4                                                           THEN A6.NBS := '6510' ; A6.ob22 := kk.SD_SK4  ;  --- ���������� ���������
            Else   ---------------------------------------------------------------------------------------------------------- ����������/���������.������
               -- 5 
               If    A2.NBS =    '2010'  then A6.NBS := '6022' ; --  ��*������� � 1*�������, �� ����� �� ���������� ����
               elsIf A2.NBS =    '2020'  then A6.NBS := '6023' ; --  ��*������� � 1*�������, �� �����i �� ����������� ���������
               elsIf A2.NBS =    '2030'  then A6.NBS := '6024' ; --  ��*������� � 1*������, �� �������i �� ������i��� ���������� 
               elsIf A2.NBS =    '2040'  then A6.NBS := '6030' ; --  ��*������� � 4*������� �� ���������� ���� 
               elsIf A2.NBS =    '2041'  then A6.NBS := '6031' ; --  ��*������� � 4*�������,�� ����� �� ����������� ���� 
               elsIf A2.NBS =    '2042'  then A6.NBS := '6032' ; --  ��*������� � 4*������ �� ���������� ���������� 
               elsIf A2.NBS =    '2043'  then A6.NBS := '6033' ; --  ��*������� � 4*������� � ������� �������� 
               elsIf A2.NBS =    '2044'  then A6.NBS := '6034' ; --  ��*������� � 4*������� �� ���������� �������
               elsIf A2.NBS =    '2045'  then A6.NBS := '6035' ; --  ��*������� � 4*������� ������� 
               elsIf A2.NBS =    '2063'  then A6.NBS := '6025' ; --  ��*������� � 1*������� � ������� ��������
               elsIf A2.NBS =    '2071'  then A6.NBS := '6026' ; --  ��*������� � 1*Գ�������� ����� (������)
               elsIf A2.NBS =    '2083'  then A6.NBS := '6027' ; --  ��*������� � 1*I������i �������
               ----------------------------------------------------------------------------------------
               ElsIf A2.NBS =    '2103'  then A6.NBS := '6040' ; --  ���*������� � 1*�������, �� ����� ��� ���� �����
               elsIf A2.NBS =    '2113'  then A6.NBS := '6041' ; --  ���*������� � 1*�������, �� ����� ��� ̲�� �����
               elsIf A2.NBS =    '2123'  then A6.NBS := '6042' ; --  ���*������� � 1*I������i �������, �� �����i ��� ���� ����� 
               elsIf A2.NBS =    '2133'  then A6.NBS := '6043' ; --  ���*������� � 1*I������i �������, �� �����i ��� ̲�� �����
               elsIf A2.NBS =    '2140'  then A6.NBS := '6044' ; --  ���*������� � 4*�������, �� ����� ��� ���� �����         
               elsIf A2.NBS =    '2141'  then A6.NBS := '6045' ; --  ���*������� � 4*�������, �� ����� ��� ̲�� �����          
               elsIf A2.NBS =    '2142'  then A6.NBS := '6046' ; --  ���*������� � 4*I������i �������, �� �����i ��� ���� �����
               elsIf A2.NBS =    '2143'  then A6.NBS := '6047' ; --  ���*������� � 4*I������i �������, �� �����i ��� ̲�� �����
               ----------------------------------------------------------------------------------------
               ElsIf A2.NBS =    '2203'  then A6.NBS := '6052' ; --  ��*������� � 1*������� �� ������ �������
               elsIf A2.NBS =    '2211'  then A6.NBS := '6053' ; --  ��*������� � 1*�i�������� �i���� (������)
               elsIf A2.NBS =    '2220'  then A6.NBS := '6054' ; --  ��*�������, �� ����� �� ����.���������
               elsIf A2.NBS =    '2233'  then A6.NBS := '6055' ; --  ��*I������i �������
               elsIf A2.NBS =    '2240'  then A6.NBS := '6060' ; --  ��*������� � 4*������� �� ������ ������� 
               elsIf A2.NBS =    '2241'  then A6.NBS := '6061' ; --  ��*������� � 4*������� �� ���������� ������� (�������) 
               elsIf A2.NBS =    '2242'  then A6.NBS := '6062' ; --  ��*������� � 4*�������, �� ����� �� ����������� ������
               elsIf A2.NBS =    '2243'  then A6.NBS := '6063' ; --  ��*������� � 4*������� �������
               ----------------------------------------------------------------------------------------
               elsIf A2.NBS =    '2303'  then A6.NBS := '6070' ; --  ��*������� � 2*������� � ������� ��������
               elsIf A2.NBS =    '2301'  then A6.NBS := '6076' ; --  ��*������� � 5*������� � ������� ��������
               elsIf A2.NBS =    '2310'  then A6.NBS := '6071' ; --  ��*������� � 2*�������, �� ����� �� ���������� ����

               elsIf A2.NBS =    '2311'  then A6.NBS := '6071' ; --  ��*������� � 5*�������, �� ����� �� ���������� ����
               elsIf A2.NBS =    '2321'  then A6.NBS := '6072' ; --  ��*������� � 5*�������, �� ����� �� ����������� ���������
               elsIf A2.NBS =    '2331'  then A6.NBS := '6077' ; --  ��*������� � 5*�� ���������� ����������
               elsIf A2.NBS =    '2341'  then A6.NBS := '6074' ; --  ��*������� � 5*Ԣ�������� �����
               elsIf A2.NBS =    '2320'  then A6.NBS := '6072' ; --  ��*������� � 2*�������, �� ����� �� ����������� ���������
               elsIf A2.NBS =    '2330'  then A6.NBS := '6073' ; --  ��*������� � 2*�� ���������� ����������
               elsIf A2.NBS =    '2340'  then A6.NBS := '6074' ; --  ��*������� � 2*Ԣ�������� �����

               elsIf A2.NBS =    '2353'  then A6.NBS := '6075' ; --  ��*������� � 2*������� �������
               elsIf A2.NBS =    '2351'  then A6.NBS := '6078' ; --  ��*������� � 5*������� �������
               elsIf A2.NBS =    '2360'  then A6.NBS := '6080' ; --  ���*������� � 2*�������  ���� 
               elsIf A2.NBS =    '2361'  then A6.NBS := '6084' ; --  ���*������� � 5*�������  ���� 
               elsIf A2.NBS =    '2362'  then A6.NBS := '6081' ; --  ���*������� � 2*������� �������  ���� 
               elsIf A2.NBS =    '2363'  then A6.NBS := '6086' ; --  ���*������� � 5*������� �������  ���� 
               elsIf A2.NBS =    '2370'  then A6.NBS := '6082' ; --  ���*������� � 2*�������  ̲�� 
               elsIf A2.NBS =    '2371'  then A6.NBS := '6085' ; --  ���*������� � 5*�������  ̲�� 
               elsIf A2.NBS =    '2372'  then A6.NBS := '6083' ; --  ���*������� � 2*������� ������� ̲�� 
               elsIf A2.NBS =    '2373'  then A6.NBS := '6087' ; --  ���*������� � 5*������� ������� ̲�� 
               elsIf A2.NBS =    '2380'  then A6.NBS := '6096' ; --  ���*������� � 3* ������� ���� 
               elsIf A2.NBS =    '2381'  then A6.NBS := '6096' ; --  ���*������� � 3* ������� ̲�� 
               elsIf A2.NBS =    '2382'  then A6.NBS := '6096' ; --  ���*������� � 3* ������� ������� ���� 
               elsIf A2.NBS =    '2383'  then A6.NBS := '6096' ; --  ���*������� � 3* ������� ������� ̲�� 
               elsIf A2.NBS =    '2390'  then A6.NBS := '6090' ; --  ��*������� � 3*������� � ������� ��������
               elsIf A2.NBS =    '2391'  then A6.NBS := '6091' ; --  ��*������� � 3*������� �� ���������� ����
               elsIf A2.NBS =    '2392'  then A6.NBS := '6092' ; --  ��*������� � 3*�������, �� ����� �� ����������� ����
               elsIf A2.NBS =    '2393'  then A6.NBS := '6093' ; --  ��*������� � 3*������, �� ������� �� ���������� ����
               elsIf A2.NBS =    '2394'  then A6.NBS := '6094' ; --  ��*������� � 3*Ԣ�������� ����� (������)
               elsIf A2.NBS =    '2395'  then A6.NBS := '6095' ; --  ��*������� � 3*������� �������
               ------------------------------------------------------------------------------------------
               elsIf A2.NBS =    '2401'  then A6.NBS := '6104'  ; --  ��*������� � 5*������� �� ������ �������
               elsIf A2.NBS =    '2403'  then A6.NBS := '6100'  ; --  ��*������� � 2*������� �� ������ �������
               elsIf A2.NBS =    '2410'  then A6.NBS := '6101'  ; --  ��*������� � 2*Ԣ�������� ����� (������)
               elsIf A2.NBS =    '2411'  then A6.NBS := '6105'  ; --  ��*������� � 5*Ԣ�������� ����� (������)    
               elsIf A2.NBS =    '2420'  then A6.NBS := '6102'  ; --  ��*������� � 2*�������, �� ����� �� ����������� �������
               elsIf A2.NBS =    '2421'  then A6.NBS := '6106'  ; --  ��*������� � 5*�������, �� ����� �� ����������� �������
               elsIf A2.NBS =    '2431'  then A6.NBS := '6107'  ; --  ��*������� � 5*������� �������
               elsIf A2.NBS =    '2433'  then A6.NBS := '6103'  ; --  ��*������� � 2*������� �������
               elsIf A2.NBS =    '2450'  then A6.NBS := '6110'  ; --  ��*������� � 3*������� �� ������ �������
               elsIf A2.NBS =    '2453'  then A6.NBS := '6113'  ; --  ��*������� � 3*������� �������
               end if ; --- 5 
               ------------------------------------------------------------------------------------------
               If    KV_ = gl.baseval and ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_M ;   --������� ���
               ElsIf                      ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_J ;   --������� ���
               ElsIf KV_ = gl.baseval                                                 THEN A6.OB22 := kk.SD_N ;   --���.���� ���
               Else                                                                        A6.OB22 := kk.SD_I ;   --���.���� ���
               end if ;

            End if ; --4 ���� ������� ��� �������� ������������  (���������� ��� �������� ����� � ����� SK0),  � �.� ��� �������� ������� ������� � ��������� � ��

         end if;  -- 3   ����� ���� ������� �� ����
         select acc into ACC_ from accounts where nls = NBS_OB22_BRA ( A6.NBS, A6.OB22, a6.BRANCH );
      exception when no_data_found then null;
      end;  ---2

   end if;  -- 1    ---tip3_   ='SN '

   RETURN ACC_;

END CC_O_NLS_EXT;
/
 show err;
 
PROMPT *** Create  grants  CC_O_NLS_EXT ***
grant EXECUTE                                                                on CC_O_NLS_EXT    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_O_NLS_EXT    to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_o_nls_ext.sql =========*** End *
 PROMPT ===================================================================================== 
 