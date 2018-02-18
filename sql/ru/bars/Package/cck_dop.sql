CREATE OR REPLACE PACKAGE BARS.CCK_dop IS

  G_HEADER_VERSION CONSTANT VARCHAR2(64) := 'version 6.0 17.11.2016';

  -- ===============================================================================================
  -- Public types declarations
  -- ��������� ��������� ����������
  type t_pmt_instr is record(
    mfo  oper.mfob%type, -- ��� ����������
    nls  oper.nlsb%type, -- ����� ����� ����������
    nam  oper.nam_b%type, -- ������������ ����� ����������
    okpo oper.id_b%type, -- ��� ����������
    nazn oper.nazn%type -- ���������� �������
    );
  -- ===============================================================================================

  --------------------------------------------------------------
  -- CC_OPEN()
  --
  --     ��������� �������� �� ���������� � ������������
  --     ������ �� 10 ����� ������� � ��� ��������� ��� �����������
  --     �������������� ���� ������ � ���������� ��������
  --
  --
  --     ���������:
  --       ND_     - ������������� (Ref) ��������
  --       CC_ID_  - ����� �������� (����� ������)
  --       nRNK    - ������������� (Ref) �������
  --       nKV     - ��� ������
  --       SDOG    - ����� ��������
  --       SumSDI  - ����� ��������
  --       fPROC   - ���������� ������
  --       BASEY   - ��� ���� ���������� ���������
  --       SDATE   - ���� ��������� ��
  --       WDATE   - ���� ��������� ��
  --       GPK     - ������ ����� ������� ��������� (1- ������� 2- � ���� ����� 3- �������)
  --       METR    - ����� ����������� ��������
  --       METR_R  - % ������ ��������
  --       METR_9  - % ������ �������� �� ���������������� ����� (null - ����������� ���)
  --       nFIN    - ��� ���� �������
  --       nFREQ   - ������������� ���������
  --       dfDen   - ���� ��������� ��
  --       PROD_   - ��� ��������
  --       nBANK   - ��� ����� ��� ������������ �����
  --       NLS     - ���� ��� ������������ �����
  --        (PAWNyxx,PAWN_Syxx,PAWN_RNKyxx) - ��� ��� ���� �������� ��������� ����� ����� � ���������
  --                                     ��������� 5 �������(xx - null,2,4,6,8) � 5 �������� (Pxx - 1,3,5,7,9)
  -- x10    PAWN    - ��� ������
  -- x10    PAWN_S  - ����� ������ (0.00)
  -- x10    PAWN_RNK- Ref ������������
  --       Err_Code    - ��� ������
  --       Err_Message - ����� ������

PROCEDURE CC_OPEN(ND_         in OUT int,    CC_ID_      in varchar2,      nRNK        in int,        nKV         in int,
                  SDOG        in number,     SumSDI      in number,        fPROC       in number,     BASEY       in int,
                  SDATE       in DATE,       WDATE       in DATE,          GPK         in number,     METR        in int,
                  METR_R      in number,     METR_9      in number,        nFIN        in int,        nFREQ       in int,
                  dfDen       in int,        PROD_       in VARCHAR2, --was int
                  nBANK       number default null,        NLS         varchar2 default null,
                  PAWN        number , PAWN_S  number,  PAWN_RNK  int,  PAWNP  number,   PAWNP_S  number, PAWNP_RNK   int,
                  PAWN2       number , PAWN2_S number,  PAWN2_RNK int,  PAWNP2 number,   PAWNP2_S number, PAWNP2_RNK  int,
                  PAWN3       number , PAWN3_S number,  PAWN3_RNK int,  PAWNP3 number,   PAWNP3_S number, PAWNP3_RNK  int,
                  PAWN4       number , PAWN4_S number,  PAWN4_RNK int,  PAWNP4 number,   PAWNP4_S number, PAWNP4_RNK  int,
                  PAWN5       number , PAWN5_S number,  PAWN5_RNK int,  PAWNP5 number,   PAWNP5_S number, PAWNP5_RNK  int,
                  Err_Code    out int, Err_Message out varchar2
);


  PROCEDURE CC_OPEN(ND_         in OUT int,    CC_ID_      in varchar2,      nRNK        in int,        nKV         in int,
                  SDOG        in number,     SumSDI      in number,        fPROC       in number,     BASEY       in int,
                  SDATE       in DATE,       WDATE       in DATE,          GPK         in number,     METR        in int,
                  METR_R      in number,     METR_9      in number,        nFIN        in int,        nFREQ       in int,
                  dfDen       in int,        PROD_       in INT, 
                  nBANK       number default null,        NLS         varchar2 default null,
                  PAWN        number , PAWN_S  number,  PAWN_RNK  int,  PAWNP  number,   PAWNP_S  number, PAWNP_RNK   int,
                  PAWN2       number , PAWN2_S number,  PAWN2_RNK int,  PAWNP2 number,   PAWNP2_S number, PAWNP2_RNK  int,
                  PAWN3       number , PAWN3_S number,  PAWN3_RNK int,  PAWNP3 number,   PAWNP3_S number, PAWNP3_RNK  int,
                  PAWN4       number , PAWN4_S number,  PAWN4_RNK int,  PAWNP4 number,   PAWNP4_S number, PAWNP4_RNK  int,
                  PAWN5       number , PAWN5_S number,  PAWN5_RNK int,  PAWNP5 number,   PAWNP5_S number, PAWNP5_RNK  int,
                  Err_Code    out int, Err_Message out varchar2
);

  -- ���������� ��� �� ��������� �������� � ��.
  --------------------------------------------------------------
  -- Builder_GPK()
  -- ���������
  -- �� ��������� ������ ��� � ��� ����. ��.

  -- ���������
  -- p_nd - ��� ��������
  -- p_ccv - ���������� ���������� ������ ��� ����������� ��������
  --   ������������� ���� ����������
  --   l_ccv.acc8    -- ����� 8999
  --   l_ccv.apdate  -- ���� ���� ���
  --   l_ccv.awdate  -- ������ ���
  --   l_ccv.dwdate  -- ���� ���������
  --   l_ccv.sdog    -- ��������� �����
  --   l_ccv.freq    -- �������������
  --   l_ccv.GPK     -- ��� ������� ��������� 4 -������� 2 ������ �����
  --   l_ccv.pr      -- ���������� ������
  -- p_dig -- ������ ���������� ���� ��� ���������� ��� (0 - �� ���. 2 - �� ���.)

  procedure builder_gpk(p_nd     number,
                        p_ccv    cc_v%rowtype default null,
                        p_months number default null,
                        p_dig    number default 2);

  -- ��������
  procedure Rebuild_GPK(p_ND number, p_fdat date := null);

  -- ������ ��������
  --------------------------------------------------------------
  -- CALC_SDI()
  --
  --     ���������
  --     1.  ����������� ��. ������ (���� � ��������)
  --     2. ������ ������
  --     3. ���� �������� �������� � ���� ��������� ���
  --       ������ �������������� ����� � ��� ��������� 'S_SDI'
  --
  --     ���������:
  --
  --      ND_      -   ������������� (Ref) ��������
  --      Sum_Sdi  -  ����� ��������
  --

  procedure CALC_SDI(nd_ in int, SUM_SDI in int);

  -- �������� �������� �� ��������������� ��������
  -----------------------------------------------------------
  --  PAY_SDI ()
  --      �� ����� ODB �� ���� SDI  �� �����.
  --      ��� ������� ��� �������� �� ����� ��� ������.
  --    p_nd       - ��� ��������
  --    p_sum_sdi  - ����� ��������

  function PAY_SDI(p_nd in int, p_sum_sdi int := null) return int;

  -- �������� �������� �� ������ (������� �������� ����)
  -----------------------------------------------------------
  --  pay_lending_money ()
  --      ��������� ������ ����� �� ���� ������������ ���� (�� ���� cc_deal.kredacc)
  --    p_nd       - ��� ��������
  --    p_sum_sdi  - ����� ��������

  function pay_lending_money(p_nd in int, p_sum int := null) return int;

  -- ��������� �����. ����������� �� ������ �� ��� ���������
  function get_isp_by_branch(p_branch in cck_isp_nls.branch%type)
    return staff$base.id%type;

  -- ��������� �����. ����������� �� ������ �� ��� ����������
  function get_isp_by_user(p_id in cck_isp_nls.id%type)
    return staff$base.id%type;

  -- �������� ����� �� �� ����
  procedure open_account(p_nd  in cc_deal.nd%type,
                         p_tip in accounts.tip%type);

  -- ������������� �������� ����� ��
  procedure open_an_account(p_nd  in cc_deal.nd%type,
                            p_tip in varchar2_list);

  --------------------------------------------------------------
  -- CC_AUTOR()
  --
  --     ����������� ��������� ����������� ��
  --     1.  �������� ����������� ������� �����������
  --     2.  ��������� ���������� ����� 'SS ', 'SN ', 'SG ' + 'SD '����������� � ��
  --     3. ��������� ���� ������ � ������������ �������

  --     ���������:
  --
  --      ND_      -   ������������� (Ref) ��������
  --      Sum_Sdi  -  ����� ��������
  --

  -- ����������� ��
  procedure cc_autor(p_nd   in number,
                     p_saim in varchar2 default null,
                     p_urov in varchar2 default null);

function get_prod_old(p_prod varchar2) return varchar2;
-------------------------------------------------------
  /**
  * header_version - ���������� ������ ��������� ������ CCK
  */
  function header_version return varchar2;

  /**
  * body_version - ���������� ������ ���� ������ CCK
  */
  function body_version return varchar2;
  -------------------

END CCK_DOP;
/
CREATE OR REPLACE PACKAGE BODY BARS.cck_dop IS

  G_BODY_VERSION CONSTANT VARCHAR2(64) :=  'ver.6.00 PLAN 08/11/2017';

  /*
  28/03/2017 ���������� �������� � ������ NNNNNN.NN
  02/03/2017 ����� ����������� ��������� ����������� ��������� ����� �������� ������
  15/02/2017 COBUSUPABS-5326 
              3.1    ��� ������ ����������� ��������� �������� � ������:
            �    ������������ �������� ���� 
            �    �������� ���� (�� �������. ��� � �� ������)
            �� ������� ����������� ��������������� �������� ��������� ��������� ��������� ������
  03/02/2017 ����� ������ ��������� < 30 ����. �� �� �� ����� ������ ���
  17/11/2016 LSO ����� ��������� �������� ���������� ��������� �� ������.
  27.10.2016 BAA ���������� ��22 ����. Accreg.setAccountSParam
  18.10.2016 STA round ��. ������ �� 8 ������ ����� �������
  10/10/2016 Sta ����, �� �� ��� � ���� ���� ����� ������ (COBUSUPABS-4863), 
                 ����, �� ���� ��� ��� �� ����������,
                 � ������� �� �������, ��� ����� ��� ���� ���������� ���� �������.
                 ����� ������� �������� <MeshkoEI@oschadbank.ua>

  28/09/2016 LSO COBUSUPABS-4806 ���������� ����������� �� ��� ������������ �������� �³���������� ��������� �� ������� ��� ������������ �������� � �ϻ.
  23/09/2016 LSO ������ �� ���������� ��������� �� ����.
  20.07.2016 ����� ����� 8999 �� �o �����, � �� ��� ND_ACC
  02-03-2015 � ��������� builder_gpk ��� ����������� ���������� ������ ������������ greatest(gl.bdate, cc_v.awdate)
               ��� ���������� ������ � ����������, ������������� � �������
  22-01-2015
  24-12-2014   ������ �� 2625.  ��� �� PKJ
  06.03.2013  cc_autor ��� �������� ������ � ������ �������� ������� �������� ��������
  08.11.2012  DAV � ��������� �������� �� ������� ����������� � ����������� ���. ��������� S260
  25.07.2012: ����������� ���������������� �����
  05.07.2012: ������ �.
              ��22 ��� ������ �����������  - �� ������ �����.
              procedure cc_autor  - ����������� ��

  20.02.2012 tvSukhov �������� ��������� open_account. ��������� ��������� ��������
             vidd_tip.force_open - �������������� �������� ����� � ��������� cc_autor
  01.02.2012 tvSukhov ����� ��������� � ���� ����, ���������� ��������� ����������� �
             ����� ����������� ����������� �� ������� � �� ������ � ����������� �� ��������� ������,
             ����� ������������ �.�. ��� � ��� ������ ������� �� ����� �����-���
  03.11.2011 tvSukhov � ��������� Builder_GPK �������� �������� p_dig number default 2
             p_dig -- ������ ���������� ���� ��� ���������� ��� (0 - �� ���. 2 - �� ���.)

  ??.??.???? ???
  ��������� ��� ���������������:
   - ���������� ��� ,
   - �������� ������,
   - ������� ����������� ������
   - � ��������� �������� �� �����������

  11.08.2011 Sta ���������� �� CC_AUTOR � ������ ����������� �� ������ ��
  12/04/2011 Nov �������� �������� �������� � ������ ������� ��� ����� ����� �������� GRT
  15/10/2010 Nov ���� �� �������� ��������� "�������������� ����������" �������� ���������� ������ � �� ������ ��������� ������
  04/12/2009 Nov ������� calc_sdi ��������� ������� � ���� �� ������ ���������   �� ����� �������� XIRR
  */

  -- ��� ���������
--------------------------------------------------------------
--������� �� �� �������� ���
PROCEDURE CC_OPEN(ND_         in OUT int,    CC_ID_      in varchar2,      nRNK        in int,        nKV         in int,
                  SDOG        in number,     SumSDI      in number,        fPROC       in number,     BASEY       in int,
                  SDATE       in DATE,       WDATE       in DATE,          GPK         in number,     METR        in int,
                  METR_R      in number,     METR_9      in number,        nFIN        in int,        nFREQ       in int,
                  dfDen       in int,        in VARCHAR2,  --COBUSUPABS-7065        
                  nBANK       number default null,        NLS         varchar2 default null,
                  PAWN        number , PAWN_S  number,  PAWN_RNK  int,  PAWNP  number,   PAWNP_S  number, PAWNP_RNK   int,
                  PAWN2       number , PAWN2_S number,  PAWN2_RNK int,  PAWNP2 number,   PAWNP2_S number, PAWNP2_RNK  int,
                  PAWN3       number , PAWN3_S number,  PAWN3_RNK int,  PAWNP3 number,   PAWNP3_S number, PAWNP3_RNK  int,
                  PAWN4       number , PAWN4_S number,  PAWN4_RNK int,  PAWNP4 number,   PAWNP4_S number, PAWNP4_RNK  int,
                  PAWN5       number , PAWN5_S number,  PAWN5_RNK int,  PAWNP5 number,   PAWNP5_S number, PAWNP5_RNK  int,
                  Err_Code    out int, Err_Message out varchar2
) is

    AIM_   int; -- ���� �������
    Vid_   int; -- ��� �������
    DATN_  date; -- ���� ������� �������
    Den_   int; -- ���� ��������� ���-��� �� ���� ���-�� ����
    SDATE_ date; -- ���� ����. �������� ���-��� �� ��������
    WDATE_ date; -- ���� �����. �������� ���-��� �� ��������
    K_     int ; -- ���� ��� �������� ��� � ���
    ACC8_  int ;    NLS8_  accounts.nls%type;    INIC_  varchar2(30);
    STOP_PRC EXCEPTION;    ret_    int;
    acc_    int;    CC_KOM_ int;    NMS_    varchar2(38);    gpk2    int;    nTmp_ number;  nInt_ number := 0; S260_ varchar2(2);
BEGIN
    ERR_Code    := null;    ERR_Message := NULL;
    logger.trace('CCK_DOP.CC_OPEN  �����!');
    select denom into K_ from tabval where kv = nKV;
--  WDATE_ := cck.CorrectDate(gl.baseval, WDATE, WDATE - 1);
--  SDATE_ := cck.CorrectDate(gl.baseval, SDATE, WDATE + 1);
    WDATE_ :=  WDATE;
    SDATE_ :=  SDATE;

    if prod_ is null then
       ERR_Message := '�� ��������� ��� ��������. ������ � �����i� � ��i��i�� � �� �� ���';    ERR_Code    := 1;
       raise STOP_PRC;
    elsif (WDATE_ - SDATE_ > 366) and substr(get_prod_old(prod_), 4, 1) = 2 then
      ERR_Message := '��� ������ �������� �� �i��� ���������� ����� �������� ' || to_char(WDATE_ - SDATE_) || ' ��.';
      ERR_Code    := 1;    raise STOP_PRC;
    elsif (WDATE_ - SDATE_ < 366) and substr(get_prod_old(prod_), 4, 1) = 3 then
      ERR_Message := '��� ������ �������� �� �i��� ���������� ����� �������� ' || to_char(WDATE_ - SDATE_) || ' ��.';
      ERR_Code    := 1;     raise STOP_PRC;
    end if;
    
    -- ������ ����
    if NEWNBS.GET_STATE = 1 then
     select nvl(min(AIM),62) into aim_ from cc_aim where substr(PROD_,1,4) in ( nvl(NBS,'2063'), nvl(NBS2,'2063'), nvl(NBSF,'2203'), nvl(NBSF2,'2203'));  
    else
     select nvl(min(AIM),62) into aim_ from cc_aim where substr(PROD_,1,4) in ( nvl(NBS,'2062'), nvl(NBS2,'2063'), nvl(NBSF,'2202'), nvl(NBSF2,'2203'));
    end if;
    -- p���������� ���� ������� �������

    -- ������������� �������������� ����
    Den_ := NVL(dfDen, 25);
    If    to_char(add_months(SDATE_, 1), 'mm') || dfDen in    ('0229', '0230', '0231')         then  Den_ := '28';
    elsIf to_char(add_months(SDATE_, 1), 'mm') || dfDen in    ('0431', '0631', '0931', '1131') then  Den_ := '30';
    end if;

    if Den_ < 10 then   DATN_ := to_date('0'  || Den_ ||  to_char(add_months(SDATE_, 1), 'mmyyyy'),    'ddmmyyyy');
    else                DATN_ := to_date(Den_ || to_char(add_months(SDATE_, 1), 'mmyyyy'),            'ddmmyyyy');
    end if;

    -- ��� �������
    if substr(prod_, 2, 1) = 0 then      Vid_ := 1;
    else                                 Vid_ := 11;
    end if;

    logger.trace('CCK_DOP.CC_OPEN  ����� ��������� cck.CC_OPEN');
    cck.CC_OPEN(ND_   , nRNK  ,  CC_ID_,  SDATE_, WDATE_,  SDATE_,  SDATE_,
                nKV   , SDOG  ,  Vid_  ,       4, aim_  ,  null  ,  nFIN  ,
                1     , null  , gl.aUID,     NLS,  nBANK,   nFREQ,   fPROC,
                BASEY ,  dfDen,   DATN_,   nFREQ,   NULL);
    update cc_deal set prod = to_char(prod_) where nd = ND_;
    logger.trace('CCK_DOP.CC_OPEN  ������ ������� ����� ND=' || ND_);
    ----------------------------------------------------------------------

    -- ���
--    nls8_ := VkrzN(substr(gl.aMFO, 1, 5), '89990' || ND_);
--    select acc, branch into ACC8_, INIC_ from accounts where nls = nls8_;
    begin  select a.nls, a.acc, a.branch   into nls8_, ACC8_, INIC_ 
           from accounts a, nd_acc n where a.acc =n.acc and a.tip='LIM' and n.nd = ND_ ;
    exception  when no_data_found then
            raise_application_error(-20000, '��� ���.'|| ND_||' �� �������� ��� 8999*LIM' );
    end ;


    -- 1 �� ������ ����� �������������� ���������

    if    gpk = 1 then    gpk2 := 2 ;
    elsif gpk = 2 then    gpk2 := 4 ;
          update int_accn set BASEM = 1, basey =2 where acc= acc8_ and id=0; --�������
    else                  gpk2 := 0 ;
    end if;

    --������ ���������� ����� ���������
    if wdate - sdate >30 then
    cck.CC_GPK( GPK, ND_, ACC8_, SDATE_, DATN_, WDATE_, SDOG, nFREQ, fPROC, 2);
    logger.trace('CCK_DOP.CC_OPEN  ������ ���');
    end if;
    -- ����� �������������� ������� (��������)
    if SumSDI is not null then
       Insert into nd_txt (ND,TAG,TXT) Values (ND_,'S_SDI', replace(to_char (replace (round(SumSDI,2), ',', '.'),'9999999999.99'),' '));
    end if;

    -- �������� �� ��������������� ����� 9129
    if METR_9 is not null then
       Insert into nd_txt (ND, TAG, TXT) Values (ND_,'R_CR9', to_char(METR_9));
    end if;

    -- ����������� ��������
    if metr is not null and metr_r is not null then
      insert into int_accn (acc,id,metr,basem,basey,freq,tt) values (Acc8_, 2, trunc(METR), 0, BASEY, 5, '%%1');
      insert into int_ratn (acc,id,bdat,ir)                  values (Acc8_, 2, SDATE_, METR_R);
    end if;



    --��������� ������ � �������
    if PAWN is not null and PAWN_S is not null and PAWN_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY0P', PAWN);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY0S', PAWN_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY0R', PAWN_RNK);
    end if;
    --��������� ������ � �������
    if PAWNP is not null and PAWNP_S is not null and PAWNP_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY1P', PAWNP);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY1S', PAWNP_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY1R', PAWNP_RNK);
    end if;

    if PAWN2 is not null and PAWN2_S is not null and PAWN2_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY2P', PAWN2);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY2S', PAWN2_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY2R', PAWN2_RNK);
    end if;
    --��������� ������ � �������
    if PAWNP2 is not null and PAWNP2_S is not null and
       PAWNP2_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY3P', PAWNP2);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY3S', PAWNP2_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY3R', PAWNP2_RNK);
    end if;

    if PAWN3 is not null and PAWN3_S is not null and PAWN3_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY4P', PAWN3);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY4S', PAWN3_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY4R', PAWN3_RNK);
    end if;
    --��������� ������ � �������
    if PAWNP3 is not null and PAWNP3_S is not null and
       PAWNP3_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY5P', PAWNP3);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY5S', PAWNP3_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY5R', PAWNP3_RNK);
    end if;

    if PAWN4 is not null and PAWN4_S is not null and PAWN4_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY6P', PAWN4);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY6S', PAWN4_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY6R', PAWN4_RNK);
    end if;
    --��������� ������ � �������
    if PAWNP4 is not null and PAWNP4_S is not null and
       PAWNP4_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY7P', PAWNP4);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY7S', PAWNP4_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY7R', PAWNP4_RNK);
    end if;

    if PAWN5 is not null and PAWN5_S is not null and PAWN5_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY8P', PAWN5);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY8S', PAWN5_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY8R', PAWN5_RNK);
    end if;
    --��������� ������ � �������
    if PAWNP5 is not null and PAWNP5_S is not null and
       PAWNP5_RNK is not null then
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY9P', PAWNP5);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY9S', PAWNP5_S);
      Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'ZAY9R', PAWNP5_RNK);
    end if;

    -- ��������� ��� ���������
    Insert into nd_txt (ND, TAG, TXT) Values (ND_, 'INIC', INIC_); -- ������ �������
--  INSERT INTO nd_txt (ND, TAG, TXT) values (ND_, 'FLAGS', '00'); -- �������� ���� � �� ���� ����

    -- ���������� � ��������� S260
    select s260 into s260_ from cc_potra where id=substr(prod_,1,6);
    cck_app.set_nd_txt (ND_,'S260' ,s260_);


--    update cc_deal set prod = prod_ where nd = nd_;


  exception when others then
    rollback;
    if ERR_Message is null then
       ERR_Code:=0;
       ERR_Message:=nvl(ERR_Message, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());--SQLERRM;
    end if;


end CC_OPEN;

--�������� �� �� ��� , PROD_ type changed, denied to modify curr proc -->COBUSUPABS-7065
PROCEDURE CC_OPEN(ND_         in OUT int,    CC_ID_      in varchar2,      nRNK        in int,        nKV         in int,
                  SDOG        in number,     SumSDI      in number,        fPROC       in number,     BASEY       in int,
                  SDATE       in DATE,       WDATE       in DATE,          GPK         in number,     METR        in int,
                  METR_R      in number,     METR_9      in number,        nFIN        in int,        nFREQ       in int,
                  dfDen       in int,        PROD_       in INT, 
                  nBANK       number default null,        NLS         varchar2 default null,
                  PAWN        number , PAWN_S  number,  PAWN_RNK  int,  PAWNP  number,   PAWNP_S  number, PAWNP_RNK   int,
                  PAWN2       number , PAWN2_S number,  PAWN2_RNK int,  PAWNP2 number,   PAWNP2_S number, PAWNP2_RNK  int,
                  PAWN3       number , PAWN3_S number,  PAWN3_RNK int,  PAWNP3 number,   PAWNP3_S number, PAWNP3_RNK  int,
                  PAWN4       number , PAWN4_S number,  PAWN4_RNK int,  PAWNP4 number,   PAWNP4_S number, PAWNP4_RNK  int,
                  PAWN5       number , PAWN5_S number,  PAWN5_RNK int,  PAWNP5 number,   PAWNP5_S number, PAWNP5_RNK  int,
                  Err_Code    out int, Err_Message out varchar2
) is

BEGIN
      cck_dop.cc_open(    ND_ ,     CC_ID_,    nRNK,   nKV, 
                  SDOG,     SumSDI,    fPROC,  BASEY,
                  SDATE,    WDATE,     GPK,    METR,
                  METR_R,   METR_9,    nFIN,   nFREQ,
                  dfDen,    PROD_,  --was int 
                  nBANK,    NLS,
                  PAWN,     PAWN_S  ,  PAWN_RNK  ,  PAWNP  ,   PAWNP_S  , PAWNP_RNK   ,
                  PAWN2,    PAWN2_S ,  PAWN2_RNK ,  PAWNP2 ,   PAWNP2_S , PAWNP2_RNK  ,
                  PAWN3,    PAWN3_S ,  PAWN3_RNK ,  PAWNP3 ,   PAWNP3_S , PAWNP3_RNK  ,
                  PAWN4,    PAWN4_S ,  PAWN4_RNK ,  PAWNP4 ,   PAWNP4_S , PAWNP4_RNK  ,
                  PAWN5,    PAWN5_S ,  PAWN5_RNK ,  PAWNP5 ,   PAWNP5_S , PAWNP5_RNK, Err_Code, Err_Message); 
									
EXCEPTION WHEN OTHERS THEN
    ROLLBACK;
    if ERR_Message is null then
       ERR_Code:=0;
       ERR_Message:=nvl(ERR_Message, DBMS_UTILITY.FORMAT_ERROR_STACK()||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());--SQLERRM;
    end if;

end CC_OPEN;

---------------------------------------------

procedure builder_gpk(p_nd     number,
                      p_ccv    cc_v%rowtype default null,
                      p_months number default null,
                      p_dig    number default 2) is

    l_ccv         cc_v%rowtype := p_ccv;
    l_kol         int;
    l_dat_end_gpk date;

  -- ���������� ��� �� ��������� �������� � ��.
  -- �� ��������� ������ ��� � ��� ����. ��.

  -- ���������
  -- p_nd - ��� ��������
  -- p_ccv - ���������� ���������� ������ ��� ����������� ��������
  -- ������������� ���� ����������
  -- l_ccv.acc8    -- ����� 8999
  -- l_ccv.apdate  -- ���� ���� ���
  -- l_ccv.awdate  -- ������ ���
  -- l_ccv.dwdate  -- ���� ���������
  -- l_ccv.sdog    -- ��������� �����
  -- l_ccv.freq    -- �������������
  -- l_ccv.GPK     -- ��� ������� ��������� 4 -������� 2 ������ �����
  -- l_ccv.pr      -- ���������� ������
  -- p_dig -- ������ ���������� ���� ��� ���������� ��� (0 - �� ���. 2 - �� ���.)


begin

    -- ������ ������ ���� �� ����� ��������
    select count(*) - 1  into l_kol   from cc_lim   where nd = p_nd    and acc = l_ccv.acc8 and fdat >= l_ccv.awdate;

    if l_kol <= 2 then --   /* H�� ��� , �������� */

      -- ���� ��� �� � p_ccv ���� �� �������� ����������
      if l_ccv.acc8 is null or l_ccv.dwdate is null or l_ccv.awdate is null or l_ccv.apdate is null or
         l_ccv.sdog is null or l_ccv.freq   is null or l_ccv.pr     is null or l_ccv.gpk    is null or l_ccv.s  is null    then

         select nvl(l_ccv.acc8, cc_v.acc8),    nvl(l_ccv.dwdate, cc_v.dwdate), nvl(l_ccv.awdate, cc_v.awdate),
                nvl(l_ccv.apdate, i.apl_dat),  nvl(l_ccv.sdog, cc_v.sdog),     nvl(l_ccv.freq, i.freq),
                nvl(l_ccv.pr, acrn.fprocn(cc_v.acc8, 0, greatest(gl.bdate, cc_v.awdate))), nvl(l_ccv.s, i.s),       nvl(l_ccv.gpk, ac.vid)
           into l_ccv.acc8,   l_ccv.dwdate,  l_ccv.awdate,     l_ccv.apdate,
                l_ccv.sdog,   l_ccv.freq,    l_ccv.pr,         l_ccv.s,       l_ccv.gpk
           from int_accn i, accounts ac,
               (select d.nd, a8.acc acc8, d.wdate dwdate, ad.wdate awdate, d.sdog from cc_deal d, accounts a8, cc_add ad, nd_acc n
                where ad.nd = d.nd  and ad.adds = 0      and n.nd = d.nd  and n.acc = a8.acc   and a8.tip = 'LIM') cc_v
         where cc_v.nd = p_nd     and i.acc = cc_v.acc8 and i.id = 0     and ac.acc = cc_v.acc8;

      end if;

      -- ��� �������� ����� ������ ��������� ��������
      -- �� ��������� ������� � �� �� ����� ������� �������� ��
      if p_months is not null then
         l_dat_end_gpk :=
          cck_app.check_max_day(ADD_MONTHS(l_ccv.awdate,p_months), l_ccv.s,  cck_app.to_number2(cck_app.get_nd_txt(p_nd,  'DAYNP')));
        CCK_APP.SET_ND_TXT(p_nd, 'RTERM', p_months);
      else
        l_dat_end_gpk := l_ccv.dwdate; ---���� ����������
      end if;

 --     delete from cc_lim     where nd = p_nd  and fdat >= l_ccv.awdate;


      l_ccv.apdate := add_months(l_ccv.awdate, 1);  -- ���� ������ + 1 ���= ������ ���� �����
      cck.cc_gpk(l_ccv.gpk-1, p_nd, l_ccv.acc8, l_ccv.awdate,l_ccv.apdate, l_dat_end_gpk,  l_ccv.sdog, l_ccv.freq,l_ccv.pr, p_dig);
--
    /*  delete from cc_lim  where nd = p_nd   and fdat > l_dat_end_gpk;
---   cck.cc_tmp_gpk(p_nd, l_ccv.gpk, l_ccv.acc8, l_ccv.awdate, l_dat_end_gpk, null, l_ccv.sdog, l_ccv.awdate);

      if p_months is not null then
        update cc_lim   set not_9129 = 1  where nd = p_nd   and fdat > l_ccv.awdate    and fdat < l_dat_end_gpk;
      end if;

      if l_dat_end_gpk < l_ccv.dwdate then
         insert into cc_lim (fdat, lim2, acc, nd, sumo, sumg) values (l_ccv.dwdate, 0, l_ccv.acc8, p_nd, 0, 0);
      end if;*/

    end if;

end builder_gpk;

  procedure Rebuild_GPK(p_ND number, p_fdat date := null) is
    l_new_dat date;
    l_old_dat date;
    l_diff    number;
    l_sumg    number;
  begin

    for i in (select n.nd,
                     abs(a.ostx) ostx,
                     abs(a.ostc) ostc,
                     a.acc acc8,
                     d.cc_id,
                     d.sdate
                from cc_deal      d,
                     accounts     a,
                     nd_acc       n,
                     nd_txt       nt,
                     cc_rang_name cr
               where d.nd = n.nd
                 and d.vidd in (11, 12, 13)
                 and d.sos < 15
                 and a.acc = n.acc
                 and n.nd = nt.nd
                 and to_number(nt.txt) = cr.rang
                 and nt.tag = 'CCRNG'
                 and cr.blk = 15
                 and a.tip = 'LIM'
                 and a.ostx < a.ostc
                 and d.nd = decode(p_ND, 0, d.nd, p_nd)) loop

      select min(fdat)
        into l_new_dat
        from cc_lim
       where nd = i.nd
         and lim2 = i.ostc
         and fdat > gl.bd;
      select max(fdat)
        into l_old_dat
        from cc_lim
       where nd = i.nd
         and lim2 = i.ostx
         and fdat < gl.bd;

      if l_new_dat is not null and l_old_dat is not null and
         l_old_dat < l_new_dat then

        logger.info('CCK_DOP.Rebuild_GPK (' || to_char(i.nd) ||
                    '): �������� ���� ���������� ������� �' || i.cc_id ||
                    ' �� ' || to_char(i.sdate, 'dd/mm/yyyy') ||
                    ' �� ������� ���� ������������� ����� ����������');

        select sum(sumg)
          into l_sumg
          from cc_lim
         where nd = i.nd
           and fdat >= l_old_dat
           and fdat <= l_new_dat;

        l_diff := MONTHS_BETWEEN(l_old_dat, l_new_dat);

        -- �������� ���-��� ������
        update cc_lim
           set lim2 = i.ostc, sumg = l_sumg, sumo = sumo + (l_sumg - sumg)
         where fdat = l_old_dat;

        -- ������� ��������� �������
        delete from cc_lim
         where nd = i.nd
           and fdat > l_old_dat
           and fdat <= l_new_dat;

        begin
          update cc_lim
             set fdat = ADD_MONTHS(fdat, l_diff)
           where fdat > l_old_dat
             and nd = i.nd;
        exception
          when others then
            raise_application_error(-20000, ADD_MONTHS(l_new_dat, l_diff));
        end;

        update accounts set ostx = -i.ostc where acc = i.acc8;

      end if;

    end loop;

  end;

  procedure CALC_SDI(nd_ in int, SUM_SDI in int) is
    n_          int;
    dat1        date; --���� ������
    l_SUM_KOM   int;
    Err_        varchar2(2000);
    IrrE_       number; -- ���.������
    SUM_ALL_    int;
    ACRB_       int;
    NBS_SDI_SPI varchar2(4);
    l_tt        int_accn.tt%type;

  begin

    logger.info('CCK_DOP.CALC_SDI run  nd=' || to_char(ND_) || ' sum_sdi=' ||
                to_char(sum_sdi));

    -- ��������� ������. ��������� �� ������
    FOR k in (select (case
                       when nvl(acrn.FPROCN(a.acc, 0), 0) = 0 then
                        (select ir
                           from int_ratn
                          where id = 0
                            and acc = a.acc)
                       else
                        acrn.FPROCN(a.acc, 0)
                     end) / 36500 ir,
                     a.acc acc8,
                     d.nd,
                     d.wdate,
                     d.rnk,
                     a.kv,
                     (case
                       when a2.nbs is not null then
                        a2.nbs
                       when d.vidd in (1, 2, 3) then
                        ca.nbs
                       else
                        ca.nbsf
                     end) nbs2,
                     ad.sour,
                     d.prod
                from accounts a,
                     nd_acc   n,
                     cc_deal  d,
                     cc_add   ad,
                     accounts a2,
                     cc_aim   ca
               where ND_ in (0, d.ND)
                 and d.nd = n.nd
                 and d.vidd in (1, 2, 3, 11, 12, 13)
                 and d.sos < 15
                 and d.wdate > gl.bd
                 and d.nd = ad.nd
                 and ad.accs = a2.acc(+)
                 and a.acc = n.acc
                 and a.tip = 'LIM'
                 and ad.aim = ca.aim
              --               and not exists (select * from cc_many where nd=d.nd)
              ) LOOP
      logger.info('CCK_DOP.CALC_SDI �' || k.nd || ' IR=' || to_char(k.ir) ||
                  ' acc8=' || to_char(k.acc8) || ' nd=' || to_char(k.nd) ||
                  ' wdate=' || to_char(k.wdate) || ' rnk=' ||
                  to_char(k.rnk) || ' kv=  ' || to_char(k.kv) || ' nbs =' ||
                  to_char(k.nbs2) || ' prod =' || to_char(k.prod));
      -- ������ ����� �������
      begin
        select fdat, lim2
          into dat1, SUM_ALL_
          from cc_lim
         where nd = k.nd
           and fdat = (select min(fdat)
                         from cc_lim
                        where lim2 > 0

                          and nd = k.nd);
      exception
        when no_data_found then
          logger.info('CCK_DOP.CALC_SDI :��� �������� �' || k.nd ||
                      ' �� ��������� ���!');
          goto end_loop;
      end;

      if SUM_SDI is null then
        -- EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';
        l_SUM_KOM := nvl(cck_app.to_number2(cck_app.get_nd_txt(nd_, 'S_SDI')) * 100,
                         0);
      else
        l_SUM_KOM := SUM_SDI;
      end if;

      delete from TMP_IRR;
      delete from cc_many where nd = nd_;

      /* ������ ����� IRR
           n_ := (k.wdate-dat1) +1;

           insert into TMP_IRR(n,s)
                -- ����� �� ���
           select 1 n, -(SUM_ALL_-SUM_KOM_) s from dual
           union all
                -- ������ � ���
           select o.n, nvl(l.sumo,0)
           from (select (dat1+c.num-1) FDAT, c.num N from conductor c
                 where c.num>1 and c.num <=n_    ) o,
                (select FDAT,SUMO
                 from cc_lim where nd=k.ND and fdat>dat1 and sumo>0) l
           where  o.FDAT = l.fdat  (+);

           select IRR( k.ir ) into IrrE_ from dual;
           -- ������� �� ���������� � �������
           -- ���� 1-�� ���
           -- ���� ���� (365 ����)
           IrrE_:= ( power( 1+IrrE_, 365 ) - 1 ) * 100;
      */
      --    ������ ����� ����� ������� XIRR

      insert into TMP_IRR
        (n, s)
        select 1 n,- (SUM_ALL_ - l_SUM_KOM) s
          from dual
        union all
        select (FDAT - dat1) + 1, SUMO
          from cc_lim
         where nd = k.ND
           and fdat > dat1
           and sumo > 0;

      select XIRR(k.ir) * 100 into IrrE_ from dual;

      --������ ���� �������
      ACRB_ := null;

      --        begin
      if l_SUM_KOM >= 0 then
        NBS_SDI_SPI := substr(nvl(k.nbs2, substr(k.prod, 1, 4)), 1, 3) || '6';
      else
        NBS_SDI_SPI := substr(nvl(k.nbs2, substr(k.prod, 1, 4)), 1, 3) || '5';
      end if;

      ACRB_ := cc_o_nls_ext(NBS_SDI_SPI,
                            k.rnk,
                            k.sour,
                            k.nd,
                            k.kv,
                            'SDI',
                            'SD ',
                            k.prod,
                            l_tt);

      if ACRB_ is null then
        logger.info('CCK_DOP.CALC_SDI NBS_SDI_SPI=' || NBS_SDI_SPI ||
                    ' RNK=' || to_char(k.rnk) || ' Sour=' ||
                    to_char(k.sour) || ' ND=' || to_char(k.nd) || ' KV=' ||
                    to_char(k.kv));
        raise_application_error(-20210,
                                '\8999 �� ������� ������� ������ �� �������� ��� �� ref=' ||
                                to_char(nd_),
                                TRUE);
      end if;
      --        exception when no_data_found then  null;
      --        end;
     
      --������� �������� ��� IRR
      delete from int_ratn
       where acc = k.ACC8
         and id = -2;
      delete from int_accn
       where acc = k.ACC8
         and id = -2;

      insert into int_accn
        (ACC, ID, acrb, METR, BASEY, FREQ)
      values
        (k.ACC8, -2, ACRB_, 0, 0, 1);

     -- round ��. ������ �� 8 ������ ����� �������
      Insert into int_ratn
        ( ACC, BDAT, ID, IR )
      values
        ( k.ACC8, dat1, -2, round(IrrE_,8) );
      
      --�������  �������� ������
      logger.info('CCK_DOP.CALC_SDI SDI=' || to_char(l_sum_kom));

      Insert into CC_many
        (ND, FDAT, SS1, SDP, SS2, SN2)
        select k.ND, dat1, SUM_ALL_ / 100, l_SUM_KOM / 100, 0, 0
          from dual
        union all
        select k.ND, fdat, 0, 0, sumg / 100, (sumo - sumg) / 100
          FROM cc_LIM
         where nd = k.ND
           and fdat > dat1;

      -- ���������
      update tmp_irr set s = s - l_SUM_KOM where n = 1;
      select XIRR(k.ir) * 100 into IrrE_ from dual;
      --     IrrE_:= ( power( 1+IrrE_, 365 ) - 1 ) * 100;
      update cc_deal set ir = IrrE_ where nd = k.nd;

      <<end_loop>>
      NULL;
      --  exception when others then
    --    Err_:=SQLERRM;
    --    bars_audit.INFO('START IRR ��������� ������ ��� �������� nd='||k.nd||' �� ������� �� �������. '||Err_);
    --  end;

    end LOOP;

  end calc_sdi;

  -- �������� �������� �� ��������������� ��������
  -----------------------------------------------------------
  --  PAY_SDI ()
  --      �� ����� ODB �� ���� SDI  �� �����.

  function pay_sdi(p_nd in int, p_sum_sdi int := null) return int is
    REF_      int;
    l_dk      int := 1;
    l_fl_opl  int := 0;
    l_tt      char(3) := '015';
    l_vob     int := 6;
    l_user_id int; -- ��� ��������� �� ��
    --   l_ostc    accounts.ostc%type;
    --   l_ostb    accounts.ostb%type;

    l_sum_sdi number;

    l_instr_ODB cck_app.t_pmt_instr; -- ��������� ���������� ����� ODB
    l_instr_SDI cck_app.t_pmt_instr; -- ��������� ���������� ����� SDI
    /*
     mfo  oper.mfob%type, -- ��� ����������
     nls  oper.nlsb%type, -- ����� ����� ����������
     nam oper.nam_b%type, -- ������������ ����� ����������
     okpo oper.id_b%type, -- ��� ����������
     nazn oper.nazn%type -- ���������� �������
    */

  begin
    if p_sum_sdi is null then
      l_sum_sdi := cck_app.to_number2(cck_app.get_nd_txt(p_nd, 'S_SDI')) * 100;
    else
      l_sum_sdi := p_sum_sdi;
    end if;

    if l_sum_sdi is null or l_sum_sdi = 0 then
      return null;
    end if;
    -- ����� ����� ��������
    begin
      select a.nls,
             a.kv,
             substr(a.nms, 1, 38),
             c.okpo,
             d.user_id,
             '������ �� ������� ������� �' || d.cc_id || ' �� ' ||
             to_char(d.sdate, 'dd/mm/yyyy')
        into l_instr_SDI.nls,
             l_instr_SDI.kv,
             l_instr_SDI.nam,
             l_instr_SDI.okpo,
             l_user_id,
             l_instr_SDI.nazn
        from cc_deal d, cc_add ca, nd_acc n, accounts a, customer c
       where d.nd = n.nd
         and d.rnk = c.rnk
         and n.acc = a.acc
         and a.tip = 'SDI'
         and ca.nd = d.nd
         and ca.adds = 0
         and a.kv = ca.kv
         and d.nd = p_nd;

    exception
      when no_data_found then
        raise_application_error(-20210,
                                '\8999 �� ������� ������� �������� ��� �� ref=' ||
                                to_char(p_nd),
                                TRUE);
      when TOO_MANY_ROWS then
        raise_application_error(-20210,
                                '\8999 �� ref=' || to_char(p_nd) ||
                                ' �� ������� ������� �������.',
                                TRUE);
    end;

    -- ����� �������� �����
    begin
      select a.nls, a.kv, substr(a.nms, 1, 38), c.okpo
        into l_instr_ODB.nls,
             l_instr_ODB.kv,
             l_instr_ODB.nam,
             l_instr_ODB.okpo
        from nd_acc n, accounts a, customer c
       where a.rnk = c.rnk
         and n.acc = a.acc
         and (a.tip = 'ODB' or a.nbs in ('2620', '2625') )
         and a.kv = l_instr_SDI.kv
         and n.nd = p_nd
         and a.ostc = (select max(a1.ostc)
                         from nd_acc n1, accounts a1, customer c1
                        where a1.rnk = c1.rnk
                          and n1.acc = a1.acc
                          and (a1.tip = 'ODB' or a1.nbs in ('2620','2625') )
                          and a1.kv = a.kv
                          and n1.nd = n.nd);

    exception
      when no_data_found then
        raise_application_error(-20210,
                                '\8999 � �� ���=' || to_char(p_nd) ||
                                ' �������� �������� �������',
                                TRUE);
    end;

    --    if l_ostc!=0 then
    --       raise_application_error(-20210,'\8999 � �� ref='||to_char(p_nd)' ������� '||l_instr_ODB.nls||' ��� �� �������',TRUE);
    --    end if;

    GL.REF(REF_);

    gl.in_doc3(ref_   => REF_,
               tt_    => l_TT,
               vob_   => l_vob,
               nd_    => substr(to_char(REF_), 1, 10),
               pdat_  => SYSDATE,
               vdat_  => gl.BDATE,
               dk_    => l_dk,
               kv_    => l_instr_ODB.kv,
               s_     => l_sum_sdi,
               kv2_   => l_instr_SDI.kv,
               s2_    => l_sum_sdi,
               sk_    => null,
               data_  => gl.BDATE,
               datp_  => gl.bdate,
               nam_a_ => substr(l_instr_ODB.nam, 1, 38),
               nlsa_  => l_instr_ODB.nls,
               mfoa_  => gl.aMfo,
               nam_b_ => substr(l_instr_SDI.NAM, 1, 38),
               nlsb_  => l_instr_SDI.nls,
               mfob_  => l_instr_SDI.mfo,
               nazn_  => substr(l_instr_SDI.NAZN, 1, 160),
               d_rec_ => null,
               id_a_  => l_instr_ODB.okpo,
               id_b_  => l_instr_SDI.okpo,
               id_o_  => null,
               sign_  => null,
               sos_   => 0,
               prty_  => null,
               uid_   => l_user_id);

    paytt(flg_  => l_fl_opl,
          ref_  => REF_,
          datv_ => gl.bDATE,
          tt_   => l_TT,
          dk0_  => l_dk,
          kva_  => l_instr_ODB.kv,
          nls1_ => l_instr_ODB.nls,
          sa_   => l_sum_sdi,
          kvb_  => l_instr_SDI.kv,
          nls2_ => l_instr_SDI.nls,
          sb_   => l_sum_sdi);

    dbms_output.put_line('PAY_SDI=' || to_char(ref_));
    gl.pay(2, ref_, gl.bdate);

    return ref_;

  end pay_sdi;

  -- �������� �������� �� ������ (������� �������� ����)
  -----------------------------------------------------------
  --  pay_lending_money ()
  --      ��������� ������ ����� �� ���� ������������ ���� (�� ���� cc_deal.kredacc)
  --    p_nd       - ��� ��������
  --    p_sum_sdi  - ����� ��������

  function pay_lending_money(p_nd in int, p_sum int := null) return int is
    REF_      int;
    l_dk      int := 1;
    l_fl_opl  int := 0;
    l_tt      char(3);
    l_vob     int := 6;
    l_sc      int; -- ������ ���������
    l_user_id int; -- ��� ��������� �� ��

    l_sdate date;
    l_cc_id cc_deal.cc_id%type;

    --   l_ostc    accounts.ostc%type;
    --   l_ostb    accounts.ostb%type;

    l_sum number;

    l_instr_SS  cck_app.t_pmt_instr; -- ��������� �������� �����
    l_instr_ODB cck_app.t_pmt_instr; -- ��������� ���������� ����� ������

    -- ��� ��������� ��� ������ ��������
    l_fio   operw.value%type;
    l_PASP  operw.value%type;
    l_PASPN operw.value%type;
    l_ATRT  operw.value%type;
    l_adres operw.value%type;
    l_DT_R  operw.value%type;

    l_err int;

    /*
     mfo  oper.mfob%type, -- ��� ����������
     nls  oper.nlsb%type, -- ����� ����� ����������
     nam oper.nam_b%type, -- ������������ ����� ����������
     okpo oper.id_b%type, -- ��� ����������
     nazn oper.nazn%type -- ���������� �������
    */

  begin
    -- ���� ����� �� ������ ������ ������ �� ����������� ����������
    if p_sum is null then
      select max(abs(ostx)) - max(abs(a.ostb))
        into l_sum
        from accounts a, nd_acc n, cc_deal d
       where a.tip = 'LIM'
         and a.acc = n.acc
         and n.nd = d.nd
         and d.nd = p_nd;
    else
      l_sum := p_sum;
    end if;

    if l_sum is null or l_sum = 0 then
      return null;
    end if;

    -- ����� �������� �����
    -- ��������� ��������� ����� �

    begin
      select a.nls,
             a.kv,
             substr(a.nms, 1, 38),
             c.okpo,
             d.user_id,
             '������ �� ������� ������� �' || d.cc_id || ' �� ' ||
             to_char(d.sdate, 'dd/mm/yyyy')
        into l_instr_SS.nls,
             l_instr_SS.kv,
             l_instr_SS.nam,
             l_instr_SS.okpo,
             l_user_id,
             l_instr_SS.nazn
        from cc_deal d, cc_add ca, nd_acc n, accounts a, customer c
       where d.nd = n.nd
         and d.rnk = c.rnk
         and n.acc = a.acc
         and a.tip = 'SS '
         and ca.nd = d.nd
         and ca.adds = 0
         and a.kv = ca.kv
         and d.nd = p_nd
         and rownum = 1;

    exception
      when no_data_found then
        raise_application_error(-20210,
                                '\8999 �� �������� ������� ������� ��� �� ref=' ||
                                to_char(p_nd),
                                TRUE);
    end;

    -- ��������� ��������� ����� �

    select nvl(ca.mfokred, gl.AMFO),
           ca.acckred,
           nvl(okpokred, l_instr_SS.okpo),
           coalesce(namkred, c.nmkk, substr(c.nmk, 1, 38)),
           nvl(naznkred,
               DECODE(SUBSTR(ca.acckred, 1, 3),
                      '100',
                      '������ ����i� ���i����',
                      '������������� ����i�') ||
               ' ��i��� ���������� �������� � ' || cc_id || ' �i� ' ||
               TO_CHAR(d.sdate, 'dd.mm.yyyy')),
           ca.kv,
           d.sdate,
           d.cc_id
      into l_instr_ODB.mfo,
           l_instr_ODB.nls,
           l_instr_ODB.okpo,
           l_instr_ODB.nam,
           l_instr_ODB.nazn,
           l_instr_ODB.kv,
           l_sdate,
           l_cc_id
      from cc_deal d, cc_add ca, customer c
     where d.rnk = c.rnk
       and d.nd = ca.nd
       and adds = 0
       and d.nd = p_nd;

    -- ��������� ��������� �����������
    --  ������ ������ �� ������� ����
    if l_instr_ODB.nls is null then

      -- ��������� ��������� ����� �
      begin
        select gl.AMFO,
               a.nls,
               c.okpo,
               substr(a.nms, 1, 38),
               '������������� ����i�' || ' ��i��� ���������� �������� � ' ||
               cc_id || ' �i� ' || TO_CHAR(d.sdate, 'dd.mm.yyyy'),
               ca.kv,
               d.sdate,
               d.cc_id
          into l_instr_ODB.mfo,
               l_instr_ODB.nls,
               l_instr_ODB.okpo,
               l_instr_ODB.nam,
               l_instr_ODB.nazn,
               l_instr_ODB.kv,
               l_sdate,
               l_cc_id
          from cc_deal d, cc_add ca, customer c, nd_acc n, accounts a
         where d.rnk = c.rnk
           and d.nd = ca.nd
           and adds = 0
           and d.nd = p_nd
           and d.nd = n.nd
           and n.acc = a.acc
           and a.nbs in ('2600', '2620', '2625')
           and rownum = 1
           and a.dazs is null;
      exception
        when no_data_found then
          l_instr_ODB.nls := null;
      end;

    end if;

    if l_instr_ODB.nls is null then
      raise_application_error(-20210,
                              '\8999 �� ��������� ������� ���������� �� �������� �������� ������� ��� �� ref=' ||
                              to_char(p_nd),
                              TRUE);
    end if;

    if gl.AMFO != l_instr_ODB.mfo               then   l_tt := 'KK2';   -- �������
    elsif substr(l_instr_ODB.nls, 1, 3) = '100' then   l_tt := 'KK3';    --  �����

     if nvl(l_instr_ODB.kv, l_instr_SS.kv) = gl.baseval then
        begin  select val into l_vob from params where par = 'KK3_NV';
        exception  when others then  raise_application_error(-20210, '\8999 ���������� ������� ���������� �������� "KK3_NV"',   TRUE);
        end;
      else
        begin select val into l_vob from params where par = 'KK3_IV';
        exception  when others then raise_application_error(-20210, '\8999 ���������� ������� ���������� �������� "KK3_IV"',  TRUE);
        end;
      end if;
    elsIf l_instr_ODB.nls like '2625%'           then   l_tt := 'PKR';   -- �� ���  2625
    else                                                l_tt := 'KK1';   -- ��������� ������
    end if;

    begin select substr(flags, 38, 1), sk  into l_FL_OPL, l_sc    from tts  where tt = l_tt;
    exception  when others then raise_application_error(-20210, '\8999 �� �������� ��� �������� ��� ������ '|| l_tt ,  TRUE);
    end;

    GL.REF(REF_);
    gl.in_doc3(ref_   => REF_,
               tt_    => l_TT,
               vob_   => l_vob,
               nd_    => substr(to_char(REF_), 1, 10),
               pdat_  => SYSDATE,
               vdat_  => gl.BDATE,
               dk_    => l_dk,
               kv_    => l_instr_SS.kv,
               s_     => l_sum,
               kv2_   => l_instr_ODB.kv,
               s2_    => l_sum,
               sk_    => l_sc,
               data_  => gl.BDATE,
               datp_  => gl.bdate,
               nam_a_ => substr(l_instr_SS.nam, 1, 38),
               nlsa_  => l_instr_SS.nls,
               mfoa_  => gl.aMfo,
               nam_b_ => substr(l_instr_ODB.NAM, 1, 38),
               nlsb_  => l_instr_ODB.nls,
               mfob_  => l_instr_ODB.mfo,
               nazn_  => substr(l_instr_ODB.NAZN, 1, 160),
               d_rec_ => null,
               id_a_  => l_instr_SS.okpo,
               id_b_  => l_instr_ODB.okpo,
               id_o_  => null,
               sign_  => null,
               sos_   => 0,
               prty_  => null,
               uid_   => l_user_id);

    paytt(flg_  => l_fl_opl,
          ref_  => REF_,
          datv_ => gl.bDATE,
          tt_   => l_TT,
          dk0_  => l_dk,
          kva_  => l_instr_SS.kv,
          nls1_ => l_instr_SS.nls,
          sa_   => l_sum,
          kvb_  => l_instr_ODB.kv,
          nls2_ => l_instr_ODB.nls,
          sb_   => l_sum);

    l_err := CCK.CC_STOP(REF_);

    dbms_output.put_line('PAY_LENDING_MONEY=' || to_char(l_instr_ODB.mfo));
    dbms_output.put_line('PAY_LENDING_MONEY=' || to_char(ref_));
    --     gl.pay(2,ref_,gl.bdate);

    If l_tt = 'KK3' then
      begin
        SELECT c.nmk,
               k.name,
               p.SER || ' ' || p.NUMDOC,
               p.ORGAN || ' ' || To_char(p.PDATE, 'dd/mm/yyyy'),
               to_char(p.BDAY, 'dd/mm/yyyy'),
               c.adr
          INTO l_FIO, l_PASP, l_PASPN, l_ATRT, l_DT_R, l_adres
          from PASSP k, person p, customer c, cc_deal d
         where d.nd = p_nd
           and d.nd = c.rnk
           and NVL(p.PASSP, 1) = k.PASSP(+)
           and c.rnk = p.rnk;

        INSERT INTO operw (ref, tag, value) VALUES (REF_, 'FIO', l_fio);
        INSERT INTO operw (ref, tag, value) VALUES (REF_, 'PASP', l_PASP);
        INSERT INTO operw
          (ref, tag, value)
        VALUES
          (REF_, 'PASPN', l_PASPN);
        INSERT INTO operw (ref, tag, value) VALUES (REF_, 'ATRT', l_ATRT);
        INSERT INTO operw
          (ref, tag, value)
        VALUES
          (REF_, 'ADRES', l_ADRES);
        INSERT INTO operw (ref, tag, value) VALUES (REF_, 'DT_R', l_DT_R);

      exception
        when NO_DATA_FOUND THEN
          null;
      end;
    end if;

    return ref_;

    null;
  end pay_lending_money;

  -- ��������� �����. ����������� �� ������ �� ��� ���������
  function get_isp_by_branch(p_branch in cck_isp_nls.branch%type)
    return staff$base.id%type is
    l_acc_isp staff$base.id%type;
  begin
    -- ���� ����������� �� ������ ����� � ����������, ����������� ������ ����
    -- �� �� ��������� � ����� ������� �����. �����������
    select isp  into l_acc_isp
    from (select cin.isp from cck_isp_nls cin
          where cin.branch = p_branch   and not exists
             (select * from staff$base sb
              where sb.id = cin.isp  and (nvl(sb.bax, 0) = 0 or sb.type != 1)
             )
          order by cin.ord)
     where rownum = 1;

    return l_acc_isp;
  exception
    when no_data_found then
      -- ��� ��������� %s �� �������� ���������� "�i����i�����i ��������i �� ������� ��� �����. �������� � ��" ��� ��������� ����������� ��������� �� ��������� ��� �� ������������������ ��� �����. �����������.
      bars_error.raise_nerror('CCK', 'ACCISP_BY_BRANCH_NOTFOUND', p_branch);
  end get_isp_by_branch;

  -- ��������� �����. ����������� �� ������ �� ��� ����������
  function get_isp_by_user(p_id in cck_isp_nls.id%type)
    return staff$base.id%type is
    l_sb_row  staff$base%rowtype;
    l_acc_isp staff$base.id%type;
  begin
    -- ���� ����������� �� ������ ����� � ����������, ����������� ������ ����
    -- �� �� ��������� � ����� ������� �����. �����������
    select isp
      into l_acc_isp
      from (select cin.isp
              from cck_isp_nls cin
             where cin.id = p_id
               and not exists
             (select *
                      from staff$base sb
                     where sb.id = cin.isp
                       and (nvl(sb.bax, 0) = 0 or sb.type != 1))
             order by cin.ord)
     where rownum = 1;

    return l_acc_isp;
  exception
    when no_data_found then
      -- ���� �� ���� ������ ������������
      select * into l_sb_row from staff$base sb where sb.id = p_id;

      return get_isp_by_branch(l_sb_row.branch);
  end get_isp_by_user;

  -- �������� ����� �� �� ����
  procedure open_account(p_nd  in cc_deal.nd%type,
                         p_tip in accounts.tip%type) is
    l_prod    cc_deal.prod%type;
    l_rnk     cc_deal.rnk%type;
    l_user_id cc_deal.USER_ID%type;
    l_wdate   cc_deal.wdate%type;

    l_acc8 accounts.acc%type;
    l_kv   accounts.kv%type;
    l_grp  accounts.grp%type;

    l_ob22_prd_nbs cc_deal.prod%type;

    l_acc accounts.acc%type;
    l_nbs accounts.nbs%type;
    l_nls accounts.nls%type;

    l_isp staff$base.id%type; -- �����. ����������� �� ������ ��
  begin
    -- ���� ���� ������ ���� ��� ������ �� �������
    declare
      l_tmp number;
    begin
      select count(*)
        into l_tmp
        from nd_acc na, accounts a
       where na.nd = p_nd
         and na.acc = a.acc
         and a.tip = p_tip;

      if (l_tmp > 0) then
        return;
      end if;
    end;

    -- ��������� ��
    select cd.prod, cd.rnk, cd.user_id, cd.wdate, a.acc, a.kv, a.grp
      into l_prod, l_rnk, l_user_id, l_wdate, l_acc8, l_kv, l_grp
      from cc_deal cd, nd_acc na, accounts a
     where cd.nd = p_nd
       and cd.nd = na.nd
       and na.acc = a.acc
       and a.tip = 'LIM';

    -- ���������� ���� �������� � �������� ��22
    l_ob22_prd_nbs := substr(l_prod, 1, 4);

    -- ����� ����� ����������� �� ������ ��
    --l_isp := cck_dop.get_isp_by_user(l_user_id);
    -- ������ ������������ ������� ��������� �����������
      l_isp := sys_context('bars_global', 'user_id');

    -- ���������� ����� ����� � ����������� �� ���� �����
    case (p_tip)
      when 'SS ' then
        l_nbs := l_ob22_prd_nbs;
      when 'SN ' then
        l_nbs := substr(l_ob22_prd_nbs, 1, 3) || '8';
      when 'SDI' then
        l_nbs := substr(l_ob22_prd_nbs, 1, 3) || '6';
      else
        l_nbs := null;
    end case;

    -- ����� ����� � ����������� �� ���� �����
    case p_tip
      when 'SD ' then
        l_nls := cc_f_nls(l_ob22_prd_nbs, l_rnk, null, p_nd, l_kv, p_tip);
      else
        l_nls := f_newnls(l_acc8, p_tip, l_nbs);
    end case;
    if l_nls is null then
      -- ������ ����������� ����������, �.�. ��� ������ �������� ��� ����������� ������������� ���������� ���� ���� %s.
      bars_error.raise_nerror('CCK', 'AUTH_ERROR_CANNT_OPEN_ACC', p_tip);
    end if;

    -- ��������� � ����������� �� ���� �����
    case p_tip
      when 'SD ' then
        cck.cc_op_nls(p_nd,
                      gl.baseval,
                      l_nls,
                      p_tip,
                      l_isp,
                      l_grp,
                      null,
                      l_wdate,
                      l_acc);
      else
        declare
          l_sum_sdi number := cck_app.to_number2(cck_app.get_nd_txt(p_nd,
                                                                    'S_SDI'));
        begin
          -- ���� �������� ������ �� ���������
          if (p_tip != 'SDI' or nvl(l_sum_sdi, 0) != 0) then
            cck.cc_op_nls(p_nd,
                          l_kv,
                          l_nls,
                          p_tip,
                          l_isp,
                          l_grp,
                          null,
                          l_wdate,
                          l_acc);
          end if;
        end;
    end case;
  end open_account;

  -- ������������� �������� ����� ��
  procedure open_an_account(p_nd  in cc_deal.nd%type,
                            p_tip in varchar2_list) is
  begin
    for k in p_tip.first .. p_tip.last loop
      open_account(p_nd, p_tip(k));
    end loop;
  end open_an_account;

----- ����������� ��-------------------------
procedure cc_autor(p_nd   in number,
                   p_saim in varchar2 default null,
                   p_urov in varchar2 default null
                   ) is
  l_deal_source number;
  l_cd_row      cc_deal%rowtype;
  l_tmp_cnt number;
  l_acc  accounts.acc%type;
  tmp_   int;
  ref_   int;
  t      date := sysdate;
  l_acc8_old accounts.accc%type := null;
  l_acc8_new accounts.accc%type := null;
  RaxN_ char(1) ; --������� ������ ���� �� ��� ����������: '1' -��. ����� -���

  l_PAR_N   nd_txt.txt%type;
  ww        WCS_PARTNERS_ALL%rowtype;
  l_RomStal int := 0; -- ������� =1 =  ��� ������� ������
  l_ES001   nd_txt.txt%type;
  l_SDI     number := 0;
  l_SDI_add number := 0;
begin

  -- �������� �� ��� ����������� �����������
  select * into l_cd_row from cc_deal where nd = p_nd;
  if l_cd_row.sos > 5 then     RETURN;  end if;
  ----------------------------------------------
 
  -- COBUSUPABS-4863
  If l_cd_row.vidd in (11,12,13) then 
   
     -- 3.1. ��� ������� ��, ����������� �������� ������������ ���������� ����������� ��������� ���������� �������� ���������� �������� 
     If CCK_APP.Get_ND_TXT (p_ND => l_cd_row.ND, p_TAG =>'PARTN') in ('YES','Ta�')  then  

        -- � ������� ���������� ��������� ���������� �������� - ����, 
        -- �������� �������� ��� ������� ���� ����������� ��� ���������� 
        l_PAR_N := CCK_APP.Get_ND_TXT (p_ND => l_cd_row.ND, p_TAG =>'PAR_N') ;
        If l_PAR_N is null then raise_application_error(  -20203, '�� �������� �������� �������� ' );  end if; 

        --� �������, ���� � �������� �������� ��������� ���� ������� ������ (TABLE - WCS_PARTNERS_ALL, PTN_NLS = 26002003045900, PTN_OKPO = 32346937) 
        -- ������������� ������������ ���������� ����: 
        Begin select * into ww from  WCS_PARTNERS_ALL where to_char (id) = trim(l_PAR_N) and PTN_OKPO = '32346937' ;   

           --ES001    ������� ������ (����.��������)
           l_ES001 := CCK_APP.Get_ND_TXT (p_ND => l_cd_row.ND, p_TAG =>'ES001') ;
           If l_ES001 is null then raise_application_error(  -20203, '�� �������� �������� �������� ������ (����.��������)�' );  end if; 

           ---����������������� ����� (������ �� - ES104 or ES110 or ES116 or �)
           begin select 1 into l_RomStal from nd_txt 
                 where nd =  l_cd_row.ND and rownum = 1  and tag in (select tag from cc_tag where tag like 'ES1%' AND TABLE_NAME = 'VW_ESCR_EVENTS_CENTURA' );
           EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(  -20203, '�� �������� ������ �������� ����������������� �����' ); 
           end;

        EXCEPTION WHEN NO_DATA_FOUND THEN  l_RomStal  := 0;
        end ;
     end if ;
  end if ;  -- COBUSUPABS-4863

  

/*  -- ���� ��� ��� �������� ������� (������ �� ������)
  if substr (l_cd_row.prod,1,1)='9' then    return;  end if;*/

  If l_RomStal  = 1 then  ---- COBUSUPABS-4863 �������� ����� �������� �� ���������
     --���� ���� ���� ������� ������������� ��� ���������� ���, ����� � ����� ���� �� �������, ��� ������ ����������� �� � ���������� ��������������. 
     --���� ���� ������������� �� ��������:    0,5/6 * �� , ��: �� - �������� ��������� �������� ������(����. ��������)�.
     begin l_SDI_add := round(to_number (l_ES001) * 1/12 ,2) ;
           l_SDI     := to_number (CCK_APP.Get_ND_TXT (p_ND => l_cd_row.ND, p_TAG => 'S_SDI' ) ); 
           l_SDI     := Nvl(l_SDI,0);           
           l_SDI     := l_SDI + l_SDI_add; 
           CCK_APP.Set_ND_TXT (p_ND => l_cd_row.ND, p_TAG => 'S_SDI'  ,p_TXT => to_char(l_SDI) ) ;
     exception when others then raise_application_error(  -20203, '��������� ����������� ���������� ������� �� ����.������='||l_ES001 ); 
     end ;  
  end if ;  --- COBUSUPABS-4863

  -- ���������� ������� � ������ ��. ������
  if l_cd_row.vidd in (2,3,12,13) then
         logger.info('CCK_DOP.CALC_SDI VIDD =' || l_cd_row.vidd ||'��� ��������  ND=' || to_char(l_cd_row.nd) ||'��������� ��� �������� ��.������ �� �������������');
  else
      select count(*) into l_tmp_cnt from cc_many where nd = p_nd ;
      if (l_tmp_cnt = 0) then      calc_sdi( p_nd, null);  end if ;
  end if;

  If l_cd_row.NDI is null then  GOTO NEW_ACC ;  end if;
  -----------------------------------------------------

  -- ����������������  ����� -------
  RaxN_ := nvl( substr(CCK_APP.Get_ND_TXT (p_ND,'OLD_A'),1,1),'0');

  begin  select a.acc into l_acc8_new from accounts a, nd_acc n where n.nd=p_ND and n.acc=a.acc and a.tip='LIM' and a.nls like '8999%';
  EXCEPTION WHEN NO_DATA_FOUND THEN  return;
  end;

  for k in (select a.acc, a.tip, a.accc from nd_acc n, accounts a where n.nd =l_cd_row.NDI and n.acc= a.acc  and a.dazs is null order by decode(a.tip,'LIM',1,2)  )
  loop

     if k.tip = 'LIM' and RaxN_ = '1' then   l_acc8_old := k.acc;
        -- �������� ������ 8999
        update accounts set dazs=gl.bdate+1,ostc=0,ostb=0,ostf=0 where acc=k.acc;
     else
        -- ���� ������� ��������� ��� ����� 8999, ���� ������ �����������
        If k.accc = l_acc8_old  AND RaxN_ = '1' then
           update accounts set accc = l_acc8_new where acc= k.acc;
        end if;
        -- ���� ������� ����������� ������
        -- ������ ����� ����������� ������ � ������ , ���� ������ �����������
        If k.tip = 'SG '         OR RaxN_ = '1' then
           -- ��� �����
           delete from nd_acc where nd = l_cd_row.NDI  and acc= k.acc ;
           insert into nd_acc ( nd,acc) values (p_ND, k.acc)  ;
        end if;
     end if;

  end loop;

  --������ �����������
  If RaxN_ = '1' then      -- ��������������� ��� �� ����� 8999
     CCK.cc_START(p_ND) ;  -- ����������� ������������� ����������� ������ �� ������� �������������
     RETURN;
  end if;
  -------------------------------------------------

  -- �������� ��������� ������ ��  ��������
  <<NEW_ACC >> null;
  ------------------
  declare
     l_stmt_pattern varchar2(4000) := 'select count(*) from dual where ';
     l_force_open   number;
  begin
     for cur in (select * from vidd_tip where vidd = l_cd_row.vidd)
     loop
        -- ������� �������� ��������� �������������� �������� ����� � ��������� ��� ���� ����������
        if cur.force_open in ('0', '1') then     l_force_open := to_number(cur.force_open);
        else                                     doc_strans(l_stmt_pattern || cur.force_open, l_force_open, p_nd);
        end if;
        -- ��������� ��� ��� ���� � ����������� �� ���������
        if l_force_open = 1 then   cck_dop.open_account(p_nd, cur.tip);    end if;
     end loop;
  end;
 
  If l_RomStal  = 1 and l_SDI_add > 0 then ---- COBUSUPABS-4863
     --3.2. �����������, ��� ����������� ���������� ��������, ���� ������� ������ (3.1.) ����������� ���������� ��������:
     -- ��. 3578 (05)* � ��. 2206 (SDI)**
     --* - ������� 3578 (��22=05) ����������� � ������ ������� �� ��� �볺��� ���� ������� ������ (���� = 32346937). � �������, ���� �볺��� � ����� ���� �� ��������, ��� � ����� �������� �������� ������� 3578 (05). ������� ������� �������� �������� ����������� � ��������� ����������� ��������;
     --** - ������� �������� ��� ������ ���������� ��������;
     declare oo oper%rowtype;
     begin 
        oo.dk   := 1 ;
        oo.kv   := gl.Baseval ;
        oo.nd   := substr( l_cd_row.cc_id,1,10) ;
        oo.tt   := 'ASG' ;
        oo.s    := l_SDI_add *100;
        oo.nazn := Substr(  '����������� �������� ������ �� ��������� '|| l_cd_row.cc_id || ' �� '|| to_char(l_cd_row.sdate,'dd.mm.yyyy'), 1, 160 );

        begin select a.nls, substr(a.nms,1,38), c.okpo     into oo.nlsa, oo.nam_a , oo.id_a   from accounts a, customer c 
              where c.okpo = ww.PTN_OKPO  and a.rnk = c.rnk and rownum = 1 and a.kv = oo.kv  and a.nbs = '3578' and a.ob22 ='05' and a.dazs is null ;
        EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(  -20203, '�� �������� ��� 3578/05 ��� '||ww.PTN_NAME|| ', ��.���='||ww.PTN_OKPO  ); 
        end;

        begin select a.nls, substr(a.nms,1,38), c.okpo     into oo.nlsb, oo.nam_b, oo.id_b    from accounts a, customer c , nd_acc n
              where n.nd = l_cd_row.ND and a.acc = n.acc and a.tip ='SDI' and a.kv = oo.kv and a.rnk = c.rnk and a.dazs is null ;
        EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(  -20203, '�� �������� ��� SDI  ��� �� '||l_cd_row.ND);
        end;

        GL.REF ( oo.REF) ;  
        gl.in_doc3(ref_=>oo.REF  , tt_  =>oo.tt  , vob_ => 6      , nd_   => oo.nd   , pdat_=> SYSDATE, vdat_=> gl.BDATE, 
                   dk_ =>oo.dk   , kv_  =>oo.kv  , s_   => oo.s   , kv2_  => oo.kv   , s2_  => oo.s   , sk_  => null, data_=> gl.BDATE , datp_=> gl.bdate,
                 nam_a_=>oo.nam_a, nlsa_=>oo.nlsa, mfoa_=> gl.aMfo, nam_b_=> oo.nam_b, nlsb_=> oo.nlsb, mfob_=> gl.aMfo , 
                 nazn_ =>oo.nazn ,d_rec_=> null  , id_a_=> oo.id_a, id_b_ => oo.id_b , id_o_=> null   , sign_=> null, sos_=>1, prty_=>null, uid_=>null) ;
        gl.payV ( 0, oo.REF, gl.BDATE , oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv, oo.nlsb, oo.s );  
        gl.pay  ( 2, oo.REF, gl.BDATE);
     end ;
  end If ;  ---- COBUSUPABS-4863

  -- ==== ����������� ====
  -- ������� �������� �������� �� ( 2 - ������ � WCS)

  l_deal_source := to_number(cck_app.get_nd_txt(p_nd, 'CCSRC'));

  -- ���� ���������� �� ���� ����� �� �����������  �������,
  -- �� ������������ ����������� �� ������ � ������� GRT_MGR

  if (l_deal_source = 2) then
     for k in (select grt_deal_id from cc_grt where nd = p_nd)
     loop
        l_acc := grt_mgr.authorize_deal ( k.grt_deal_id ) ;
        grt_mgr.create_account_balance  ( k.grt_deal_id ) ;
     end loop;
     RETURN;
  end if;
  
/*     if p_nd=5911154601 then
      raise_application_error(-20005,'cck.AUTOR');
    end if;*/
-- ����� ����������� ��������� �����������
  cck.cc_autor(p_nd, p_saim, p_urov);
  -- �� ���� ��������� ������� �� �������
  declare
     l_nls9     tts.nlsm%type      ; l_nms9     accounts.nms%type             ;
     l_fl_opl   int                ; l_nms_zal  customer.nmk%type             ;
     l_okpo     customer.okpo%type ; l_custtype customer.custtype%type        ;
     l_new_nls  accounts.nls%type  ; l_ob22     accounts.ob22%type            ;
     l_new_acc  accounts.acc%type  ; l_vob      number  ; nazn_ varchar2(160) ;
     l_sb_row   staff$base%rowtype ; l_dk       int     ; l_ccv cc_v%rowtype  ;

     -- ��� ����������, ������� �������� �.�. ����,
     -- ��� ������� � �������� �������� ��� ���������
     -- ��������� ���� ������� (�� ��������� �� STAFF$BASE, � ����� ���������� �������)
     l_branch branch.branch%type :=
                sys_context('bars_context','user_branch');

  begin
     -- ��������� �������
     select * into l_ccv from cc_v where nd = p_nd;

     -- ���������� ������ ������ �������� ��� ����������� ���������� ���
     -- �������������� ������ ��������       -- bc.set_context;
     bc.subst_branch(l_ccv.branch);

     --l_sb_row.id := cck_dop.get_isp_by_branch( l_ccv.branch);
     l_sb_row.id := sys_context('bars_global', 'user_id');      

     -- ���� ����� ���� ��� �����������
     select nlsm,substr(flags,38,1) into l_nls9,l_fl_opl from tts where tt='ZAL';

     if substr(l_nls9, 1, 2) = '#(' then      -- dynamic account number present
        execute immediate 'select '||substr(l_nls9,3,length(l_nls9)-3)||' from dual' into l_nls9;
     end if;

     -- ��� ������������
     select substr(nms,1,38) into l_nms9 from accounts where nls=l_nls9 and kv=gl.baseval;

     -- ���������� ���������� ����������� � ������������� ��������� �����������
     for k in
        (SELECT cck_app.to_number2(txt)                          as PAWN,
 (select nbsz from cc_pawn where pawn = to_number(n.txt))        as NBSZ,
 100 * cck_app.to_number2(
       cck_app.get_nd_txt(p_nd,'ZAY'||substr(n.tag,4,1) || 'S')) as SUM,
       cck_app.to_number2(
       cck_app.get_nd_txt(p_nd,'ZAY'||substr(n.tag,4,1) || 'R')) as RNK
         FROM nd_txt n
         WHERE n.nd = p_nd and tag like 'ZAY_P'
         )

     LOOP

       -- ��������� ������������
       select substr(nmk,1,38),okpo,custtype into l_nms_zal,l_okpo,l_custtype
       from customer where rnk = k.rnk;

       -- ��������� ���� �����������
       l_new_nls := bars.f_newnls2(l_ccv.acc8,'ZAL', k.nbsz,  l_ccv.rnk, null);

       if k.nbsz = '9031' then  l_nms_zal := l_nms_zal || ' ������';
       else                     l_nms_zal := l_nms_zal || ' �������';
       end if;

       Op_Reg(2,p_nd,k.pawn,1,tmp_,k.rnk,l_new_nls,gl.baseval,l_nms_zal,'ZAL',
              l_sb_row.id,  l_new_acc);

       update pawn_acc set sv = k.sum where acc = l_new_acc;
       
       -- 05.07.2012 Sta OB22  ��� ������� � ��������
       If ( k.nbsz like '9500' )
       then
         /*
          9500 ���� ��������� ob22 = mpawn = ����� ������ ������ = 01,02,03
          R020 OB TXT
          ---- -- --------------------------------------------------------------------------------------------
          9500 01 ������� ��, �� ��� ������� ������� ���������� � ������������
          9500 02 ������� ��, �� ��� ������� ������� ���������� �� ��������� ����������������
          9500 03 ������� ��, �� ��� ������� ������� ���������� ����� ������
          9500 04 ������� ��, �� ��� ������� ������� ���������� � ������������
          9500 05 ������� ��, �� ��� ������� ������� ���������� �� ��������� ��������
          9500 06 ������� ��, �� ��� ������� ������� ���������� ����� ������
          ���...�����������.������ �� ª� �� ����������. ���������� � ������������
         */

          if  l_custtype = 3 then  l_ob22 := '01';
          else                     l_ob22 := '04';
          end if;

       else
         /*
          9031 �������� � 9520 9521 9523 ���������� ���������
          R020 OB TXT
          ---- -- ----------------------------------------------------------------------------------------
          9031 01 �������� �������������� �� �������� ���
          9031 02 �������� ������ �� ���`���i� ��������������
          9031 03 �������� ������ �� ������� �������� �����
          9520 01 �������� ������, ������ � ������� ��������� �������
          9520 02 �������� ������, ������ � ������� ���`������ ��������������
          9521 01 �������� ����� ��������� �����������, ������ � ������� ��������� �������
          9521 02 �������� ����� ��������� �����������, ������ � ������� ���`������ ��������������
          9523 01 ���� ��`���� ���������� �����, ������ � ������� ��������� �������
          9523 02 ���� ��`���� ���������� �����, ������ � ������� ���`������ ��������������
             --03 - �������i �i� �����i� �������� ����� *****���� ��� ! �������� � ����� (��������)
         */

          if  l_custtype = 3 then  l_ob22 := '01';
          else                     l_ob22 := '02';
          end if;

       end if;
       
       Accreg.setAccountSParam( l_new_acc, 'OB22', l_ob22 );
       
       update pawn_acc set sv = k.sum where acc = l_new_acc;

       -- �������� ����� � ������ ��������
       insert into cc_accp    (acc, accs, nd)
       select l_new_acc, a.acc, n.nd  from accounts a, nd_acc n
        where n.nd = p_nd and n.acc=a.acc and a.tip in ('SS ','SP ','SL ')
          and not exists
           ( select 1 from cc_accp where acc=l_new_acc and accs = a.acc);

       SELECT to_number(val) into l_vob from params where par = 'VOB9_P';

       if k.nbsz = '9031' then l_dk  := 0;
          nazn_ := '����������� ������ ��i��� ����� ' || l_ccv.cc_id ||
                   ' �i� ' || to_char(l_ccv.dsdate, 'dd/mm/yyyy');
       else                    l_dk  := 1;
          nazn_ := '����������� ������� ��i��� ����� ' || l_ccv.cc_id ||
                  ' �i� ' || to_char(l_ccv.dsdate, 'dd/mm/yyyy');
       end if;

       begin

         gl.ref(ref_);
         gl.in_doc3
           (ref_,'ZAL', l_vob, ref_, sysdate , gl.bdate, l_dk, gl.baseval,
            k.sum, gl.baseval, k.sum,   null , gl.bdate, gl.bdate,
            substr(l_nms_zal,1,38),l_new_nls , gl.amfo,
            substr(l_nms9,   1,38),l_nls9    , gl.amfo, substr(nazn_,1,160),
            null , l_okpo,  l_okpo, null,null, 0,null , l_ccv.id);

       exception when others then
         -- ��������� � ���� ������� ���������
         bc.subst_branch(l_branch);
         -- ���������� ������� ������
         raise_application_error(-20000,sqlerrm || chr(10) ||
                                 dbms_utility.format_error_backtrace(), true);
       end;

       gl.payv(l_fl_opl, ref_, gl.bdate, 'ZAL', l_dk,  gl.baseval,l_new_nls,   k.sum,  gl.baseval,   l_nls9,   k.sum);

     end loop;
    
     -- ��������� � ���� ������� ���������
     bc.subst_branch(l_branch);

  end;

end cc_autor;

function get_prod_old(p_prod varchar2) return varchar2 is
l_prod_old varchar2(6);
begin
   l_prod_old := p_prod;
  begin 
   SELECT r020_old || ob_old
      INTO l_prod_old
      FROM transfer_2017
     WHERE r020_new || ob_new = p_prod AND r020_new > r020_old;
   exception when others then
     return l_prod_old;
   end;
return l_prod_old;
end get_prod_old;

-----------------------------------

  function header_version return varchar2 is
  begin
    return 'Package header CCK ' || G_HEADER_VERSION;
  end header_version;

  function body_version return varchar2 is
  begin
    return 'Package body CCK_DOP ' || G_BODY_VERSION;
  end body_version;

end cck_dop;
/
