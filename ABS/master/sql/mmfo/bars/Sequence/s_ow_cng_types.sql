

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_OW_CNG_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OW_CNG_TYPES ***


begin 
 execute immediate 'CREATE SEQUENCE S_W4_ACC_REQUEST 
                                    MINVALUE 1 
                                    MAXVALUE 9999999999999999999999999999 
                                    INCREMENT BY 1 
                                    START WITH 1 
                                    CACHE 20 NOORDER  NOCYCLE';
exception when others then if (sqlcode = -00955) then null; else raise; end if;
end;
/
PROMPT *** Create  grants  S_OW_CNG_TYPES ***
grant SELECT                                                                 on S_OW_CNG_TYPES  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_OW_CNG_TYPES.sql =========*** End
PROMPT ===================================================================================== 
