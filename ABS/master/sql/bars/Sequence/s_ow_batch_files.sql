

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OW_BATCH_FILES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OW_BATCH_FILES ***


begin 
 execute immediate 'CREATE SEQUENCE S_OW_BATCH_FILES 
                                    MINVALUE 1 
                                    MAXVALUE 9999999999999999999999999999 
                                    INCREMENT BY 1 
                                    START WITH 1 
                                    CACHE 20 NOORDER  NOCYCLE';
exception when others then if (sqlcode = -00955) then null; else raise; end if;
end;
/
PROMPT *** Create  grants  S_OW_BATCH_FILES ***
grant SELECT  on S_OW_BATCH_FILES  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OW_CNG_TYPES.sql =========*** End
PROMPT ===================================================================================== 
