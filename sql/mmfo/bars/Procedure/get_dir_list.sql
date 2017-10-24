

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_DIR_LIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_DIR_LIST ***

  CREATE OR REPLACE PROCEDURE BARS.GET_DIR_LIST (p_directory IN VARCHAR2)
AS
   LANGUAGE JAVA
   NAME 'DirList.getList( java.lang.String )' ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_DIR_LIST.sql =========*** End 
PROMPT ===================================================================================== 
