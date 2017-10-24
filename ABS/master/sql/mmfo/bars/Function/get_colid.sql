
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_colid.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_COLID (TABID_ number, COLNAME_ varchar2)
RETURN NUMBER IS COLID_ NUMBER;
-- ! ���� �� ������� ������� ����������  NULL,
--   ���� �� ������� ���� ���������� 0
tabname_ varchar2(30);
BEGIN
  BEGIN
  -- ������������� �� ������� ������� � ���
  select tabname into tabname_ from META_TABLES where tabid=tabid_;
  EXCEPTION WHEN NO_DATA_FOUND then COLID_:=NULL;
  dbms_output.put_line
      ('�������� ����.'||tabid_||' �� ������� � ���');
  RETURN(colid_);
  end;
  BEGIN
    SELECT COLID into COLID_
    from META_COLUMNS
    where TABID=TABID_ and upper(COLNAME)=upper(COLNAME_);
  EXCEPTION WHEN NO_DATA_FOUND then COLID_:=0;
  dbms_output.put_line
      ('�������� ���� '||COLNAME_||' ��� ����.'||tabid_||' �� ������� � ���');
  END;
  RETURN COLID_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_colid.sql =========*** End *** 
 PROMPT ===================================================================================== 
 