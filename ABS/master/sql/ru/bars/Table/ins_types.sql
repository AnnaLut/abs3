

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_TYPES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_TYPES 
   (	ID NUMBER, 
	NAME VARCHAR2(500), 
	OBJECT_TYPE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_TYPES ***
 exec bpa.alter_policies('INS_TYPES');


COMMENT ON TABLE BARS.INS_TYPES IS '���� �������i� �����������';
COMMENT ON COLUMN BARS.INS_TYPES.ID IS '�������������';
COMMENT ON COLUMN BARS.INS_TYPES.NAME IS '������������';
COMMENT ON COLUMN BARS.INS_TYPES.OBJECT_TYPE IS '��� ��`���� �����������';




PROMPT *** Create  constraint FK_TYPES_OT_OBJTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TYPES ADD CONSTRAINT FK_TYPES_OT_OBJTYPES_ID FOREIGN KEY (OBJECT_TYPE)
	  REFERENCES BARS.INS_OBJECT_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TYPES ADD CONSTRAINT PK_INSTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TYPES MODIFY (NAME CONSTRAINT CC_INSTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101163 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TYPES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSTYPES ON BARS.INS_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_TYPES ***
grant SELECT                                                                 on INS_TYPES       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_TYPES.sql =========*** End *** ===
PROMPT ===================================================================================== 
