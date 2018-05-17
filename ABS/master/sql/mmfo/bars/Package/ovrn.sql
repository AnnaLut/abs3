CREATE OR REPLACE PACKAGE OVRN IS  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :='ver.3 10.05.2018';
-- 06.04.2018  ��� %% ����� JOB
 g_TIP  tips.tip%type     := 'OVN';
 g_VIDD cc_vidd.vidd%type := 10   ;  -- <<���s������>> �����
 g_VID1 cc_vidd.vidd%type := 110  ;  -- ���.���<<���?������>> �����
 g_TAG  char(8)   := 'TERM_OVR'; -- ����i� ������������� ���, �i�.��i�
 g_TAGD char(8)   := 'TERM_DAY'; -- ����i�(���� �i�) ��� ������ %%
 g_TAGT char(8)   := 'TERM_TRZ'; -- ����i� ��� �i������� ��������� �� ��������� �i�.��i�
 g_TAGC char(8)   := 'PCR_CHKO'; -- ����i� �i�i�� (% �i� ���)
 g_TAGK char(8)   := 'NEW_KL'  ; -- ������� "���" ��
 g_TAGN char(8)   := 'DONOR'   ; -- ������� ������
 g_TAGS char(8)   := 'STOP_O'  ; -- <<����>> ��� ����
 g_2017 int       := 1 ; -- ���� ����������� (=1) ��� �� ����������� �������������-2017 �� �������� �� ����� ���� ������


/*
 g_TAR144 Tarif.KOD%type := 144 ;  --���?�?� �� ������.������ ��� (% �?� ����.���.���.)
 g_TAR143 Tarif.KOD%type := 143 ;  --���?�?� �� �?��������� ������� NPP
 g_TAR142 Tarif.KOD%type := 142 ;  --���?�?� �� �?��������� ���������� ����?���
 g_TAR141 Tarif.KOD%type := 141 ;  --���?�?� �� ������� ���������� (% �?� �?�?��)
*/

/*
08.04.2016 ������ ����� ������ ����������
*/

function  Get_NLS   (p_R4 accounts.NBS%type ) return accounts.NLS%type   ;
procedure NEXT_LIM (p_acc8 number ) ; --  �������� �� ���������� � ���������� � ����� ����
procedure REV_LIM  (p_acc  number , p_Dat_Tek date, p_dat21 date , p_dat_Nxt date ) ; -- ������������� �������
procedure DEB_LIM  (p_acc  number , p_S number ) ; --- �������� ������ ��� �� ���
procedure ins_TRZ  (p_acc1 number , p_datVZ date, p_datSP date, p_trz int)  ;
procedure UPD_SOS  (p_nd   number , p_sos int ) ; --��������� � ����������� ��������� ���
procedure NEW_SOS  (p_ND   number , p_sos int ) ;
procedure REPL_ZAl (p_nd  number )  ; --�������� ������� �� ��� � nd_acc ��� ��������
function  FOST_SAL (p_acc number ,  p_fdat date ) return number  ;
function  RES26    (p_acc number )  return number ;  -- ������ ������� ��� ��������
function  Get_MDAT (p_acc number )  return date   ;  -- ����������� ����-���� ���������
procedure STOP     (p_mode int,     p_ND number, p_ACC number,  p_NLS varchar2, p_KV int,  p_X varchar2); -- ����������=0 / �����=1  ������ ������ ����
--------------------
procedure SetZ     ( p_acc number , p_npp int, p_txt varchar2  ) ; --���������� ������ ���.���?�������� ��� ��?�� ���
procedure SetIR    ( p_nd  number , aa accounts%rowtype, p_id int, p_dat date, p_ir number) ; --���������� ���� ������ �� ���
procedure SetW     ( p_acc number , p_tag varchar2, p_val  varchar2  ) ; --���������� ���.���� �� ���
function  GetAL    ( p_acc number , p_dat date ) return  number  ; --���� (1) ��� ���(0) ������������� ����� �� ���� �� 21 ����� ������ ����
function  GetW     ( p_acc number , p_tag varchar2) return  varchar2   ; --��������   ���.���� �� ���
function  GetCW    ( p_rnk number , p_tag varchar2) return  varchar2   ; --��������   ���.���� �� RNK
-------------------
procedure LIM      ( p_ND number , p_date date ) ; --����-�������� ������ �� ��� � �����  � �� ������� �� �� 5-� ������
PROCEDURE AUTOR    ( p_nd number , p_x varchar2) ;-- �����������
PROCEDURE CHKO     ( p_mode int  , p_acc number, p_dat date  , p_s number, p_pr int) ;   ---  ���
PROCEDURE INT_OLD  ( p_acc number, p_dat2 date ) ;              ---  �������  %
procedure GLO      ( p_mode int  , p_FDAT date , p_LIM number, p_OK INT    ) ; -- ins del upd
procedure TARIF    ( p_mode int  , p_acc number, p_kod number, p_TAR number) ; -- upd

procedure PUL_OVR  ( p_RANG int  , p_ND number , p_ACC number) ;
procedure PUL_OVRD ( p_ND number , p_ACC number, p_dat1 varchar2, p_dat2 varchar2) ;
procedure Chk_dat  ( m_SDate date, s_sdate date, m_wDate date, s_wdate date) ;
procedure Chk_nls  ( p_mode int  , p_acc number, p_kv IN int , p_nls IN varchar2, aa OUT accounts%rowtype) ;

procedure ADD_master  (p_ND number, p_ACC number, p_CC_ID varchar2, p_sdate date, p_wdate date, p_lim number, p_ir0 number, p_ir1 number,
                      p_nls varchar2, p_kv int,  p_day int, p_PD number, p_isp number,
                      p_METR int, -- =1 = �������  ����.������
                      p_SK   int,  -- = � ����v ��� ����.������
                      p_NZ   int  -- ������� "��� �����������"
                     );
procedure DEL_master  (p_ND number);
procedure ADD_slave
         (p_mode int, p_ND number, p_acc number, p_lim number, p_ir0 number, p_ir1 number, p_nls varchar2, p_term int, p_PK number, p_don int, p_NK int) ;
procedure DEL_slave  (p_ND number, p_acc number, p_nls varchar2, p_kv int) ;
procedure Set_ost8   ( p_acc8 number) ;
procedure OPL1       ( oo IN OUT oper%rowtype); -- �������
procedure background ( p_ini int, p_mode int, p_ND number, p_date date); -- ���-������������� ��������
procedure INTX               ( p_mode int ,p_dat1 date, p_dat2 date, p_acc8 number, p_acc2 number) ;  -- JOB-����� ������ %%
procedure INTXJ  ( p_User int, p_mode int ,p_dat1 date, p_dat2 date, p_acc8 number, p_acc2 number) ;  -- ���������� ������  %%
procedure INTB       ( p_mode int); --- ��������� �������� �������� ��������� ���������
procedure OP_3600    ( dd IN cc_deal%rowtype, a26 IN accounts%rowtype , a36 IN OUT accounts%rowtype) ;   -- ���� ��������  3600
procedure OP_SP      ( dd IN cc_deal%rowtype, a26 IN accounts%rowtype , a67 IN OUT accounts%rowtype, a69 IN OUT accounts%rowtype) ;   -- ���� ��������� 2067 + 2069
procedure BG1        ( p_ini  int, p_mode int, p_dat date, dd cc_deal%rowtype, a26 accounts%rowtype, x26 accounts%rowtype ) ;   -- ���-������������� ������ 2600
function  SP         ( p_mode int, p_nd number, p_rnk number) return number ;
procedure FLOW_IR    ( p_accc number, p_dat1 date, p_dat2 date);  -- �������� ���������� ��������� % ������ (METR=7)

-------------------------------
procedure DEL_ALL (p_nd number);  -- �������� ����/�������� ����� ��� ������ �����������������
procedure rep_LIM ( p_nls varchar2, p_acc number) ; -- ���� ����������� �������
procedure CLS (P_ND NUMBER) ; -- �������� ���
procedure ins_110 (d_nd number, p_acc26 number, p_acc number, u_nd IN OUT number) ; -- �������� � ND_ACC ��� ������ � ����� 110  �� ����� ����� � ����� 10
procedure isob    (p_nd number, p_sob varchar2);  -- ����������� �������
procedure ADD_ACC   ( p_mode int, p_acc number, p_acc_add number);
---============================
function TIP  return varchar2  ;
function VIDD return number    ; ---- <<���i������>> �����
function VID1 return number    ; ---- ���.��� <<���i������>> �����
function TAG  return varchar2  ; ---- TERM_OVR  ����?� ������������� ���, �?�.��?�
function TAGD return varchar2  ; ---- TERM_DAY  ����i�(���� �i�) ��� ������ %%'
function TAGT return varchar2  ; ---- TERM_TRZ  ����i� �i������� ��������� �� ��������� �i�.��i�
function TAGC return varchar2  ; ---- ����i� �i�i�� (% �i� ���)
function TAGK return varchar2  ; ---- ������� ��� ��
function TAGN return varchar2  ; ---- ������� ������
function TAGS return varchar2  ; ---- <<����>> ��� ����
function F2017 return int      ; -- ���� ����������� (=1) ��� �� ����������� �������������-2017 �� �������� �� ����� ���� ������

function header_version return varchar2;
function body_version   return varchar2;
-------------------------------
procedure repl_acc (p_nd number, p_old_acc number, p_new_kv int, p_new_nls varchar2);

-------------------
END ;
/
CREATE OR REPLACE PACKAGE BODY OVRN IS
 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :='ver.3 10.05.2018';
/*
06.04.2018  ��� %% ����� JOB
06.04.2018 Sta �������� ��� ������ ��� �� 2- (� �����) ������

04.04.2018 Sta ��� ����������� ���������� ����������� 2 ����� 2607 (COBUMMFO-5668).
20.03.2018 Sta COBUMMFO-6154 ���������� �������� �����
               COBUMMFO-6843=����������� ����������� ���

01.03.2018 Sta �������������� ����� �� ����� ����
28.02.2018 Sta COBUMMFO-5491=������� % �� ���������, 
               COBUMMFO-6917=�������� ��� ������������ ���������� ������� ���������� ��� ���������� %%% ---- 
27.02.2018 Sta ������ 2608
27.12.2017 Sta ����������� ����� �� ��������� �� ���������� ���
               ��� ����.��� ������ ���� 2607 �� ����������, ���� �� � �����������. ��� �������� ������ ���. ������ ���� ������������� �����.
               �������  %   �� ���������

15.11.2017 Sta Transfer-2017 -- 2067	01	2063	33			����������� ������������� �� �������������� ������� � ������� ��������
17.10.2017 Sta COBUMMFO-4843 ������ 2602. 2603. 2604
05/10/2017  SC-0360782-> COBUMMFO-5042  ���������� ��������� �����.������� � ���.3739 +       ��������� �������� . ����: 2600, 3739. � ����� ������� :3739, 2600.
06.09.2017 ����� 9129 ��������� ��� ������� �� ������ ��������� ������,
05.09.2017 STA ������²� ��� ��� ��������� ��� http://jira.unity-bars.com:11000/browse/COBUMMFO-4718
17.08.2017 Sta  �������� �� ����� ������������ ��� ������� ����� (��������� �� ���, �� ��� �����������): 
           1)	³������ �������������� ������� 8998 �� ������� 2600 (��� ��������� ������� ����� ��������� �� ����� �������;
           2)	�������� ��� �������, �� �������� ������ � ������� (2607, 8998, 2067, 2069, 3578, 3579, 3600, 3739)
             ��� ����� ���� �� ���� ����/����. 
             ������������� ����������� ��22 �� ������� 9129:
             ��22 = 04,  ���� ���� ����������� � ����� ���������;
             ��22 = 37,  ���� ����������� ��� ������ ���� �������������� ������������ ��������� �������������� (34 � 334. ������)
       --��������� � ���.�� �� ����.������

19.07.2017 Sta procedure repl_acc (2600) -�������� ������ ���� �� ��������,  �������� ��� �����
13.06.2017 jeka 20.04.2017 --��������� ���� ���������� ����� ���� � ���� ����� 2610, 2615, 2651, 2652, 2062, 2063, 2082, 2083
08.06.2017 Sta  ���.����. EXIT_ZN = ҳ���� ������ ����� �� "���" =1
                          DEL_LIM = Max ���������� % ��������� ������ ���� �� ������������
                          
06.06.2017 Sta ���.�������� TERM_LIM = ���� ��.��������� ����(��=20,����=10)
25.05.2017 add_months(trunc(acr_dat,'MM'),1) + l_term_DAY - 1  - ����-���� �� ������ %%
11.04.2017 ����������� ������� ���
10.04.2017 ��� ����� �������� ���������� (���.���. - 646715701; 646715801; 646715901)
��� ����� ��� ����� ��������� ���� ���������� ���������� �� ������� � ����� ������ ������ ������������.

...
04.02.2016 ������ ����� ������ ����������
*/
-------------------------------------
g_errN number := -20203 ;
g_errS varchar2(5) := 'OVRN:' ;
nlchr char(2) := chr(13)||chr(10) ;

SB_2067 SB_OB22%rowtype;
SB_2069 SB_OB22%rowtype;
SB_6020 SB_OB22%rowtype;
SB_6111 SB_OB22%rowtype;
-------------------------------------
function Get_NLS  (p_R4 accounts.NBS%type ) return accounts.NLS%type   is   --��������� � ���.�� �� ����.������
                    nTmp_ number ;            l_nls accounts.NLS%type ;

begin
  While 1<2        loop nTmp_ := trunc ( dbms_random.value (1, 999999999 ) ) ;
    begin select 1 into nTmp_ from accounts where nls like p_R4||'_'||nTmp_  ;
    EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ;
    end;
  end loop;         l_nls := vkrzn ( substr(gl.aMfo,1,5) , p_R4||'0'||nTmp_ );
  RETURN l_Nls ;
end    Get_NLS ;

procedure NEXT_LIM (p_acc8 number ) is  --  �������� �� ���������� � ���������� � ����� ����
  Sum_Deb number ;
begin   ----- 2  ���.���<���.���(�������)  15
  For k in (select * from accounts where p_acc8 in ( accc, acc) and tip <> 'SP ' and lim > 0 )
  loop  If    k.acc = p_acc8 then
              select NVL(sum(ostc),0)  into  sum_deb from accounts where ostc < 0 and accc = p_acc8 ;
              If k.lim < Sum_Deb then                OVRN.ins_TRZ (k.acc, gl.bdate + 1, null, 2 )   ; end If ;  -- ��������� �� ���
        elsIf k.ostc <  0  and k.lim < -k.ostc then  OVRN.ins_TRZ (k.acc, gl.bdate + 1, null, 2 )   ;           -- ��������� �� �������
        end if ;
  end loop     ;
end NEXT_LIM   ;
----------------

procedure REV_LIM  (p_acc  number , p_Dat_Tek date, p_dat21 date , p_dat_Nxt date ) is
 -- ��������� ������� �� "������".
 -- ����������� �� ������
 -- ��������� ���������
 l_Dat_Tek date ;
 l_dat21   date ;
 l_dat_Nxt date ;
 l_Dat_Lim date ;
 l_lim  number  ;
 l_nd   number  ; 
begin

 If l_Dat_Tek is null then l_Dat_Tek:= gl.bDate;                                                    else l_Dat_Tek := p_Dat_Tek ; end if ;
 If l_dat21   is null then l_dat21  := trunc(l_Dat_Tek,'MM')+20 ; l_dat21 := Dat_Next_U(l_dat21,0); else l_dat21   := p_dat21   ; end if ;
 If l_dat_Nxt is null then l_Dat_Nxt:= Dat_Next_U ( l_Dat_Tek,1);                                   else l_dat_Nxt := p_dat_Nxt ; end if ;

 begin select d.nd into l_nd from cc_deal d, nd_acc n where d.sos >= 10 and d.sos < 15 and d.nd = n.nd and n.acc = p_acc and d.vidd = 10 ;
 EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
 end ;

 -- ����������� ������ ���������� �  ���������������  ������  ������� ������� "20" �� ������ "21"
 If l_Dat_Tek < l_dat21  and l_Dat_Nxt >= l_dat21 then
    select min(fdat) into l_Dat_Lim from OVR_LIM where nd = l_nd and acc = p_acc  and fdat > l_Dat_Tek and ok = 1 ;
    -- gl.Bdate <= ... 18, 19, 20
    -- Dat_Next >= 21, 22, 23  ...
    -- Dat_Lim  >= 21, 22, 23  ...
    -- ��������� �.�.  19, 20, 21, 22
    -- ����� �� ������ 18 ������������� ������ �� 23.
    If l_Dat_Lim <= l_Dat_Nxt  then
       begin select lim  into l_lim  from OVR_LIM  where acc = p_acc and fdat = l_Dat_Lim  and ok = 1 and nd = l_nd ;
             update accounts set lim = l_lim       where acc = p_acc and lim <> l_lim ;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end ;
    end if;
 else -- ����������� ������ �����������  ������  ������� ������� "��" �� ������ "��+1"
    select min(fdat) into l_Dat_Lim from OVR_LIM_DOG where acc = p_acc  and fdat > l_Dat_Tek and nd = l_nd ;
    If l_Dat_Lim <= l_Dat_Nxt  then
       begin select lim  into l_lim from OVR_LIM_DOG where acc = p_acc  and fdat = l_Dat_Lim and nd = l_nd ; 
             update accounts set lim = l_lim where acc = p_acc and lim <> l_lim;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end ;
   end if;
 end if ;

end REV_LIM ;

procedure DEB_LIM  (p_acc number, p_S number )  is --- �������� ������ ��� �� ���
   Lim_deb number ;
   sum_deb number ; -- ����� ���������� ������ ����������� ���
   sum_bal number ;
   aaD     accounts%rowtype;
   aaK     accounts%rowtype;
   dd      cc_deal%rowtype ;
   l_stmt  number ;
   l_Ok    int;
begin
   If P_S < 0 then
      begin select lim into Lim_deb from accounts where acc = p_acc and tip = 'OVN';
            select d.* into dd from nd_acc n, cc_deal d where n.acc = p_acc  and n.nd = d.nd and d.vidd = 10 ;
      EXCEPTION WHEN NO_DATA_FOUND THEN  return;
      end;
      select  - nvl ( Sum(ostC) , 0 ) into sum_deb from accounts where accc = p_acc  and ostC < 0 ;
      -- ���� ��������� ������ �� ��� !!!
      If Lim_deb < sum_deb then
         --��������� ������ �� ���. ����������� ���
         begin
             -- ��������� ���� �� ������
             select a.rnk,   a.tip, o.stmt,   a.ostc,   a.kv,   a.nls
             into aaD.rnk, aaD.tip, l_stmt, aad.ostc, aad.kv, aad.nls
             FROM accounts a, ( SELECT stmt, acc FROM opldok where ref = gl.aRef and dk = 0 ) o
             where a.accc = p_acc and a.acc = o.acc and rownum = 1 ;
             -- ��� ����� �� ��������� -- ���������
             If aaD.tip = 'SP ' then RETURN; end if  ;
             -- � ��� �� ������� ?
             select a.rnk, a.tip into aak.rnk, aaK.tip FROM accounts a, opldok o where a.acc = o.acc and o.ref = gl.aRef and o.stmt = l_stmt and o.dk = 1 ;
             -- ��� ��������� ��������� - ���������
             If  aak.rnk = aaD.rnk and aak.tip in ('SP ', 'SPN') then RETURN; end if;
             -- � ���� �� ����������� ��������� � ����� ��
             select 1 into l_ok  from dual
             where not exists  (select 1 from nd_acc n, accounts a
                                where n.nd = dd.nd and n.acc= a.acc and a.rnk = aad.rnk and a.tip in ('SP ','SPN') and a.ostc < 0
                                )
               and aad.ostc + p_S > 0;
             -- ���. ���������
                RETURN;
         EXCEPTION WHEN NO_DATA_FOUND THEN

            raise_application_error(g_errn,'��������� ��.���=' || trim(to_char(Lim_deb/100,'999999999990D00')) ||
                                           '�� ��� �'|| dd.cc_id|| ' �� ' || to_char( dd.sdate, 'dd.mm.yyyy')  || nlchr ||
                                           '�������='|| aad.kv  ||'/'||aad.nls|| ', '|| '���.���='|| gl.aRef )  ;
         END ;
      end if ;
   end if;

end DEB_LIM;
-------------
procedure ins_TRZ -- ��������� � ����� ����
 (p_acc1 number,  -- ����-���������� (��������)
  p_datVZ date ,  -- ���� ������������� "�������" ������� 
  p_datSP date ,  -- ���� ����� �� ��������� 
  p_trz int       -- ��� "�������" �������  = ��� ������� ��������� � ����� ����
 )  
is
  New_datVZ date ;  
  New_datSP date ;  
  Old_DatSP date ;
begin
  New_DatVZ := NVL( p_datVZ, gl.bDate     ) ;

  If p_datSP is null then  -- ��������� �� ����������� ������ "����� ����"  ���� ������ �� ��������� 

/*
1	�������� ���.��.��� � ���	15
2	���.���<���.���(�������)	15
3	����������� �����.����.+����.	15
4	"�����" ������������ ���	30
*/

     begin  select  New_DatVZ + z.CountD into  New_DatSP  from OVR_ZONE z  where p_trz = z.id;
     EXCEPTION WHEN NO_DATA_FOUND THEN   New_DatSP :=  New_DatVZ + ( CASE WHEN p_trz = 4 THEN 30  else 15 end ) ;
     end;

  else  New_DatSP := p_datSP ;
  end if;

  New_DatSP := GREATEST ( New_DatVZ,  New_DatSP ) ;
  --------------------------------------------------
  select max (datSP) into Old_datSP from OVR_TERM_TRZ where acc1 = p_acc1 and trz = p_trz ;

  If    Old_datSP is null then    -- ������ ������  �����-����������. ����� �� ����� ����

        insert into OVR_TERM_TRZ (acc1, acc,     datVZ,     datSP,   trz  )
                        select  p_acc1, acc, New_datVZ, New_DatSP, p_trz
                        from accounts  where accc = (select accc from accounts where acc = p_acc1) ;

  ElsIf Old_datSP < gl.bdate Or Old_datSP > New_DatSP  then

       -- ������� ��������� ���� ���������� , � ����� ����� �������, ���  ����
        delete from OVR_TERM_TRZ where acc1 = p_acc1  and   trz =  p_trz ;
        insert into OVR_TERM_TRZ (acc1, acc,     datVZ,     datSP,   trz  )
                        select  p_acc1, acc, New_datVZ, New_DatSP, p_trz
                        from accounts  where accc = ( select accc from accounts where acc = p_acc1) ;
  end if;

end ins_TRZ;

-------------------
procedure UPD_SOS  (p_nd number ,p_sos int ) is -- ��������� � ����������� ��������� ���
      gl_bdate date ;  n_sos int ;  dd cc_deal%rowtype;  a89 accounts%rowtype;   l_txt varchar2(250);  l_mdat date ;  nTmp_  int  ;

      l_EXIT_ZN int ;  ---ҳ���� ������ ����� �� "���" =1

begin gl_bdate := gl.bdate ;

  begin select d.* into dd  from cc_deal d where nd = p_nd and vidd = 10 and sos >= 10 and sos < 14 ;
        select a.* into a89 from nd_acc  n, accounts a where a.acc = n.acc and a.tip ='OVN' and n.nd = dd.nd ;
        If p_sos is NOT null  then  n_Sos := p_Sos ;    goto Ret_; end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  If dd.WDATE < gl_bdate and dd.sos < 13 then  -- ������ ������ ������� ��� ����������� ���� ���������� ���
     OVRN.SetW ( a89.acc, 'STOP_O', '2' );
     OVRN.isob    (p_nd => dd.ND, p_sob => '���.�������� �� ��� ���������� '|| to_char( dd.wdate,'dd.mm.yyyy') );
     n_sos  := 13; goto ReT_;
  end if;

/*
OVR_TERM_TRZ.TRZ = ��� �������:
-------------------------------
1 �������� ���.��.��� � ���  15
2 ���.���<���.���(�������)  15
3 ����������� �����.����.+���.  15
4 "�����" ������������ ���  30
*/
  -- �������� �� 13, 12, 11

  begin  ---- ������������ ���� -- ���������� ����
     select 13 into n_sos from accounts a, nd_acc n
     where n.nd = dd.ND and a.acc= n.acc and a.nbs = SB_2067.R020 and a.ob22 = SB_2067.ob22 and a.tip = 'SP ' and OSTC < 0 and rownum = 1 ;        
     goto ReT_;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  begin -- ������ ������ ������ ������� (��������� � ������ ������ ) , 30
     select 12 into n_sos from accounts a, nd_acc n, OVR_TERM_TRZ t
     where n.nd=dd.ND and a.acc=n.acc and a.acc=t.acc and t.trz=4 and rownum = 1 ;              goto ReT_;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  delete from OVR_TERM_TRZ t
   where TRZ < 4 and ( DATSP < gl_bdate and exists (select 1 from nd_acc where nd = dd.nd and acc = t.acc )  OR ovrn.fost_sal(t.acc, gl_bdate) >= 0  )  ;

  begin -- ������������ �������� ��������������� ������ %/��������,
     select 11 into n_sos from accounts a, nd_acc n where n.nd = dd.ND and a.acc= n.acc and a.nbs = SB_2069.R020 and tip ='SPN' and a.ob22 = SB_2069.ob22 and OSTC < 0  and rownum = 1 ;   
     goto ReT_;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  begin -- ���������� �� ���
    select 11 into n_sos from accounts a where accc=a89.acc and mdate < gl_Bdate and rownum = 1 ;  goto ReT_;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;

  begin -- ������ � ����� ����
    select 11 into n_sos from accounts a, nd_acc n, OVR_TERM_TRZ t
    where n.nd=dd.ND and a.acc=n.acc and a.acc=t.acc and t.trz < 4 and rownum = 1 ;               goto ReT_;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null ;
  end;
  n_sos := 10  ;
  l_EXIT_ZN := NVL( to_number(OVRN.GetW(a89.acc,'EXIT_ZN') ), 0) ; -- -- ҳ���� ������ ����� �� "���" =1
  If l_EXIT_ZN = 1 THEN RETURN;  end if ;
-----------------------------------------
  <<Ret_>> null ;
  ---------------

  If dd.sos <> n_sos then
     ------------------------------------------------------------
     OVRN.NEW_SOS (p_ND => dd.nd, p_sos => n_sos ) ;
     OVRN.SetW    ( a89.acc, 'DT_SOS', to_char(gl_bdate,'dd.mm.yyyy' ) || ':' || dd.sos ||' -> '|| n_sos );

     ------- ���� �� ������� �����������
     If dd.sos = 10 and n_sos in (11,12) and getglobaloption ('BMS') = '1' then  -- BMS �������: 1-����������� �������� ��������� then
        begin select nmk into l_txt from customer where rnk = dd.rnk ;
              l_txt  := To_char(gl_bdate, 'dd/mm/yyyy') ||nlchr ||
                        l_txt  || nlchr ||'���.' || dd.CC_ID ||nlchr || CASE WHEN n_sos = 11 THEN '1.����������� ���'
                                                                             WHEN n_sos = 12 THEN '2-5.��������� ����'
                                                                        else null
                                                                        end || nlchr || '��������� ��������� ����������� �볺���(����)' ;
              bms.enqueue_msg( l_Txt, dbms_aq.no_delay, dbms_aq.never, dd.user_id );
        EXCEPTION WHEN NO_DATA_FOUND THEN  null;
        end;
     end if;
     ---------------------------------------------------------
     for aaa in (select * from accounts where a89.acc in (acc, accc ) AND tip <> 'SP ')
     loop

        If n_Sos = 10 and  dd.wdate >= gl_bdate  then  -------------------------------------- ��� ! ��������� ! ���������� (sos=10)

           --- ��������������� ���������� ��������������  ������
           begin select lim into aaa.lim from OVR_LIM where acc = aaa.acc and nd = dd.ND and ok = 1
                    and fdat = (select max(fdat) from OVR_LIM where acc = aaa.acc and nd = dd.ND and fdat<= gl_bdate and ok = 1);
                 update accounts set lim = aaa.lim where acc = aaa.acc ;
           EXCEPTION WHEN NO_DATA_FOUND THEN aaa.lim := 0 ;
           end;

           --- ��������������� ���������� ������ + ������� ����� ����C� �� ���������
           OVRN.SetIR ( dd.nd, aaa, 1, gl_bdate, acrn.fprocn ( aaa.acc, 1, dd.sdate) )   ; -- �� ���� ��� 2600+8998*
           If aaa.acc=a89.acc then OVRN.SetIR(dd.nd, aaa, 0, gl_bdate, acrn.fprocn ( aaa.acc, 0, dd.sdate) )   ;   -- ��������������� ���������� ������ �� ������  ��� 899*
           else                    delete from OVR_TERM_TRZ where acc = aaa.acc ;        -- ��� 2600 ������� ����� ����C� �� ���������
           end if;

        Else   ------------------------------------------------------------------------------- ��� ... ���������...(sos=11,12,13)
           -- ��������� ������ ����
           update accounts set lim = 0 where acc = aaa.acc ;

           --  �������� �������� ������ ��� 8999, a �� ��� - ������ ��������� �� �������,
           OVRN.SetIR ( dd.nd, aaa, 1, gl_bdate, acrn.fprocn ( aaa.acc, 1, dd.sdate-1 ) ) ;

           If aaa.tip = 'OVN' then    --- �������� ��� ��� !!!!
              OVRN.SetIR ( dd.nd, aaa, 0, gl_bdate, 0 ) ;  ---8998*

           ElsIf n_Sos in (11,12) then  -- ������ ���� ������ �� ���������

              nTmp_:= CASE  WHEN n_Sos = 12 THEN 30  -- ������ ������
                            Else                 15  -- ���������
                            end ;

              l_mdat := LEAST ( NVL(aaa.mdate, gl_bdate) + nTmp_, dd.wdate) + 1 ;  -- �� �� �����, ��� ���� ������
              l_mdat := Dat_Next_U ( l_mdat , 0 ) ;
              If aaa.ostc < 0 then
                 OVRN.isob  (p_nd => dd.ND, p_sob =>  '������� ���������� '||to_date(l_mdat,'dd.mm.yyyy') );
              end if;

           end if;
        end if;

       end loop; ---- aaa

  end if;

end UPD_SOS ;
--------------------------------------------------
procedure NEW_SOS (p_ND number, p_sos int) is
begin
   for k in (select rowid RI, vidd, nd, ndi from cc_deal where (vidd=10 and nd= p_nd) OR (vidd=110 and ndi=p_nd) )
   loop  Update cc_deal set sos = p_sos where rowid = k.RI; end loop;
end NEW_sos;
----------------------
procedure REPL_ZAl  ( p_nd number ) is  --�������� ������� �� ��� � nd_acc ��� ��������
begin for z in ( Select ND,acc from cc_accp Z where nd = p_nd )
      loop
          begin insert into nd_acc (nd,acc) values (z.ND,z.acc);
          exception when dup_val_on_index then null;
          end  ;
      end loop ;
end REPL_ZAl ;
------------------------
function FOST_SAL (p_acc number, p_fdat date ) return number  is  l_ost number := 0;
begin
 begin select ostf - dos + kos into l_ost from saldoa SA
       where SA.acc  = p_acc
         and SA.fdat = ( select max(x.fdat) from saldoa x where x.acc = SA.acc and x.fdat <= p_fdat);
 EXCEPTION WHEN NO_DATA_FOUND THEN l_ost := 0;
 END;
 return l_ost;
end FOST_SAL ;
---------------

function  RES26    (p_acc number )  return number is l_Res number;
  -- �������-���������� ������� ������� 2600 ��� ��������
  -- � ����������� �������� ������� + �������� ���� + ���� �� ���
  a26 accounts%rowtype;

  A_ number ; -- ������ ���
  B_ number ; -- ������ ���
  C_ number ; -- C����� ��� = A+B
  D_ number ; -- ��� ���
  E_ number ; -- ����� ���
  F_ number ; -- ����.��� �� ��� = D - E
  R_ number ; -- ������ ��� ��������  . �� �� ����� 0 !

/* �������
        A         B      C       D       E       F       R
  1) + 1000  500  1500   300  200  100  1100  ���(  � + min(B,F), 0 )
  2) + 1000   50  1050   300  200  100  1050
  3)      0  500  500   300  200  100   100
  4)      0   50  50   300  200  100    50
  5)    -30  500  470    300  230   70    70  ��� ( min(C,F) ,0)
  6)    -30   50  20   300  230   70    20
  7)    -50  500  450   300  250  50    50
* 8)    -50   50  *0   300  250  50     0
  9)    -70  500  430   300  270  30    30
*10)    -70   50  *0(-20)   300  270  30     0
 11)   -200  500  300      300  400  0(-100)     0
*12)   -200   50  *0(-150) 300  400  0(-100)     0

*/

begin
  begin select * into a26 from accounts where acc = p_acc;
        A_ := a26.ostc ;  B_ := a26.lim ;  C_ := A_ +  B_ ;    R_:= 0 ;

        If C_ > 0 then
           If a26.accc is null then
              R_ := C_ ;
           else
               begin  select lim                into D_ from accounts where acc  = a26.accc;
                      select -NVL( sum(ostc),0) into E_ from accounts where accc = a26.accc and ostc < 0 ;
                      F_ :=  D_ - E_ ;
                      If A_ >=  0 then R_ :=  A_+ Least( B_, F_ );
                      Else             R_ :=      Least( C_, F_ );
                      end if ;
               EXCEPTION WHEN NO_DATA_FOUND THEN R_ := C_ ;
               END ;
           end if ;
        end if ;

        RETURN Greatest( 0 , R_ );
  EXCEPTION WHEN NO_DATA_FOUND THEN null ;
  END;

end RES26 ;
-----------
function Get_MDAT(p_acc number) return date is -- ����������� ����-���� ���������
  l_mdat     date;
  l_term_OVR int ;
begin
  select max(fdat) into l_mdat  from saldoa where acc = p_acc and ostf >= 0 and ostf-dos+kos < 0 ;
  l_term_OVR := to_number(OVRN.GetW(p_acc, 'TERM_OVR' )) ;
  l_mdat     := l_mdat + l_term_OVR - 1   ;
  l_mdat     := Dat_Next_U ( l_mdat , 0 ) ;
  RETURN l_mdat;
end Get_MDAT;

procedure STOP (p_mode int, p_ND number, p_ACC number,  p_NLS varchar2, p_KV int,  p_X varchar2) is -- ����������=1 / �����=0

--�������~�������~~ 1.��������� STOP  sPar=[PROC=>OVRN.STOP(1,:ND,:ACC,:NLS,:KV,:X)][QST=>���������� ���������� :NLS ?
--�������~������ ~~ 0.³����   STOP  sPar=[PROC=>OVRN.STOP(0,:ND,:ACC,:NLS,:KV,:X)][QST=>³������ ����������  :NLS ?

  l_txt varchar2(250); l_sos int;  tt OVR_TERM_TRZ%rowtype;
begin

  If p_mode = 0 then  -- ����� ����� ����������

     begin select * into tt from  OVR_TERM_TRZ where acc1 = p_acc and (DATVZ <= gl.bdate or datsp >= gl.bdate) and rownum = 1 ;
           l_Txt := '����� ����: '      ;
           l_sos := null;
           delete from OVR_TERM_TRZ where acc1 = p_acc ; ---- and trz = 4;
     EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error (g_errn,'�� ���.'||p_nls||' �� �� ���� �� ��������� ����� ����������');
     end ;

  elsIf p_mode = 1 then -- �������� ������ ����������

     begin select * into tt from  OVR_TERM_TRZ where acc1 = p_acc and trz = 4 and (DATVZ <= gl.bdate or datsp >= gl.bdate) and rownum = 1 ;
           raise_application_error (g_errn,'�� ���.'||p_nls||' '||to_date(tt.DATVZ,'dd.mm.yyyy')||' ��� ���� ��������� ����� ����������');
     EXCEPTION WHEN NO_DATA_FOUND THEN
           l_Txt := '����������� ����: ';
           l_sos := 12 ;
           delete from OVR_TERM_TRZ where acc1 = p_acc and trz = 4;
           -- ������ ���� 4 "�����" ������������ ���  30
           OVRN.ins_TRZ (p_acc1 => p_acc, p_datVZ => gl.bdate, p_datSP => null, p_trz => 4);
      end ;

  end if;

  OVRN.UPD_SOS  (p_nd => p_ND, p_sos => l_sos  ) ;
  OVRN.SetW ( p_acc, 'STOP_O', to_char(p_mode) ) ;
  l_Txt := Substr(l_Txt || p_x,1, 250);
  OVRN.isob (p_nd => p_ND, p_sob => '���.'|| p_nls || '/'||p_kv|| l_txt );

end STOP;

procedure SetZ  ( p_acc number, p_npp int, p_txt varchar2  ) is  --���������� ������ ���.����������� ��� ���� ���
      l_txt varchar2 (100) := substr(p_txt,1,100);
      l_acc number         := NVL ( p_acc, to_number( pul.Get_Mas_Ini_Val('ACC') ) );
begin
      If p_npp = 0 then
         delete from OVR_REP_ZAG where acc = l_acc;
         insert into OVR_REP_ZAG (ACC,npp,txt) select l_acc, npp, '______________' from vZ_ovrn;
      else
         update OVR_REP_ZAG set txt = l_txt where  acc = l_acc and npp = p_npp;
         if SQL%rowcount = 0 then insert into OVR_REP_ZAG (ACC,npp,txt) values (l_acc, p_npp, l_txt); end if;
      end if;

end SetZ;
----------------
procedure SetIR    ( p_nd  number, aa accounts%rowtype, p_id int, p_dat date, p_ir number) is --���������� ���� ������ �� ���
  ii int_accn%rowtype       ;
  o_IR   number; n_IR number;   p4_ number ;
  l_kodK RNKP_KOD.kodk%type ;
  l_ob2  accounts.ob22%type ;
  l_ob7  accounts.ob22%type ;
  l_nls  accounts.nls%type  ;
begin

  If p_ir is not null then

     begin select * into ii from int_accn where acc = aa.acc and id = p_id ;
           If p_Ir = 0 and aa.nbs like '20%' and p_id = 0 and aa.tip <> 'SP ' then
              raise_application_error(g_errn,'��������� % ������=0 (������ id=0) ��� ���'|| aa.nls );
           end if;

     EXCEPTION WHEN NO_DATA_FOUND THEN   ----- raise_application_error(g_errn,'�� �������� % ������(id='||p_id||') ��� ���=' ||aa.nls);

        If aa.tip = ovrn.tip then
           insert into int_accn (ACC,ID,METR,BASEM,BASEY,FREQ, acr_dat ) values (aa.acc, p_id, 0,0,0,1, (aa.daos-1) );
        else
           -- ��� �������������� ��
           begin Select KODK Into l_kodK From RNKP_KOD Where RNK = aa.RNK and rownum=1 ;
           EXCEPTION WHEN NO_DATA_FOUND THEN l_kodK := 0;
           END;

           If    l_kodK =  2 then l_ob2 := '04' ; l_ob7 := '13' ;  --  ��������
-------    ElsIf l_kodK =  5 then l_ob2 := '10' ; l_ob7 := '17' ;  --  ���������
-------    ElsIf l_kodK =  6 then l_ob2 := '11' ; l_ob7 := '19' ;  --  ���
-------    ElsIf l_kodK =  8 then l_ob2 := '12' ; l_ob7 := '20' ;  --  ���
-------    ElsIf l_kodK = 11 then l_ob2 := '13' ; l_ob7 := '21' ;  --  �����
           Else                   l_ob2 := '01' ; l_ob7 := '06' ;  --  ����
           end if;

           begin
              select a.acc, a.dazs   into ii.acra , ii.acr_dat  ------------  1).  ������������ ACRA
              from accounts a, int_accn i
              where a.rnk = aa.rnk and a.kv= aa.kv  and i.id = 1 and i.acc = aa.acc and a.acc = i.acra and a.dazs is null ;
/*
              select acc, dazs   into ii.acra , ii.acr_dat  ------------  1).  ������������ ACRA
              from ( select acc, dazs from accounts where rnk= aa.rnk and kv= aa.kv and nbs= substr(aa.nbs,1,3)||'8'  order by decode(dazs,null,1,2) )  where rownum = 1;
              If ii.acr_dat is not null then
                 update accounts set dazs = null where acc = ii.acra ;
                 Accreg.setAccountSParam ( ii.Acra, 'OB22', l_ob2 )  ;
              end if ;
*/
           EXCEPTION WHEN NO_DATA_FOUND THEN  --  2608
              l_nls := OVRN.Get_NLS (p_R4 => substr(aa.nls,1,3) || '8' ) ;   --l_nls := vkrzn (substr(gl.aMfo,1,5), substr(aa.nls,1,3) || '80'|| substr(aa.nls,6,9) ) ;
              op_reg_ex(mod_=> 1 , p1_ =>p_nd, p2_=>0, p3_=>aa.grp, p4_=>p4_, rnk_=> aa.rnk, nls_ => l_nls ,
                        kv_ => aa.kv, nms_=>'���.%% �� ���.��� ���.'||aa.nls, tip_=> 'ODB' , isp_ => aa.isp, accR_=> ii.acra, tobo_=> aa.branch );
              Accreg.setAccountSParam(ii.Acra, 'OB22', l_ob2 ) ;
           end;

           Accreg.setAccountSParam(ii.Acra, 'R011', '1' ) ;
           Accreg.setAccountSParam(ii.Acra, 'S180', '1' ) ;
           Accreg.setAccountSParam(ii.Acra, 'S240', '1' ) ;
           OP_BS_OB1 (PP_BRANCH => substr(aa.branch,1,15) , P_BBBOO =>'7020'||l_ob7 ) ;   ------------  2).  ������������ ACRB -- �� � 2017 �� ��������

           begin select acc into ii.AcrB from accounts where nls = nbs_ob22_null('7020',l_ob7, substr(aa.branch,1,15) ) and kv = gl.baseval; -- �� � 2017 �� ��������
           EXCEPTION WHEN NO_DATA_FOUND THEN  null;
           end ;

           begin insert into int_accn (ACC,ID,METR,BASEM,BASEY,FREQ, acr_dat, acra, acrb) values( aa.acc, 1, 0, 0, 0, 1 ,gl.bdate-1, ii.acra, ii.acrb );
           exception when dup_val_on_index then    update int_accn set acra = ii.acra,  acrb = ii.acrb    where acc = aa.acc and id = 1;
           end ;

        end if ;
     end ;

     o_IR := acrn.fprocn ( aa.acc, p_id, p_dat ); -- ���������� % ������

     n_IR := p_Ir ;

     If aa.tip = 'SP ' then

        -- ����� ���� ��� ����� ����.������
        begin select * into ii from int_accn where id = 0 and acc = aa.ACCC and metr = 7;
              select max(ir) into n_IR from INT_OVR where id = ii.idr;
        EXCEPTION WHEN NO_DATA_FOUND THEN  null;
        end ;

     end if;

     If o_IR <> n_IR then
        update int_ratn set ir = p_ir where acc = aa.acc and id = p_id and BDAT = p_dat  ;
        if SQL%rowcount = 0 and p_IR <> o_IR  then  insert into int_ratn (ACC,ID,BDAT,IR) values (aa.acc, p_id, p_dat, p_ir ); end if;
     end if ;

  end if ;

end SetIR;
-------------------------------------
procedure SetW     ( p_acc number , p_tag varchar2, p_val varchar2 ) is  --���������� ���.���� �� ���
begin delete from accountsW where acc = p_acc  and tag = p_tag;
      If p_val is NOT null then insert into accountsW (acc,tag,value) values (p_acc,p_tag,p_val); end if;
end SetW;
----------------
function  GetAL  ( p_acc number , p_dat date ) return  number  is
 --���� (1) ��� ���(0) ������������� ����� �� ���� �� 21 ����� ������ ����
 l_ret int := 0; l_dat21 date; l_nd number ;
begin
 l_dat21 := trunc ( p_dat, 'MM') + 20 ;

 begin select d.nd into l_nd from cc_deal d, nd_acc n where d.sos >= 10 and d.sos < 15 and d.nd = n.nd and n.acc = p_acc and d.vidd = 10 ;
 EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
 end ;

 begin select 1 into l_ret from ovr_lim where acc = p_acc and fdat = l_dat21 and OK = 1 and nd = l_nd ;
 EXCEPTION WHEN NO_DATA_FOUND   THEN  l_ret := 0 ;
 end;
 RETURN l_Ret;
end GetAL;
-----------------

function GetW ( p_acc number, p_tag varchar2) return  varchar2 is --��������   ���.���� �� ���
       l_val accountsw.value%type;
begin  begin select value into l_val from accountsW where acc = p_acc  and tag = p_tag;
       EXCEPTION WHEN NO_DATA_FOUND   THEN  null;
       end;
       RETURN l_val ;
end GetW;

-------------------
function  GetCW    ( p_rnk number , p_tag varchar2) return  varchar2   is --��������   ���.���� �� RNK
       l_val CUSTOMERW.value%type;
begin  begin select value into l_val from CUSTOMERW where rnk = p_rnk  and tag = p_tag;
       EXCEPTION WHEN NO_DATA_FOUND   THEN  null;
       end;
       RETURN l_val ;
end GetCW;
-------------------


procedure LIM      ( p_ND number , p_date date ) is --����-�������� ������ �� ��� � �����  � �� ������� �� �� 5-� ������
  ---  � ������� ������
  LD0_ number  ; -- ��0  ����� �� �������� ��������������  �������� ��������
  PD_  number  ; -- ��  % ��� ��� ����.������ �� ���  �������� ��������
  LDT_ number  ; -- ���  �������  ����� �� ��������   ������� ��������

  LK0_ number  ; --  -- �K0  ����� �� ������� ��������������  �������� ��������
--PK_  number  ; -- ��  % ��� ��� ����.������ �������  ���.�������� ��������( � �)
--LKT_ number  ; -- ���  �����  �� ������� �������  ������� ��������
  --- � ���������� ���������
  LKN_ number  ; -- ���  �����  �� ������� �����   ������� ��������
  LDN_ number  ; -- ���  �����  �� �������� �����   ������� ��������
  --- � ������� ����������
  CKO_ number  ;      -- ��� ������� � �� ��� �  � = 1,2, 3 , . . .  � = 1,2,3
  CDO_ number  := 0 ; -- ��� ��������
  l_ND number  ;
  dat_  date   ;
  dat1_ date   ;
  dat3_ date   ;
  acc8_ number ;
  dat21_ date  ;
  l_donor int  ;
  dTmp_ date   ;
  nTmp_ number ;
  l_DEL_LIM  number;  -- Max ���������� % ��������� ������ ���� �� ������������
  l_TERM_LIM int   ;
begin

  l_ND := NVL(p_ND, to_number( pul.Get_Mas_Ini_Val('ND'))  ) ;

  begin select d.limit*100, to_number(OVRN.GetW(a.acc, 'PCR_CHKO')), a.acc, a.lim,  NVL(to_number (OVRN.GetW(a.acc, 'DEL_LIM') ),10) /100
        into   LD0_       ,    PD_                                 , acc8_, LDT_ ,  l_DEL_LIM
        from cc_deal d, accounts a, nd_acc n
        where d.nd = L_ND  and d.nd = n.nd and n.acc = a.acc and a.tip = 'OVN' ;
        -- ������ - �������-����������� ������
        select lim into LD0_ from OVR_LIM   where nd = l_ND and acc = acc8_ and fdat = (select min(fdat) from OVR_LIM where nd= l_ND and acc= acc8_);
  EXCEPTION WHEN NO_DATA_FOUND   THEN  RETURN;
  end;

  dat_   := trunc( nvl ( p_date, gl.bdate), 'MM') ; --- ����� ��� = 05.05.2016.      dat_  = 01.05.2016
  dat1_  := add_months ( dat_ , - 3 ) ;             ---                        ����� dat1_ = 01.02.2016,
  dat3_  := dat_ - 1   ;                            ---                              dat3_ = 30.04.2016
--dat21_ :=  dat3_ + 21;

  l_TERM_LIM := NVL( to_number(OVRN.GetW( acc8_, 'TERM_LIM') ), 20) ;              -- 09                   --20(null)
  dat21_ :=  dat_  +  l_TERM_LIM ;                                                 -- dat21_ = 10.05.2017.  21.05.2017
  dat21_ := Dat_Next_U ( dat21_, 0 ) ;

  --������ ���
  delete from OVR_LIM where ND = l_nd and fdat =  dat21_  and  PR = 1;  -- �������� ������ �������������
  -----------------------------------------------------g_TAGC = 'PCR_CHKO'; -- ����i� �i�i�� (% �i� ���)
  For a26 in (select acc, to_number(OVRN.GetW(acc,'PCR_CHKO')) PK, lim LKT from accounts where  accc = acc8_ and nbs in ('2600','2650','2602','2603','2604') )  -- ��� ��-2017 �� �������� 
  loop
     l_donor := nvl(to_number (OVRN.GetW(a26.acc,'DONOR' ) ),0) ;

     If l_donor <> 1 then

        -- ���� ��� = 0, �� ����� ���������� �� �������
        If a26.LKT = 0 then
           select max(fdat) into dTmp_ from OVR_LIM  where nd = l_ND and acc = a26.acc and fdat < dat21_ and lim >0 and ok = 1;
           If dTmp_ is null then
              raise_application_error(g_errn, g_errS||'³����� ������ ���� �� =0 �� �������� ref='||l_nd )  ;
           end if;
           select lim  into a26.LKT from  OVR_LIM  where nd = l_ND and acc = a26.acc and fdat = dTmp_ and ok = 1 ;
        end if;

        -- �������������� (����������)
        select max(fdat) into dTmp_ from OVR_LIM_DOG  where nd = l_ND and acc = a26.acc and fdat <= dat21_ and lim >0 ;
        If dTmp_ is null then
            raise_application_error(g_errn, g_errS||'³����� �����. ���� �� =0 �� �������� ref='||l_nd )  ;
        end if;
        select lim  into LK0_ from  OVR_LIM_DOG  where nd = l_ND and acc = a26.acc and fdat = dTmp_;

       ---� ��  = �������������� = (��1+��2+��3)/3
---    select DIV0( sum(s), count(*) )  into CKO_ from OVR_CHKO where acc = a26.acc and datm >= dat1_ and datm <= dat3_ and s > 0 ;
       select DIV0( sum(s), count(*) )  into CKO_ from OVR_CHKO where acc = a26.acc and datm >= dat1_ and datm <= dat3_ and s is not null ;

       CDO_ := CDO_ + CKO_ ;
       LKN_ := CKO_ * a26.PK /100  ;  -- � ��� = �� *��.
       nTmp_ := div0( Abs(LKN_-a26.LKT), a26.LKT );

       If to_number(OVRN.GetW(a26.acc,'DONOR')) = 1    then  LKN_ := 0 ; -- �����
       ElsIf nTmp_ < l_DEL_LIM                         then  LKN_ := a26.LKT;
       end if;

       LKN_ := least ( LKN_, LK0_ );
       delete from OVR_LIM  where ND = l_ND and acc=a26.acc and fdat =dat21_ ;
       Insert into OVR_LIM (PR, ND, ACC, fdat, Lim ) values (1, l_ND, a26.acc, dat21_, round(LKN_,0) );

     end if;

  end loop;

  -- ������ ���
  If LDT_ = 0 then
     select max(fdat) into dTmp_ from OVR_LIM  where nd = l_ND and acc = ACC8_ and fdat < dat21_ and lim >0 and ok = 1 ;
     If dTmp_ is null then
        raise_application_error(g_errn, g_errS||'³����� ������ ���� �� =0 �� �������� ref='||l_nd )  ;
     end if;
     select lim  into LDT_ from  OVR_LIM  where nd = l_ND and acc = ACC8_ and fdat = dTmp_ and ok = 1 ;
   end if;

  -- �������������� (����������)
  select max(fdat) into dTmp_ from OVR_LIM_DOG  where nd = l_ND and acc = acc8_ and fdat <= dat21_ and lim >0 ;
  If dTmp_ is null then
     raise_application_error(g_errn, g_errS||'³����� �����. ���� �� =0 �� �������� ref='||l_nd )  ;
  end if;
  select lim  into LD0_ from  OVR_LIM_DOG  where nd = l_ND and acc = acc8_ and fdat = dTmp_;
  LDN_ := CDO_ * PD_ /100  ;  -- � ��� = �� *��.
  nTmp_ := div0( Abs(LDN_-LDT_), LDT_ );

  If nTmp_  < l_DEL_LIM  then  LDN_ := LDT_ ; end if ;

  LDN_ := least ( LDN_, LD0_);

  delete from OVR_LIM  where ND = l_ND and acc= acc8_ and fdat =dat21_ ;
  Insert into OVR_LIM (PR, ND, ACC,  fdat, Lim ) values (1, l_ND, acc8_, dat21_, round(LDN_,0) );

end LIM;

----------------------------------------
PROCEDURE AUTOR ( p_nd number , p_x varchar2) is ---- �����������
  l_nd number;
  dd  cc_deal%rowtype  ;
  a89 accounts%rowtype ;
  ii  int_accn%rowtype ;

  l_lim number   ;
  n_Kom int      ;
  n_Sum number   ;
  u_Kol int      ;
  nTmp_ number   ;
  sTmp_ varchar2 (100) ;
  dTmp_ Date     ;
  k9129_ number  ;
  l_donor int    ;
  x_acc26 number ;
  x_lim26 number ;
  l_CPROD int    ;
  l_ob22_9129 accounts.ob22%type;
  l_acc_9129  accounts.acc%type;
BEGIN

  if  length(trim(p_x )) < 6 then raise_application_error(g_errn, g_errS||'�� ������ ������� ��� �����������' )  ;  end if;
  l_ND := ABS( p_ND );
  BEGIN  sTmp_ :='cc_deal' ; SELEct   * into dd  from cc_deal              where   nd =  l_ND ;
         sTmp_ :='accounts'; select a.* into a89 from nd_acc n, accounts a where n.nd = dd.nd   and n.acc= a.acc and a.tip = OVRN.tip;
         sTmp_ :='int_accn'; select   * into ii  from int_accn             where  acc = a89.acc and id = 0 ;
  EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||'�� �������� ������ ref='||p_nd||' '||sTmp_ )  ;
  end;
  If p_nd < 0 then

--   update cc_deal set sos = 0 where nd = l_ND;
     OVRN.new_sos ( p_nd =>l_nd, p_sos => 0) ;

     OVRN.isob  (p_nd => dd.ND, p_sob => '��-������������:������ OVRN');
     return;
  end if;
  --- �������� �� ���.
  if gl.aUid = dd.user_id then raise_application_error(g_errn,'���������� '||  gl.aUid || ' �� ���� ������������ <����> ����� ' ||dd.nd); end if;

  select count(*), min(acc), min (lim) into u_Kol, x_acc26, x_lim26 from accounts where accc = a89.acc and nbs in ('2600','2650','2602','2603','2604') ;  -- ��� ��-2017 �� �������� 
  If u_Kol = 0 then raise_application_error(g_errn, g_errS||'³����� ��� ��� �������� ��������' ) ;   end if;

  If u_kol = 1 then

     -- 26.10.2016 ��� ����������� ������ ��� ������ ����� �������� ��� ������� ������������� �������� ����������
     --             ������.���, ������� ˳�.��л, �˳�� �� ��� (%)�
     --             - ������������� ������� ��������� ������� ��� ����������� ���

     update cc_deal  set limit = x_lim26/100 where nd  = dd.nd   ; --\  ������.���,
     update accounts set lim   = x_lim26     where acc = a89.acc ; --/

     delete from OVR_LIM where nd = dd.ND and acc = a89.acc      ; --|
     insert into OVR_LIM (ND,    ACC,FDAT,LIM,          PR,OK)               --V   ������� ˳�.��л
                   select ND,a89.acc,FDAT,round(LIM,0), PR,OK
                   from OVR_Lim where nd = dd.ND and acc = x_acc26 ;

     OVRN.SetW ( p_acc => a89.acc, p_tag =>'PCR_CHKO', p_val => OVRN.GetW(x_acc26 ,'PCR_CHKO')   )  ; -- �˳�� �� ��� (%)
     ---------------------------
     OVRN.SetIR( dd.nd, a89,  0, dd.sdate, 0 ) ; --\ �������� ������ = 0,
     OVRN.SetIR( dd.nd, a89,  1, dd.sdate, 0 ) ; --/
     delete from int_ratn where id = 1 and acc = x_acc26 and bdat >= dd.sdate; -- ���.��� = ������� ���.

     --- � ������ ���� � ������ 1 �������� ��������� �������� �� ��������� (��� ����������� �� �������������� �������):
     OVRN.TARIF   ( 2, x_acc26, 142, 0); --- 142 � �������� �� ����������� ���������� ��������;
     OVRN.TARIF   ( 2, x_acc26, 143, 0); --- 143 � �������� �� ����������� ������ NPP;
     OVRN.TARIF   ( 2, x_acc26, 145, 0); --- 145 � �� ����������� ����������� ��������;
     OVRN.TARIF   ( 2, x_acc26, 146, 0); --- 146 � �� ����������� ������� NPP;

  end if;

/*
��������� ������� ���������� �������� ������������ ����� �������� � ������ ��̳ ����������, ��������� ��������, NPP�:
1) ���� � ������� 1 ������� � �������� �������� CPROD ������ �������� 13 � ������������� �����;
2) ���� � ������� 2 �� ����� �������� �� ������� ������ �������� ���������� �� ������ �������� (�����) � �������� �������� CPROD ������ �������� 14 � ������������� �����;
3) ���� � �������� 2 �� ����� �������� �� ������ ������ �������� ���������� �� ������ �������� (�����) � �������� �������� CPROD ������ �������� 15 � ������������� �����;
*/

  If    u_kol = 1 then   l_CPROD := 13;
  elsIf acrn.fprocn (a89.acc,0,gl.bdate) = 0 and acrn.fprocn(a89.acc,1,gl.bdate) = 0 then l_CPROD := 14;
  else                   l_CPROD := 15;
  end if;

  begin insert into nd_txt ( nd, tag, txt) values (dd.nd, 'CPROD', l_CPROD );
  exception when dup_val_on_index then null;
  end;


  If NVL( to_number( OVRN.GetW ( a89.acc, 'NOT_ZAL')), 0 ) <> 1 then  -- ������� "��� �����������"
     BEGIN  SELEct   1 into nTmp_ from cc_accp z, nd_acc n where n.nd = l_ND and n.acc = z.accS and rownum = 1 ;
     EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||'³����� ����-��� ������������ �� �������� ref='||l_nd )  ;
     end;
  end if;


  If ii.metr = 7  then
     BEGIN  SELEct 1 into nTmp_ from int_ovr where id = ii.idr and kv = gl.baseval and rownum = 1 ;
     EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||'³������ ���� ����� ��� �������� ������. ���='||l_nd )  ;
     end;
  end if ;

  If OVRN.GetW(a89.acc, 'PCR_CHKO') is null then
     raise_application_error(g_errn, g_errS||'���.�� ��������� ����.PCR_CHKO=����i� �i�i�� (% �i� ���)' );
  end if ;

  If OVRN.GetW(a89.acc, 'TERM_DAY') is null then
     raise_application_error(g_errn, g_errS||'���.�� ��������� ����.TERM_DAY =����i�(���� �i�) ��� ������ %%' );
  end if ;

  update int_accn set basey = 3 where acc = a89.acc and id = 0 ; -- 3 �% ����/360  ACT/360
  update int_accn set basey = 0 where acc = a89.acc and id = 1 ; -- 0 �% ����/����  ACT/ACT

  -- ������������ ������������� ��� �������� ������
  update  OVR_lim set ok = 1 where nd = dd.nd;


  --- �������� �� ��������
  FOR a26 in (select * from accounts where nbs in ('2600','2650','2602','2603','2604') and acc in ( select acc from nd_acc where nd = dd.nd)) --  -- ��� ��-2017 �� �������� 
  loop
    ------------------------------------ g_TAGN   =  DONOR -- ������� ������
    l_donor := to_number (OVRN.GetW(a26.acc, 'DONOR' ) );
    If    l_donor = 1 then null;
    else
   
       -- 9129.��22 = 04,  ���� ���� ����������� � ����� ���������;
       -- 9129.��22 = 37,  ���� ����������� ��� ������ ���� �������������� ������������ ��������� �������������� (34 � 334. ������)
       begin select a.acc      into l_acc_9129  from accounts a, nd_acc n     where a.tip ='CR9'       and a.acc= n.acc and n.nd = dd.nd    and a.rnk = a26.rnk ;
             begin select '04' into l_ob22_9129 from cc_accp zz, accounts az  where az.nbs like '95__' and az.ostB < 0  and zz.acc = az.acc and zz.accs = a26.acc and rownum = 1 ;
             EXCEPTION WHEN NO_DATA_FOUND  THEN l_ob22_9129 := '37' ;
             end;
             Accreg.setAccountSParam( l_acc_9129, 'OB22', l_ob22_9129 );      
        EXCEPTION WHEN NO_DATA_FOUND  THEN null ;
        end;

       -- ���.����.�����
       If OVRN.GetW(a26.acc, 'TERM_OVR' ) is null then
          raise_application_error(g_errn, g_errS||a26.nls||'.�� ��������� ����.TERM_OVR = T���i� ������������� ���, �i�.��i�' );
       end if;

       If OVRN.GetW(a26.acc,'PCR_CHKO') is null then
          raise_application_error(g_errn, g_errS||a26.nls||'.�� ��������� ����.PCR_CHKO=����i� �i�i�� (% �i� ���)' );
       end if;

       sTmp_ := OVRN.GetW(a26.acc, 'NEW_KL' ) ;
       dTmp_ := trunc( dd.sdate, 'MM');

       If    sTmp_ = '0' then --  ��� �����������
             --������������� ����-����������� ��������� �� ������� �����, ���� ��� �� ����� ����� �� ���������,
             dTmp_  := add_months ( trunc (gl.BDATE, 'MM'), -1 ) ;
             OVRN.CHKO ( p_mode => 0 , p_acc => a26.acc , p_dat => dTmp_ , p_s => null, p_pr => null) ; -- 0 - ��������  ������ ��� �� ����� � ������
             OVRN.CHKO ( p_mode => 1 , p_acc => a26.acc , p_dat => dTmp_ , p_s => null, p_pr => null) ; -- 1 - ��������� ������ ��� �� ����� � ������
             OVRN.CHKO ( p_mode => 9 , p_acc => a26.acc , p_dat => dTmp_ , p_s => null, p_pr => null) ; -- 9 - ��������� ������ ��� �� ����� � ���� ����� = ���� ��� �� �����
             --  ������ ��λ �� ���������� ��� ������
             select count (*) into nTmp_ from
             (
------         select 1 s from OVR_CHKO where acc = a26.acc and s >0 and datm = add_months(dTmp_,-3) union all
               select 1 s from OVR_CHKO where acc = a26.acc and s >0 and datm = add_months(dTmp_,-2) union all
               select 1 s from OVR_CHKO where acc = a26.acc and s >0 and datm = add_months(dTmp_,-1)
              ) ;
             If nTmp_ < 2 then   null;
                raise_application_error(g_errn, g_errS||a26.nls||'.�� �����. ³����� ������� ��� �� �������� -3,-2 �����');
             end if;

       ElsIf sTmp_ = '1' then --  ??????  ��� ����� � ������ ���� ������� ������ ��λ �� ������� 2 ������.  � ��, ��� �����.
             null ;
       Else  raise_application_error(g_errn, g_errS||a26.nls||'.�� ��������� ����.NEW_KL =������� "���(0/1) ��"');
       end if;
    end if;

    --������ �������� �����
    select count (*), sum( decode( kod,145, tar, 0) ) into n_Kom, n_Sum from acc_tarif where acc = a26.acc and kod in (141,142,143,144,145,146);
    if n_Kom <  6             then  raise_application_error(g_errn, g_errS||a26.nls||'.�� ��������� �� ��� ��� ������ ������');   end if;
    If n_Sum <> 0 and u_Kol=1 then  raise_application_error(g_errn, g_errS||a26.nls||'.����� 145='||n_Sum/100 || ' > 0 �������� ����� ��� �������� (����� 1-�� ��������) !' );    end if;

    begin SELEct lim into l_lim from OVR_lim where nd = dd.nd and acc = a26.acc and fdat =
         (select min (fdat)     from OVR_lim where nd = dd.nd and acc = a26.acc);
    EXCEPTION WHEN NO_DATA_FOUND  THEN l_lim := 0 ;
    end;

    -- ��������� ��������
    OVRN.BG1 ( 1, 0, gl.bdate, dd, a26 , a26);

    -- ��������� ��� ������
    If l_donor = 1 then l_lim := 0 ; end if; -- �����
    If u_kol = 1 then update accounts set lim = l_lim  where acc = a26.accc ;  end if;
                      update accounts set lim = l_lim  where acc = a26.acc  ;

    -- �������� ����.��������
    If ii.metr = 7  then  update int_accn set metr = ii.metr, idr = ii.idr where acc = a26.acc and id = 0  ; end if ;
    update int_accn set   basey = 3 where acc = a26.acc and id = 0 ; -- 3 �% ����/360  ACT/360
    update int_accn set   basey = 0 where acc = a26.acc and id = 1 ; -- 0 �% ����/����  ACT/ACT

  end loop;

  --� ����� ����������� � ��������� ������� ��������� �������
  delete from OVR_LIM_DOG where nd = dd.nd;
  insert into OVR_LIM_DOG ( ND, ACC, FDAT, LIM ) select ND, ACC, FDAT, round(LIM,0)  from OVR_LIM  where nd = dd.nd;

  -- ��������� 9129
  -- ����� ��� 9129 = ��������� ����-�������, ������� ������ ���� 9129, ������ �� ������� ������� � ������� ���
  select DIV0 ( a89.Lim, sum(LIM) )  into  k9129_ from accounts a where a.accc =  a89.acc;
  for  a26 in (select * from accounts where accc = a89.acc  )
  loop a26.ostx := round( a26.LIM * k9129_ , 0);
       OVRN.BG1 ( 1, 90, gl.bdate, dd, a26,a26 );
  end loop ; -- a26

--update cc_deal set sos = 10 where nd = dd.nd;
  OVRN.new_sos ( p_nd =>dd.nd, p_sos => 10) ;
  OVRN.SetW    ( a89.acc, 'DT_SOS', to_char(gl.bdate,'dd.mm.yyyy' ) || ':0 -> 10' );
  OVRN.isob  (p_nd => dd.ND, p_sob => '������������:������ OVRN');

  update nd_txt set txt = to_char(gl.aUid) || ':' || p_x where nd = dd.nd and tag = 'AUTOR' ;
  if SQL%rowcount = 0 then   INSERT INTO nd_txt (ND,TAG,TXT) values (dd.ND, 'AUTOR', To_char(gl.aUid) || ':' || p_x );  end if;

END autor;
------------------------------------------
PROCEDURE CHKO ( p_mode int, p_acc number, p_dat date , p_s number, p_pr int) is   ---  ���
-- ��� ����������� � �������� ����� ������ ������ � ��� -1 �� �������
--                                                      -2 � -3 (�� �������)- ������ ���� ��� ��������� ���� ���.���
-- 0 - ��������  ������ ��� �� ����� � ������
-- 1 - ��������� ������ ��� �� ����� � ������
-- 9 - ��������� ������ ��� �� ����� � ���� ����� = ���� ��� �� �����
--91 - ������� ������
--92 - �������� ������
--93 - �������� ������

--60 - ��������  ����   ��� �� ����� � ������
--61 - ��������  ����   ��� �� ����� � ������ �������
--62 - ��������  ����   ��� �� ����� � ������ �������

  l_acc number  ; l_dat date  ; l_nls varchar2(15);   l_okpo VARCHAR2(14);
  dat1_ date    ;
  dat2_ date    ;
  l_nd  number  ; l_donor int ;

  l_bDAT_0 date ;   l_sDAT_0 date ;
  l_bDAT_1 date ;   l_sDAT_1 date ;
  l_bDAT_2 date ;   l_sDAT_2 date ;
  l_bDAT_3 date ;   l_sDAT_3 date ;
begin
  If p_mode NOT in ( 0,1,9, 60,61,62, 91 ) then RETURN; end if;

  l_nd  :=                        pul.Get ( 'ND'    )   ;
  l_acc := NVL ( p_acc,           Pul.Get ( 'ACC26' ) ) ;
  l_dat := NVL ( p_dat, TO_DATE ( pul.get ( 'DATM01'), 'dd.mm.yyyy') ) ;

  If p_mode in ( 0, 1, 9, 91 ) then -- ������ � ��������

     l_bDAT_0 :=     trunc (gl.bdate, 'MM') ;
     l_bDAT_1 := add_months( l_bDAT_0, - 1) ;
     l_bDAT_2 := add_months( l_bDAT_0, - 2) ;
     l_bDAT_3 := add_months( l_bDAT_0, - 3) ;

     If    l_dat NoT in ( l_bDAT_1, l_bDAT_2, l_bDAT_3 ) then
                     raise_application_error(g_errn, '������������ ����� ��� ������ � ��� (-1,-2,-3) '||to_date(l_dat,'dd.MM.YYYY')  );
     ElsIf l_dat     in (           l_bDAT_2, l_bDAT_3 ) then
           begin select trunc(d.sdate, 'MM')
                 into l_sDAT_0
                 from cc_deal d, nd_acc n
                 where d.sos < 15 and d.nd = n.nd and n.acc = l_acc and d.vidd = 10  ;

                 l_sDAT_1 := add_months( l_sDAT_0, - 1) ;
                 l_sDAT_2 := add_months( l_sDAT_0, - 2) ;
                 l_sDAT_3 := add_months( l_sDAT_0, - 3) ;
                 If l_dat not in (l_sDAT_1, l_sDAT_2, l_sDAT_3)  then
                    raise_application_error(g_errn, '������������ ������� ����� ��� ������ � ���(-2,-3) ' ||to_date(l_dat,'dd.MM.YYYY')) ;
                 end if;
           EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, ' �� �������� ����� ��� ��� ���='|| l_acc ) ;
           end;
     end if;

  end if;

  dat1_ := trunc     ( l_dat, 'MM');
  dat2_ := add_months( dat1_ , 1) ;

  PUL.Set_Mas_Ini( 'sFdat2', to_char(dat2_,'dd.mm.yyyy'), '���.sFdat2' );

  l_donor := nvl(to_number (OVRN.GetW(l_acc, 'DONOR' ) ),0) ;
  If  l_donor = 1 then RETURN; end if ;

  If    p_mode = 60 then  delete from OVR_CHKO      where datm  = dat1_ and  ACC = l_acc              ; --\
--60 - ��������  ����   ��� �� ����� � ������

  ElsIf p_mode = 61 then  insert into OVR_CHKO (ACC, DATM, S,PR ) values (l_acc, dat1_, p_s*100, p_pr); ---| ������������� ������ ���
--61 - ��������  ����   ��� �� ����� � ������ �������

  ElsIf p_mode = 62 then  update OVR_CHKO set s = p_s*100 where ACC=l_acc and  DATM =dat1_            ; --/
--62 - ��������  ����   ��� �� ����� � ������ �������

  ElsIf p_mode = 91 then
     declare  DAtm0_ date; DAtm1_ date; datm2_ date; datm3_ date; datmF_ date; datmD_ date;
     begin  datm0_ :=  trunc     ( gl.bdate, 'MM') ;
            datm1_ :=  add_months( datm0_,  -1 ) ;
            datm2_ :=  add_months( datm0_,  -2 ) ;
            datm3_ :=  add_months( datm0_,  -3 ) ;

            select datm into datmF_ from OVR_CHKO_DET  where ref = p_s and acc = l_acc ;  -- 05.04.2018 Sta �������� ��� ������ ��� �� 2- (� �����) ������
            If datmF_ <  datm3_  then  raise_application_error(g_errn, ' ���� ��� > 3 ��'); end if;
            If datmF_ <> datm1_  then
               select trunc(sdate,'MM') into datmD_ from cc_deal where nd = l_nd;
               If datmf_ < add_months( datmD_, -1) then
                   raise_application_error(g_errn, ' ���� ��� ����������� ��� ���������');
               end if;
            end if;
            delete from OVR_CHKO_DET  where ref = p_s and acc = l_acc ; -- 91 ������� ��������
     EXCEPTION WHEN NO_DATA_FOUND  THEN null ;
     end;


  -----------------------------------------
  ElsIf p_mode = 0  then  delete from OVR_CHKO_DET  where datm = dat1_ and acc = l_acc ; -- 0 - �������� �����  � ������

  elsIf p_mode = 1  then  ------ 1 - ��������� ����� � ������

     BEGIN SELEct c.OKPO, a.nls, d.nd
           INTO   l_OKPO, l_nls, l_nd
           from customer c, accounts a, nd_acc n, cc_deal d
           where a.acc = l_acc and a.rnk  = c.rnk and a.acc= n.acc
             and n.nd  = d.nd  and d.vidd = 10    and d.sos < 15   ;
     EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, ' �� �������� � ���� ���= '||l_acc )  ;
     end;

/* 10.04.2017
������� ������ ���� :
��� ����� �������� ���������� (���.���. - 646715701; 646715801; 646715901)
��� ����� ��� ����� ��������� ���� ���������� ���������� �� ������� � ����� ������ ������ ������������.
��� �������� �������� ����� ��������������� �� �������� �������.
������� ����� ��������� ����� �������� �������� ��������� ��������㳿 �� �������� ��������
��� ���. ����������, 12� ���.: +380 (44) 249 23 39 ���. ��������: 7339
*/

     -- ��� ������ �������� ����� - � ������������ OPLDOK+SALDOA

/*If l_nd NOT in (646715701, 646715801, 646715901) then
     INSERT INTO OVR_CHKO_DET ( REF,  acc, datm)
     SELECT O.REF,  l_acc, dat1_
     FROM OPER O , (select oo.ref from opldok oo, saldoa ss
                    where ss.acc= l_acc  and ss.acc= oo.acc
                      and ss.fdat >= dat1_ and ss.fdat < dat2_ and ss.kos> 0 and ss.fdat = oo.fdat
                      and oo.dk= 1 and oo.sos= 5
                   ) p
     where o.id_b = l_OKPO and o.nlsb = l_nls   and o.mfob = gl.aMfo   and o.ref  = p.ref
       and o.id_a not in ( select distinct cc.okpo
                           from customer cc, accounts aa, nd_acc nn
                           where cc.rnk = aa.rnk and aa.acc = nn.acc and nn.nd = l_nd
                         ) ;
else
     INSERT INTO OVR_CHKO_DET ( REF,  acc, datm)
     SELECT O.REF,  l_acc, dat1_
     FROM OPER O , (select oo.ref from opldok oo, saldoa ss
                    where ss.acc= l_acc  and ss.acc= oo.acc
                      and ss.fdat >= dat1_ and ss.fdat < dat2_ and ss.kos> 0 and ss.fdat = oo.fdat
                      and oo.dk= 1 and oo.sos= 5
                   ) p
     where o.id_b = l_OKPO and o.nlsb = l_nls   and o.mfob = gl.aMfo   and o.ref  = p.ref
       ;
end if ;*/

DECLARE OKPO_2600 CUSTOMER.OKPO%TYPE := l_OKPO ; ACC_2600 ACCOUNTS.ACC%TYPE := l_acc ;
BEGIN
--jeka 20.04.2017 --��������� ���� ���������� ����� ���� � ���� ����� 2610, 2615, 2651, 2652, 2062, 2063, 2082, 2083
   INSERT INTO OVR_CHKO_DET ( REF,  acc, datm)
   with tt as (select a.acc,a.nls from OVR_ACC_ADD v, accounts a where a.acc = v.acc_add and v.acc = ACC_2600   union all  select a.acc,a.nls from  accounts a where  a.acc = ACC_2600)
     SELECT O.REF,  l_acc, dat1_
     FROM OPER O , (select x.ref from opldok x, saldoa y where y.acc in (select acc from tt) and y.acc=x.acc and y.fdat >= dat1_ and y.fdat < dat2_ and y.kos>0 and y.fdat=x.fdat and x.dk= 1 and x.sos=5 ) p
     where o.id_B = OKPO_2600 and o.nlsB in (select nls from tt) and o.dk = 1 
       and o.mfoB = gl.aMfo   and o.ref  = p.ref

       and o.id_A not in (select distinct z.okpo from customer z, accounts q, nd_acc w  where z.rnk = q.rnk and q.acc = w.acc and W.nd = l_nd  and z.okpo <> OKPO_2600 )
       and o.NLSA not in (select a.nls from accounts a where a.rnk=o.id_B and a.nbs not in ('2610', '2615', '2651', '2652', '2062', '2063', '2082', '2083' )) ;  -- ��� �� � 2017 � ������ ���������

--STA 	05.09.2017 --������²� ���
   INSERT INTO OVR_CHKO_DET ( REF,  acc, datm)
   with tt as (select a.acc,a.nls from OVR_ACC_ADD v, accounts a where a.acc = v.acc_add and v.acc = ACC_2600   union all  select a.acc,a.nls from  accounts a where  a.acc = ACC_2600)
     SELECT O.REF,  l_acc, dat1_
     FROM OPER O , (select x.ref from opldok x, saldoa y where y.acc in (select acc from tt) and y.acc=x.acc and y.fdat >= dat1_ and y.fdat < dat2_ and y.kos>0 and y.fdat=x.fdat and x.dk= 1 and x.sos=5 ) p
     where o.id_A = OKPO_2600 and o.nlsA in (select nls from tt) and o.dk = 0
       and o.mfoA = gl.aMfo   and o.ref  = p.ref
       and o.id_B not in (select distinct z.okpo from customer z, accounts q, nd_acc w  where z.rnk = q.rnk and q.acc = w.acc and W.nd = l_nd  and z.okpo <> OKPO_2600 )
       and o.NLSB not in (select a.nls from accounts a where a.rnk=o.id_A and a.nbs not in ('2610', '2615', '2651', '2652', '2062', '2063', '2082', '2083' )) ;  -- ��� �� � 2017 � ������ ���������

end ;
--------------------------

  elsIf p_mode = 9 then  -- 9 - ����� � ���� ����

/*
     declare l_yes int;
     begin   select 1 into l_yes from OVR_CHKO where datm >= dat1_ and datm < dat2_ and acc = l_acc and s >= 0 ;
             -- ����� ��� �� ���� ����� ��� ����. ��������� �� �� �����
             RETURN;
     EXCEPTION WHEN NO_DATA_FOUND  THEN null;
     end;
*/
     delete from OVR_CHKO where datm = dat1_ and acc = l_acc;
     insert into OVR_CHKO (ACC,DATM,S,PR)     select l_acc, dat1_, sum(o.s), 0 from OVR_CHKO_DET d, oper o where d.acc = l_acc and d.datm = dat1_ and d.ref = o.ref;

  end if;

end CHKO;
---------------------
PROCEDURE INT_OLD ( p_acc number, p_dat2 date ) is    ---  �������  %
  oo   oper%rowtype ;  l_dat2 date ;
begin
  l_dat2 := nvl( p_dat2, gl.bdate-1 ) ;

  for x in (select SN.nls NLSA, SN.KV KV, substr(SN.nms,1,38) NAM_A,   SD.nls NLSB, SD.KV KV2, substr(SD.nms,1,38) nam_b,
                   aa.nls     ,    ii.ID, (ii.acr_dat + 1) DAT1,
                  least (l_dat2, nvl(II.stp_dat, l_dat2) ) DAT2
            from accounts SN,  accounts SD , int_accn II , accounts aa
           where aa.acc = ii.acc and ii.acc = p_acc  and SN.acc = II.acra and SD.acc = II.acrb  and SN.dazs is null  and SD.dazs is null
             and ii.id in (0,1,2)  and ii.acr_dat < least (l_dat2, nvl(II.stp_dat, l_dat2) )
            )
  loop
     acrn.p_int (p_Acc, x.id, x.dat1, x.dat2, oo.s, Null, 1 ) ; -- ���������� ����������
     If abs(oo.s) >= 1 then
        If x.id = 2 then oo.nazn := '����';
        Else             oo.nazn := '�i������' ;
        end if; 
        oo.nazn := substr( oo.nazn || ' �� ���. '||x.nls||' � '||to_char(x.DAT1,'dd.mm.yyyy')||' �� '||to_char (x.DAT2,'dd.mm.yyyy')||' ���. ������ '||to_char(acrn.FPROCN(p_acc,x.id,x.DAT2)) , 1, 160 ) ;

        If oo.s > 0 then oo.dk := 0 ;                  -- �������
        else             oo.dk := 1 ; oo.s := - oo.s ; -- �����
        end if;

        if x.kv <> gl.baseval then oo.s2 := gl.p_icurval ( x.kv, oo.s, gl.bdate);
        else                       oo.s2 := oo.s;
        end if;

        gl.ref (oo.REF);
        oo.nd :=  substr(to_char(oo.REF),-10) ;
        gl.in_doc3(ref_=> oo.REF, tt_=>'%%1', vob_=> 6, nd_ => oo.nd, pdat_=> SYSDATE, vdat_ => gl.BDATE,
                   dk_ => 1,  kv_ => x.kv   , s_=>oo.s, kv2_=> x.kv2, s2_=> oo.s2, sk_ => null, data_ => gl.BDATE, datp_ => gl.bdate ,
                nam_a_ => x.nam_a, nlsa_ => x.nlsa, mfoa_ => gl.aMfo,
                nam_b_ => x.nam_b, nlsb_ => x.nlsb, mfob_ => gl.aMfo,
                nazn_  => oo.nazn, d_rec_=> null  ,
                id_a_  => oo.id_a, id_b_ => gl.aOkpo, id_o_=> null,  sign_ => null, sos_ => 1,  prty_ => null, uid_=> null) ;

        gl.payv( 0, oo.REF, gl.bDATE, '%%1', oo.dk,  x.kv ,  x.nlsa,  oo.s,  x.kv2,  x.nlsb,  oo.s );
        -- ���������� ����, �� ��� % ��� ���������
        update int_accn   set acr_dat = x.dat2  where id = x.id and acc = p_acc ;
        gl.pay ( 2, oo.REF, gl.bDATE);

     end if;
   end loop ;  --- x

end INT_OLD ;
----------------------------------------------------------------------------------------

procedure GLO (p_mode int, p_FDAT date, p_LIM number, p_OK INT ) is  -- ins del upd
  l_nd  number; l_acc number; l_dat date ;
begin
  l_nd  := to_number ( PUL.get('ND')  );
  l_acc := to_number ( pul.get('ACC') );
  If    p_mode=0 then  delete from OVR_LIM where nd = l_nd and acc= l_acc and fdat = p_fdat;
  elsIf p_mode=1 then  insert into OVR_LIM (nd,acc, fdat, lim) values (l_nd,l_acc, p_fdat, round( p_lim*100, 0) ) ;
  elsIf p_mode=2 then
---     select min(fdat) into l_dat where nd=l_nd ND ACC = L_ACC AND FDAT > GL.BDAT
        update OVR_LIM set lim = round(p_lim*100,0), OK = NVL(P_OK,0) where nd=l_nd and acc=l_acc and fdat =p_fdat  ;
  end if;
end GLO;
-----------------------------------------------------------------------------------------
procedure TARIF   ( p_mode int, p_acc number, p_kod number, p_TAR number) is --   upd
 l_S number;
 dd cc_deal%rowtype;
 ee e_deal%rowtype ;
 L_ACC number      ;
begin
 l_acc := NVL(p_acc, to_number ( pul.Get_Mas_Ini_Val('ACC') ) );

If    p_mode = 99 then  -- �������� ����������� ������  =  �������
      delete from ACC_TARIF  where acc = L_ACC   and          kod in (141, 142, 143, 144, 145, 146);
      insert into ACC_TARIF (acc,kod,pr,tar)
                   select  l_acc,kod,pr,tar from tarif where  kod in (141, 142, 143, 144, 145, 146);
elsif p_mode = 2 then

   If p_kod in (141, 144) then
      l_s := p_tar       ; -- �������
      update ACC_TARIF  set PR =  l_s where acc = L_ACC  and kod = p_kod ;
      if SQL%rowcount = 0 then insert into ACC_TARIF (acc,kod, pr, tar) values ( L_ACC, p_kod, l_s,0 ); end if;
      --  141-���?�?� �� ������� ���������� (% �?� �?�?��)
      --  144-���?�?� �� ������.������ ��� (% �?� ����.���.���.)

   elsIf p_kod in (142, 143,145, 146 ) then

      l_s := p_tar * 100 ; -- �����
      update ACC_TARIF  set tar = l_s where acc = L_ACC  and kod = p_kod ;
      if SQL%rowcount = 0 then insert into ACC_TARIF (acc,kod, pr, tar) values (L_ACC,p_kod, 0, l_s); end if;
      --  143-���?�?� �� �?��������� ������� NPP
      --  142-���?�?� �� �?��������� ���������� ����?���
   end if;
end if;

end TARIF ;
--------------------------------
procedure PUL_OVR ( p_RANG int, p_ND number, p_ACC number) is
  l_nd  number;
  l_acc number;
begin
  PUL.PUT( 'ND' , to_char(p_nd ) );
  PUL.PUT( 'ACC', to_char(p_acc) );
  If p_RANG  = 1 then   PUL.Set_Mas_Ini( 'ACCC', to_char(p_acc), 'ACCC' );
  else                  null;
  end if ;
end pul_ovr;

procedure PUL_OVRD ( p_ND number , p_ACC number, p_dat1 varchar2, p_dat2 varchar2)  is
 d_dat1  date := to_date(p_dat1, 'DD.MM.YYYY');
 d_dat2  date := to_date(p_dat2, 'DD.MM.YYYY');
 m_dat1  date ;
begin
    PUL.Put ( 'ND'    , p_nd    ) ;
    PUL.Put ( 'ACC26' , p_acc   ) ;
    m_dat1  := trunc(d_dat1,'MM') ;
    PUL.Put ( 'DATM01', to_char (m_dat1,'DD.MM.YYYY')  ) ;

    PUL_DAT ( p_dat1  , p_dat2  ) ;
end PUL_OVRD;

--------------------------------
procedure Chk_dat ( m_SDate date, s_sdate date , m_wDate date, s_wdate date) is
begin
 if NOT (  m_SDate <= s_Sdate and s_Sdate < s_wdate and s_wdate <= m_wDate ) then
   raise_application_error(g_errn,'�������� ����������� ���:'||nlchr ||
   to_char(m_SDate,'dd.mm.yyyy') ||' <= '||
   to_char(s_Sdate,'dd.mm.yyyy') ||' <  '||
   to_char(s_wdate,'dd.mm.yyyy') ||' <= '||
   to_char(m_wDate,'dd.mm.yyyy') ) ;
 end if;
end chk_dat;
-----------------------------------
procedure Chk_nls ( p_mode int, p_acc number, p_kv IN int, p_nls IN varchar2, aa OUT accounts%rowtype) is
  l_err  varchar2 (100);  l_accc number ; l_nd number ; dd cc_deal%rowtype ;
begin -- �������� �� ������������ �����

  l_err  := '���.' ||p_kv||'/'||p_nls ||'/'||p_acc|| ' ' ;
  l_accc :=  NVL( to_number ( pul.Get_Mas_Ini_Val('ACCC') ), 0) ;

  If p_kv <> gl.baseval then raise_application_error(g_errn, l_err || ' ������������ ��� ��� '); end if;

  begin select * into aa from accounts where  (nls = p_nls  and kv=p_kv or acc = p_acc) and dazs is null ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn, l_err || ' �������/�������� ')  ;
  end;
  --------------- ������������ ������� �� ����� ����� � ��������������
  If p_mode >= 0 then
     If  aa.pap <> 2                                        then raise_application_error(g_errn, l_err || ' �� ������ ��� ')            ;  end if;
     If  aa.nbs not in ('2600','2650','2602','2603','2604') then raise_application_error(g_errn, l_err || ' �� 2600/2650 ')             ;  end if;  -- ��� �� � 2017 �� ��������
     If  aa.blkd > 0 or aa.blkk > 0                         then raise_application_error(g_errn, l_err || ' �� ����������' )           ;  end if;
     If  aa.lim <> 0                                        then raise_application_error(g_errn, l_err || ' ˳�� �� ���� ' || aa.lim ) ;  end if;
  end if;

  ---------------

  If p_mode = 0 then
     If  aa.accc is not null     then raise_application_error(g_errn, l_err || ' ��� �� ����������� ' )    ;  end if;
     begin select d.* into dd from cc_deal d, nd_acc n where d.sos < 14 and n.nd = d.nd and n.acc = aa.acc and rownum = 1;
           raise_application_error(g_errn, l_err||' �������� ����� ²����Ҳ� ����, ���='||dd.nd||',���='||dd.vidd) ;
     EXCEPTION WHEN NO_DATA_FOUND THEN null ;
     end;
  end if;

  begin select * into aa from accounts where acc = aa.acc  FOR  UPDATE OF acc NOWAIT ;
  EXCEPTION WHEN NO_DATA_FOUND   THEN  raise_application_error(g_errn, l_err || ' ��������� ������ ' )        ;
  end;

end chk_nls;
-----------------------------------
procedure ADD_master (p_ND number, p_ACC number, p_CC_ID varchar2, p_sdate date, p_wdate date, p_lim number, p_ir0 number, p_ir1 number,
                      p_nls varchar2, p_kv int,  p_day int, p_PD number, p_isp number,
                      p_METR int, -- =1 = �������  ����.������
                      p_SK   int,  -- = � ����� ��� ����.������
                      p_NZ   int  -- ������� "��� �����������"
                     ) is
  aa accounts%rowtype ;
  a8 accounts%rowtype ;
  dd cc_deal%rowtype  ;
  p4_ int ;
  l_Day int ;
  l_PD number  ; --- := LEAST( nvl(p_PD , 50), 100) ;
  l_kv int     := nvl(p_kv, 980) ;
  l_sdate date ;
  l_wdate date ;
  l_Isp number := nvl (p_ISP,gl.aUid) ;
  x_ACCC number;
  l_BUSSS varchar2(10);
begin
  l_sdate := nvl(p_sdate, gl.bdate) ; -------------------------\
  l_wdate := nvl(p_wdate, add_months(gl.bdate,12) -1 ) ; ------/ �� ��������� 1 ���

  ovrn.Chk_dat ( l_SDate, l_sdate, l_wDate, l_wdate  ) ;

  If p_ND = 0 then

     begin select accc into x_ACCC from accounts where kv = l_kv and nls = p_nls;
     EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn,'�� �������� ���.' ||l_kv||'/'|| p_nls);
     end;

     ovrn.Chk_nls ( p_mode => 0, p_acc =>null, p_kv=>l_kv , p_nls=>p_nls , aa => aa ) ;

     -- �������� ��� � ����� 10
     dd.nd      := bars_sqnc.get_nextval('s_cc_deal') ;  ---- s_cc_deal.NEXTVAL ;
     dd.sos     := 0       ;  dd.cc_id   := p_CC_ID   ;
     dd.sdate   := l_sdate           ;  dd.wdate   := l_wdate ;  dd.limit   := p_lim    ;
     dd.rnk     := aa.rnk            ;  dd.vidd    := 10      ;
     dd.branch  := sys_context('bars_context','user_branch');
     dd.kf      := sys_context('bars_context','user_mfo');
     dd.user_id := l_ISP ;
     INSERT INTO cc_deal  values dd;
     a8.nls :=OVRN.Get_Nls (p_R4 => '8998') ;
     a8.nms :='��������� ��� '|| dd.cc_id;
     op_reg_ex( mod_=>1, p1_=>dd.nd, p2_=>0, p3_=>aa.grp, p4_=>p4_, rnk_=>dd.rnk, nls_=>a8.nls, kv_=>aa.kv, nms_=>a8.nms, tip_=> 'OVN' ,
             isp_=>aa.isp,   accR_=> a8.acc, nbsnull_ =>null, pap_ => 3,  tobo_ =>aa.branch);
  else
     dd.nd  := p_nd ;
     a8.acc := p_acc;
  end if;

  begin select * into dd from cc_deal  where nd  = dd.nd and sos <14;

        If dd.user_id <> l_Isp then
           update cc_deal set user_id = l_isp where nd = dd.nd;
           OVRN.isob  (p_nd => dd.ND, p_sob => '���� �����.�����.'|| dd.user_id||'->'||l_isp );
           dd.user_id := l_Isp ;
        end if;
        If dd.sos >= 10 then RETURN; end if;
        --------------------------------------
        select * into a8 from accounts where acc = a8.acc ;

  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn,'�� �������� master-����� ' ||p_nd);
  end;

  if p_metr = 1 and  (p_ir0 >0  or p_ir1 > 0 ) then raise_application_error(g_errn,'�������� ������ ����̲��� � ϲ�������(���+���)'); end if;

  dd.user_id := l_ISP ;

  update cc_deal d set d.cc_id= p_cc_id, d.sdate=l_sdate, d.wdate=l_wdate, d.limit=p_lim where d.nd = dd.nd ;
  update accounts  set lim   = round(p_lim *100,0) where acc = a8.acc;
  update OVR_LIM   set lim   = round(p_lim *100,0) where acc = a8.acc  and fdat = dd.sdate   and  nd = dd.nd ;
  if SQL%rowcount = 0 then  insert into OVR_LIM (nd,acc,fdat, lim) values (dd.nd, a8.acc, dd.sdate , round( p_lim*100,0) ); end if;


  l_Day := nvl(p_day ,0) ;
  If l_Day < 1 or l_day > 31 then  raise_application_error(g_errn, g_errS||'������� ����. ����i�(���� �i�) ��� ������ %% = '|| l_Day  );  end if ;
  OVRN.SetW ( a8.acc, 'TERM_DAY' , to_char(l_day ) );   ------------ g_TAGD = TERM_DAY -- ����i�(���� �i�) ��� ������ %%

  l_PD  := nvl(p_PD,0) ;
  If l_PD < 1 or l_PD > 100 then  raise_application_error(g_errn, g_errS||'������� ����.����i� �i�i�� (% �i� ���) = '|| l_PD  );  end if ;
  OVRN.SetW ( a8.acc, 'PCR_CHKO' , to_char(l_PD  ) );   ----------- g_TAGC = PCR_CHKO -- ����i� �i�i�� (% �i� ���)

  If  NVL( to_number( OVRN.GetW ( a8.acc, 'NOT_ZAL')), 0 ) <> NVL( p_NZ,0) then
      OVRN.SetW ( a8.acc, 'NOT_ZAL', to_char(p_NZ) );   ----------- p_NZ   int  -- ������� "��� �����������"
  end if;

  If p_ND = 0 then
     l_BUSSS := Substr ( OVRN.GetCW( dd.rnk, 'BUSSS'),1,1) ;
     -- �� ������� 8998 �� 2600 � ���������� ������� ����������� �������������� ������� �� ����������� �� %% ����/360(3), �� ���� �� ���� ����/����(0). 
     If l_BUSSS  = '2' then  insert into int_accn (ACC,ID,METR,BASEM,BASEY,FREQ, stp_DAT, acr_dat ) values (a8.acc,0,0,0,0,1, dd.wdate, dd.sdate-1 );
     else                    insert into int_accn (ACC,ID,METR,BASEM,BASEY,FREQ, stp_DAT, acr_dat ) values (a8.acc,0,0,0,3,1, dd.wdate, dd.sdate-1 );
     end if;

     -- ���������� �� 8998* ��� ����� ��� ������� ��� = 0 0 �% ����/���� -- ��� ��������
     insert into int_accn (ACC,ID,METR,BASEM,BASEY,FREQ, stp_DAT, acr_dat ) values (a8.acc,1,0,0,0,1, dd.wdate, dd.sdate-1 );

  end if;

  If p_metr = 1 then
     OVRN.SetIR( dd.nd, a8,  0, dd.sdate, 0 ) ; --\ ���������� ����. ���� ������ �� 8998*
     OVRN.SetIR( dd.nd, a8,  1, dd.sdate, 0 ) ; --/
     update int_accn set metr = 7, idr = p_sk where acc = a8.acc and id = 0;
  else
     OVRN.SetIR( dd.nd, a8,  0, dd.sdate, p_ir0 ) ; --\ ���������� �������� ���� ������ �� 8998*
     OVRN.SetIR( dd.nd, a8,  1, dd.sdate, p_ir1 ) ; --/
  end if;

  If p_ND = 0 then OVRN.ADD_slave  (0, dd.ND , aa.acc , dd.limit, null, null, aa.nls, null, null, null, null );
                   If p_metr = 1 then  update int_accn set metr = 7, idr = p_sk where acc = aa.acc and id = 0 ; end if ;
                   OVRN.isob  (p_nd => dd.ND, p_sob => 'INS:master-������/'|| p_nls||'/'||l_kv );
  else             OVRN.isob  (p_nd => dd.ND, p_sob => 'UPD:master-������/'|| p_nls||'/'||l_kv );
  end if;
end ADD_master;
-----------------------------------
procedure DEL_master (p_ND number) is begin  OVRN.DEL_ALL (p_nd => p_ND) ; end DEL_master;
-----------------------------------
procedure ADD_slave
  (p_mode int, p_ND number, p_acc number, p_lim number, p_ir0 number, p_ir1 number, p_nls varchar2, p_term int, p_PK number, p_don int, p_NK int ) is
  aa accounts%rowtype ;  sn accounts%rowtype ;  a8 accounts%rowtype ;  a9 accounts%rowtype ;  a0 accounts%rowtype ;
  dd cc_deal%rowtype  ;  U_ND number ;
  p4_ int             ;  l_nd number ;  dTmp_ date          ;  L_LIM NUMBER        ;
  l_BUSSS varchar2(10);  l_basey int ;
  l_acc6 number ;
begin

  If p_nd is null then l_nd := to_number ( pul.Get_Mas_Ini_Val('ND') );
  else                 l_nd := p_nd ;
  end if;

  begin select   * into dd from cc_deal where vidd = 10 and nd =l_nd ; -- and sos < 10
        If dd.sos >= 10 then   RETURN; end if ;  --- ������ ��� �� ��������������
        ----------------------------------------
        select a.* into a8 from nd_acc n, accounts a where n.nd = dd.nd and n.acc= a.acc and tip = 'OVN' ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn,'!! �� �������� master-����� !! ' ||l_nd);
  end;

  ovrn.Chk_nls ( p_mode, p_acc, a8.kv , p_nls , aa ) ;
  ----------------------------------------------------
  OP_BS_OB1 ( PP_BRANCH => substr(aa.branch,1,15) , P_BBBOO => SB_6020.R020||SB_6020.OB22 );
  OP_BS_OB1 ( PP_BRANCH => substr(aa.branch,1,15) , P_BBBOO => SB_6111.R020||SB_6111.OB22 );
  -------------------------------------------------------------------------
  If aa.nbs in ('2602','2603','2604') and nvl(P_DON,0) <>1  then   raise_application_error(g_errn,'���.2602*,2603*,2604*) ������ ���� ����� "��������" ');  end if; -- ��� �� � 2017 �� ��������

  If P_DON = 1 then  l_lim := 0    ;
  else               l_lim := p_lim;
  end if;

  update accounts set accc = a8.acc where acc =aa.acc;

  If l_lim is not null then
     update OVR_LIM set lim = round( l_lim*100, 0)  where acc = aa.acc  and fdat = dd.sdate  and  nd = l_nd ;
     if SQL%rowcount = 0 then insert into OVR_LIM (nd,acc,fdat, lim) values (l_nd, aa.acc, dd.sdate , round( l_lim*100, 0) ); end if;
  end if;

  u_ND := null ;
  OVRN.ins_110 (d_nd => l_ND, p_acc26 => aa.acc, p_ACC => aa.acc, u_nd => U_ND ) ; -- ������� ����� ��� 110

  update accounts set  ostc = (select sum(ostC) from accounts where accc= a8.acc),
                       ostb = (select sum(ostB) from accounts where accc= a8.acc),
                       ostf = (select sum(ostF) from accounts where accc= a8.acc)
                  where acc = a8.acc;

  OVRN.INT_OLD (aa.acc, DD.SDATE-1 ); ---------- ����������� ���� �� <�����>

  -----------------------------------------------------------------

  begin insert into nd_acc (nd,acc) values ( dd.nd, aa.acc ); -- �������� 2600 � ��� 10
  exception when dup_val_on_index then  null;
  end ;

  begin insert into nd_acc (nd,acc) select dd.nd, i.acra from int_accn i where i.acc = aa.acc and i.id = 1;
  exception when dup_val_on_index then  null; -- �������� 2608 � ��� 10
  end ;

  If p_Ir1 is not null then
     OVRN.SetIR( dd.nd, aa, 1,  dd.sdate   , p_ir1 ) ;                                -- \ ����������  ������ ���� ������ �� 26* �� ����� �������� ���
     OVRN.SetIR( dd.nd, aa, 1, (dd.wdate+1), acrn.fprocn(aa.acc,1, (dd.sdate-1) ) ) ; -- /������������ ������ ���� ������ �� 26*
  end if;
  -----------------------------------------------------------------
--04.04.2018 Sta ��� ����������� ���������� ����������� 2 ����� 2607 (COBUMMFO-5668).  
  Begin select x.* into sn 
        from (select * from accounts where tip ='SN ' and nbs = substr(aa.nls,1,3) || '7' and dazs is null ) x, 
             (select * from int_accn where acc = aa.acc and id = 0) i, 
             (select * from nd_acc   where nd = dd.nd             ) n 
        where x.acc = n.acc and n.nd =  dd.nd and i.acra = x.acc ;
  EXCEPTION WHEN NO_DATA_FOUND THEN --2607   -- ��� % ������
       sn.nls := OVRN.Get_Nls (p_R4 => substr(aa.nls,1,3) || '7' ) ; --sn.nls := vkrzn (substr(gl.aMfo,1,5), substr(aa.nls,1,3) || '70'|| substr(aa.nls,6,9) ) ;
       sn.nms :=  '���.%% �� ��� �� ���.'||aa.nls;
       op_reg_ex(mod_=>1,p1_=> dd.nd,p2_=>0,p3_=>aa.grp,p4_=>p4_,rnk_=>aa.rnk,nls_=>sn.nls,kv_=>aa.kv,nms_=>sn.nms,tip_=>'SN ',isp_=>aa.isp, accR_=>sn.acc,tobo_ =>aa.branch);
       Accreg.setAccountSParam(SN.Acc, 'OB22', '01');
  end ;

  begin select acc into l_acc6 from accounts where nls = nbs_ob22_null( SB_6020.R020, SB_6020.OB22, substr(aa.branch,1,15) ) and kv = gl.baseval;  
  EXCEPTION WHEN NO_DATA_FOUND THEN l_acc6 := null;
  end ;

  l_BUSSS := Substr ( OVRN.GetCW( aa.rnk, 'BUSSS'),1,1) ;
  If l_BUSSS = '2' then l_basey := 0;  else l_basey := 3;  end if; 

  begin insert into int_accn ( ACC, ID, METR, BASEM, BASEY, FREQ, acr_dat, acra, acrb) values (aa.acc, 0, 0, 0, l_basey, 1, dd.sdate-1, sn.acc, l_acc6);
  exception when dup_val_on_index then  
       update int_accn              set METR=0, 
                                              BASEM=0, 
                                                     BASEY= l_basey,
                                                            FREQ= 1, 
                                                                  acr_dat= dd.sdate-1,   
                                                                           acra= sn.acc,
                                                                                 acrb =l_acc6  where acc = aa.acc and id = 0;
  end ;

  OVRN.ins_110 (d_nd => l_ND, p_acc26 => aa.acc, p_ACC => SN.acc, u_nd => U_ND ) ; -- �������� 2607 � ��� 110

  If nvl(p_don,0) <> 1  and p_ir0 is not null then
     OVRN.SetIR( dd.nd, aa, 0, dd.sdate, p_ir0 ) ; --\ ���������� ����� ���� ������ �� 26*
  end if;
  ---------------------------------------------------------------

  OVRN.SetW (aa.acc, 'TERM_OVR' , to_char(p_term) ) ;   --- g_TAG  = TERM_OVR -- ����i� ������������� ���, �i�.��i�
  OVRN.SetW (aa.acc, 'PCR_CHKO' , to_char(p_PK  ) ) ;   --- g_TAGC = PCR_CHKO -- ����i� �i�i�� (% �i� ���)
  OVRN.SetW (aa.acc, 'DONOR'    , to_char(p_Don ) ) ;   --- g_TAGN = DONOR -- ������� ������
  OVRN.SetW (aa.acc, 'NEW_KL'   , to_char(p_NK  ) ) ;   --- g_TAGK = NEW_KL -- ������� <<��� ��>>

  if nvl(p_don,0) <> 1 then
     begin select a.* into a9 from accounts a, nd_acc n where a.rnk = aa.rnk and a.nbs = '9129' and a.tip ='CR9' and a.kv = aa.kv and a.acc= n.acc and n.nd = dd.nd ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
       a9.nls := OVRN.Get_Nls (p_R4 => '9129' ) ; --  a9.nls  := vkrzn (substr(gl.aMfo,1,5), F_NEWNLS(aa.acc,'CR9','9129') ) ;
       a9.nms  :=  '���������.��.��� �� ���.'||aa.nls;
       op_reg_ex(mod_=>1,p1_=>dd.nd,p2_=>0,p3_=>aa.grp,p4_=>p4_,rnk_=>aa.rnk,nls_=>a9.nls,kv_=>aa.kv,nms_=>a9.nms,tip_=>'CR9',isp_=>aa.isp,accR_=>a9.acc, tobo_ =>aa.branch);

       If NVL( to_number( OVRN.GetW ( a8.acc, 'NOT_ZAL')), 0 ) = 1 then  a9.ob22 := '37' ;       -- ������� "��� �����������"
       else                                                              a9.ob22 := '04' ;
       end if;
       Accreg.setAccountSParam(a9.Acc, 'OB22', a9.ob22);

     end ;
     OVRN.ins_110 (d_nd => l_ND, p_acc26 => aa.acc, p_ACC => a9.acc, u_nd => U_ND ) ; -- �������� 9129 � ��� 110

     dTmp_ := trunc(dd.sdate,'MM') ;
     begin insert into  OVR_CHKO  (PR, acc,datM ) values ( 0 ,aa.acc, add_months( dTmp_, -1) );
           insert into  OVR_CHKO  (PR, acc,datM ) values ( 0, aa.acc, add_months( dTmp_, -2) );
           insert into  OVR_CHKO  (PR, acc,datM ) values ( 0, aa.acc, add_months( dTmp_, -3) );
     exception when dup_val_on_index then  null;
     end ;
  end if ;
  OVRN.isob  (p_nd => dd.ND, p_sob => 'ADD/UPD:slave-������/'|| p_nls||'/'||aa.kv );
end ADD_slave ;

procedure DEL_slave  (p_ND number, p_acc number, p_nls varchar2, p_kv int) is
  a26 accounts%rowtype;  dd cc_deal%rowtype ;
  l_ndu number;
begin
  begin select *    into dd    from cc_deal             where   nd  = p_ND and vidd   =  10 ;
        select n.nd into l_ndu from cc_deal d, nd_acc n where d.ndi = p_ND and d.vidd = 110 and d.nd = n.nd and n.acc= p_acc ;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
  end ;
  ----------------------------------------------
  OVRN.Chk_nls ( -1, p_acc, p_kv, p_nls, a26 ) ;

  For k in (select * from accounts where rnk = a26.rnk and acc in (select acc from nd_acc where nd = p_ND))
  loop
     If k.ostc < 0 and k.nbs not like '95%' and k.nbs not like '90%' then
        raise_application_error(g_errn, 'OVRN='|| p_nd|| '/'|| k.nls || ' ��������� ������� ='|| k.ostc/100 ) ;
     end if;

       If k.acc = a26.acc then
          update accounts set ostc = ostc - a26.ostc, ostb  = a26.ostb, ostf = ostf - a26.ostf where acc = a26.accc;
          update accounts set lim  = 0, accc = null where acc = a26.acc ;
       end if ;
       delete from nd_acc nn where acc = k.acc and exists  (select 1 from cc_deal where nd = nn.ND and (nd = P_ND or ndi= p_ND) ) ;
       update cc_deal set sos = 14 where nd = l_ndu ;
  end loop;
  delete from OVR_REP_ZAG  where  acc = a26.acc ;                             -- ������ ������
  delete from int_ratn     where  acc = a26.acc  and bdat >= dd.SDATE;         -- ���� ������
  delete from accountsW    where  acc = a26.acc  and tag in ('TERM_LIM', 'TERM_OVR', 'TERM_DAY', 'PCR_CHKO', 'NEW_KL', 'DONOR', 'STOP_O', 'DT_SOS', 'NOT_DS' ); --���.���� �����
  delete from accountsW    where  acc = a26.accc and tag in ('TERM_LIM', 'TERM_OVR', 'TERM_DAY', 'PCR_CHKO', 'NEW_KL', 'DONOR', 'STOP_O', 'DT_SOS', 'NOT_DS' ); --���.���� �����
  delete from OVR_LIM      where  acc = a26.acc  and nd = p_ND;                   --������

  delete from OVR_CHKO_det where  acc = a26.acc ;                             --������ ���
  delete from OVR_CHKO     where  acc = a26.acc ;                             --�����  ���
  delete from ACC_TARIF    where  acc = a26.acc and kod in (141,142,143,144,145,146); -- ������

  OVRN.isob  (p_nd => p_ND, p_sob => 'Del:slave-������/'|| a26.nls||'/'||a26.kv );

end DEL_slave;
-----------------------------------------------
procedure Set_ost8 ( p_acc8 number) is l_Daos date;  l_s number;
  gl_BD date;
begin
  gl_BD := gl.Bdate;

  begin select daos into l_daos from accounts where acc= p_acc8;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
  end ;

  --���������  ���������
  update accounts set ostc=0  where acc= p_acc8;    delete from saldoa where acc = p_acc8;

  -- ��������� ���� ���
  select Nvl( sum( ovrn.FOST_SAL (acc, l_daos-1)) ,0) into  l_s from accounts where accc= p_acc8;
  gl.bdate := l_daos -1;
  update accounts set ostc = l_s where acc= p_acc8;

  for k in (select s.fdat, sum(s.dos) dos, sum(s.kos) kos from saldoa s, accounts a
            where a.accc = p_acc8 and a.acc = s.acc and fdat >= l_daos   group by s.fdat  order by s.fdat    )
  loop  gl.bdate := k.fdat;
        update accounts set ostc = ostc - k.dos where acc = p_acc8;
        update accounts set ostc = ostc + k.kos where acc = p_acc8;
        gl.Bdate := gl_BD ;
  end loop;

end Set_ost8 ;
-----------------------------------------
procedure OPL1   ( oo IN OUT oper%rowtype) is  -- �������
begin
  oo.vdat := NVL ( oo.vdat,gl.bdate); 
  oo.vob  := NVL ( oo.vob, 6   );
  oo.kv2  := NVL ( oo.kv2,oo.kv); 
  oo.s2   := NVL ( oo.s2, gl.p_icurval(oo.kv2,oo.s,oo.vdat) ) ; 


  If oo.ref is null then

     If oo.nam_a is null then  begin select substr(nms,1,38) into oo.nam_A from accounts where kv = oo.kv   and nls = oo.nlsA; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;  end if;

     If oo.id_A  is null then 
        If Substr(oo.nlsA,1,1) in ('4','5','6','7') then oo.id_A := gl.aOkpo;
        else begin select c.okpo into oo.id_A from accounts a, customer c where a.kv=oo.kv  and a.nls=oo.nlsA and a.rnk=c.rnk; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;
        end if;   
     end if;
 
     If oo.nam_B is null then  begin select substr(nms,1,38) into oo.nam_B from accounts where kv = oo.kv2  and nls = oo.nlsB; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;  end if;

     If oo.id_B  is null then 
        If Substr(oo.nlsB,1,1) in ('4','5','6','7') then oo.id_B := gl.aOkpo;
        else begin select c.okpo into oo.id_B from accounts a, customer c where a.kv=oo.kv2 and a.nls=oo.nlsB and a.rnk=c.rnk; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;
        end if;   
     end if;

     oo.mfoa := NVL ( oo.mfoa, gl.aMfo);
     oo.mfoB := NVL ( oo.mfoB,gl.aMfo) ;
     oo.ND   := NVL ( oo.ND, trim (Substr( '          '||to_char(oo.ref), -10 ) ) ) ;  
 
     gl.ref (oo.REF);
     oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
     gl.in_doc3 (ref_=>oo.REF  ,  tt_ =>oo.tt  , vob_=>oo.vob , nd_  =>oo.nd   ,pdat_=>SYSDATE, vdat_=>oo.vdat , dk_ =>oo.dk,
                  kv_=>oo.kv   ,  s_  =>oo.S   , kv2_=>oo.kv2 , s2_  =>oo.S2   ,sk_  => null  , data_=>gl.BDATE,datp_=>gl.bdate,
               nam_a_=>oo.nam_a, nlsa_=>oo.nlsa,mfoa_=>oo.mfoa,nam_b_=>oo.nam_b,nlsb_=>oo.nlsb, mfob_=>oo.mfob,
                nazn_=>oo.nazn ,d_rec_=>null   ,id_a_=>oo.id_a,id_b_=>oo.id_b  ,id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
  end if;

  gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2,  oo.nlsb, oo.s2);

end OPL1;
-------------

procedure background ( p_ini int, p_mode int, p_ND number, p_date date) is -- ���-������������� ��������
-- p_ini  = 0 ����� �� ��������� �� ������ ������/������ (��� �����)
-- p_ini  = 1 ����� �� ����. ���-������ (��  ������)

-- p_mode = 0 - start  ������ �������� ���  �������, �� ����������� ��� ������� ���
-- p_mode = 1 - finish ������ �������� ���  �������, �� ����������� ��� ������� ���

  a89 accounts%rowtype;  a69 accounts%rowtype;  a67 accounts%rowtype;  ii int_accn%rowtype;
  l_TERM_DAY int ;
  l_mdat date    ;
  l_TERM_LIM int ;

  k_BL   int     ; -- ����-���������� ������ ���������
  l_date date    := nvl( p_date, gl.bdate) ;
  dTmp_  date    ;
  Dat_Lim date   ;
  Dat_Next date  ;
  nTmp_  number  ;
  sTmp_  varchar2 (255);
  k9129_ number  ;
  m_date   date  ;
  l_dat05  date  ;
  l_dat15  date  ;
  l_dat15k date  ;
  l_dat21  date  ;
  a37 accounts%rowtype ;
  l_EXIT_ZN int  ; -- ҳ���� ������ ����� �� "���" =1
begin

  l_date   := nvl        ( p_date , gl.bdate ) ;
  Dat_Next := Dat_Next_U ( l_date , 1 );
  l_dat05  := trunc      ( l_date , 'MM') + 4  ;  l_dat05  := Dat_Next_U ( l_dat05 , 0 ) ;
  l_dat15k := trunc      ( l_date , 'MM') +14  ;  l_dat15k := Dat_Next_U ( l_dat15k, 0 ) ;

  --���� �� ���.
  for dd in ( select * from cc_deal  where vidd  = 10 and sdate <= l_date  and sos>0  and sos < 14 and nd = decode (p_nd,0, nd, p_nd ) )
  loop

      begin  select a.* into a89 from accounts a, nd_acc n where n.nd = dd.ND and n.acc= a.acc and a.tip = 'OVN' ;

           --06.06.2017 Sta ���.�������� TERM_LIM = ���� ��.��������� ����(��=20,����=10)
             l_TERM_LIM := NVL( to_number(OVRN.GetW(a89.acc,'TERM_LIM') ), 20) ;
             l_dat21    := trunc      ( l_date , 'MM') + l_TERM_LIM  ;
             l_dat21    := Dat_Next_U ( l_dat21, 0 ) ;

             If l_TERM_LIM  <> 20 then  l_dat15 := l_dat21 - 1 ;
             else                       l_dat15 := l_dat15k ;
             end if ;

             l_EXIT_ZN := NVL( to_number(OVRN.GetW(a89.acc,'EXIT_ZN') ), 0) ; -- -- ҳ���� ������ ����� �� "���" =1

      EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn, 'OVRN='|| dd.nd|| ' ������� 8998*') ;
      end;

      ----- 4.2) ����-�������� �������� ������ �� ��� � �����  � �� ������� �� �� 5-� ������.
      -- ���� ����� ������ ����� ������������ � ����������� �� ������ 20 ����� . �� ������ � ������. ���� �� ����� ��������������
      If gl.bdate = l_dat05 and  p_mode = 0 then  OVRN.LIM ( dd.ND, l_date) ; end if;

      -- ����-1 �� ��������� 26*
      for  a26 in (select * from accounts where accc = a89.acc and acc in (select acc from nd_acc where nd = dd.ND) AND TIP <> 'SP ' )
      loop

        If a26.ostc >= 0   then
           update accounts set mdate = null where acc = a26.acc and mdate is not null ; ----- 0) ���������/�������� ���� ��������� MDATE
        end if;

        Begin  -- ��������� �� ����� 3739/05/SG
            select a.* into a37 from accounts a, nd_acc n where a.tip='SG ' and a.ostc >0 and a.rnk=a26.rnk and a.acc=n.acc and n.nd=dd.ND ;
            OVRN.BG1 ( p_ini, 1, l_date, dd, a37,a26 ) ;
        EXCEPTION WHEN NO_DATA_FOUND THEN  null ;
        end;

        If a26.ostc+a26.lim > 0 then  ----- 1) ��������� ���� �������� ������
           -- ��������  ���.���� �� ��� �� ����������������� ���.�������� �� ����� 2600
           If  Nvl ( OVRN.GetW(a26.acc,'NOT_DS') , '0') <> '1'  then  OVRN.BG1 ( p_ini, 1, l_date, dd, a26,a26 ) ;  end if;
        end if;

        select ostc into a26.ostc from accounts where acc = a26.acc;

        If a26.ostc <= 0 and  p_mode = 0 then

           If a26.ostc < 0 then   --������� ����
              l_mdat := Least ( dd.Wdate, OVRN.Get_mdat (a26.acc) );
              update accounts set mdate = l_mdat where acc = a26.acc and (mdate <> l_mdat or mdate is null) ;

        
              If dd.Wdate < gl.bDate then dTmp_ := gl.bDate ;
                 OVRN.OP_SP ( dd, a26   , a67, a69 ) ; -- �������� �� ���������
                 OVRN.BG1   ( p_ini,  2 , l_date,  dd, a26, a26 ) ; -- �������� �� ��������� �� ����
                 OVRN.isob  ( p_nd => dd.ND, p_sob => '�������� �� ���������� '||a26.nls );

              else select max(datSP) into dTmp_ from OVR_TERM_TRZ where acc = a26.acc and datSP <= l_date ;    ----- 2) �����: ����� �� ���������

                 If dTmp_ is not null then
                    If l_EXIT_ZN <> 1 then  -- 1 = ҳ���� ������ ����� �� "���" ���� -> �� ���������
                       OVRN.OP_SP ( dd, a26   , a67, a69 ) ; -- �������� �� ���������
                       OVRN.BG1   ( p_ini,  2 , l_date,  dd, a26, a26 ) ; -- �������� �� ��������� �� ����
                       OVRN.isob  ( p_nd => dd.ND, p_sob => '�������� �� ���������� '||a26.nls );
                    end if ;
                 end if ;

              end if; 



           end if;

           OVRN.BG1   ( p_ini, 3 , l_date,  dd, a26, a26 ) ; -- -- ��������� �������� �� % � ���� ��� - ����� �� ���������

        end if;
      end loop ; -- ����-1 �� ��������� 2600

      -------------------------------------------------
      -- �������� ������ �� ��������� ���
      OVRN.UPD_SOS  ( p_nd => dd.ND,  p_sos => null ) ;
      select sos  into dd.sos   from cc_deal  where nd  = dd.nd  ;
      -------------------------------------------------

      -- ����-2 �� ��������� 26* + ���.8998

      If p_mode = 0 then  --START
         for aaa in (select * from accounts  where a89.acc in (acc, accc) and acc in (select acc from nd_acc where nd = dd.ND)
                        AND TIP <> 'SP '     )
         loop
            If gl.bdate >= l_dat05 and gl.bdate < l_dat21 then  ---  �������� ����������� ����.������� � ������������� ����������� ������
               If OVRN.GetAL (  aaa.acc, gl.bdate ) = 0 then
                  If gl.bdate < l_dat15 then  sTmp_ := '��������� �����������';
                  else                        sTmp_ := '����������� ����� ���������';
                  end if;
                  sTmp_ := sTmp_||' ��.˳�.���. ��� ���.� '||dd.cc_id||' ���='||dd.ND;
                  If aaa.tip <> 'OVN' then sTmp_ := sTmp_||' ���.'||aaa.nls;  end if;
                  if getglobaloption ('BMS') = '1'  then -- BMS �������: 1-����������� �������� ���������
                     bms.enqueue_msg( sTmp_, dbms_aq.no_delay, dbms_aq.never, dd.user_id );
                  end if;
                  bars_audit.info( 'OVRN=>BMS:'||sTmp_ );
               end if;
            end if ;
         end loop  ; -- aaa
      end if;  -- p_mode = 0 then  --START
      ----------------------

      If p_mode = 1 then  -- FINISH

         for aaa in (select * from accounts  where a89.acc in (acc, accc) and acc in (select acc from nd_acc where nd = dd.ND)
                        AND TIP <>'SP '                    )
         loop
            select ostc into aaa.ostc from accounts where acc = aaa.acc;
            If dd.sos = 10 and  dd.wdate > l_date  then

               ------ ���������� (sos=10)   ��������������� ���������� ������ � ������ ����
               begin select max(fdat) into Dat_Lim from OVR_LIM where acc = aaa.acc and nd = dd.ND and fdat <= gl.bdate  and ok = 1;
                     select lim       into aaa.lim from OVR_LIM where acc = aaa.acc and nd = dd.ND and fdat = Dat_Lim    and ok = 1;
                     -- �������������� ������� ������ �� �������, o� ��� ����� ��� 9129
                     update accounts set lim = aaa.lim where acc = aaa.acc and lim <> aaa.lim;
               EXCEPTION WHEN NO_DATA_FOUND THEN null;
               end ;

               -- ��������������� ���������� ������ �� �������
               OVRN.SetIR ( dd.nd, aaa, 1, l_date+1, acrn.fprocn ( aaa.acc, 1, dd.sdate) ) ;

               -- �� ������
               If aaa.acc = a89.acc then -------------------------------------------- �� 8998 : ��������������� ���������� ������ �� ������ 899*
                  OVRN.SetIR(dd.nd,aaa, 0, l_date+1, acrn.fprocn ( aaa.acc, 0, dd.sdate) ) ;
               else                      -------------------------------------------- �� 2600 : ������� ����� ����C� �� ���������
                  delete from OVR_TERM_TRZ where acc = aaa.acc ;
               end if;

            else
               ----- ���� ���� ��������� ���� ������ �� ��� -> � ������-���� ���� - ��������� ������ ����,  �������� �������� ������, �� ��� - ������ ��������� �� �������, ������ ���� ������ �� ���������
               update accounts set lim = 0 where acc = aaa.acc and lim <> aaa.lim;

               --���������� ���� ������ �� �������
               OVRN.SetIR ( dd.nd, aaa, 1, l_date+1, acrn.fprocn ( aaa.acc, 1, dd.sdate-1 ) ) ;

               If aaa.tip = 'OVN' then    --- �������� ��� ��� !!!!
                  OVRN.SetIR ( dd.nd, aaa, 0, l_date, 0 ) ;  ---8998*
               else
                  nTmp_:= CASE WHEN aaa.ostc < 0                          THEN 15  -- ���������
                               WHEN dd.wdate <= gl.bdate                  THEN  0  -- ����������
                               WHEN OVRN.GetW (aaa.acc, 'STOP_O' ) = '1'  THEN 25  -- ������ ������
                               else                                             0  -- ����
                               end ;
                  l_mdat := LEAST ( NVL(aaa.mdate, gl.bdate) + nTmp_, dd.wdate) + 1 ;  -- �� �� �����, ��� ���� ������
                  l_mdat := Dat_Next_U ( l_mdat , 0 ) ;
                  If aaa.ostc < 0 then
                     OVRN.isob  (p_nd => dd.ND, p_sob =>  '������� ���������� '||to_date(l_mdat,'dd.mm.yyyy') );
                  end if;

                  -- ����� ���� 15 ���� �� ������� ��������� MDATE. �.�. ������ ��������� �� ����
                  -- 1  �������� ���.��.��� � ���  15
                  OVRN.ins_TRZ  (p_acc1  => aaa.acc, -- ����-���������� (��������)
                                 p_datVZ => l_date ,
                                 p_datSP => null   ,
                                 p_trz   => 1    ) ;
               end if;
            end if ; ---

         end loop  ; -- aaa

         --- �������� ������ �� 89998         -- ����� �����  a89.LIM
         select a.* into a89 from accounts a, nd_acc n where n.nd = dd.ND and n.acc= a.acc and a.tip = ovrn.tip;

         -- ����� ������� �������. ��� (������� ����� ����� ! )
         select NVL ( sum ( LEAST ( 0, x.OSTC ) ) , 0) into a89.ostc  from accounts x where x.accc = a89.acc ;

         -- �� �������������� ��� �����
         a89.ostx := GREATEST (0, a89.LIM + a89.OSTC) ;

         -- ����� ��� 9129 = ��������� ����-�������, ������� ������ ���� 9129, ������ �� ������� ������� � ������� ���
         select DIV0 ( a89.ostx, sum( GREATEST( 0, (LIM+least(0, x.OSTC )) ) ) ) into  k9129_ from accounts x where x.accc =  a89.acc;

         for  a26 in (select * from accounts where a89.acc in ( acc, accc ) AND TIP <> 'SP ' )
         loop
              If a26.acc <> a89.acc then
                a26.ostx := round( GREATEST( 0, (a26.LIM+least(0,a26.ostc)) ) * k9129_ , 0);
                OVRN.BG1 (p_ini,  9, l_date, dd, a26, a26 );  ----- 3.1) �������� �� 9129
                OVRN.BG1 (p_ini, 99, l_date, dd, a26, a26 );  ----- 3.2) ������� ������������ �� ��� �� ����
              end if;
              If dd.sos = 10 then  OVRN.REV_LIM ( a26.acc, l_date, l_dat21, Dat_Next ); end if ; --------------- ��������� �������
         end loop ; -- a26

         OVRN.NEXT_LIM ( a89.acc ); -- �������� �� ��������� ����� ��������� ����� �������

      end if;  -- �����

  end loop ; -- d

end background ;
---------------------------------------------
procedure intX ( p_mode int ,p_dat1 date, p_dat2 date, p_acc8 number, p_acc2 number)  IS -- JOB-����� ������ %%
   l_job_id   number;
   l_job_what varchar2(4000) ;
   s_Dat1  varchar2(10);
   s_Dat2  varchar2(10);

begin
   s_Dat1  := to_char(p_Dat1,'dd.mm.yyyy');
   s_Dat2  := to_char(p_Dat2,'dd.mm.yyyy');

   l_job_what :=  'OVRN.intXJ ('|| gl.aUid ||', '|| p_mode|| ', to_date ('''||s_Dat1||''',''dd.mm.yyyy''), to_date('''||s_Dat2||''',''dd.mm.yyyy''), ' || p_acc8 ||', '|| p_acc2 || ');';
   bms.enqueue_msg( '������. %% �� ��� ���������� � �����:' || l_job_what, dbms_aq.no_delay, dbms_aq.never, gl.aUid );

    -- �������� job
   savepoint before_job_start;
   dbms_job.submit(job       => l_job_id,
                   what      => l_job_what,
                   next_date => sysdate,
                   interval  => null,
                   no_parse  => true);
exception when others then    rollback to savepoint before_job_start;   bars_audit.info('ERROR'||substr(sqlerrm || chr(10) ||    dbms_utility.format_call_stack(), 0,4000));    -- ��������� ������
end intx;

procedure INTXJ  ( p_User int, p_mode int ,p_dat1 date, p_dat2 date, p_acc8 number, p_acc2 number) is   -- ���������� ������  %%
--  p_mode = 0   3.0) ����������� ��� �� ������ (%%, �����) �� ��²����� �����
--                    OVRN.INTX(0, :B, :D,0,0)                :B(SEM=���_�_����,TYPE=D),:D(SEM=���_��_����,TYPE=D)
--                    ����  p_dat1  = Null = �������-�����������

--  p_mode = 1   2.0) ����������� ��� �� ������ (%%, �����) �� �������� �����
--                    OVRN.INTX(0, DATETIME_Null, :D,0,0)     :D(SEM=���_��_����,TYPE=D)
--                    p_dat1  = Null = �������-�����������
------------------------------------------------------------


-- ���������� % �� �����+����� �������
-- ���������� % ��       ����� ������� (��� �����=0)
--
-- ������ ���� � �������� - ����� �.�. �������������  2607 -> 6020, 6110
-- ������� - ����� �.�. �������������                 7020 -> 2608

  TYPE INTT  IS TABLE OF OVR_INTX%rowtype INDEX BY varchar2 (8) ;
  tmpD INTT    ;  d8 varchar2 (8) ;  npp_ int   ;
  k31_  int    ; -- ���-�� ���� � ���
  dTmp_ date   ;
  l_donor int  ;
  l_kol   int  ;
--21.06.2015 ������� ��� ��� ��� = ����/360, ��� ��� = ����.����
  l_BAZA  int  := 36000;
  l_BAZP  int  := 36500;

begin
  if p_User is not null then
    bars.bars_login.login_user(sys_guid,p_User,null,null);
  end if;
  If p_mode not in (0,1) then RETURN; end if;

  If p_mode = 0  and ( p_dat2 is null  or p_dat1 > p_dat2 ) then
     --  3.0) ����������� ��� �� ������ (%%, �����) �� ��²����� �����
     raise_application_error(g_errn,'��²����� ����� ����������� ������� � ��������' );
  end if;

  If p_mode = 1  and ( p_dat1 is NOT null  or p_dat2 is NULL ) then
     --2.0) ����������� ��� �� ������ (%%, �����) �� �������� �����
     raise_application_error(g_errn,'�������� ����� ����������� ������� � ��������' ) ;
  end if;

  k31_ :=  to_number( to_char( last_day(p_dat2) , 'dd') ) ;
  If  mod( to_number (to_char(p_dat2, 'YYY')) ,4) = 0 then   l_BAZP  := 36600; end if; --���������� ���
  delete from OVR_INTX where ISP = gl.aUid;
  ----------------------
  for a8 in (SELECT a.acc , NVL(i.acr_dat+1, d.sdate)  DAT1, i.metr, i.basey
             FROM accounts a, nd_acc n, cc_deal d , int_accn i
             WHERE a.tip  = ovrn.tip and (p_acc8 = 0 or p_acc8 = a.acc)
               and d.vidd = OVRN.VIDD and d.sos  >= 10 and d.sos < 15
               and a.acc  = n.acc     and n.nd   = d.nd  and i.acc  = a.acc  and i.id = 0    )
  loop

    If    a8.basey =  3 then  ------- 3 �% ����/360
          If mod ( to_char(p_dat2,'YYY'),4)=0 then l_BAZA  := 36000; l_BAZP  := 36600;  -- ���������� ���
          else                                     l_BAZA  := 36000; l_BAZP  := 36500;  -- HE ���������� ���
          end if;
    else  --------------------------- 0 �% ����/����
          If mod ( to_char(p_dat2,'YYY'),4)=0 then l_BAZA  := 36600; l_BAZP  := 36600;  --���������� ���
          else                                     l_BAZA  := 36500; l_BAZP  := 36500;  -- HE ���������� ���
          end if;
    end if;

--  elsIf a8.basey = 0 then l_BAZA  := 36500;     l_BAZP  := 36500; -- 0 �% ����/����  ACT/ACT
--  elsIf a8.basey = 0 --1 �% ����/365  AFI/365
--  elsIf a8.basey = 2 --2 �% SIA 30/360  SIA 30/360

     If p_dat1 is NOT NULL then a8.DAT1 := p_dat1 ; end if;

     If a8.DAT1 > p_Dat2 then goto Rec_Next; end if;


     If a8.metr = 7 then ovrn.FLOW_IR ( a8.acc, a8.DAT1, p_DAT2);  end if; -- ����.% ������

     select count(*) into l_kol from accounts where accc = a8.acc and nbs in ('2600','2650','2602','2603','2604'); -- ��� �� � 2017 �� ��������

     tmpD.delete;  -- �������� ����  � �������   tmpD
     for  d in (select (a8.dat1 - 1 + c.num) CDAT, mod(c.num,3) npp from conductor c where (a8.dat1 - 1 + c.num) <= p_dat2 )
     loop
        d8:= to_char(d.cdat,'yyyymmdd');
        tmpD(d8).mod1 := p_mode ;
        tmpD(d8).cdat := d.cdat ;
        tmpD(d8).npp  := d.npp ;
        tmpD(d8).IP8  := acrn.fprocn( a8.acc, 1, d.cdat) ;
        tmpD(d8).IA8  := acrn.fprocn( a8.acc, 0, d.cdat) ;
        tmpD(d8).acc8 := a8.acc ;

        select  NVL( sum ( decode ( sign(ost),  1, ost, 0) ), 0),    NVL( sum ( decode ( sign(ost), -1, ost, 0) ), 0)
        into tmpD(d8).Pas8 ,   tmpD(d8).Akt8     from  (select ovrn.FOST_SAL (acc, d.cdat) ost  from accounts where accc = a8.acc );

        tmpD(d8).Sal8 := tmpD(d8).Pas8 + tmpD(d8).Akt8  ;

        If tmpD(d8).IP8 = 0 and  tmpD(d8).IA8 = 0 then  -- �������� = 0    . ������� ��� %
           tmpD(d8).KP := 1;     tmpD(d8).KA := 1 ;
        else                                            -- �������� �� = 0 . ������� ��� %
           If  tmpD(d8).Sal8 > 0 then tmpD(d8).KP := round(div0( tmpD(d8).Sal8 , tmpD(d8).Pas8),8) ; tmpD(d8).KA := 0 ;
           Else                       tmpD(d8).KA := round(div0( tmpD(d8).Sal8 , tmpD(d8).Akt8),8) ; tmpD(d8).KP := 0 ;
           end if;
        end if;

        for  x in (select rnk, acc, kv, nls, ovrn.FOST_SAL ( acc, d.cdat) ost from accounts where accc= a8.acc and (p_acc2 = 0 or p_acc2 = acc) )
        loop
           tmpD(d8).Ost2 := x.ost;
           tmpD(d8).IP2  := acrn.fprocn( x.acc, 1, d.cdat);
           tmpD(d8).IA2  := acrn.fprocn( x.acc, 0, d.cdat);
           tmpD(d8).acc  := x.acc ;
           tmpD(d8).rnk  := x.rnk ;

           If x.ost >= 0  then tmpD(d8).S2  := round(tmpD(d8).KP  * x.ost,8) ;
                               tmpD(d8).S8  := round(x.ost - tmpD(d8).S2 ,8) ;
                               tmpD(d8).PR2 := round( tmpD(d8).S2 * tmpD(d8).IP2/l_bazp,8) ;
                               tmpD(d8).PR8 := round( tmpD(d8).S8 * tmpD(d8).IP8/l_bazp,8)  ;
                               tmpD(d8).VN  := 70 ;   -- ��������, ������, �������

           else                tmpD(d8).S2  := round(tmpD(d8).KA  * x.ost,8) ;
                               tmpD(d8).S8  := round(x.ost - tmpD(d8).S2,8)  ;
                               tmpD(d8).PR2 := round(tmpD(d8).S2  * tmpD(d8).IA2/l_baza,8) ;
                               tmpD(d8).PR8 := round(tmpD(d8).S8 * tmpD(d8).IA8/l_baza,8)  ;
                               tmpD(d8).VN  := 60 ;   -- ��������, �����,  ������
           end if;
           tmpD(d8).PR  := round( tmpD(d8).PR2 + tmpD(d8).PR8,8) ;

           -- ���������� ��������� ���������� ��� ���������� ���
           tmpD(d8).IP8 := ROUND( tmpD(d8).IP8, 4 ) ;
           tmpD(d8).IA8 := ROUND( tmpD(d8).IA8, 4 ) ;
           tmpD(d8).KP  := Round( tmpD(d8).KP , 4 ) ;
           tmpD(d8).KA  := ROUND( tmpD(d8).KA , 4 ) ;
           tmpD(d8).IP2 := Round( tmpD(d8).IP2, 4 ) ;
           tmpD(d8).IA2 := ROUND( tmpD(d8).IA2, 4 ) ;
           tmpD(d8).S2  := Round( tmpD(d8).S2 , 0 ) ;
           tmpD(d8).S8  := ROUND( tmpD(d8).S8 , 0 ) ;
           tmpD(d8).PR2 := Round( tmpD(d8).PR2, 8 ) ;
           tmpD(d8).PR8 := ROUND( tmpD(d8).PR8, 8 ) ;
           tmpD(d8).PR  := ROUND( tmpD(d8).PR , 8 ) ;
           tmpD(d8).ISP := gl.aUid ;
           insert into OVR_INTX values tmpD(d8);
           ---------------------------------------
           l_donor := nvl(to_number (OVRN.GetW(x.acc, 'DONOR' ) ),0) ;

           tmpD(d8).IP2 := null ;
           tmpD(d8).IA2 := null ;
           tmpD(d8).S2  := null ;
           tmpD(d8).S8  := null ;
           tmpD(d8).PR2 := null ;
           tmpD(d8).PR8 := null ;

           ------- ���� 1 ��� �� �������� 145 ( �������� ���������)
           -- �������� ����� ��� ������������  ����������� ��������  ������ ������ ��� ���������� ���������� = 1
           If l_donor <> 1 and l_kol > 1 then
              tmpD(d8).VN  := 62   ;
              begin select - round (tar/k31_,8) into tmpD(d8).PR  from ACC_TARIF where acc = x.acc and kod = 145 and tar > 0 ;
                    If tmpD(d8).PR  < 0 then         tmpD(d8).ISP := gl.aUid ;  insert into OVR_INTX values tmpD(d8); end if;
              EXCEPTION WHEN NO_DATA_FOUND THEN null;
              end ;
           end if ;

           ----- ���� 1 ��� �� �������� 146 ( �������� ��������� ��� ��������� ������ )
           -- �������� ����� ��� ������������  ��ϻ  ����������� ������ = 0 ��� ���������� ���������� = 1
           If l_kol > 1 and tmpD(d8).IA8  > 0 then
              tmpD(d8).VN  := 63   ;
              begin select - round( tar/k31_, 8)  into tmpD(d8).PR from ACC_TARIF where acc = x.acc and kod = 146 and tar > 0  ;
                    If tmpD(d8).PR < 0 then            tmpD(d8).ISP := gl.aUid ; insert into OVR_INTX values tmpD(d8); end if;
              EXCEPTION WHEN NO_DATA_FOUND THEN null;
              end ;
           end if ;

           If x.ost >= 0 and l_donor <> 1   then   -- 144  ����� �� ��������� 1-�� ��� (%)  ������ �� ������
              begin
                 select  v.sum         into tmpD(d8).S2  from ACC_OVER_COMIS v  where v.acc = x.acc and v.fdat = d.cdat ;
                 select NVL(a.pr,t.PR) into tmpD(d8).IA2 from (select kod,pr from acc_tarif where acc=x.acc and kod=144) a, tarif t where T.kod= 144 and t.kod= a.kod (+);
                 tmpD(d8).PR  :=  ROUND( tmpD(d8).S2  * tmpD(d8).IA2/100,8)  ;
                 tmpD(d8).VN  := 61   ;
                 if tmpD(d8).PR < 0 then tmpD(d8).ISP := gl.aUid ; insert into OVR_INTX values tmpD(d8); end if ;
              EXCEPTION WHEN NO_DATA_FOUND THEN null;
              end ;
           end if ;

        end loop;  --x
     end loop  ;  -- d

     <<Rec_Next >> null;

  end loop ; -- a8
  commit;
  if p_User is not null then
   bms.enqueue_msg( '���������� %% �� ��� ����������� '|| p_User|| ' ��������� ! ����������� ��������� ' , dbms_aq.no_delay, dbms_aq.never, p_User );   
   bars.bars_login.logout_user;  
  end if; 
exception when others
  then
   if p_User is not null then  
   bms.enqueue_msg( '���������� %% �� ��� ����������� '|| p_User|| ' ��������� � ��������! -'||SQLERRM , dbms_aq.no_delay, dbms_aq.never, p_User );   
   bars.bars_login.logout_user; 
   end if;
end intxJ ;
-----------------
procedure INTB  (p_mode int) is  --- ��������� �������� �������� ��������� ���������
  dd cc_deal%rowtype;  oo oper%rowtype;
begin 
    oo.tt := '%%1';  oo.vob := 6; oo.vdat := gl.bdate; oo.kv2 := gl.baseval ; oo.mfoa := gl.aMfo; oo.mfob := gl.aMfo; oo.id_b := gl.aOkpo;

for x in (select * from vX_ovrn order by acc8 )
loop
  begin
     update int_accn set acr_dat = x.dat2 where acc in ( x.acc, x.acc8) and id in (0,1) and acr_dat < x.dat2  ;
     select d.* into dd from cc_deal d, nd_acc n where n.acc = x.acc8 and d.nd = n.nd;
     select okpo into oo.id_a from customer where rnk = x.rnk;
     oo.nam_a := Substr(x.nam_a,1,38) ;  oo.nlsa := x.nlsa ;
     oo.nam_b := substr(x.nam_b,1,38) ;  oo.nlsb := x.nlsb ;    oo.kv   := x.kv   ;
     oo.nazn  := Substr( ' ��.���.�' || dd.cc_id || ' �� ' ||  to_char(dd.sdate,'dd.mm.yy') || ' ���.'|| x.nls ||
                         ' � '|| to_char(x.dat1,'dd.mm.yy') || ' �� ' || to_char(x.dat2,'dd.mm.yy') , 1, 160 ) ;


  --- ��������� �������� �� ������ ��������� � ��������
     x.PR := round(abs(x.pr),0) ;
     If x.pr > 0 then oo.s := x.pr ; oo.s2 := gl.p_icurval(x.kv,oo.s,oo.vdat);   oo.ref := null ;  oo.dk := x.id ;
        oo.nazn := Substr (
          CASE WHEN x.vn = 70 THEN '%% �� ���.' ||x.nls ||' � '|| to_char(x.dat1,'dd.mm.yy') || ' �� ' || to_char(x.dat2,'dd.mm.yy')||
                                   ' ��. ���. ���. ��� �� '||to_char(dd.sdate,'dd.mm.yy')
               WHEN x.vn = 60 THEN '���.%% ���.'||oo.nazn
               WHEN x.vn = 61 THEN '���.����.�� ������. ������.'|| oo.nazn
               WHEN x.vn = 62 THEN '���.����.�� ���. ����.��������'|| oo.nazn
               WHEN x.vn = 63 THEN '���.���� �� ���. �������� NPP'||oo.nazn
               else                x.nazn||oo.nazn
          END , 1, 160 );

        OVRN.opl1(oo);   gl.pay (2, oo.ref, oo.vdat);
        insert into operw (ref,tag, value) values (oo.ref, 'ND   ', to_char( dd.nd) );
        -- ������ ���
        If   x.VN in (70,60)  then  acrn.acr_dati (acc_=> x.acc, id_=> (1-x.id ), ref_ => oo.ref, dat_ => x.acr_dat, remi_ => 0) ;
        elsIf x.VN in ( 61 )  then  insert into operw (ref,tag, value) values (oo.ref, 'KTAR ', '144' );
              delete  from ACC_OVER_COMIS v where v.acc = x.acc and v.fdat >= x.dat1 and v.fdat <= x.dat2  ;
        elsIf x.VN in ( 62 )  then  insert into operw (ref,tag, value) values (oo.ref, 'KTAR ', '145' );
        elsIf x.VN in ( 63 )  then  insert into operw (ref,tag, value) values (oo.ref, 'KTAR ', '146' );
        end if ;
     end if;

     --COBUMMFO-5491  �������  %   �� ���������+      -- COBUMMFO-6843=����������� ����������� ���
     For xx in (select * from accounts where tip in  ('SP ','SPN')  and acc in (select acc from nd_acc where nd = dd.nd)   )
     loop OVRN.INT_OLD ( xx.acc, x.dat2 ) ; end loop;  

  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end ;

end loop ; --x

  delete  from OVR_INTX where  ISP = gl.aUid ;

end INTB;
-------------------------------
procedure OP_3600 (dd IN cc_deal%rowtype, a26 IN accounts%rowtype , a36 IN OUT accounts%rowtype) IS   -- ���� ��������  3600
  p4_  int;
  u_ND number;
begin
  begin select a.* into a36 from accounts a, nd_acc n   where a.rnk = a26.rnk and a.nbs = '3600' and a.acc =n.acc and n.nd = dd.nd and a.ob22 = '09' ;  -- �� � 2017 �� ��������
  EXCEPTION WHEN NO_DATA_FOUND THEN
     -- ������� 3600
     a36.nls := OVRN.Get_Nls (p_R4 => '3600' )  ;  ----a36.nls :=  f_newnls (a26.acc, 'OV2067', '')   ;    a36.nls :=  '3600'|| '0'|| substr(a36.nls,6,9) ;   a36.nls := VKrzn(substr(gl.aMfo,1,5), a36.nls) ;
     a36.nms := SUBSTR('������.���� �� ���.� '||trim(dd.cc_id) || ' �� ���.'|| a26.nls, 1,50);
     op_reg_ex( mod_=>1, p1_=>dd.nd, p2_=>0, p3_=>a26.grp, p4_=>p4_, rnk_=>a26.rnk, nls_=>a36.nls, kv_=>a26.kv, nms_=>a36.nms, tip_=>'ODB',
                isp_=>a26.isp,   accR_=>a36.acc,  tobo_ =>a26.branch);
     Accreg.setAccountSParam(a36.Acc, 'OB22', '09');
  end;
  OVRN.ins_110 (d_nd => dd.ND, p_acc26 => a26.acc, p_ACC => a36.acc, u_nd => U_ND ) ;  -- �������� 3600 � ��� 110

end OP_3600;
-----------------------------------------
procedure OP_SP (dd IN cc_deal%rowtype, a26 IN accounts%rowtype , a67 IN OUT accounts%rowtype , a69 IN OUT accounts%rowtype) IS   -- ���� ��������� 2067 + 2069
  p4_  int;
  sn8 accounts%rowtype;
  U_ND number ;
  l_donor int ;
begin

  l_donor  := nvl(to_number (OVRN.GetW(a26.acc,'DONOR' ) ),0) ;

  --�����/������� ���� SN8, �� ������� ����� ��������� ����
  begin select a.* into sn8 from accounts a, nd_acc n where a.tip = 'SN8' AND a.acc=n.acc and n.nd = dd.nd and a.rnk =  a26.rnk  AND a.dazs is null and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     -- ������� 8008
     sn8.nls := OVRN.Get_Nls (p_R4 => '8008' )  ;  --- sn8.nls := VKrzn ( substr( gl.aMfo,1,5),  '80080'|| substr(a26.nls,6,9)  ) ;
     sn8.nms := SUBSTR('�����.��� �� ���.� '||trim(dd.cc_id) || ' �� ���.'|| a26.nls, 1,50);
     op_reg_ex( mod_=>1, p1_=>dd.nd, p2_=>0, p3_=>a26.grp, p4_=>p4_, rnk_=>a26.rnk, nls_=>sn8.nls, kv_=>a26.kv, nms_=>sn8.nms, tip_=>'SN8',
                isp_=>a26.isp,   accR_=>sn8.acc,  tobo_ =>a26.branch );
  end;
  OVRN.ins_110 (d_nd => dd.ND, p_acc26 => a26.acc, p_ACC => sn8.acc, u_nd => U_ND ) ; -- �������� 8008 � ��� 110

  -- ���� 2069 SPN
  begin select a.* into a69 from accounts a, nd_acc n where a.rnk = a26.rnk and a.nbs = SB_2069.R020 and a.tip ='SPN'  and a.ob22 = SB_2069.ob22 and a.acc =n.acc and n.nd = dd.nd;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     -- ������� 2069
     a69.nls := OVRN.Get_Nls (p_R4 => SB_2069.R020 ) ;  ---a69.nls := VKrzn ( substr( gl.aMfo,1,5),  f_newnls (a26.acc, 'OV2069', '') ) ;
     a69.nms := SUBSTR('�������. % �� ���.� '||trim(dd.cc_id) || ' �� ���.'|| a26.nls, 1,50);
     op_reg_ex( mod_=>1, p1_=>dd.nd, p2_=>0, p3_=>a26.grp, p4_=> p4_, rnk_=>a26.rnk, nls_=>a69.nls, kv_=>a26.kv, nms_=>a69.nms, tip_=>'SPN',
                isp_=>a26.isp,   accR_=>a69.acc,  tobo_ =>a26.branch);
     Accreg.setAccountSParam(a69.Acc, 'OB22', SB_2069.ob22 );
  end;
  OVRN.ins_110 (d_nd => dd.ND, p_acc26 => a26.acc, p_ACC => a69.acc, u_nd => U_ND ) ; -- �������� 2609 � ��� 110

  begin insert into int_accn (ACC, ID, METR,BASEM,BASEY, FREQ, acr_dat, acra, acrb)
                    select a69.acc, 2, 0   ,    0,    0, 1, gl.bdate-1, sn8.acc, acc
                    from accounts  where kv = a26.kv and nls like '8006%' and dazs is null and rownum = 1 ;
------  Insert into INT_RATN  (ACC, ID, BDAT, IR, BR, OP) Values (a69.acc, 2, gl.bdate, 2, 10001,  3);
  exception when dup_val_on_index then  null;
  end ;
  ----------------
  If l_donor = 1 then RETURN; end if;
  ---------------------------------------

  --- ���� SP
  begin select a.* into a67 from accounts a, nd_acc n where a.rnk = a26.rnk and a.nbs = SB_2067.R020  and a.ob22 = SB_2067.ob22 and a.tip = 'SP ' and a.acc =n.acc and n.nd = dd.nd;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     -- ������� 2067
     a67.nls := OVRN.Get_Nls (p_R4 => SB_2067.R020  )  ; --a67.nls := VKrzn ( substr( gl.aMfo,1,5),  f_newnls (a26.acc, 'OV2067', '') ) ;
     a67.nms := SUBSTR('�������. ��� �� ���.� '||trim(dd.cc_id) || ' �� ���.'|| a26.nls, 1,50);
     op_reg_ex( mod_=>1, p1_=>dd.nd, p2_=>0, p3_=>a26.grp, p4_=>p4_, rnk_=>a26.rnk, nls_=>a67.nls, kv_=>a26.kv, nms_=>a67.nms, tip_=>'SP ',
                isp_=>a26.isp,   accR_=>a67.acc,  tobo_ =>a26.branch, accc_ => a26.accc );
     Accreg.setAccountSParam(a67.Acc, 'OB22', SB_2067.ob22 );
  end;
  OVRN.ins_110 (d_nd => dd.ND, p_acc26 => a26.acc, p_ACC => a67.acc, u_nd => U_ND ) ; -- �������� 2067 � ��� 110

   --� ������ ����������� �������������� ���������� (� �.�. ����� ��������� ������� ����������� ����)
   -- �������� ����������� �� ������������ ���������
   -- � ���������� �� ������ ������������ ����������� �������. �������� �� 2069.
   begin insert into int_accn (ACC, ID, METR,BASEM,BASEY, FREQ, acr_dat, acra, acrb)
                 select a67.acc, id, 0   ,    0,    0, 1, dd.sdate-1, a69.acc, acrb  from int_accn where acc = a26.acc and id = 0 ;
   exception when dup_val_on_index then  null;
   end ;

   begin insert into int_accn (ACC, ID, METR,BASEM,BASEY, FREQ, acr_dat, acra, acrb)
                    select a67.acc, 2, 0   ,    0,    0, 1, gl.bdate-1, sn8.acc, acc
                    from accounts
                    where kv = a26.kv and nls like '8006%' and dazs is null and rownum = 1 ;
---      Insert into INT_RATN  (ACC, ID, BDAT, IR, BR, OP) Values (a67.acc, 2, gl.bdate, 2, 10001,  3);
   exception when dup_val_on_index then  null;
   end ;

   OVRN.SetIR( dd.nd, a67, 0, gl.bdate, acrn.fprocn(a26.acc,0, gl.bdate) ) ; -- ���������� ������ ���� ������ �� 26*

end OP_SP;

procedure BG1 ( p_ini int, p_mode int, p_dat date, dd cc_deal%rowtype, a26 accounts%rowtype, x26 accounts%rowtype  ) is   -- ���-������������� ������ 26*
-- p_ini  = 0 ����� �� ��������� �� ������ ������/������ (��� �����)
-- p_ini  = 1 ����� �� ����. ���-������ (��  ������)

-- p_mode = 0                          --- �������� ��������
-- p_mode = 1 and              then    --- ���������
-- p_mode = 2 and l_donor <> 1 then    --- ����� �� ��������� ����
-- p_mode = 3                  then    --- 06 ����� ��������� �������� �� % � ���� ��� - ����� �� ���������
-- a26 - ���� ��� ��������( �.�.= 2600 ��� 3739)
-- �26 - ���� ���� ��� , ������ = 2600, - ��� ������ � ����.��������

  oo oper%rowtype      ;
  ii  int_accn%rowtype ;
  a91 accounts%rowtype ;
  a36 accounts%rowtype ;
  i36 int_accn%rowtype ;
  a67 accounts%rowtype ;
  a68 accounts%rowtype ;
  a69 accounts%rowtype ;
  l_term_DAy int ;
  l_donor int    ;  l_ir8 number ; l_kol int ; sTmp_ varchar2(500);
  l_OST number   ;
  ----------------
  Dat0_ date   ;
  KOLD_ int    ;
  spl1_ number ;
  itog_ number ;
  s1_   number ;
  -------------
  code_   NUMBER;
  erm_    VARCHAR2(2048);
  status_ VARCHAR2(10);
  ----------
  procedure OFF_SP (p_mode int, oo oper%rowtype, a26 accounts%rowtype, sp accounts%rowtype) is
  begin

     If oo.dk = 0  and oo.nlsa = a26.nls and  oo.tt = 'ASP' and  oo.nlsb = sp.nls and sp.tip = 'SP '  then
        If p_mode = 0 then -- ��������� ���.������-������ DEB_LIM �� ����� ���.���������� ������ �� ��������� ����� ������� �� ��������
           update accounts set accc = null     where acc = a26.acc;
           update accounts set accc = null     where acc = sp.acc ;
        else   -- ������� ���.������-������
           update accounts set accc = a26.accc where acc = a26.acc;
           update accounts set accc = a26.accc where acc = sp.acc ;
        end if ;
     end if    ;
  end OFF_SP   ;
------------------
begin

  begin select okpo into oo.id_a from customer where rnk = a26.rnk;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     If  p_ini  = 0 then RETURN ; --����� �� ��������� �� ������ ������/������ (��� �����)
     else raise_application_error(g_errn,'�� �������� RNK=' ||a26.rnk);
     end if ;
  end;

  l_donor    := NVL( to_number (OVRN.GetW(a26.acc , 'DONOR'    ) ), 0) ;
  l_term_DAY := NVL( to_number (OVRN.GetW(a26.accc, 'TERM_DAY' ) ), 5) ;

  oo.vob  := 6        ;
  oo.vdat := gl.bdate ;
  oo.kv   := a26.kv   ;
  oo.kv2  := a26.kv   ;
  oo.mfoa := gl.aMfo  ;
  oo.mfob := gl.aMfo  ;


If p_mode = 0 then    --- �������� ��������
   -- 141   ����� �� ������� ���������� (% �� ����)           1%
   -- 142   ����� �� ���������� ���������� �������             1000 ���
   -- 143   ����� �� ���������� ������� NPP                     1000 ���
   -- 144   ����� �� ������.������ ��� (% �� ����.���.���.)     0.06%
   OVRN.OP_3600 ( dd, a26, a36 ) ; -- �������� �� �������� �������
   l_ir8   := acrn.fprocn(a26.accc, 0, p_dat) ;
   select count(*) into l_kol from accounts where accc = a26.accc and nbs in ('2600','2650','2602','2603','2604'); -- ��� �� � 2017 �� ��������

   KOLD_  := (dd.wdate - dd.sdate +1 ) ;

   for k in (select T.kod, T.name, NVL(at.pr, t.PR) PR, NVL( at.tar, t.TAR) TAR
             from (select * from acc_tarif where acc = a26.acc            ) AT ,
                  (select * from     tarif where kod in (141,142,143    ) ) T
             where  T.kod = AT.kod (+)
            )
   loop
      -- ������� ����� ���������� <HumenuykSS@oschadbank.ua> �� 13/06/2016 17:48
      If    k.kod = 141 and l_donor = 1  then oo.s := 0; --����� �� ������� ���������� (% �� ����)    ������ ������
      ElsIf k.kod = 142 and l_donor = 1  then oo.s := 0; --����� �� ���������� ��������� ��������(����) ������ ������
      ElsIf k.kod = 142 and l_kol   = 1  then oo.s := 0; --����� �� ���������� ��������� ��������(����) ���������� ���������� = 1
      ElsIf k.kod = 143 and l_ir8   = 0  then oo.s := 0; --����� �� ���������� ������� ��� (����)  ����������� ������ = 0
      ElsIf k.kod = 143 and l_kol   = 1  then oo.s := 0; --����� �� ���������� ������� ��� (����)  ���������� ���������� = 1
      ElsIf k.kod = 141                  then select round ( NVL(max(LIM), a26.lim) *k.PR/100,0)
                                              into oo.s from ovr_lim where acc = a26.acc and nd = dd.nd;
      else                                    oo.s := k.Tar ;
      end if;

      if oo.s > 0 then
         oo.dk   := 1       ;  oo.nam_a := substr(a26.nms,1,38); oo.nlsa := a26.nls; oo.id_b := oo.id_a ;
         oo.tt   := 'ASG'   ;
         oo.nlsb := a36.nls ;  oo.nam_b := substr( a36.nms,1,38);
         oo.ref  := null    ;
         oo.s2   := oo.s    ;
         oo.nazn := Substr( '���.� '|| dd.cc_id || ' �� '|| to_char(dd.sdate, 'dd.mm.yyyy') ||'. ' || k.name, 1, 160 ) ;

         oo.vdat  := gl.bdate ;
         begin OVRN.opl1(oo);  gl.pay (2, oo.ref, oo.vdat);
         EXCEPTION  WHEN OTHERS THEN
            deb.trap(SQLERRM,code_,erm_,status_);
            raise_application_error(g_errn,'���.'||a26.nls||'.��������� �������� '||k.kod||':'|| k.name ||nlchr|| erm_ );
         end ;

         -- ����������� = ���� �������
         Dat0_    := dd.sdate -1 ;
         itog_    := oo.s ;
         oo.nlsb  := nbs_ob22_null( SB_6020.R020, SB_6020.ob22, substr(a26.branch,1,15) );
         oo.nam_b := '������ �i� �������������� ���.���';
         oo.nam_a := substr( a36.nms,1,38);
         oo.nlsa  := a36.nls ;
         oo.id_b  := gl.aOkpo ;
         oo.tt    := '%%1'   ;
         s1_      := oo.s    ;
         FOR x in (select TRUNC(add_months(dd.sdate,c.num),'MM')-1 dat31 from conductor c where TRUNC(add_months(dd.sdate,c.num),'MM')-1 <dd.wdate
                   union all select dd.wdate from dual
                   order by 1   )
         loop
            If x.dat31 = dd.wdate then spl1_ := itog_ ;
            else                       spl1_ := ROUND(  S1_ * (x.dat31-Dat0_) / KOLD_ -0.5 ,0) ;
            end if;

            If spl1_ > 0 then
               itog_ := itog_ - spl1_ ;
               oo.ref   := null    ;
               oo.s2    := spl1_   ;
               oo.s     := spl1_   ;
               oo.vdat  := x.dat31 ;
               oo.nazn  := Substr(
                          '���i����� ���������i� ���.���i�i� �� ���.� '|| dd.cc_id  ||
                          ' �i� '|| to_char(dd.sdate, 'dd.mm.yyyy') || '. ����� � ' || to_char( (Dat0_+1), 'dd.mm.yyyy') ||
                          ' �� ' || to_char(oo.vdat , 'dd.mm.yyyy')
                          , 1, 160 ) ;
               OVRN.opl1(oo);  gl.pay (2, oo.ref, oo.vdat);
---------------gl.payv( 0, oo.REF, x.dat31, '%%1', 1, gl.baseval,  oo.nlsa, oo.s,  gl.baseval,  oo.nlsb , oo.s );
               insert into operw (ref,tag, value) values (oo.Ref, 'KTAR ', to_char ( k.kod ) ) ;
            end if ; --    If spl1_ > 0 then
            Dat0_ := x.dat31;

         end loop  ; --- x
      end if ;  -- if oo.s > 0 then
   end loop ;  --- k  �� ������� ��������

   -- ���.���� ������� 3739/05 SG  � ��� ������������ � ���������� : ������� 2600, ����� 3739
   Declare a37 accounts%rowtype; p4_ int ; u_nd number := null ;
   begin
      begin select a.* into a37 from accounts a, nd_acc n where a.rnk=a26.rnk and a.nbs='3739' and a.acc=n.acc and n.nd=dd.nd and a.ob22='05' and a.tip='SG ';
      EXCEPTION WHEN NO_DATA_FOUND THEN  -- ������� 3739
         a37.nls := OVRN.Get_Nls (p_R4 => '3739' ) ; --a37.nls :=  f_newnls (a26.acc, 'OV2067', '')   ;    a37.nls := '3739'|| '0'|| substr(a37.nls,6,9)  ;   a37.nls := VKrzn(substr(gl.aMfo,1,5), a37.nls) ;
         a37.nms := SUBSTR('�����. �� ���.� '||trim(dd.cc_id) || ' �� ���.'|| a26.nls, 1,50);
         op_reg_ex( mod_=>1, p1_=>dd.nd, p2_=>0, p3_=>a26.grp, p4_=>p4_, rnk_=>a26.rnk, nls_=>a37.nls, kv_=>a26.kv, nms_=>a37.nms, tip_=>'SG ',
              isp_=>a26.isp,   accR_=>a37.acc,  tobo_ =>a26.branch);
         Accreg.setAccountSParam(a37.Acc, 'OB22', '05');
      end;
      OVRN.ins_110 (d_nd => dd.ND, p_acc26 => a26.acc, p_ACC => a37.acc, u_nd => U_ND ) ; -- -- �������� 3739 � ��� 110
   end ;

   RETURN ;

end if; --- If p_mode = 0 then    --- �������� ��������

----------------
If p_mode = 1  then    --- ���������

   oo.dk := 1    ;  oo.nam_a := substr(a26.nms,1,38); oo.nlsa := a26.nls; oo.id_b := oo.id_a;
   oo.tt := 'ASG';
   L_OST := a26.ostc;
   for sp in (select * from accounts where acc in (select acc from nd_acc where nd = dd.nd) and tip in ('SPN', 'SP ', 'SN ') and ostc < 0 and rnk = a26.rnk 
              order by decode (tip,'SPN', 1, 'SP ', 2, 3 )  )
   loop  oo.s := 0;

      --04.10.2017 Sta �������� ����� ���.���� �� ����� 3739.SG � ���� ����������� �������� �������, � �� � ��������� ���� ( ���� 05 �����) 
      If l_OST > 0  and ( sp.tip in ('SPN', 'SP ') OR a26.tip = 'SG ' )  then  
         oo.s := LEAST ( L_OST, - sp.ostc) ;

      ElsIf sp.tip  = 'SN ' then   ------ g_TAGD = TERM_DAY -- ����i�(���� �i�) ��� ������ %%
         -- ���� ������ ��������� � ���� ������ ����� �� ����������
         begin select add_months(trunc(acr_dat,'MM'),1) + l_term_DAY - 1        into ii.acr_dat      from int_accn where id=0 and acc = x26.acc ;
      
               If p_dat < ii.acr_dat AND DD.WDATE > P_DAT and a26.tip <> 'SG '  then oo.s := 0 ; -- �� 01 - 05 (��� 2600)������ �� ������. ���� ������ ��� �� ���������
               else  oo.s := OVRN.RES26( a26.acc  ) ;     oo.s := LEAST(oo.s, - sp.ostc) ;
               end if;

         EXCEPTION WHEN NO_DATA_FOUND THEN oo.s := 0;
         end ;
      elsIf l_OST > 0  then  oo.s := LEAST ( L_OST, - sp.ostc) ;
      else                   oo.s := 0;
      end if;

      If oo.s > 0 then
         oo.nlsb  := sp.nls ;
         oo.nam_b := substr( sp.nms,1,38);
         oo.ref   := null;
         oo.s2    := oo.s ;

         If    sp.tip = 'SP ' then  sTmp_ := '��������� ���� ����� �������.����������.';
         elsIf sp.tip = 'SPN' then  sTmp_ := '��������� �������.%% �� �����, ����������� �� ���������.';
         elsIf sp.tip = 'SN ' then  sTmp_ := '��������� %% �� �����, ����������� �� ���������.';
         end if ;
         oo.nazn  := substr( sTmp_ ||' ����� � ' || TRIM (dd.cc_id)|| ' �i� '  || TO_CHAR (dd.sdate, 'dd.mm.yyyy'), 1, 160 );

         If p_ini = 0 then   --����� �� ��������� �� ������ ������/������ (��� �����)
            SAVEPOINT do_SP1 ;
            begin     OVRN.opl1(oo);    gl.pay (2, oo.ref, oo.vdat);   L_OST  := L_OST  - oo.s ;
            EXCEPTION WHEN OTHERS THEN sTmp_ := 'OVRN:'||oo.nlsa||'->'|| oo.nlsb||'. ��������� �������� '||oo.s||'='||sTmp_; ROLLBACK TO do_SP1;   logger.error(sTmp_) ;
            end ;
         else         OVRN.opl1(oo);   gl.pay (2, oo.ref, oo.vdat);   L_OST  := L_OST  - oo.s ;
         end if ;
      end if ; -- oo.s > 0
   end loop ;  -- sp
   RETURN ;
end if;

If p_mode = 2 and l_donor <> 1 then    --- ����� �� ��������� ����
   oo.dk := 0    ;  oo.nam_a := substr(a26.nms,1,38); oo.nlsa := a26.nls; oo.id_b := oo.id_a;
   oo.tt := 'ASP';
   for sp in (select * from accounts where acc in (select acc from nd_acc where nd = dd.nd) and tip in ('SP ') and rnk = a26.rnk )
   loop
      oo.nlsb  := sp.nls ;     oo.nam_b := substr( sp.nms,1,38);
      oo.ref   := null;
      oo.s     := - a26.ostc;   oo.s2    := oo.s ;
      sTmp_    := '��������� �� �������. ���� ����������.';
      oo.nazn  := substr( sTmp_||' ����� � ' || TRIM (dd.cc_id)|| ' �i� '  || TO_CHAR (dd.sdate, 'dd.mm.yyyy'), 1, 160 );

      If p_ini = 0 then -- �� ���������
         SAVEPOINT do_SP2 ;
         begin OVRN.opl1(oo);
               OFF_SP (0, oo, a26, sp ) ;   gl.pay (2, oo.ref, oo.vdat);   OFF_SP ( 1, oo, a26, sp ) ;
               delete from OVR_TERM_TRZ where acc = a26.acc ;
         EXCEPTION  WHEN OTHERS THEN sTmp_ := 'OVRN:'||oo.nlsa||'->'|| oo.nlsb||'. ��������� �������� '||oo.s||'='||sTmp_;  ROLLBACK TO do_SP2;   logger.error(sTmp_ ) ;
         end ;
      else     OVRN.opl1(oo);
               OFF_SP (0, oo, a26, sp ) ;   gl.pay (2, oo.ref, oo.vdat);   OFF_SP ( 1, oo, a26, sp ) ;
               delete from OVR_TERM_TRZ where acc = a26.acc ;
      end if ;
   end loop  ; -- sp
   OVRN.UPD_SOS  (p_nd => dd.ND, p_sos => null ) ;
   RETURN;
end if;

If p_mode = 3 and to_number(to_char(p_dat,'DD')) > l_term_DAY  then

   ----------------------------------------------------------------- 06 ����� ��������� �������� �� % � ���� ��� - ����� �� ���������
   begin select * into a68 from accounts where acc in (select acc from nd_acc where nd=dd.nd) and tip in ('SN ') and rnk= a26.rnk and ostc <0 ;
   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
   end;

   oo.dk    := 0         ;
   oo.nam_a := substr(a68.nms,1,38);
   oo.nlsa  := a68.nls   ;
   oo.id_b  := oo.id_a   ;
   oo.tt    := 'ASP'     ;
   oo.kv    := a68.kv    ;
   oo.s     := -a68.ostc ;
   oo.s2    := oo.s  ;
   oo.kv2   := oo.kv ;
   OVRN.OP_SP (dd, a26, a67, a69  );  -- �������� �� ���������
   oo.nam_b := substr(a69.nms,1,38);
   oo.nlsB  := a69.nls   ;
   sTmp_    := '��������� �� �������.�����.%%';
   oo.nazn  := substr( sTmp_||' ����� � ' || TRIM (dd.cc_id)|| ' �i� '  || TO_CHAR (dd.sdate, 'dd.mm.yyyy'), 1, 160 );

   If p_ini = 0 then -- �� ���������
      SAVEPOINT do_SP3 ;
      begin     OVRN.opl1(oo);   gl.pay (2, oo.ref, oo.vdat);
      EXCEPTION WHEN OTHERS THEN sTmp_ := 'OVRN:'||oo.nlsa||'->'|| oo.nlsb||'. ��������� �������� '||oo.s||'='||sTmp_;  ROLLBACK TO do_SP3;  logger.error(sTmp_ ) ;
      end ;
   else         OVRN.opl1(oo);   gl.pay (2, oo.ref, oo.vdat);
   end if ;

   -- ����� ���� 15 ���� �� ������� ��������� 05 ����� �� ��������� %%
   -- 3  ����������� �����.����.+����.  15
   OVRN.ins_TRZ (p_acc1 => a26.acc, p_datVZ => null, p_datSP => null, p_trz => 3);
   OVRN.UPD_SOS  (p_nd  => dd.ND , p_sos => null ) ;
   RETURN;
end if;

If p_mode in ( 9,90) and l_donor <> 1 then    --- 9129

   oo.nlsb  := BRANCH_USR.GET_BRANCH_PARAM2('NLS_9900',0) ; oo.nam_b :='�����.���.9900';    oo.id_b := gl.aOkpo;
   oo.tt    := 'CR9';
   begin select * into a91 from accounts where acc in (select acc from nd_acc where nd= dd.nd) and nbs= '9129' and rnk= a26.rnk  and dazs is null ;
   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
   end;

   oo.s := a26.ostx + a91.ostc;
   If oo.s <> 0 then
      oo.nlsa := a91.nls;    oo.nam_a := substr( a91.nms,1,38);
      If oo.s > 0 then oo.dk := 1 ;
      else             oo.dk := 0 ;  oo.s := - oo.s;
      end if;
      oo.ref   := null;
      oo.s2    := oo.s ;

      If    p_mode = 9 and oo.dk = 1 then  oo.nazn  := '���������';
      elsIf p_mode = 9 and oo.dk = 0 then  oo.nazn  := '���������' ;
      elsIf p_mode = 90              then  oo.nazn  := '�������� ' ;
      end if ;
      oo.nazn  := substr( oo.nazn||' ���������� ����� �� ����������� ��. ���. �'||dd.cc_id||' �i� '||TO_CHAR (dd.sdate,'dd.mm.yyyy')||'�.',1, 160 );

      If p_ini = 0 then  -- ����� �� ���������
         SAVEPOINT do_SP9 ;
         begin     OVRN.opl1(oo) ;   gl.pay (2, oo.ref, oo.vdat);
         EXCEPTION WHEN OTHERS THEN  sTmp_ := 'OVRN:'||oo.nlsa||'->'|| oo.nlsb||' ����='||oo.s||'='||sTmp_; ROLLBACK TO do_SP9; logger.error(sTmp_ ) ;
         end ;
      else         OVRN.opl1(oo) ;   gl.pay (2, oo.ref, oo.vdat);
      end if;
   end if ;

   RETURN ;
end if;

If p_mode = 99 and l_donor <> 1 then
   -- ���������� ������� ���
   declare l_chko3 number ;   l_dat01 date   := trunc(p_dat, 'MM') ;  m_dat01 date ;
   begin
      begin      m_dat01 := add_months ( l_dat01, -1) ;
          select s into l_chko3  from OVR_CHKO where acc = a26.acc and datm = m_dat01 and s is not null ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
          ----- ���� ��� ������ ��� �� ����.�����. �� �������� ������ �� ���� ��� � ������������� �����
          OVRN.CHKO(p_mode=>60, p_acc=> a26.acc, p_dat=> m_dat01, p_s=> null, p_pr=> null) ; --60 - ��������  ����   ��� �� ����� � ������
          OVRN.CHKO(p_mode=> 0, p_acc=> a26.acc, p_dat=> m_dat01, p_s=> null, p_pr=> null) ; -- 0 - ��������  ������ ��� �� ����� � ������
          OVRN.CHKO(p_mode=> 1, p_acc=> a26.acc, p_dat=> m_dat01, p_s=> null, p_pr=> null) ; -- 1 - ��������� ������ ��� �� ����� � ������
          OVRN.CHKO(p_mode=> 9, p_acc=> a26.acc, p_dat=> m_dat01, p_s=> null, p_pr=> null) ; -- 9 - ��������� ������ ��� �� ����� � ���� ����� = ���� ��� �� �����
      end ;

      -- ������� � ������ ����� ����� ( ���� ��� ��� ���)
      Insert into OVR_CHKO (ACC,  DATM , PR )
                 select a26.acc,l_dat01, 0 from dual where NOT exists (select 1 from OVR_CHKO where ACC=a26.acc and datm=l_dat01);

      -- ���������� ������� ��� �� 1 ������� ����
/*If dd.nd NOT in (646715701, 646715801, 646715901) then

      INSERT INTO OVR_CHKO_DET ( REF, acc, datm)
      SELECT O.REF, p.acc, l_dat01  FROM OPER O , opldok p
      where  o.nlsb = a26.nls  and o.id_b = oo.id_a
         and o.id_a not in
              (select cc.okpo
               from customer cc, accounts aa, nd_acc nn
               where cc.rnk = aa.rnk and aa.acc = nn.acc and nn.nd = dd.nd )
        and o.ref  = p.ref and p.fdat = p_dat and p.sos = 5 and  p.acc = a26.acc and p.dk = 1
        and NOT exists (select 1 from  OVR_CHKO_DET where acc = a26.acc and ref = o.REF);
else
      INSERT INTO OVR_CHKO_DET ( REF, acc, datm)
      SELECT O.REF, p.acc, l_dat01 FROM OPER O, opldok p
      where  o.nlsb = a26.nls  and o.id_b = oo.id_a
        and o.ref  = p.ref and p.fdat = p_dat and p.sos = 5 and  p.acc = a26.acc and p.dk = 1
        and NOT exists (select 1 from  OVR_CHKO_DET where acc = a26.acc and ref = o.REF);
end if;*/


--jeka 20.04.2017 --��������� ���� ���������� ����� ���� � ���� ����� 2610, 2615, 2651, 2652, 2062, 2063, 2082, 2083
DECLARE OKPO_2600 CUSTOMER.OKPO%TYPE := oo.id_a ; ACC_2600 ACCOUNTS.ACC%TYPE := a26.acc ;
BEGIN
      INSERT INTO OVR_CHKO_DET ( REF, acc, datm)
      with tt as (select a.acc,a.nls from OVR_ACC_ADD V, accounts a where a.acc = V.acc_add and V.acc = ACC_2600  union all select a.acc,a.nls from  accounts a where  a.acc = ACC_2600 )
      SELECT O.REF, p.acc, l_dat01  
       FROM OPER O, opldok p
       where o.nlsB in (select nls from tt)  and o.id_B = OKPO_2600 AND O.DK = 1
         and o.id_A not in (select cc.okpo from customer cc, accounts aa, nd_acc nn   where cc.rnk = aa.rnk and aa.acc = nn.acc and nn.nd = dd.nd and cc.okpo <> o.id_B)
         and o.NLSA not in (select a.nls from accounts a where a.rnk=o.id_B and a.nbs not in ('2610', '2615', '2651', '2652', '2062', '2063', '2082', '2083' )) -- ��� �� � 2017 ���������
         and o.ref  = p.ref and p.fdat = p_dat and p.sos = 5 and  p.acc in (select acc from tt) and p.dk = 1  and NOT exists (select 1 from  OVR_CHKO_DET where acc = ACC_2600 and ref = o.REF);

--STA 	05.09.2017 --������²� ���
      INSERT INTO OVR_CHKO_DET ( REF, acc, datm)
      with tt as (select a.acc,a.nls from OVR_ACC_ADD V, accounts a where a.acc = V.acc_add and V.acc = ACC_2600  union all select a.acc,a.nls from  accounts a where  a.acc = ACC_2600 )
      SELECT O.REF, p.acc, l_dat01  
        FROM OPER O, opldok p
       where o.nlsA in (select nls from tt)  and o.id_A = OKPO_2600 AND O.DK = 0
         and o.id_B not in (select cc.okpo from customer cc, accounts aa, nd_acc nn   where cc.rnk = aa.rnk and aa.acc = nn.acc and nn.nd = dd.nd and cc.okpo <> o.id_A)
         and o.NLSB not in (select a.nls from accounts a where a.rnk=o.id_A and a.nbs not in ('2610', '2615', '2651', '2652', '2062', '2063', '2082', '2083' )) -- ��� �� � 2017 ��������� 
         and o.ref  = p.ref and p.fdat = p_dat and p.sos = 5 and  p.acc in (select acc from tt) and p.dk = 1 and NOT exists (select 1 from  OVR_CHKO_DET where acc = ACC_2600 and ref = o.REF);
END;

    RETURN;
   end;
end if;
end BG1;

function SP (p_mode int, p_nd number, p_rnk number) return number is   l_ost number := 0;
begin
  begin select -a.ostc into l_ost from accounts a, nd_acc n where a.rnk = p_rnk and a.tip = decode(p_mode,7, 'SP ', 'SPN') and a.acc= n.acc and n.nd= p_nd;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end ;
  RETURN l_ost;
end SP;
-------------------------------
procedure FLOW_IR    ( p_accc number, p_dat1 date, p_dat2 date) is  -- �������� ���������� ��������� % ������ (METR=7)
  kol_ int;  ir1_  NUMBER := -1 ;   ir2_ number ; dat1_ date ;
begin

for ii in (select i.* from int_accn i, accounts a where a.accc = p_accc and a.acc = i.acc and i.id = 0)
loop
   --������� ������ ��� ������� ����������
   DELETE FROM int_ratn WHERE acc = ii.acc AND ID = 0 AND bdat > ii.acr_dat;
   ir1_  := -1 ;

   -- ��������� ��� ��� �� ���� �� ��� ����������
   for f in (select FDAT
             from ( select (ii.acr_dat+c.num) FDAT from conductor c where  (ii.acr_dat+c.num) <= p_dat2  )
             where ovrn.FOST_SAL (ii.acc, FDAT ) < 0
             order by FDAT
             )
   LOOP
     -- ��������� ���� ����� � ���
     select max(fdat) into dat1_ from saldoa  where fdat <= f.FDAT and acc = ii.acc and  ostf >= 0 ;
     kol_ := f.FDAT - dat1_ + 1;

     begin   -- ������ ������ ���
        SELECT NVL(ir,IR1_) INTO IR2_
        FROM (SELECT ir,dni FROM int_ovr WHERE kv = gl.baseval AND ID = ii.idr ORDER BY dni)  WHERE ROWNUM = 1 AND dni >= KOL_ ;
        -- ���� ����������, �� ���������
        If IR1_ <> IR2_ then   INSERT INTO int_ratn (acc,ID,bdat,ir) VALUES (ii.acc,0,f.FDAT,IR2_);     IR1_:= IR2_;   end if;
     EXCEPTION  WHEN NO_DATA_FOUND THEN null;
     end;
   end loop; --- f
end loop ; -- k

end FLOW_IR;
-------- -----------------------------------------------------------------
procedure DEL_ALL (p_nd number) Is  -- �������� ����/�������� ����� ��� ������ �����������������
 x_dat date := to_date('16.11.2016','dd.mm.yyyy');
begin
 ------------------------------------------------------------------------
 If sysdate > x_dat and p_nd = 0 then
    raise_application_error(g_errn,'����-����� ��������� �Ѳ� 䳺 ���� �� '|| to_char (x_dat,'dd.mm.yyyy') ) ;
 end if;
 ------------------------------------------------------------------------
 for dd in (select d.nd, d.sdate, a.acc ACC8 , d.sos
            from cc_deal d, nd_acc n, accounts a
            where d.vidd = ovrn.vidd and d.nd = n.nd and n.acc = a.acc and a.tip = OVRN.tip
              and ( p_ND = 0 or
                    p_ND = d.nd and sysdate < x_dat OR
                    p_ND = d.nd and d.sos < 10
                  )
            )
 loop

    for a26 in (select * from accounts where accc = dd.ACC8)
    loop  OVRN.DEL_slave  (dd.nd, a26.acc, a26.nls, a26.kv ) ;
          delete from nd_acc where acc = a26.acc and nd = dd.nd;
          delete from nd_acc where acc = a26.acc and nd = (select nd from cc_deal where ndi =dd.nd and vidd=110);
          update accounts set accc = null where acc = a26.acc and accc= dd.acc8 ;
    end loop ; -- a26

    delete from int_ratn   where  acc = dd.acc8 ;  -- ���� ������
    delete from int_accn   where  acc = dd.acc8 ;  -- ����
    delete from accountsW  where  acc = dd.acc8 and tag in ('TERM_LIM', 'TERM_OVR', 'TERM_DAY', 'PCR_CHKO', 'NEW_KL', 'DONOR', 'STOP_O', 'DT_SOS', 'NOT_DS' ); --���.���� �����
    delete from OVR_LIM    where  acc = dd.acc8 and nd = dd.nd ;            --������
    delete from cc_sob     where nd = dd.ND ;
    delete from nd_txt     where nd = dd.ND ;
    delete from nd_acc     where nd in (select nd from cc_deal where ndi = dd.ND );
    delete from cc_deal    where nd in (select nd from cc_deal where ndi = dd.ND );
    delete from nd_acc     where nd = dd.ND ;
    delete from cc_deal    where nd = dd.ND ;
    OVRN.isob  (p_nd => dd.ND, p_sob => 'DEL:master-������' );

 end loop; -- dd

 If p_nd = 0 then delete from OVR_INTX ; end if;

end DEL_ALL;

procedure rep_LIM ( p_nls varchar2, p_acc number) is
  l_key zapros.PKEY%type := '\BRS\SBR\OVR\LIM';
  l_rep reports.Id%type ;
  ------------------------
  l_Ret cbirep_queries.id%type;
begin

  begin select r.id into l_Rep from reports r, zapros z where z.pkey = l_key and r.param like z.KODZ||',3%';
  EXCEPTION  WHEN NO_DATA_FOUND THEN    raise_application_error(g_errn,'³������ � ��� ��� � ����� ������ PKEY='||l_key);
  end;

  l_Ret := RS.create_report_query(p_rep_id     => l_Rep,
                                  p_xml_params =>'<ReportParams><Param ID=":ACC" Value="'||p_acc||'" /></ReportParams>'
                                  ) ;
  if getglobaloption ('BMS') = '1'  then -- BMS �������: 1-����������� �������� ���������
     bms.enqueue_msg( '���� ��� ���.'||p_nls, dbms_aq.no_delay, dbms_aq.never, gl.aUid );
  end if;

end rep_LIM ;

procedure CLS (P_ND NUMBER) IS
  dd  cc_deal%rowtype;
  AA  accounts%rowtype;
  A8  accounts%rowtype;
  l_bDat_Next date;
  l_Txt varchar2 (250);
  oo oper%rowtype ;

BEGIN
  l_bDat_Next := Dat_Next_U ( gl.bdate, 1 ) ;

--begin select * into dd from cc_deal where nd = p_nd and wdate < gl.bdate and sos < 15;
--EXCEPTION  WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn,'��� '|| p_nd ||' ³������ ����� ���������� � ������� ����� '|| to_char(gl.bdate,'dd.mm.yyyy') );
--end;

  begin select * into dd from cc_deal where nd = p_nd                      and sos < 15;
  EXCEPTION  WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn,'��� '|| p_nd ||' ³������ ����� ���������� ' );
  end;


  begin select a.* into A8 from accounts  a, nd_acc n where a.acc=n.acc and n.nd = dd.nd and a.TIP = OVRN.TIP ;
  EXCEPTION  WHEN NO_DATA_FOUND THEN  raise_application_error(g_errn,'��� '|| p_nd ||' ³������ 8998*');
  end;

  -- 1) ����������� �������� �� ���� ���������� ������������
  ovrn.INTXj (p_User => null,p_mode => 1, p_dat1 => null, p_dat2 => (GL.BDATE-1), p_acc8 =>A8.ACC, p_acc2 =>0) ;


  -- 0) ������� ���������� �������� ��� ��������� ��������
  If DD.wdate >=  gl.bdate then
     Declare Par2_  Number ;    Par3_   Varchar2 (200);
     begin -- ���� �� ������ 3600, �� ���� ��������� = ���-�� ����������
         FOR a36 in (select a.* from accounts  a, nd_acc n where a.acc = n.acc and n.nd = dd.nd and a.NBS = '3600' and a.ostf <> 0 )
         LOOP oo := null;
            for k in (select o.ref from opldok o where o.sos=3 and o.fdat >= gl.bdate and o.acc=a36.ACC )
            loop If oo.NLSA is Null then select * into oo from oper where ref = k.REF; end if;
                 ful_bak( k.Ref); -- ������ ��� �������� 
            end loop;  -- k
            -- � ������� �������� ����� ������
            If oo.NLSA is not Null then 
               oo.REF  := null     ;
               oo.vdat := gl.bdate ; 
               oo.dk   := 1 -oo.DK ;
               oo.S    := -A36.OSTF;
               oo.S2   := oo.S     ;      
               oo.Nazn := Substr( '��������� ���������i� ���.���i�i� �� ���.� '|| dd.cc_id ||' �i� ' || to_date( dd.sdate, 'dd.mm.yyyy') || ' � ��`���� � ����������� ��������� �����' , 1, 160) ;
               OVRN.OPL1 (oo)      ; -- �������
            end if;
         end loop;  -- a36 
     end ;
  end if ;

  -- 2) ������� �������� �� ----- 1) ��������� ���� �������� ������ :
  FOR A26 IN (SELECT * FROM ACCOUNTS WHERE ACCC = A8.ACC  AND ACC IN (SELECT ACC FROM ND_ACC WHERE ND = DD.ND) )
  loop If a26.ostc > 0 then
          OVRN.BG1 ( 1, 1, gl.bdate, dd, a26,a26 ) ;
       end if;
  end loop ;

  -- ���-�� ���-���� �������� �������
  begin select a.* into AA  from accounts  a, nd_acc n
        where a.acc=n.acc and n.nd = dd.nd and a.nbs in (SB_2067.R020 ,SB_2069.R020,'2607') and a.tip in ('SP ', 'SPN', 'SN ' ) and a.ostc <0 and rownum =1;
        l_txt := ' �� ������� ! �� �������� ������.'|| aa.nls ||'*'|| aa.tip ||' ' ||aa.ostc/100 ;
        goto RET;
  EXCEPTION  WHEN NO_DATA_FOUND THEN null ;
  end;

  ---- �������� ��� �����������,  ��������� - ������ ����, ���� �������� ��� ����������� �������� � �� ������ ���. ��� , ��������, �� �����-�� ������ ?
  for k in (select az.kv, aZ.acc, az.ostc, az.rnk, min(z.accs) accs
            from accounts aZ, cc_accp Z
            where Z.acc = az.acc and not exists (select 1 from cc_accp where acc = AZ.acc and nvl(nd,0) <> dd.ND )
            group by  az.kv, aZ.acc, az.ostc, az.rnk
           )
  loop If k.ostc<>0 then
        OVRN.PUL_OVR(2, dd.ND, k.accs ) ;
        P_ADD_ZAl     (  null,   null,  null, null, k.ACC, k.kv, null, - ABS(k.ostc)/100, null, null, null, null, null, null, null);
------- P_ADD_ZAl     ( dd.ND, k.accs, k.rnk, null, k.ACC, k.kv, null, - ABS(k.ostc)/100, null, null, null, null, null, null, null);
       end if;
       update accounts set dazs = l_bDat_Next where acc = k.ACC;
  end loop;


  -- ������ ������� � �������� ���. ��������� � �������� �������� .    ������� ����� ���������� ���������
  for k in (select * from accounts   where acc in (select acc from nd_acc where nd = dd.nd)  and dazs is null      )
  loop 
     If    k.nbs in ('2600','2650','2602','2603','2604')     then  update accounts set lim = 0, accc = null where acc = k.ACC;  -- ��� �� � 2017 �� ��������
                                                                   update accounts set ostc = ostc - k.ostc where acc = k.accc;
     elsIf k.nbs in ('2608','2658')                          then  null;                                                        -- ��� �� � 2017 �� ��������
     elsIf k.tip in ('OVN')                                  then  update accounts set dazs = l_bDat_Next where acc = k.ACC; 
     elsIf k.tip in ('SN ') and k.ostc =0                    then  update accounts set dazs = l_bDat_Next where acc = k.ACC; 

     elsIf k.nbs ='9129' and k.ostc < 0 then  -- ��������
           oo.nlsb := BRANCH_USR.GET_BRANCH_PARAM2('NLS_9900',0) ;  oo.kv := k.KV       ;    oo.tt := 'CR9';
           oo.s    := -k.ostc ;   oo.nlsa := k.nls;    oo.nam_a  := substr( k.nms,1,38) ;    oo.dk := 0    ;  oo.ref   := null;    
           oo.nazn := Substr ( '��������� �������� ���������� ����� �� ����������� ��. ���. �'||dd.cc_id||' �i� '||TO_CHAR (dd.sdate,'dd.mm.yyyy')||'�.', 1, 160 );
           OVRN.opl1(oo) ;   gl.pay (2, oo.ref, oo.vdat);
           update accounts set dazs = l_bDat_Next where acc = k.ACC;

     Elsif k.ostc <> 0               then  raise_application_error(g_errn,'���.'||k.nls ||' �� �������='|| k.ostc/100 );  
     else                                  update accounts set dazs = l_bDat_Next where acc = k.ACC;
     end if ;
  end loop;

--update cc_deal set sos = 15 where nd = dd.nd;
  OVRN.NEW_SOS (p_ND=> dd.nd, p_sos => 15);
  l_txt := ' ������� !';
  -------------------
  <<RET>> null;
  ---  �������� �����������
  l_Txt := '���.���. � '||dd.cc_id||' �� '|| to_char (dd.sdate, 'dd.mm.yyyy')|| ' ���='||dd.ND || ' '|| l_txt;
  if getglobaloption ('BMS') = '1'  then -- BMS �������: 1-����������� �������� ���������
     bms.enqueue_msg( l_Txt, dbms_aq.no_delay, dbms_aq.never, dd.user_id );
  end if;
  bars_audit.info( 'OVRN=>BMS:'|| l_txt );
  OVRN.isob  (p_nd => dd.ND, p_sob => l_txt );
  RETURN;
end CLS;

procedure ins_110 (d_nd number, p_acc26 number, p_acc number, u_nd IN OUT number) is   -- �������� � ND_ACC ��� ������ � ����� 110  �� ����� ����� � ����� 10
  uu cc_deal%rowtype   ;
  aa accounts %rowtype ;
  l_ok int ;
begin

  -- ���������,  � ���� �� ���� ���� ��� � ����� 110 ?
  begin select 1  into l_ok
        from nd_acc n , cc_deal d10,   cc_deal d110
        where n.acc = p_acc and n.nd = d110.nd  and d110.vidd = 110
          and d110.ndi = d10.nd  and d10.sos <15 ;
        RETURN ;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end ;

  If p_acc26 = p_acc then
     -- ������� ����� ��� � ����� 110, �.�. ��� ����� ��������
     begin select * into uu from cc_deal  where nd  = d_nd   ;
           select * into aa from accounts where acc = p_acc26;
     EXCEPTION WHEN NO_DATA_FOUND THEN
           raise_application_error(g_errn,'�� ������� ���.���(10)='||d_nd ||' ��� acc_2600=' || p_acc26 );
     end   ;

     uu.ndi   := d_ND   ;
     uu.rnk   := aa.rnk ;
     uu.nd    := bars_sqnc.get_nextval('s_cc_deal') ; --- s_cc_deal.NEXTVAL ;
     uu.cc_id := uu.CC_ID||'/'||aa.nls;
     uu.vidd  := 110    ;
     INSERT INTO cc_deal values uu;
     u_ND     := uu.nd  ;
  else
     select min(d.nd) into u_nd from cc_deal d, nd_acc n where d.vidd =110 and d.nd = n.nd and  n.acc = p_acc26 ;
     If  u_nd is null then raise_application_error(g_errn,'�� ������� ���.���(110) ��� acc_2600=' || p_acc26 )  ; end if ;
  end if ;

  begin insert into nd_acc (nd,acc) values (u_ND, p_acc );
  exception when dup_val_on_index then null;
  end  ;

  ---------------------------------------------------
end ins_110;

procedure isob    (p_nd number, p_sob varchar2) is  -- ����������� �������
begin  INSERT INTO cc_sob (ND,FDAT,ISP,TXT,otm) VALUES    (p_ND, gl.bDATE, gl.aUid, p_sob, 6 );
end isob;
-----------------------------------------------------------------------------------------
procedure ADD_ACC   ( p_mode int, p_acc number, p_acc_add number) is
begin
If    p_mode = 1 then  --��������
    begin
      delete from OVR_ACC_ADD  where acc = p_acc   and  acc_add = p_acc_add ;
    exception when no_data_found then null;
    end;
elsif p_mode = 2 then  -- ����������
    begin
      insert into OVR_ACC_ADD values (p_acc, p_acc_add);
    exception when dup_val_on_index then null;
    end;
end if;

end ADD_ACC ;
---====================================================================
function TIP  return varchar2 is begin  return 'OVN'       ; end TIP   ;
function VIDD return number   is begin  return   10        ; end vidd  ; ---- <<���i������>> �����
function VID1 return number   is begin  return  110        ; end vid1  ; ---- ���.��� <<���i������>> �����
function TAG  return varchar2 is begin  return 'TERM_OVR'  ; end TAG   ;  --- TERM_OVR  ����i� ������������� ���, �i�.��i�
function TAGD return varchar2 is begin  return 'TERM_DAY'  ; end TAGD  ;  --- TERM_DAY  �����(���� ��) ��� ������ %%'
function TAGT return varchar2 is begin  return 'TERM_TRZ'  ; end tagT  ;  --- ����i� �i������� ��������� �� ��������� �i�.��i�
function TAGC return varchar2 is begin  return 'PCR_CHKO'  ; end TAGC  ;  --- ����i� �i�i�� (% �i� ���)
function TAGK return varchar2 is begin  return 'NEW_KL'    ; end TAGK  ;  --- ������� "��� ��"
function TAGN return varchar2 is begin  return 'DONOR'     ; end TAGN  ;  --- ������� ������
function TAGS return varchar2 is begin  return 'STOP_O'    ; end TAGS  ;  --- <<����>> ��� ����
function F2017 return int     is begin  RETURN OVRN.G_2017 ; end F2017 ; -- ���� ����������� (=1) ��� �� ����������� �������������-2017 �� �������� �� ����� ���� ������
----------------------------------------------------------------------
function header_version return varchar2 is begin  return 'Package header OVRN '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body OVRN '  ||G_BODY_VERSION  ; end body_version;
-----------------------------------------------------------------------------------------
procedure repl_acc (p_nd number, p_old_acc number, p_new_kv int, p_new_nls varchar2) is
  oo accounts%rowtype; dd cc_deal%rowtype;
  nn accounts%rowtype;
  g_errN  number      := -20203 ;
  g_errS  varchar2(5) := 'OVRN:';

begin

  begin select *    into dd    from cc_deal    where   nd  = p_ND and vidd   =  10 ;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(g_errn, g_errS||'�� �������� �����='||p_ND )  ;
  end ;

  begin select * into oo from accounts where acc = p_old_acc;
  EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||'�� �������� ������ ���. ( ��� = '||p_old_acc|| ')'  )  ;
  end;

  begin select * into nn from accounts where kv = p_new_kv and nls = p_new_nls;
  EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||'�� �������� ����� ���.: ��� = '||p_new_kv || ', ��� = '||p_new_nls )  ;
  end;

  If  oo.rnk <> nn.rnk then      raise_application_error(g_errn, g_errS||'�� c��������� ��� ������� �� ������ ���.' )  ;    end if;
  -----------------------

  -- ������� ������ �� ����� ����� 
  for  kk in (select * from ACC_TARIF  where  acc = oo.acc and kod in (141,142,143,144,145,146))
  loop kk.acc := nn.acc; insert into ACC_TARIF values  kk; end loop;
  --delete from ACC_TARIF    where  acc = oo.acc and kod in (141,142,143,144,145,146); -- ������

  -- ������� ���.���� �� ����� �����  
  for  kk in (select * from accountsW  where  acc = oo.acc  and tag in ('TERM_LIM', 'TERM_OVR', 'TERM_DAY', 'PCR_CHKO', 'NEW_KL', 'DONOR', 'STOP_O', 'DT_SOS', 'NOT_DS' ))
  loop kk.acc := nn.acc; insert into accountsW values  kk; end loop;
  --delete from accountsW    where  acc = oo.acc  and tag in ('TERM_LIM', 'TERM_OVR', 'TERM_DAY', 'PCR_CHKO', 'NEW_KL', 'DONOR', 'STOP_O', 'DT_SOS', 'NOT_DS' ); --���.���� �����

  -- ������� ������ ������ �� ����� �����     
  for  kk in (select * from OVR_REP_ZAG where  acc = oo.acc  )
  loop kk.acc := nn.acc; insert into OVR_REP_ZAG values  kk; end loop;
  --delete from OVR_REP_ZAG  where  acc = oo.acc ;         -- ������ ������

  -- ������� ������ �� ����� �����    
  for  kk in (select * from OVR_LIM where  acc = oo.acc and nd = dd.nd  )
  loop kk.acc := nn.acc; insert into OVR_LIM  values  kk; end loop;
  --delete from OVR_LIM      where  acc = oo.acc  ;

  -- ������� ���������� ������ �� ����� �����    
  for  kk in (select * from OVR_LIM_DOG where  acc = oo.acc and nd = dd.nd )
  loop kk.acc := nn.acc; insert into OVR_LIM_DOG  values  kk; end loop;
  --delete from OVR_LIM_DOG    where  acc = oo.acc  ;

  -- ������� �����  ��� �� ����� �����    
  for  kk in (select * from OVR_CHKO where  acc = oo.acc )
  loop kk.acc := nn.acc; insert into OVR_CHKO  values  kk; end loop;
  --delete from OVR_CHKO     where  acc = oo.acc  ;     --�����  ���
  --delete from OVR_CHKO_det where  acc = a26.acc ;    --������ ���

  -- ������� ������.���� �� ����� �����    
  for  kk in (select * from OVR_TERM_TRZ where  oo.acc in (acc, acc1) )
  loop If kk.acc = oo.acc then kk.acc  := nn.acc;
       else                    kk.acc1 := nn.acc;
       end if;
       insert into OVR_TERM_TRZ values  kk;
  end loop;

  -- ������� ����.��������-��� �� ����� �����    
  for  kk in (select * from int_accn where  acc = oo.acc and id = 0 )
  loop kk.acc := nn.acc; insert into int_accn values  kk; end loop;
  --delete from int_accn     where  acc = a26.acc  and bdat >= dd.SDATE;

  -- ������� ����.������-��� �� ����� �����    
  for  kk in (select * from int_ratn where  acc = oo.acc and id = 0 )
  loop kk.acc := nn.acc; insert into int_ratn values  kk; end loop;
  --delete from int_ratn     where  acc = a26.acc  and bdat >= dd.SDATE;

  -- �������� �� �������� ������ ���� � ��������� ����� ����
  for  kk in (select n.* from nd_acc n, cc_deal d where d.vidd in (10,110) and d.nd = n.nd and n.acc = oo.acc )
  loop delete from nd_acc where  nd = kk.nd and acc = kk.acc;
       kk.acc := nn.acc;
       insert into nd_acc values kk;
  end loop;

  --���������� ������ ����� ���� �� ��������, ��� ��� � ������� �����
  update accounts aa set aa.accc = oo.accc where acc = nn.acc;

  --�������� ������ ���� �� ��������,  �������� ��� �����
  update accounts aa set aa.accc = null, lim = 0  where acc = oo.acc;

  --����������� ���� �������� � ������ ����� ������ 
  update accounts aa set aa.ostc = ( select sum(ostc) from accounts where accc = aa.acc) ,
                         aa.ostb = ( select sum(ostb) from accounts where accc = aa.acc)
         where acc = oo.accc;

  OVRN.isob  (p_nd => p_ND, p_sob => 'Del:REPL acc:'|| oo.nls||'->'||nn.nls );

end repl_acc;

---��������� ���� --------------
begin
 G_TIP  := 'OVN'      ; PUL.Set_Mas_Ini('G_TIP' , 'OVN'     , '���.���.��� ��� 8998*OVN'  );
 G_VIDD := 10         ; PUL.Set_Mas_Ini('G_VIDD', '10'      , '���.���.��� ���/�����'     );
 G_VID1 := 110        ; PUL.Set_Mas_Ini('G_VID1', '110'     , '���.���.��� ���/�����'     );
 G_TAG  := 'TERM_OVR' ; PUL.Set_Mas_Ini('G_TAG' , 'TERM_OVR', '���.���.����i� ���'        ); -- ����i� ������������� ���, �i�.��i�
 G_TAGD := 'TERM_DAY' ; PUL.Set_Mas_Ini('G_TAGD', 'TERM_DAY', '���.���.���� ��� ������ %%'); -- ����i�(���� �i�) ��� ������ %%
 G_TAGC := 'PCR_CHKO' ; PUL.Set_Mas_Ini('G_TAGC', 'PCR_CHKO', '���.���.����.�i�(%  ���)'  ); -- ����i� �i�i�� (% �i� ���)
 G_TAGK := 'NEW_KL'   ; PUL.Set_Mas_Ini('G_TAGK', 'NEW_KL'  , '���.���.������� "���" ��'  ); -- ������� "���" ��
 G_TAGN := 'DONOR'    ; PUL.Set_Mas_Ini('G_TAGN', 'DONOR'   , '���.���.������� ������'    ); -- ������� ������
 G_TAGS := 'STOP_O'   ; PUL.Set_Mas_Ini('G_TAGS', 'STOP_O'  , '���.���.<<����>> ��� ����' ); -- <<����>> ��� ����



 begin select 0 into OVRN.G_2017 from SB_OB22  where         r020  = '2067'      and ob22  = '01'   and d_close is null ;
       SB_2067.R020 := '2067';   SB_2067.OB22 := '01' ; -- �������������� ������� � ������� ��������
       SB_2069.R020 := '2069';   SB_2069.OB22 := '04' ; -- ���������� ��������� ������ �� ����������������� ��������� � ������� ��������
       SB_6020.R020 := '6020';   SB_6020.ob22 := '06' ; -- �� ��������� �뢿��� ����� �� ����������� � ����������� ����� (������� 2600)
       SB_6111.R020 := '6111';   SB_6111.ob22 := '05' ; -- �� ������������� �������, ������� ��������� ������ �� ����� ���`����� ������������ ��������
 EXCEPTION WHEN NO_DATA_FOUND THEN OVRN.G_2017 := 1;  
       SB_2067.R020 := '2063';   SB_2067.OB22 := '33' ; -- �������������� ������� � ������� ��������                                     
       SB_2069.R020 := '2068';   SB_2069.OB22 := '46' ; -- ���������� ��������� ������ �� ����������������� ��������� � ������� ��������
       SB_6020.R020 := '6020';   SB_6020.ob22 := '06' ; -- �� ��������� �뢿��� ����� �� ����������� � ����������� ����� (������� 2600)
       SB_6111.R020 := '6511';   SB_6111.ob22 := '05' ; -- �� ������������� �������, ������� ��������� ������ �� ����� ���`����� ������������ ��������

 end ;

END ovrn;
/
