
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sb_acc.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SB_ACC (p1_ VARCHAR2, p2_ VARCHAR2,
				ref_ INTEGER DEFAULT NULL,   -- ����������
               datv_ DATE DEFAULT NULL,      -- ���� ������������
                 tt_ CHAR DEFAULT NULL,      -- ��� ����������
                dk0_ NUMBER DEFAULT NULL,    -- ������� �����-������
                kva_ SMALLINT DEFAULT NULL,  -- ��� ������ �
                 sa_ DECIMAL DEFAULT NULL,   -- ����� � ������ �
                kvb_ SMALLINT DEFAULT NULL,  -- ��� ������ �
                 sb_ DECIMAL DEFAULT NULL    -- ����� � ������ �
)
  RETURN VARCHAR2 IS

-- 12.01.2005 ������� (�����������) ����� ����� ������� �������.SQL
-- ������������� ������ ����� ��� ����� �����  � ���.��������,
-- ���� �� �� ����������� �� ������������.
-- ������� ���� �� �������� ����������
-- ������ ����� ������� (� �������� �������� ����-�(�) ��� ������)
--  #(NVL(pul.Get_Mas_Ini_Val('CASH'),'10012'))

c1_ int; i1_ int; f1_ varchar2(100);

i  NUMBER;  s_ VARCHAR2(15);

nls1_ VARCHAR2(150);
nls2_ VARCHAR2(150);

   ern    CONSTANT POSITIVE := 203;
   erm    VARCHAR2(80);
   err    EXCEPTION;
BEGIN

   bars_audit.trace('SB_ACC('||
                'p1_  =>  '''||p1_||''''||
                ',p2_  => '''||p2_||''''|| 
                ',ref_ => '||ref_||
                ',datv_  =>'''||to_char(datv_,'DD.MM.YYYY')||''''||  
                ',tt_  =>  '''||tt_||''''|| 
                ',dk0_  => '||dk0_||
                ',kva_   => '||kva_ ||
                ',sa_   =>  '||sa_ ||
                ',kvb_   => '||kvb_ ||
                ',sb_   =>  '||sb_ ||')'
                 );
   nls1_:=TRIM(p1_);
   nls2_:=TRIM(p2_);

   IF SUBSTR(nls1_,1,2)='#(' THEN -- Dynamic account number present
      BEGIN
         -- �����������
	     nls1_ := replace(nls1_,'#(REF)',to_char(ref_));
	     nls1_ := replace(nls1_,'#(VDAT)','to_date('||to_char(datv_,'YYYYMMDD')||',''YYYYMMDD'')');
	     nls1_ := replace(nls1_,'#(TT)',''''||tt_||'''');
	     nls1_ := replace(nls1_,'#(DK)',to_char(dk0_));
	     nls1_ := replace(nls1_,'#(KVA)',to_char(kva_));
	     nls1_ := replace(nls1_,'#(S)',to_char(sa_));
	     nls1_ := replace(nls1_,'#(KVB)',to_char(kvb_));
	     nls1_ := replace(nls1_,'#(S2)',to_char(sb_));
	     nls1_ := replace(nls1_,'#(NLSA)',''''||p2_||'''');
	     nls1_ := replace(nls1_,'#(NLSB)',''''||p2_||'''');

         f1_:='SELECT '||SUBSTR(nls1_,3,LENGTH(nls1_)-3)||' FROM DUAL';
         c1_:=DBMS_SQL.OPEN_CURSOR;                 --������� ������
         DBMS_SQL.PARSE(c1_, f1_, DBMS_SQL.NATIVE); --����������� ���.SQL
         DBMS_SQL.DEFINE_COLUMN(c1_,1,nls1_,100 ) ; --���������� ���� ������� � SELECT
         i1_:=DBMS_SQL.EXECUTE(c1_);                --��������� �������������� SQL
         IF DBMS_SQL.FETCH_ROWS(c1_)>0 THEN         --���������
            DBMS_SQL.COLUMN_VALUE(c1_,1,nls1_);     --����� �������������� ����������
         END IF;
         DBMS_SQL.CLOSE_CURSOR(c1_);                --������� ������

         if nls1_ is null   then     RAISE err;  end if;
      --EXCEPTION WHEN OTHERS THEN     RAISE err;
      END;
   END IF;

   s_ := '';
   nls1_:= RPAD(nls1_,15);
   nls2_:= RPAD(p2_,  15);

   FOR i IN 1..15 LOOP
      IF SUBSTR(nls1_,i,1)='?' THEN  s_ := s_ || SUBSTR(nls2_,i,1);
      ELSE                           s_ := s_ || SUBSTR(nls1_,i,1);
      END IF;
   END LOOP;

   RETURN VKRZN(SUBSTR(gl.aMFO,1,5),REPLACE(RTRIM(s_),' ','0'));

EXCEPTION   WHEN err THEN
   erm := '\9351 - Cannot get account number via '||nls1_;
   raise_application_error(-(20203),erm,TRUE);
END; 
 
/
 show err;
 
PROMPT *** Create  grants  SB_ACC ***
grant EXECUTE                                                                on SB_ACC          to ABS_ADMIN;
grant EXECUTE                                                                on SB_ACC          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SB_ACC          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sb_acc.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 