

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_EWA_DOCUMENT_TYPES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_EWA_DOCUMENT_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_EWA_DOCUMENT_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_EWA_DOCUMENT_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_EWA_DOCUMENT_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_EWA_DOCUMENT_TYPES 
   (	ID VARCHAR2(255), 
	NAME VARCHAR2(255), 
	EXT_ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_EWA_DOCUMENT_TYPES ***
 exec bpa.alter_policies('INS_EWA_DOCUMENT_TYPES');


COMMENT ON TABLE BARS.INS_EWA_DOCUMENT_TYPES IS '';
COMMENT ON COLUMN BARS.INS_EWA_DOCUMENT_TYPES.ID IS '';
COMMENT ON COLUMN BARS.INS_EWA_DOCUMENT_TYPES.NAME IS '';
COMMENT ON COLUMN BARS.INS_EWA_DOCUMENT_TYPES.EXT_ID IS '';




PROMPT *** Create  constraint SYS_C0033462 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_EWA_DOCUMENT_TYPES MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033463 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_EWA_DOCUMENT_TYPES ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_EWADOCTYPE_DOCTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_EWA_DOCUMENT_TYPES ADD CONSTRAINT FK_EWADOCTYPE_DOCTYPE FOREIGN KEY (EXT_ID)
	  REFERENCES BARS.PASSP (PASSP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0033463 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0033463 ON BARS.INS_EWA_DOCUMENT_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_EWA_DOCUMENT_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INS_EWA_DOCUMENT_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_EWA_DOCUMENT_TYPES.sql =========**
PROMPT ===================================================================================== 
