
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_colid.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_COLID (TABID_ number, COLNAME_ varchar2)
RETURN NUMBER IS COLID_ NUMBER;
-- ! если НЕ найдено таблицы возвращает  NULL,
--   если НЕ найдено поля возвращает 0
tabname_ varchar2(30);
BEGIN
  BEGIN
  -- перестраховка на наличие таблицы в БМД
  select tabname into tabname_ from META_TABLES where tabid=tabid_;
  EXCEPTION WHEN NO_DATA_FOUND then COLID_:=NULL;
  dbms_output.put_line
      ('Описание табл.'||tabid_||' НЕ найдено в БМД');
  RETURN(colid_);
  end;
  BEGIN
    SELECT COLID into COLID_
    from META_COLUMNS
    where TABID=TABID_ and upper(COLNAME)=upper(COLNAME_);
  EXCEPTION WHEN NO_DATA_FOUND then COLID_:=0;
  dbms_output.put_line
      ('Описание поля '||COLNAME_||' для табл.'||tabid_||' НЕ найдено в БМД');
  END;
  RETURN COLID_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_colid.sql =========*** End *** 
 PROMPT ===================================================================================== 
 