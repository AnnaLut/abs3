

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_ACC_2560_PAYBACK.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_ACC_2560_PAYBACK ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_ACC_2560_PAYBACK 
   (	ACC_NUM VARCHAR2(20), 
	KF VARCHAR2(10), 
	EDRPU VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_ACC_2560_PAYBACK IS 'Рахунки для повернення грошей  в ПФУ';
COMMENT ON COLUMN PFU.PFU_ACC_2560_PAYBACK.ACC_NUM IS '';
COMMENT ON COLUMN PFU.PFU_ACC_2560_PAYBACK.KF IS '';
COMMENT ON COLUMN PFU.PFU_ACC_2560_PAYBACK.EDRPU IS '';




PROMPT *** Create  constraint PK_PFU_ACC_2560_PAYBACK ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_ACC_2560_PAYBACK ADD CONSTRAINT PK_PFU_ACC_2560_PAYBACK PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFU_ACC_2560_PAYBACK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFU_ACC_2560_PAYBACK ON PFU.PFU_ACC_2560_PAYBACK (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_ACC_2560_PAYBACK ***
grant SELECT                                                                 on PFU_ACC_2560_PAYBACK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_ACC_2560_PAYBACK.sql =========*** E
PROMPT ===================================================================================== 
