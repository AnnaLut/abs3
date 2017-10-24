

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DOC_STRANS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DOC_STRANS ***

  CREATE OR REPLACE PROCEDURE BARS.DOC_STRANS (
	   text_    IN    VARCHAR2,		-- формула суми
	   res_     OUT   INTEGER,  		-- результат обчислення
	   par_	    IN    INTEGER DEFAULT NULL	-- параметр, що потрібно підставити у формулу
)
IS
--====================================================================
-- Module      : DPT
-- Author      : vblagun
-- Desc	       : Процедура використовується для обчислення формул сум
--====================================================================
BEGIN
	 IF (par_ is null)	 THEN
	 	execute immediate text_ into res_;
	 ELSE
	 	execute immediate text_ into res_ using par_;
	 END IF;
END DOC_STRANS;
/
show err;

PROMPT *** Create  grants  DOC_STRANS ***
grant EXECUTE                                                                on DOC_STRANS      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DOC_STRANS      to START1;
grant EXECUTE                                                                on DOC_STRANS      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on DOC_STRANS      to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DOC_STRANS.sql =========*** End **
PROMPT ===================================================================================== 
