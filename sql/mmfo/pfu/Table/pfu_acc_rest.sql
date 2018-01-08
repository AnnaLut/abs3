

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_ACC_REST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_ACC_REST ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_ACC_REST 
   (	ACC VARCHAR2(20), 
	REST NUMBER(38,2), 
	RESTDATE DATE, 
	FILEID NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_ACC_REST IS '';
COMMENT ON COLUMN PFU.PFU_ACC_REST.ACC IS 'Счет 2909';
COMMENT ON COLUMN PFU.PFU_ACC_REST.REST IS 'Остаток';
COMMENT ON COLUMN PFU.PFU_ACC_REST.RESTDATE IS 'Дата остатка';
COMMENT ON COLUMN PFU.PFU_ACC_REST.FILEID IS 'Связь с реестром';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_ACC_REST.sql =========*** End *** =
PROMPT ===================================================================================== 
