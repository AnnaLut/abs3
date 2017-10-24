

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ROOT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ROOT ***

  CREATE OR REPLACE PROCEDURE BARS.ROOT (
	   tt_ IN VARCHAR2, -- �������� ����
	   MaxS IN NUMBER, -- ���� �� �������
	   X OUT NUMBER -- ����������� ��������� ����, � ����������� ����
) IS
--====================================================================
-- Module      : DPT
-- Author      : vblagun
-- Desc	 : ��������� ��������������� ��� ���������� ����������� ��������� ���� �������� � �������,
--  		   ��� ������� ��� ����� ����, ��� ������� ��������.
--  		  ��� ����� �� ��������� ������� S - x - f(x) = 0 ������� ������ ����� :-)
--  			S - ������� �� �������
--  			� - ����������� ��������� ����
--  			f(x) - �����, �� ������������ � ��������� �� ����
-- 19-03-2007:  ��������
--====================================================================
  a NUMBER; 			   -- ���� ���� ���������
  b NUMBER;				   -- ������ ���� ���������
  c NUMBER;
  s_f VARCHAR2(256);  -- ������� ����
  s_a NUMBER;		  	 -- �������� ���� � ����� ���� ���������
  s_b NUMBER;			 -- �������� ���� � ������� ���� ���������
  -- ������� �������
  l_mod CONSTANT VARCHAR2(3) := 'DPT';
BEGIN
a:= 0;
b:= MaxS;
  -- �������� ������� ����
  BEGIN
	 SELECT s INTO s_f FROM TTS WHERE tt =tt_;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	 Bars_Error.raise_nerror(l_mod, 'TT_NOT_FOUND', tt_);
  END;

  -- ���� �������� �� ����� � ����� ����� ����������
  WHILE (b - a >= 1)
  LOOP
	   -- ������ ������� �����
	   c := ((a + b) / 2);
	   -- ���������� �������� ������� �� ����� ���������
	   BEGIN
	   		Doc_Strans('SELECT ROUND(' || REPLACE(s_f,'#(SMAIN)',':SMAIN') || ') from dual', s_a, a);
	   EXCEPTION
	     WHEN OTHERS THEN
		  Bars_Error.raise_nerror(l_mod, 'SUM_EVAL_ERR', REPLACE(s_f,'#(SMAIN)',a));
	   END;

	   BEGIN
	   	   Doc_Strans('SELECT ROUND(' || REPLACE(s_f,'#(SMAIN)',':SMAIN') || ') from dual', s_b, c);
	   EXCEPTION
	     WHEN OTHERS THEN
		  Bars_Error.raise_nerror(l_mod, 'SUM_EVAL_ERR', REPLACE(s_f,'#(SMAIN)',c));
	   END;

	   -- ���� ����� �� � � � - ������� ������ ����
	   IF (MaxS - a - s_a) * (MaxS - c - s_b) < 0 	   THEN b := c;
	   -- ������ ������� ���� ����
	   ELSE a := c;
	   END IF;

  END LOOP;

 x := ROUND((a + b) / 2);

END;
 
/
show err;

PROMPT *** Create  grants  ROOT ***
grant EXECUTE                                                                on ROOT            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ROOT            to DPT_ROLE;
grant EXECUTE                                                                on ROOT            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ROOT.sql =========*** End *** ====
PROMPT ===================================================================================== 
