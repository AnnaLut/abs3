
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/last_rko1.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.LAST_RKO1 (TODAY_DAT DATE,NLSA VARCHAR2,KV NUMBER,TT CHAR)
RETURN VARCHAR2 IS
DATNEXT_ DATE;  -- ����, ��������� �� ����� ���������� ��������
DATO_ DATE;  -- ���� �� OPER
DATS_ DATE;  -- ���� �� SALDOA
K_ VARCHAR2(4);
DATL_ VARCHAR2(15);
NLSA_ VARCHAR2(15);
TT_   CHAR(3);
KV_ NUMBER;
col_ number;
ern  CONSTANT POSITIVE := 1; erm  VARCHAR2(80); err  EXCEPTION;
--���������� ��� ��������������� ���������� ������� � ����������� (���)
-- ��������� ��������� ���� �������� �������� +1 ���� �� �������
-- ��� ����������� ��� ������� (���� ��� ���� ��� �������)
-- ��� ��������� �����
-- ������������� �� ������������ ������ �������� (�������� ��� � ������ � ����� ���)
-- QWA 20-10-2004
-- QWA 01-11-2004
BEGIN
 NLSA_:=NLSA; TT_:=TT;  KV_:=KV;
 DATL_:='';
 K_:='O'; -- �� OPER
 deb.trace(ern, '11', to_char(DATO_,'dd-mm-yyyy')||'���� �� OPER '||K_ );
 SELECT MAX(VDAT),count(*) INTO DATO_ ,col_   FROM OPER
 WHERE VDAT<=TODAY_DAT AND TT=TT_ AND NLSA=NLSA_ AND KV=KV_ AND SOS=5;
 if col_=0 then k_:='NO'; end if;
 deb.trace(ern, '12', to_char(DATO_,'dd-mm-yyyy')||'���� �� OPER '||K_ );
 IF K_='NO' THEN
    K_:='S'; -- �� SALDOA
 deb.trace(ern, '21', to_char(DATS_,'dd-mm-yyyy')||'���� �� SALDOA '||K_ );
    SELECT MIN(S.FDAT),count(*) INTO DATS_,col_  FROM SALDOA S,ACCOUNTS A
    WHERE A.ACC=S.ACC AND A.NLS=NLSA_ AND A.KV=KV_
    AND S.DOS+S.KOS>0  AND S.FDAT<=TODAY_DAT;
    if col_=0 THEN K_:='NS';	end if;
 deb.trace(ern, '22', to_char(DATS_,'dd-mm-yyyy')||'���� �� SALDOA '||K_ );
 end if;
 IF  K_='O' AND DATO_<TODAY_DAT  THEN
 deb.trace(ern, '21', to_char(DATO_,'dd-mm-yyyy')||'���� �� OPER '||K_ );
    K_:='NEXT';
    SELECT MIN(FDAT),count(*) INTO DATNEXT_,col_  FROM FDAT WHERE FDAT>DATO_;
    if col_=0 then k_:='NNNN'; end if;
   deb.trace(ern, '3', to_char(DATNEXT_,'dd-mm-yyyy')||'���� next '||K_ );
 end if;
 IF K_ in ('NO','NS','NNNN') THEN DATL_:='';
 ELSIF
      K_='S' THEN DATL_:=TO_CHAR(DATS_,'DD-MM-YYYY');
 ELSIF
      K_='O' AND DATO_=TODAY_DAT THEN DATL_:=TO_CHAR(DATO_,'DD-MM-YYYY');
 ELSE
	DATL_:=TO_CHAR(DATNEXT_,'DD-MM-YYYY');
 deb.trace(ern, '4',DATL_||'���� ������');
 END IF;
deb.trace(ern, '5',to_char(DATO_,'dd-mm-yyyy')||to_char(DATS_,'dd-mm-yyyy')||to_char(DATNEXT_,'dd-mm-yyyy')||K_ );
RETURN DATL_;
END LAST_RKO1;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/last_rko1.sql =========*** End *** 
 PROMPT ===================================================================================== 
 