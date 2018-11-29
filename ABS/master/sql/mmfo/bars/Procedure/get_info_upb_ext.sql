

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_INFO_UPB_EXT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_INFO_UPB_EXT ***

  CREATE OR REPLACE PROCEDURE BARS.GET_INFO_UPB_EXT /*  ��� ��������� ��� �� �� */
 ( CC_ID_  IN  varchar2, -- �������������   ��
   DAT1_   IN  date    , -- ���� �����      ��
   nRet_   OUT int     , -- ��� ��������: =1 �� ������, ������ =0
   sRet_   OUT varchar2, -- ����� ������ (?)
   RNK_    OUT int     , -- ��� � ��������
   nS_     OUT number  , -- ����� �������� �������
   nS1_    OUT number  , -- ����� �������������� �������
   NMK_    OUT varchar2, -- ������������ �������
   OKPO_   OUT varchar2, -- OKPO         �������
   ADRES_  OUT varchar2, -- �����        �������
   KV_     IN OUT int  , -- ��� ������   ��
   LCV_    OUT varchar2, -- ISO ������   ��
   NAMEV_  OUT varchar2, -- �����a       ��
   UNIT_   OUT varchar2, -- ���.������   ��
   GENDER_ OUT varchar2, -- ��� ������   ��
   nSS_    OUT number  , -- ���.����� ���.�����
   DAT4_   OUT date    , --\ ���� ���������� ��
   nSS1_   OUT number  , --/ �����.����� ���.�����
   DAT_SN_ OUT date    , --\ �� ����� ���� ��� %
   nSN_    OUT number  , --/ ����� ��� %
   nSN1_   OUT number  ,-- | �����.����� ����.�����
   DAT_SK_ OUT date    , --\ �� ����� ���� ��� ���
   nSK_    OUT number  , --/ ����� ��� ����������� ��������
   nSK1_   OUT number  , --| �����.����� �����.�����
   KV_KOM_ OUT int     , -- ��� ��������
   DAT_SP_ OUT date    , -- �� ����� ���� ��� ����
   nSP_    OUT number  , -- ����� ��� ����������� ����
   KV_SN8  OUT int     , -- ������ ����
   SN8_NLS OUT varchar2, --\
   SD8_NLS OUT varchar2, --/ ����� ���������� ����
   MFOK_   OUT varchar2, --\
   NLSK_   out varchar2,  --/ ���� �������
   nSSP_   OUT number  , --\ ����� ������������� ����
   nSSPN_  OUT number  , --\ ����� ������������ ���������
   nSSPK_  OUT number  , --\ �����  ������������ ��������
   sAddInfo_   OUT varchar2,   --\ �������������� ����������

--   DAT_och OUT date    ,  -- ��������� ���� �������
--   SUM_och OUT number     -- ��������� ����� �������
   LocalBD_ IN date default  gl.bd -- ����, �� ������� ����� �������� ���������� �� ��
) IS

-- ver 3.39

/*
   21-11-2018  LitvinSO ��������� �� ���� ����� ��� 2620, ����� �������� �������� �� ������ ���������
   25-10-2016  ������� ������ � ������ �� ��� �����. ����.  ����� 8999  ��� �� �� ������ ��
   02-04-2015  ������ ��������� ���������  CCK.INT_METR_A � ������ ����������
   26-02-2015  �������� �� ������� ��������� �� ���� ��������� , � �� �� ������������ ���
   04-02-2015  ��������� �� ������� ��������

   05-08-2014  ������� �� ������� ��������� ����, �� ������� ����� �������� ���������� �� ��, ������ ���� �� ���������� ����.


   03-12-2013  ������� ���� � ����� �������������� ������� ��� ��������� �� 2620
   10-06-2013  ��������� ��������� �� �� ������ 2620 ���� ������� ������������ � ������ ��
   05-03-2013  ������� ��������� ������ : ���� ������������� ��� ������ ��� ������� 7, �����:

               ���.�7 �� � ��� �������� ���_���� ������_� ����������� �_�����_� (SPN)!
               ���.�8.�� � ��� ���������� ������� ��������� ������ �������� �� �����_������� ��� �����_������ �������!

   04-01-2013  ������� ������ 3600 ������ ��� �������� ������
   26-12-2011  �� ��������� ������ ������ � ������ �� ������������ �������
               ��� ��� �� � ��� ��������� ������� ����� � ����������� ������ ��� �����
   21-12-2011  ���� ��������� � ����� � ���������� � ���� ����� �������� � ����� metr=0
   02-12-2011  ������� ������� ����������� ���������� �������  (������ ���������� ��������� ���� ������ �� ������ ���
               ������ ������������� � ������ ��� ������ ) ���� ��� � 11 ������ ��� ����� -  31.10.2011 ����  03.12.2011
               ���� � ��������� ��������� ������ 'SP'
   30-11-2011  �������� ����������� ��������� CC_DAY_D ����������� ���������� �������
               ��� ���������� �� 3600 �� ������������ ���� ������ ������������ ����
               ��� �� ���� ��������� �� ���� ������������ ������
   09-08-2011  ��� ������ ������ �� ����������� ����� �� ����� ���������  nSS_SK4. ����-��  ������-�� �����  ���������� ��.
               ��� ��������� ��������� �� �����
   14-07-2011  ��� ���������� ��������� ��������� ������� �� 3600 (������ � ����������� c ������-�� %) (�� ����)
   07-06-2011  ��� CCK_PAY_I=1 ���������� ������ ��� 3600 (��� ��� �������)
               �� ��� ���������� ���������� �� 31 ���-�� ��������� ���-��.
                 CCK_PAY_I=2 �������� �� 31 ���-�� ��������� ���-��.
   04-04-2011  ���������� ������ ��������� � ������-�� ��� � �� �� ����������,
               � ����� ���������� ����� �� 3600 �� ������� ����

   23-12-2010  �� ���������� ����� ��������� ������ �������� �������������
                �� ����������� ������ ������ ��� �������������� ������ (���������� ��������)
   10-10-2-2010 ���������� ������ � ����������� ��������� ��� ��������� ��������� ���
                ������� ����� ������������ ���� ��������� ���������� ���������
   03-09-2010  ����� ����� ������� ����� ��������� ��������� ����������
               ������������ ����� �������� CCK_PAY_S  0-���������� 1-�������������
               SD4 - ������������ ��� � �� ���� � ������� ���� cc_o_nls
   22-06-2010  ��� ������������ ����� ����������� ������ � ���
   11-05-2010  ���� �� ������������ ��� ������ ���� � �� ������ ������ SP, SPN
   23-04-2010  ����������� ����������� ����� �������� �������
   01-03-2010  ���� ������� ����� ���� � ������ ������
               ���� ����� ���� � ������ ������
               ��������� ���� KV_SN8

   23-02-09 ����� ������ SPN
   06-01-09 ������� ����� � ����� ���.
            ������ ��������� cck.GET_INFO,  �� � ������������� ��� - ���������
*/
  tip_SN   int:=1; -- 0 UPB   �������� ��������
                   -- 1 SBER  �������� ��������


                    -- 0 - ������ �� ����������� ������� �� �����
                    -- 1 - ����������� ������ ��� ����������� ���������
                    -- 2 - ����������� ������ �� ���������� ���
  CC_PAY_I int:= NVL( GetGlobalOption('CC_PAY_I'),'0'); -- ����������� ���� ��� ���
  CC_PAY_S int:= NVL( GetGlobalOption('CC_PAY_S'),'0'); -- 0 -������� ����� ��������� ���������� ���  ��������� �����������
                                                        --    ������� ����� ��� ����� ������� ������ ( ���������� ����������)
                                                        -- 1- ������� ����� ��������� � ������ ��� ���������� ����� ��
                                                        --    ��������� ���������  (�������������)
                                                        -- � ������ �� ����� �������� � �������� �������
  CC_PAY_D int:= to_number(GetGlobalOption('CC_PAY_D'));
  CC_DAYNP  number ;
  --����������
  ND_     cc_deal.ND%type   ;
  l_ccid  cc_deal.CC_ID%type;
  l_limit cc_deal.LIMIT%type;
  ACC8_   accounts.ACC%type ;
  VID_    accounts.VID%type ;
  l_flags varchar2(2)   ;
  nInt_   number            ;
  ratn_advanced number:=0   ;
  nSK4          number:=0   ;
  del_SK4       number:=0   ; -- ������ ���������� ��������� (��� �������������� ������ CCK_PAY_S=1)
  nSS_SK4       number:=0   ;

  nISG          number:=0   ; -- ����� ������� ��������� �� 3600
  nInt_ISG      number:=0   ; --  �������������� �������
  day_pog_SN    number;   -- ����


  -- ������ ������� cc_lim ������ � �������� ��� ������
 -- ������ � ���
 type t_lim  is record
  (
  ND        NUMBER(10),
  FDAT      DATE,
  LIM2      NUMBER(38,2),
  ACC       INTEGER,
  NOT_9129  INTEGER,
  SUMG      NUMBER(38,2),
  SUMO      NUMBER(38,2),
  OTM       INTEGER,
  KF        VARCHAR2(6 BYTE),
  SUMK      NUMBER (38,2),
  NOT_SN    INTEGER

  );

  rLim t_lim; -- ������ ��� �� ������ ��������� ������


  DAT_SN1_ date := LocalBD_-1;
  DAT_SK1_ date := LocalBD_-1;
  DAT_och date ;
 l_ost NUMBER(38,2);
  NLS_SG_980 varchar2(15);
  NLS_6110   varchar2(15); -- ���� ��� �� ���� ���������
  NLS_ISG   varchar2(15); -- ���� ��� ������� �� ������� ������

begin

     logger.trace ('GET_INFO_UPB_EXT: Start ');
nRet_:= 1; sRet_:='?'; l_ccid:=trim(CC_ID_); PUL.Set_Mas_Ini('CC_ID','', '� ��');

 -- CC_PAY_D ���������� ����� ��� ������ ��������� ��� ��� <> �������� ��
 if CC_PAY_D<1 or CC_PAY_D>31 or substr(NLSK_,1,4)='2620' then
    CC_PAY_D:=null;
 end if;

-------����� ��, ���.��  � �������
If KV_ is null then
   begin
      --1. ������ � ��� !
      SELECT d.nd, a.KV
      INTO    ND_, KV_
      FROM cc_deal d, cc_add a
      WHERE d.ND   = a.ND   and d.sos>9 and d.sos<15
        and d.cc_id= l_ccid and d.SDATE = DAT1_ and d.vidd in (11,12,13);
      -- ������������, ����� ����������, ��� ������
   EXCEPTION
   WHEN Too_Many_Rows THEN
        -- ����� ��������, �.�. ��������� ? ����������� ��� ���
        sRet_:='���. �1 �� �'||l_ccid||' �� ����. ������� '||l_ccid ||'/���'; RETURN;
   WHEN NO_DATA_FOUND THEN
        -- �� �����, �.�. �� ��� � ����� ��� ? ������ �� � �������� �����.
        begin
           KV_   := to_number(substr(l_ccid,-3));
           l_ccid:= substr(l_ccid,1,length(l_ccid)-4);
        EXCEPTION  WHEN OTHERS THEN
           sRet_ :='���. �2 �� �'||l_ccid||' �� �������� !'; RETURN;
        end;
   end;
end if;
--============== ��� ������ ��� ��������  ================
begin
   SELECT d.nd ,d.wdate ,c.NMK ,c.okpo   ,c.rnk  , c.ADR , d.limit, cck_app.get_nd_txt(ND_,'FLAGS'),
          t.LCV,t.NAME  ,t.UNIT,t.GENDER ,a.acc  , a.kf  , d.RNK, a.vid,
          (case when nvl((select to_number(substr(txt,2,1)) from nd_txt
                           where nd=d.nd and tag='FLAGS'),0)=1
                     and CC_PAY_I=2
               then  1
               else CC_PAY_I end)
   INTO     ND_,  DAT4_ ,  NMK_,  OKPO_  ,  RNK_ , ADRES_, l_Limit, l_flags,
           LCV_,  NAMEV_, UNIT_,  GENDER_,  ACC8_, MFOK_ ,   RNK_,  VID_,
           CC_PAY_I
   FROM cc_deal d, customer c, tabval t, accounts a, nd_acc nd
   WHERE a.KV  = t.KV      and d.sos   > 9       and d.sos   < 15
     and d.rnk   = c.rnk   and a.KV    = KV_
     and d.cc_id = l_ccid  and d.SDATE = DAT1_ and d.nd = nd.nd
     and nd.acc = a.acc and a.tip = 'LIM'  and d.vidd in (11,12,13);
EXCEPTION
WHEN Too_Many_Rows THEN
     sRet_ :='���. �3.�� �'||l_ccid||' �������� �� ����������!'; RETURN;
WHEN NO_DATA_FOUND THEN
     sRet_ :='���. �4 �� �'||l_ccid||' �� �������� !';  RETURN;
end;
------------------------------
   logger.trace ('GET_INFO_UPB_EXT: ND='||ND_||' CC_PAY_I='||to_char(CC_PAY_I)||' CC_PAY_S='||to_char(CC_PAY_S) );

CC_DAYNP:= CCK_APP.GET_ND_TXT(ND_,'DAYNP');
 if nvl(CC_DAYNP,0)=0 then
     CC_DAYNP:= to_number(NVL( GetGlobalOption('CC_DAYNP'),'1'));
 end if;
--����� ���� �������
 begin
   -- 10-06-2013 ������ ����� �� 2620, ������� �������� � ��������
   SELECT a.nls,a.ostc/100
   into NLSK_,l_ost
   from nd_acc n, accounts a where n.nd=ND_
   and a.NBS='2620' and a.TIP = 'DEP' and a.kv=KV_ and n.acc=a.acc and a.dazs is null;
     CC_DAYNP:=-2;  -- ��� ����� ���������� ������� ��������
     CC_PAY_D:=null; -- ��� ����� ���������� ������� ����������������� ���� ������ ��������� ����
  EXCEPTION
  WHEN Too_Many_Rows THEN
    sRet_ :='���. �6.1.�� �'||l_ccid||' �������� ������� ������� ��������� 2620!';
    RETURN;
  WHEN NO_DATA_FOUND THEN
   Begin
    SELECT a.nls,greatest(a.ostc,a.ostb)/100
      into NLSK_,l_ost
      from nd_acc n, accounts a  where n.nd=ND_
           and a.tip='SG ' and a.kv=KV_ and n.acc=a.acc and a.dazs is null;
      if l_ost>0 then
            sRet_ :='��� �8.�� �'||l_ccid||' ���������� ������� ��������� ������ �������� �� ������������ ��� ����������� �������!'
                 ;-- ||'��������� �� ���������� ���������� �����!' ;
         RETURN;
      end if;
EXCEPTION
WHEN NO_DATA_FOUND THEN null;
  sRet_ :='���. �5.�� �'||l_ccid||' �� �������� ������� ��������� (SG) !';
  RETURN;
WHEN Too_Many_Rows THEN
 sRet_ :='���. �6.0.�� �'||l_ccid||' �������� ������� ������� ��������� (SG) !';
  RETURN;
 end;
end;

-- �� ����� ���� ��� % ? */
SELECT max(i.acr_dat) into DAT_SN_
FROM accounts a, nd_acc n, int_accn i
WHERE n.nd=ND_ and n.acc=a.acc and a.tip in ('SS ','SP ','SL ')
  and i.id=0   and a.acc=i.acc and i.acr_dat is not null;


nSK_:= 0;
 begin
   -- �� ����� ���� ��� ��� ?
   SELECT acr_dat into DAT_SK_ FROM int_accn WHERE acc=ACC8_ and id=2;

     -- ������ ������ ��������. ���� ���� ���� � ���������� ��������
     -- �� ������ ���� � ������ ������ ������ ��������
     -- (� ���������� �������� ����� �������������� ���� SK9)

    SELECT kv
      INTO KV_KOM_
      from
       (
        select a.kv kv
          FROM accounts a, nd_acc n
         WHERE n.nd=ND_ and n.acc=a.acc and a.tip in ('SK0','SK9')
         order by a.tip desc,a.ostb+a.ostf,decode (a.kv,kv_,0,1)
       ) where rownum<2;

     -- �������� ����� � ������ �� �� ���������� ��� ������ � ���.
     -- ��� �� ��������� �������� � ������� � ������ ������
     -- ����� ������ ��� ����� � ���� ��� � � ����. ��������
     if KV_KOM_<>KV_ or KV_KOM_<> gl.baseval  then
        SELECT
               Nvl(-min(decode(a.tip,'SK0',ostb+ostf,0)),0)/100 SK0_OST,
               Nvl(-min(decode(a.tip,'SK9',ostb+ostf,0)),0)/100 SK9_OST

          INTO nSK_,nSSPK_
          FROM accounts a, nd_acc n
         WHERE n.nd=ND_ and n.acc=a.acc and
               a.tip in ('SK0','SK9') and a.kv=KV_KOM_;

         nSK_:=nvl(nSK_,0)+nvl(nSSPK_,0);
     else
        SELECT
               Nvl(-SUM(a.ostb+a.ostf),0)/100 SK0_OST,
               Nvl(-SUM(decode(a.tip,'SK9',ostb+ostf,0)),0)/100 SK9_OST
          INTO  nSK_ ,nSSPK_
          FROM accounts a, nd_acc n
            WHERE n.nd=ND_ and n.acc=a.acc and
                  a.tip in ('SK0','SK9') and a.kv=KV_;
     end if;

     -- ���� �������� � �������� � ������ ���� ���� ���� ������� � ������
     if KV_KOM_!=gl.baseval and nSK_>0 then
       begin
         SELECT a.nls
           into NLS_SG_980
           from nd_acc n, accounts a  where n.nd=ND_
                and a.tip='SG ' and a.kv=gl.baseval and n.acc=a.acc
                and a.dazs is null and rownum=1;
       EXCEPTION
       WHEN NO_DATA_FOUND THEN null;
         sRet_ :='��� �5.1.�� �'||l_ccid||' �� �������� ������� ��������� (SG) � ����������� �����!';
         RETURN;
       end;
     end if;



 EXCEPTION WHEN NO_DATA_FOUND THEN
 nSSPK_:=0; nSK_:=0; KV_KOM_:=KV_;
 end;

 nSP_:= 0;
 begin
  -- �� ����� ���� ��� ����
  SELECT Nvl(i.acr_dat,a.daos-1),
         a8.NLS,
         a8.kv ,
         a6.NLS,
         -(a8.ostb+a8.ostf)/100
  INTO DAT_SP_, SN8_NLS, KV_SN8,SD8_NLS, nSP_
  FROM accounts a, nd_acc n, int_accn i, accounts a8, accounts a6
  WHERE n.nd=ND_ and n.acc=a.acc and a.tip in ( 'SPN','SP ','SK9' )
    and a.dazs is null
    and i.id=2 and a.acc=i.acc and i.acrA=a8.acc and i.acrB=a6.acc
    and a8.ostc<0
    and rownum=1;
 EXCEPTION
  WHEN NO_DATA_FOUND THEN null;
       -- ��� ������ �������� ����� ��� ����� �������
     if DAT4_<=LocalBD_ then
        begin
            SELECT LocalBD_,
                   a.NLS,
                   a.kv ,
                   null,
                   -(a.ostb+a.ostf)/100
            INTO DAT_SP_, SN8_NLS, KV_SN8,SD8_NLS, nSP_
            FROM accounts a, nd_acc n
            WHERE n.nd=ND_ and n.acc=a.acc and a.tip in ('SN8')
              and a.dazs is null and a.ostc<0 and rownum=1;
        EXCEPTION
         WHEN NO_DATA_FOUND THEN
         null;
        end;
     end if;

  WHEN Too_Many_Rows THEN
    sRet_ :='���. �7 �� �'||l_ccid||' �������� ������� ������� ����������� ������� (SPN)!'; RETURN;
 end;

-- ����� ��������������

-- 1)���������� ����������� %
SELECT Nvl(-SUM(ostb+ostf),0)/100,
       Nvl(-SUM(decode(a.tip,'SN ',0,ostb+ostf)),0)/100
INTO  nSN_, nSSPN_
FROM accounts a, nd_acc n
WHERE n.nd=ND_ and n.acc=a.acc and a.tip in ('SN ','SPN','SLN')
      and a.kv=KV_;

nSN1_:=nSN_;
-- 2)����� ������������� �� ����
  -- ����� ��������� �� ����
/*
-- ����������� ����� 2 ������ � ���� ��������
select -(ostb+ostf)/100
--, (ostx-(ostb+ostf))/100
into nSS1_
--, nLim_
from accounts where acc=ACC8_;
*/


  -- ������� �� �������� � ������� �� ������������ ������
 begin
  SELECT Nvl(-SUM(a.ostb+a.ostf),0)/100,
         Nvl(-SUM(decode(a.tip,'SS ',0,a.ostb+a.ostf)),0)/100
    INTO  nSS1_,nSSP_
    FROM accounts a, nd_acc n
   WHERE n.nd=ND_ and n.acc=a.acc and a.tip in ('SS ','SP ','SL ')
         and a.kv=KV_;
 exception when no_data_found then
  nSS1_:=0; nSSP_:=0;
 end;

-- ���� ��������� ��������� � ���� 3600
 begin

 --   ������ ������ ������� ��� ��������� ��� ��� ����� ����������
 -- ������� �� ������ ���� ������ ���������� ��� ����� �����
 -- ��� ��������� (������)
/*
  select to_number(max(txt)) into day_pog_SN  from nd_txt where nd=ND_ and tag='DAYSN';


  if day_pog_SN is null then
       select trunc(i.s)
         into day_pog_SN
         from nd_acc n,accounts a,int_accn i
        where n.nd=nd_ and n.acc=a.acc and a.acc=i.acc
              and a.tip='LIM' and i.id=0;
  end if;


--  DAT_SN1_:=CC_DAY_POG(gl.bd,31);
--  DAT_SN1_:= cck_app.check_max_day(gl.bd, decode(CC_PAY_D,null,cck_app.pay_day_sn_to_nd (nd_),CC_PAY_D),nvl(cck_app.set_nd_txt(p_nd,'DAYNP'),cck.CC_DAYNP),gl.baseval);
--  DAT_SN1_:= cck_app.check_max_day(gl.bd, (case when CC_PAY_D is null or CC_PAY_D<1 or CC_PAY_D>31 then cck_app.pay_day_sn_to_nd (nd_) else CC_PAY_D end),-2,gl.baseval);


  if DAT_SN1_<gl.bd then
  DAT_SN1_:=CorrectDate2(gl.baseval, CC_DAY_POG(add_months(gl.bd,1),day_pog_SN), CC_DAYNP);
  end if;
*/




CC_DAYNP:= CCK_APP.GET_ND_TXT(ND_,'DAYNP');
 if nvl(CC_DAYNP,0)=0 then
     CC_DAYNP:= to_number(NVL( GetGlobalOption('CC_DAYNP'),'1'));
 end if;


  -- 3600
 begin
  SELECT Nvl(a.ostb+a.ostf,0)/100, a.nls
    INTO  nISG,NLS_ISG
    FROM accounts a, nd_acc n
   WHERE n.nd=ND_ and n.acc=a.acc and a.tip in ('ISG')
         and a.kv=KV_ and rownum=1 and a.dazs is null;
 exception when no_data_found then
  nISG:=0; NLS_ISG:=null;
 end;


--raise_application_error(-(20000+1),'\ '||to_char(DAT_SN1_,'ddmmyyyy'),TRUE);


 end;



begin
   -- 3)��������� ������
   select      fdat, lim2/100, sumg/100, nvl(sumk/100,0), sumo/100
     into rLim.fdat,rLim.lim2,rLim.SUMg,rLim.SUMk       ,rLim.SUMo
     from cc_lim l
    where l.nd=ND_ and (l.nd,l.fdat)=
          (select nd,min(fdat) from cc_lim
           where nd=ND_ and fdat > dat_next_u(LocalBD_,-1) and sumo>0
           group by nd
          );
     logger.trace ('GET_INFO_UPB_EXT: ������ ��������� � ������ fdat='||to_char(rLim.fdat,'dd/mm/yyyy')||'LIMIT='||to_char(rLim.lim2)||' SUMo='||rLim.SUMo||' SUMg='||rLim.SUMg||' rLim.SUMk='||rLim.SUMk);
--  ������� ����� ��� ������� "��������� ������" �������
--  �� ������������ ��������� ���� �������
  if cck_app.CorrectDate2(980,rLim.fdat, CC_DAYNP)>cck_app.CorrectDate2(980,add_months(LocalBD_,1),CC_DAYNP)
      or (TIP_SN=0 and rLim.fdat>last_day(LocalBD_))
                            then
     Logger.trace ('GET_INFO_UPB_EXT: ��������� ������ ��� �� ��������');
     rLim.LIM2:=l_limit;
     rLim.SUMo:=0;
     rLim.sumg:=0;
     rLim.SUMk:=0;
     Logger.trace ('GET_INFO_UPB_EXT: ������ ��������� � ������ fdat='||to_char(rLim.fdat,'dd/mm/yyyy')||'LIMIT='||to_char(rLim.lim2)||' SUMo='||rLim.SUMo||' SUMg='||rLim.SUMg||' rLim.SUMk='||rLim.SUMk);
  end if;


EXCEPTION  WHEN NO_DATA_FOUND THEN
     rLim.Lim2:=l_limit; rLim.SUMo:=0; rLim.SUMg:=0; rLim.SUMk:=0; rLim.fdat:=DAT4_;
end;
   -- ������ ������ ��������� ��� �������������� ������
  if CC_PAY_S=1 or vid_=4 then
   begin
    -- DEL_SK4 - ����� ����� ������� ������ � ������� ������
    SELECT greatest(Nvl(SUM(s.KOS),0)-Nvl(SUM(decode(a.tip,'SP ',s.DOS,0)),0) ,0)/100
       INTO  Del_SK4
       FROM accounts a, nd_acc n,saldoa s
      WHERE n.nd=nd_ and n.acc=a.acc and a.tip in ('SS ','SP ')
            and a.kv=KV_ and s.acc=a.acc
            and s.fdat>(select max(fdat) from cc_lim
                         where nd=nd_ and fdat < LocalBD_ and sumg>0
                       );

             Logger.trace ('GET_INFO_UPB_EXT: �������� � ���. ������ Del_SK4='||to_char(Del_SK4));
  -- ������������ ��������
  -- Del_SK4:=greatest(l_limit-nSS1_- Del_SK4,0);
  -- Del_SK4:=greatest(nvl(Del_SK4,0),0);  -- ������ ������� � ������ ���������

  --  ���� ��������         �������� - ��� ������
  /*
   if rLim.LIM2+rLim.Sumg-nSS1_>0 then
       if rLim.LIM2+rLim.Sumg-nSS1_<=DEL_SK4 then
          DEL_SK4:=rLim.Sumg;
       else
          DEL_SK4:=rLim.Sumg-least(rLim.LIM2+rLim.Sumg-nSS1_,DEL_SK4);
       end if;
   else
      DEL_SK4:=0;
   end if;
*/
   -- DEL_SK4 - ���������� ������ ��������� �������� ������ ��� ����������
   --           ����� ����� �������� ������� ��� �������� (�������� �� 0 �� SUMG)
   DEL_SK4:=greatest(least(rLim.Sumg,DEL_SK4)-greatest(nSS1_-rLim.LIM2,0),0);


     Logger.trace ('GET_INFO_UPB_EXT: ������ ��������� Del_SK4='||to_char(Del_SK4));
   exception when no_data_found then
     Del_SK4:=0;
     Logger.trace ('GET_INFO_UPB_EXT: ������ ��������� exception Del_SK4='||to_char(Del_SK4));
   end;
  end if;

--       ���� ����
-- ����� ��� ���������� �� ����� ���� ��������� ������ �� ���� � ���������
sAddInfo_:= sAddInfo_||'<BR>'||'������� ��������� ��� ������ ��������: '||NLSK_ ;
 if l_ost>0 then -- ����� ������������ �� ����� ������ ��� ��������� 2620
  sAddInfo_:= sAddInfo_||' = '||to_char(l_ost,'999999999999999D00')||' ('||KV_||')';
 end if;
-- ������������� 4 �������� (�������, ������ �����)�(������������� �����, ����������)
-- nSS_ - ����� ��� - �� ������� �� ���� �������
-- nSS_SK4 - ����� � ������� �� ���� ������� �������� ( � �� ����� �������� �������)

 If rLim.fdat is not null and DAT4_>=LocalBD_ then
    If vid_=4 then
       -- ����������� �������-����� �� ���, 2 ��������� +��� ��- ������ ����� ��� ��� �� �����
       nSS_:= greatest(nSS1_-rLim.LIM2,least( nSSP_+(rLim.Sumg-Del_SK4),nSS1_),0) ; --��� �������
       nSS_SK4:=nSS_;
       sAddInfo_:= sAddInfo_||'<BR>'||'�������� (��Ӳ������) ����� �� ��������: '||to_char(rLim.fdat,'DD/MM/YYYY')||' = '||to_char(rLim.SUMo,'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ');
    else
       nSS_:= greatest(nSS1_-rLim.LIM2,nSSP_,0); --� ����������
              -- ��� �������������� ������ ����� ������� ���������� ��� ��������
              -- ���������� ������� ��������
       if CC_PAY_S=1 then
          nSS_SK4:= greatest(nSS1_-rLim.LIM2,least( nSSP_+(rLim.Sumg-Del_SK4),nSS1_),0);  --��� �������
       else
          nSS_SK4:=nSS_;
       end if;
     sAddInfo_:= sAddInfo_||'<BR>'||'����� (�������) �� �������� ��������� ��������� �����: '||to_char(rLim.fdat,'DD/MM/YYYY')||' = '||trim(to_char(rLim.SUMg,'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' '));
    end if;
 else
     nSS_:= nss1_;
     nSS_SK4:=nSS_;
     if DAT4_<LocalBD_ then
     sAddInfo_:= sAddInfo_||'<BR>'||'������ ��������: '||to_char(rLim.fdat,'DD/MM/YYYY');
     end if;
 end if;

-- ���� ������� �� ���������� ���������
-- begin
   ratn_advanced:=acrn.fprocn(ACC8_,4,null);
      Logger.trace ('GET_INFO_UPB_EXT: ���������� ������ �� ��������� ��������� ratn_advanced='||to_char(ratn_advanced));
   if ratn_advanced>0 and LocalBD_<DAT4_ then
      sAddInfo_:= sAddInfo_||'<BR>'||'���i�i� �� ���������� ��������� ���������: '||to_char(ratn_advanced,'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||'%';

      if  KV_!=gl.baseval then
          sAddInfo_:= sAddInfo_||'<BR>'||'<font color="red"><b> ���i�i� �� ���������� ��������� ��� i�������� ����� ����������� �� ���������.<br>��� ������ �������������� i��� ������i�. </b></font>';
      else
          nSK4:=trunc(greatest(nSS1_-nSS_SK4,0)*ratn_advanced*0.01,2);
--          nSK4:=nSS_SK4;
          if nSK4 >0 then
          sAddInfo_:= sAddInfo_||'<BR>'||'��� ����������� �������� ���i�i� �� ���������� ��������� ���� ���������: '||to_char(nSK4,'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||' ���.';
          end if;
     logger.trace ('GET_INFO_UPB_EXT: ����� ����� ���='||to_char(nSK4)||' nSS1_= '||to_char(nSS1_)||' nSS_SK4= '||to_char(nSS_SK4));

   end if;

   end if;


  if substr(NLSK_,1,4)='2620' and substr(l_flags,2,1)='0' then
     DAT_SN1_ := rLim.fdat-1; -- ������� ����
  elsif substr(NLSK_,1,4)='2620' and substr(l_flags,2,1)='1' then
     DAT_SN1_ := trunc(rLim.fdat,'mm')-1; -- ������� �����
  else
    -- �������� ��� ������ ��
     -- ���� ���� ��������� ���������� �� ��������� �� ���� ������������
    -- ��� �������� ��� ��������� �� ���������
      if CC_PAY_D is null  then
        DAT_SN1_:= cck_app.check_max_day(LocalBD_, cck_app.pay_day_sn_to_nd (nd_),-2,gl.baseval)-1;
      else
         DAT_SN1_:= cck_app.check_max_day(LocalBD_, CC_PAY_D,-2,gl.baseval); -- CC_PAY_D - ������ ����� ����� 31
      end if;

        -- ���� ��������� ���� ���-�� ������ � ������� ��������� ���� ����� ��� ���������� ������
      if DAT_SN1_<LocalBD_ then
        if CC_PAY_D is null  then
           DAT_SN1_:= cck_app.check_max_day(add_months(LocalBD_,1), cck_app.pay_day_sn_to_nd (nd_),-2,gl.baseval)-1;
        else
           DAT_SN1_:= cck_app.check_max_day(add_months(LocalBD_,1), CC_PAY_D,-2,gl.baseval);
        end if;

      end if;

  end if;

  -- ��� ������������ ��� �� ���� ��������� - ���� ��������� ������ �����
  IF DAT4_<=LocalBD_ THEN
    DAT_SN1_:=LocalBD_-1;
  elsif DAT4_= rLim.fdat and rLim.fdat-40 > LocalBD_ then
    DAT_SN1_:=LocalBD_-1;
  end if;

       logger.trace ('GET_INFO_UPB_EXT CC_PAY_D='||to_char(CC_PAY_D)||' DAT_SN1_='||DAT_SN1_);

nSK1_:=0;

 If CC_PAY_I>0 then
   savepoint DO_ACRN;
  -- delete from ACR_INTN;
   FOR k in (SELECT a.acc,a.tip,i.metr,NVL(i.acr_dat, a.daos-1) + 1 DAT1,a.nls,i.stp_dat, i.basem, a.accc
             FROM nd_acc n, accounts a, int_accn i
             WHERE n.nd=ND_ and n.acc=a.acc and a.dazs is null and a.acc=i.acc
              and (  i.id=0 and a.tip in ( 'SS ','SP ','SL ')
                     OR (i.id=2 and a.tip='LIM' )
                  )
            )
   LOOP
      If k.Tip='LIM' then
         --  ���.���� �� ������ METR
         CC_KOMISSIA (k.Metr,k.Acc, 2, k.Dat1, least(nvl(k.stp_dat,DAT_SK1_),LocalBD_-1), nSK1_, Null,0);
         nSK1_ := abs( nvl(nSK1_,0))/100;
      else
            -- ���� 1
           if k.tip='SS 'and substr(NLSK_,1,4)='2620'  then  ------------------------------------------SS - 2620 -----------------------------------------
              DAT_och:=least(nvl(k.stp_dat,DAT_SN1_),DAT_SN1_);    -- �� ���������� ���
              if nvl(k.basem,0)=1 then
                 CCK.INT_METR_A(k.Accc,k.acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              else
                 acrn.p_int(k.Acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              end if;
              nSN_:=nSN_+abs(round(nvl(nInt_,0))/100); -- �� ��������� ����

               DAT_och:=least(nvl(k.stp_dat,LocalBD_-1),LocalBD_-1);
              if nvl(k.basem,0)=1 then
                  CCK.INT_METR_A(k.Accc,k.acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              else
                  acrn.p_int(k.Acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              end if;
                nSN1_:=nSN1_+abs(round(nvl(nInt_,0))/100); -- �� ��������� ����

           elsif k.tip='SP ' and substr(NLSK_,1,4)='2620'  then                  ---------------------------------------------SP 2620 -----------------------------------------------------------------
                DAT_och:=least(nvl(k.stp_dat,LocalBD_-1),LocalBD_-1); -- �� ��������� ����
                acrn.p_int(k.Acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
                nSN_:=nSN_+abs(round(nvl(nInt_,0))/100); -- ��� ����
                nSN1_:=nSN1_+abs(round(nvl(nInt_,0))/100);   -- ������� ����

         elsif k.tip='SS ' then  -- �� �� ����� ��� ���  ���� ���� ----------------------------------------------SS 3739 -----------------------------------------------------------------
              DAT_och:=least(nvl(k.stp_dat,DAT_SN1_),DAT_SN1_);    -- �� ���������� ���
              if nvl(k.basem,0)=1 then
                  CCK.INT_METR_A(k.Accc,k.acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              else
                  acrn.p_int(k.Acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              end if;
              nInt_ISG:=nInt_ISG+abs(round(nvl(nInt_,0))/100); -- on 3600

               DAT_och:=least(nvl(k.stp_dat,LocalBD_-1),LocalBD_-1); -- -- �� ��������� ����
              if nvl(k.basem,0)=1 then
                  CCK.INT_METR_A(k.Accc,k.acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              else
                  acrn.p_int(k.Acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              end if;
                nSN1_:=nSN1_+abs(round(nvl(nInt_,0))/100);  -- �� ��������� ����

           elsif k.tip='SP '   then                                             ---------------------------------------------SP 3739 -----------------------------------------------------------------
               DAT_och:=least(nvl(k.stp_dat,LocalBD_-1),LocalBD_-1); -- �� ��������� ����
                  acrn.p_int(k.Acc,0,k.DAT1,DAT_och,nInt_,NULL,1);
              nInt_ISG:=nInt_ISG+abs(round(nvl(nInt_,0))/100); -- on 3600
              nSN1_:=nSN1_+abs(round(nvl(nInt_,0))/100);  -- �� ��������� ����

           end if;

       end if;


          -- ��������� ����/����� (����� ������� ������ ���� ����� ��� ������ �������� ����� ������ ���� �� 3739 ���������  ������ ������� ������ % ��������� ���������� ��������� �� 3600)


   END LOOP;
   rollback to DO_ACRN;
 End if;

-- ���i���
   nSK1_:=nSK_ + nSK1_;

   if substr(NLSK_,1,4)='2620' then

       if  KV_=980 and nSP_!=0 then   -- ���� ���� � ��� ���������� �� ����� 2620
         nS_:=nvl(nS_,0)+nSP_;
         nS1_:=nvl(nS1_,0)+nSP_;
         sAddInfo_:=sAddInfo_||'<BR>'||'���� ��� : '||to_char(nSP_,'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||' �������� � ��������� �����';
         nSP_:=0;
      end if;

     IF DAT4_>LocalBD_ THEN
       sAddInfo_:=sAddInfo_||'<BR><BR>'||'����� !!! ��� ������������ (�������/����������) �������� ��, �볺��� ��������� ���������� � ��������� ����  ��� ��������� ����� �� ������������ ���������.';
       if   nSN_- nSN1_>0 then
               sAddInfo_:=sAddInfo_||'<BR>'||' ��� ������������ �������� ���� ������� ����  ������ �� = '||to_char((nSN_- nSN1_),'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||' �� ��������� �������';
        elsif  nSN_- nSN1_<0 then
                sAddInfo_:=sAddInfo_||'<BR>'||' ��� ������������ �������� ���� ������� ����  ������ �� = '||to_char((abs(nSN_- nSN1_)),'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||' �� ��������� �������';
       end if;
     end if;
   else        -- -3600


     if nls_isg is not null and substr(NLSK_,1,4)!='2620'  and DAT4_>LocalBD_ and nInt_ISG-nISG>0 then
        sAddInfo_:= sAddInfo_||'<BR>'||'���� ��� ����������� �� ������� '||nls_ISG||' ���������: '||to_char((nInt_ISG-nISG),'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||'('||KV_||')';
     end if;

       nSN_:=greatest(nSN_+least(nInt_ISG-nISG,0),0);
       nSN1_:=greatest(nSN1_+least(nInt_ISG-nISG,0),0);

   end if;



------------------------  SS  ------------------------------------------------------------
-- �������� ����i�

-- ��� ������ = (���� ��� 2620) +(���� �� ���) + ���.% + ���.�����
-- �������� ���������� ���� ���� ��� ��������
    --  ���� +             ��������
 nS_ := nvl(nS_,0)+nSS_
        + (case when vid_=4 and TIP_SN=-1
                then greatest(nSN_,(rLim.SUMo-nvl(rLim.SUMk,0)-(rLim.SUMg-Del_SK4)))
                else nSN_
            end)
          +(case when KV_=KV_KOM_ and KV_KOM_=gl.baseval then nSK_ else 0 end);

 -- ���������� ����� (nS1_ - �������� ����)
   nS1_ :=nvl(nS1_,0)+nSS1_+nSN1_+nSK4+(case when KV_=KV_KOM_ and KV_KOM_=gl.baseval then nSK1_ else 0 end);
   nS1_ :=round (nS1_,2);  -- ������� ����� � � �������� ���� ����� ��������

   if substr(NLSK_,1,4)='2620' then
   nS_:=greatest (nS_-l_ost ,0);
   nS1_:=greatest (nS1_-l_ost ,0);
   end if;

   IF DAT4_<=LocalBD_ THEN    nS_:=nS1_;  end if;


<<KONEC>> null;
PUL.Set_Mas_Ini( 'CC_ID', l_ccid, '� ��' );

nRet_ := 0 ;sRet_ :='';

   sAddInfo_:=sAddInfo_||'<BR>'||'���� �� ���� ����������� �������:  '||to_char(DAT_SN1_,'dd/mm/yyyy');
--RETURN;

END GET_INFO_UPB_EXT;
/
show err;

PROMPT *** Create  grants  GET_INFO_UPB_EXT ***
grant EXECUTE                                                                on GET_INFO_UPB_EXT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_INFO_UPB_EXT to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GET_INFO_UPB_EXT to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_INFO_UPB_EXT.sql =========*** 
PROMPT ===================================================================================== 
