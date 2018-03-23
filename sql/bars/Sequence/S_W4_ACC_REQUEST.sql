

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_W4_ACC_REQUEST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_W4_ACC_REQUEST ***

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


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_W4_ACC_REQUEST.sql =========*** E
PROMPT ===================================================================================== 
