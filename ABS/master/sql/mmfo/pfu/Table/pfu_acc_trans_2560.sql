

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_ACC_TRANS_2560.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_ACC_TRANS_2560 ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_ACC_TRANS_2560 
   (	ACC_NUM VARCHAR2(20), 
	KF VARCHAR2(10), 
	EDRPU VARCHAR2(10),
        FILE_TYPE VARCHAR2(2 CHAR) default ''01'' not null
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_ACC_TRANS_2560 IS 'Справочнок транзитных счетов 2560';
COMMENT ON COLUMN PFU.PFU_ACC_TRANS_2560.ACC_NUM IS '';
COMMENT ON COLUMN PFU.PFU_ACC_TRANS_2560.KF IS '';
COMMENT ON COLUMN PFU.PFU_ACC_TRANS_2560.EDRPU IS '';

begin
    execute immediate 'alter table PFU_ACC_TRANS_2560 add file_type VARCHAR2(2 CHAR) default ''01'' not null';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 




PROMPT *** Create  grants  PFU_ACC_TRANS_2560 ***
grant SELECT                                                                 on PFU_ACC_TRANS_2560 to BARS;
grant SELECT                                                                 on PFU_ACC_TRANS_2560 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PFU_ACC_TRANS_2560 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_ACC_TRANS_2560 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_ACC_TRANS_2560.sql =========*** End
PROMPT ===================================================================================== 
