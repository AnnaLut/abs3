PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_W4_ACC_INST_UPD.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_W4_ACC_INST_UPD ***
begin
   execute immediate 'CREATE SEQUENCE  BARS.S_W4_ACC_INST_UPD  MINVALUE 0 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 ORDER  NOCYCLE';
   exception when others then 
   if sqlcode=-955 then null; else raise; end if;
end;
/

PROMPT *** Create  grants  S_W4_ACC_INST_UPD ***
grant SELECT                                                                 on S_W4_ACC_INST_UPD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_W4_ACC_INST_UPD to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_W4_ACC_INST_UPD.sql =========*** 
PROMPT ===================================================================================== 

