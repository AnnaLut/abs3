

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/PRINT_ERRORS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PRINT_ERRORS ***

  CREATE OR REPLACE PROCEDURE BARSAQ.PRINT_ERRORS 
is
    l_clob   clob;
begin
    l_clob := retrieve_apply_errors();
    print_clob(l_clob);
    if dbms_lob.istemporary(l_clob)=1
    then
        dbms_lob.freetemporary(l_clob);
    end if;
end print_errors;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/PRINT_ERRORS.sql =========*** En
PROMPT ===================================================================================== 
