

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AZZZ.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AZZZ ***

  CREATE OR REPLACE PROCEDURE BARS.AZZZ as

  CC_ID_   cc_deal.CC_ID%type;
  DAT1_    cc_deal.SDATE%type;
  nRet_    int               ;
  sRet_    varchar2(256)     ;
  rnk_     accounts.RNK%type ;
  nS_      number            ; -- ����� �������� �������
  nS1_     number            ; -- ����� �������������� �������
  NMK_     operw.value%type  ;
  OKPO_    customer.OKPO%type; -- OKPO         �������
  ADRES_   operw.value%type  ;
  KV_      accounts.KV%type  ;
  LCV_     tabval.LCV%type   ;  -- ISO ������   ��
  NAMEV_   tabval.NAME%type  ; -- �����a       ��
  UNIT_    tabval.UNIT%type  ; -- ���.������   ��
  GENDER_  tabval.GENDER%type; -- ��� ������   ��
  nSS_     number            ; -- ���.����� ���.�����
  DAT4_    cc_deal.WDATE%type; --\ ���� ���������� ��
  nSS1_    number            ; --/ �����.����� ���.�����
  DAT_SN_  date              ; --\ �� ����� ���� ��� %
  nSN_     number            ; --/ ����� ��� %
  nSN1_    number            ;-- | �����.����� ����.�����
  DAT_SK_  date              ; --\ �� ����� ���� ��� ���
  nSK_     number            ; --/ ����� ��� ����������� ��������
  nSK1_    number            ; --| �����.����� �����.�����
  KV_KOM_  int               ; -- ��� ��������
  DAT_SP_  date              ; -- �� ����� ���� ��� ����
  nSP_     number            ; -- ����� ��� ����������� ����
  NLS_8008 accounts.NLS%type ; --\
  NLS_8006 accounts.NLS%type ; --/ ����� ���������� ����
  MFOK_    oper.MFOB%type    ; --\
  nls_2909 accounts.NLS%type ; --/ ���� �������
--
ref_ int; S_ number;
begin
 S_:=50000;
 CC_ID_ :='IRR';
 DAT1_  := to_date('02-10-2008','dd-mm-yyyy');
 cck.GET_INFO( CC_ID_, DAT1_, nRet_, sRet_, rnk_,
  nS_    , -- ����� �������� �������
  nS1_   , -- ����� �������������� �������
  NMK_   , OKPO_, ADRES_, KV_, LCV_, NAMEV_, UNIT_, GENDER_,
  nSS_   , -- ���.����� ���.����� � �����
  DAT4_  ,
  nSS1_  , -- �����.����� ���.������ �����
  DAT_SN_,
  nSN_   , -- ����� ��� % � �����
  nSN1_  , -- �����.����� ����.������ �����
  DAT_SK_,
  nSK_   , -- ����� ��� ����������� �������� � �����
  nSK1_  , -- �����.����� �����.����� � �����
  KV_KOM_,
  DAT_SP_,
  nSP_   , -- ����� ��� ����������� ����
  NLS_8008, NLS_8006, MFOK_, nls_2909
);


 GL.REF (REF_);

 GL.IN_DOC3( REF_,'CCK',6,REF_,SYSDATE,GL.BDATE,1,
  KV_,S_,KV_,S_,  null,GL.BDATE,GL.BDATE,
 '�����' ,'10012' ,gl.AMFO,
 '��.���',nls_2909,gl.AMFO,
 '����-���',NULL, OKPO_,OKPO_, null,null, 0, null,gl.auid);

  INSERT INTO operw (ref,tag,value) VALUES (REF_,'CC_ID','IRR' );


-- ref_:= 12571331;
-- GL.REF (REF_);
 PAYTT(0,REF_,GL.BDATE,'CCK',0,KV_,nls_2909,S_,KV_,'10012',S_);

end;
/
show err;

PROMPT *** Create  grants  AZZZ ***
grant EXECUTE                                                                on AZZZ            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AZZZ.sql =========*** End *** ====
PROMPT ===================================================================================== 
