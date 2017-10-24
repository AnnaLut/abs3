

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_REG_DIRS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_REG_DIRS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_REG_DIRS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_REG_DIRS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_REG_DIRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_REG_DIRS 
   (	RNK NUMBER(38,0), 
	DIR VARCHAR2(50), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_REG_DIRS ***
 exec bpa.alter_policies('SW_REG_DIRS');


COMMENT ON TABLE BARS.SW_REG_DIRS IS 'SWT. ������������� �������� ��� ������ SWIFT';
COMMENT ON COLUMN BARS.SW_REG_DIRS.RNK IS '��� �������';
COMMENT ON COLUMN BARS.SW_REG_DIRS.DIR IS '������� ��� ������������ �������';
COMMENT ON COLUMN BARS.SW_REG_DIRS.KF IS '';




PROMPT *** Create  constraint FK_SWREGDIRS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS ADD CONSTRAINT FK_SWREGDIRS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWREGDIRS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS ADD CONSTRAINT FK_SWREGDIRS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWREGDIRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS ADD CONSTRAINT PK_SWREGDIRS PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWREGDIRS_DIR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS MODIFY (DIR CONSTRAINT CC_SWREGDIRS_DIR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWREGDIRS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS MODIFY (RNK CONSTRAINT CC_SWREGDIRS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWREGDIRS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_REG_DIRS MODIFY (KF CONSTRAINT CC_SWREGDIRS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWREGDIRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWREGDIRS ON BARS.SW_REG_DIRS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_REG_DIRS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_REG_DIRS     to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_REG_DIRS     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_REG_DIRS ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_REG_DIRS FOR BARS.SW_REG_DIRS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_REG_DIRS.sql =========*** End *** =
PROMPT ===================================================================================== 
