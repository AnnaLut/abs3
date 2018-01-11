

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FILES_LOCAL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_FILES_LOCAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_FILES_LOCAL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_FILES_LOCAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_REF_FILES_LOCAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_FILES_LOCAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_FILES_LOCAL 
   (	KF CHAR(6), 
	FILE_ID NUMBER(5,0), 
	FILE_PATH VARCHAR2(35), 
	NBUC VARCHAR2(20), 
	E_ADDRESS CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_FILES_LOCAL ***
 exec bpa.alter_policies('NBUR_REF_FILES_LOCAL');


COMMENT ON TABLE BARS.NBUR_REF_FILES_LOCAL IS 'Параметри файлiв звітності в розрізі фiлiалів';
COMMENT ON COLUMN BARS.NBUR_REF_FILES_LOCAL.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_REF_FILES_LOCAL.FILE_ID IS 'Iдентифiкатор файлу';
COMMENT ON COLUMN BARS.NBUR_REF_FILES_LOCAL.FILE_PATH IS 'Шлях до файлу';
COMMENT ON COLUMN BARS.NBUR_REF_FILES_LOCAL.NBUC IS 'NBUC';
COMMENT ON COLUMN BARS.NBUR_REF_FILES_LOCAL.E_ADDRESS IS 'Код електронного iменi';




PROMPT *** Create  constraint CC_REFFILESLOCAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES_LOCAL MODIFY (KF CONSTRAINT CC_REFFILESLOCAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILESLOCAL_FILEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES_LOCAL MODIFY (FILE_ID CONSTRAINT CC_REFFILESLOCAL_FILEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILESLOCAL_FILEPATH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES_LOCAL MODIFY (FILE_PATH CONSTRAINT CC_REFFILESLOCAL_FILEPATH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILESLOCAL_NBUC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES_LOCAL MODIFY (NBUC CONSTRAINT CC_REFFILESLOCAL_NBUC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILESLOCAL_EADDRESS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES_LOCAL MODIFY (E_ADDRESS CONSTRAINT CC_REFFILESLOCAL_EADDRESS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_REFFILESLOCAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES_LOCAL ADD CONSTRAINT UK_REFFILESLOCAL UNIQUE (KF, FILE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_REFFILESLOCAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_REFFILESLOCAL ON BARS.NBUR_REF_FILES_LOCAL (KF, FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_FILES_LOCAL ***
grant SELECT                                                                 on NBUR_REF_FILES_LOCAL to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_REF_FILES_LOCAL to BARSUPL;
grant SELECT                                                                 on NBUR_REF_FILES_LOCAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_REF_FILES_LOCAL to BARS_DM;
grant SELECT                                                                 on NBUR_REF_FILES_LOCAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FILES_LOCAL.sql =========*** 
PROMPT ===================================================================================== 
