

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CRVACC_CLOSE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CRVACC_CLOSE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CRVACC_CLOSE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CRVACC_CLOSE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CRVACC_CLOSE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CRVACC_CLOSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CRVACC_CLOSE 
   (	ACC NUMBER(22,0), 
	DAT DATE, 
	FILE_NAME VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CRVACC_CLOSE ***
 exec bpa.alter_policies('OW_CRVACC_CLOSE');


COMMENT ON TABLE BARS.OW_CRVACC_CLOSE IS 'ЦРВ. Счета на закрытие карт';
COMMENT ON COLUMN BARS.OW_CRVACC_CLOSE.ACC IS 'Ид. счета';
COMMENT ON COLUMN BARS.OW_CRVACC_CLOSE.DAT IS 'Плановая дата закрытия';
COMMENT ON COLUMN BARS.OW_CRVACC_CLOSE.FILE_NAME IS 'Файл, в котором счет отправлен в ПЦ на закрытие';
COMMENT ON COLUMN BARS.OW_CRVACC_CLOSE.KF IS '';




PROMPT *** Create  constraint PK_OWCRVACCCLOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_CLOSE ADD CONSTRAINT PK_OWCRVACCCLOSE PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVACCCLOSE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_CLOSE MODIFY (KF CONSTRAINT CC_OWCRVACCCLOSE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OWCRVACCCLOSE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_CLOSE ADD CONSTRAINT FK_OWCRVACCCLOSE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVACCCLOSE_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_CLOSE MODIFY (ACC CONSTRAINT CC_OWCRVACCCLOSE_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCRVACCCLOSE_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CRVACC_CLOSE MODIFY (DAT CONSTRAINT CC_OWCRVACCCLOSE_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCRVACCCLOSE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCRVACCCLOSE ON BARS.OW_CRVACC_CLOSE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CRVACC_CLOSE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVACC_CLOSE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_CRVACC_CLOSE to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CRVACC_CLOSE.sql =========*** End *
PROMPT ===================================================================================== 
