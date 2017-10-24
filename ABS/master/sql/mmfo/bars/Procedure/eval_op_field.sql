

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/EVAL_OP_FIELD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure EVAL_OP_FIELD ***

  CREATE OR REPLACE PROCEDURE BARS.EVAL_OP_FIELD (
	   TT_ IN op_rules.tt%type,		-- ��������
	   OP_TAG IN op_rules.tag%type,	-- ���. �������
	   PARAM IN VARCHAR2,			-- �������� ���������
	   DEF_VAL OUT VARCHAR2 		-- ��������� ��������
) IS
--====================================================================
-- Module      : DPT
-- Author      : vblagun
-- Desc	 : ��������� �������� �������� ���. �������� �� ������������ �� ������ op_field.default_value
--  		   ���������� �������� op_rules.val ��� ���� ��������
--		   ���� ������� �������� ��� ������� no_data_found ��� def_val ���� null
-- 24-04-2007:  ��������
-- 17-10-2007:  ������������� ���. �������� � ���� used4input = 0
--====================================================================
  l_op_rules_val OP_RULES.VAL%TYPE;
  l_query OP_FIELD.DEFAULT_VALUE%TYPE;
  -- ������� �������
  l_mod CONSTANT VARCHAR2(3) := 'DOC';
BEGIN
  -- ��������� �� �� ������ �������� ������ ����������� ��������
  -- ��� ���� ��������.
  BEGIN
	  SELECT VAL	INTO l_op_rules_val
	  FROM OP_RULES
	  WHERE TT = TT_ AND TAG = OP_TAG;
  EXCEPTION
	  WHEN NO_DATA_FOUND THEN
	  Bars_Error.raise_nerror(l_mod, 'OP_RULES_NOT_FOUND', OP_TAG, TT_);
  END;

  IF (l_op_rules_val IS NOT NULL)  THEN
  -- ��� ����������� �������� ������ �������� ��� ���� ��������
  -- ������� ���� �����������
	DEF_VAL := l_op_rules_val;
  ELSE
	  -- �������� �� ������ - ������ ������� ��� ��������
	  BEGIN
		SELECT UPPER(DEFAULT_VALUE) INTO l_query
		FROM OP_FIELD
		WHERE TAG = OP_TAG;
	  EXCEPTION
		WHEN NO_DATA_FOUND THEN
		 Bars_Error.raise_nerror(l_mod, 'OP_FIELD_NOT_FOUND', OP_TAG);
	  END;

	  BEGIN
		  IF ( INSTR(l_query,':') != 0)
		  -- ���� ������� �� �������� - �����������
		  THEN
			  IF (PARAM IS NULL OR PARAM = '')
			  THEN
				 Bars_Error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', OP_TAG, TT_);
			  END IF;
			  IF ( INSTR(l_query,'SELECT') != 0 )
			  -- ������� � ������� � ����������
			  THEN
				EXECUTE IMMEDIATE l_query INTO DEF_VAL USING PARAM;
			  ELSE
			  -- ������� = :my_par
				EXECUTE IMMEDIATE 'SELECT ' || l_query || ' FROM DUAL' INTO DEF_VAL USING PARAM;
			  END IF;
		  ELSE
		  -- ���� ������� ��������� �� ������
			  IF ( INSTR(l_query,'SELECT') != 0 )
			  -- ������� � ������� ��� ���������
			  THEN
				EXECUTE IMMEDIATE l_query INTO DEF_VAL;
			  ELSE
			  -- ������� � ��������� ���������
				EXECUTE IMMEDIATE 'SELECT ' || l_query || ' FROM DUAL' INTO DEF_VAL;
			  END IF;
		  END IF;
	  -- ���� �� ��� ��������� ������� ����� �� ��������
	  -- ��������� null
	  EXCEPTION
		WHEN NO_DATA_FOUND THEN
		  Bars_Error.raise_nerror(l_mod, 'OP_FIELD_NO_DATA_FOUND', OP_TAG, TT_);
	  END;
  END IF;
END;
 
/
show err;

PROMPT *** Create  grants  EVAL_OP_FIELD ***
grant EXECUTE                                                                on EVAL_OP_FIELD   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on EVAL_OP_FIELD   to WR_ALL_RIGHTS;
grant EXECUTE                                                                on EVAL_OP_FIELD   to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/EVAL_OP_FIELD.sql =========*** End
PROMPT ===================================================================================== 
