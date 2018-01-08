

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SV_PIC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SV_PIC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SV_PIC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SV_PIC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SV_PIC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SV_PIC ***
begin 
  execute immediate '
  CREATE TABLE BARS.SV_PIC 
   (	ID NUMBER(1,0), 
	FILE_DATA BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SV_PIC ***
 exec bpa.alter_policies('SV_PIC');


COMMENT ON TABLE BARS.SV_PIC IS '';
COMMENT ON COLUMN BARS.SV_PIC.ID IS '';
COMMENT ON COLUMN BARS.SV_PIC.FILE_DATA IS '';




PROMPT *** Create  constraint PK_SVPIC_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_PIC ADD CONSTRAINT PK_SVPIC_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SVPIC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SV_PIC MODIFY (ID CONSTRAINT CC_SVPIC_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SVPIC_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SVPIC_ID ON BARS.SV_PIC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SV_PIC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_PIC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SV_PIC          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SV_PIC          to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SV_PIC.sql =========*** End *** ======
PROMPT ===================================================================================== 
