

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOCIAL_FILE_TYPES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOCIAL_FILE_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOCIAL_FILE_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_FILE_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SOCIAL_FILE_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOCIAL_FILE_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOCIAL_FILE_TYPES 
   (	TYPE_ID NUMBER(38,0), 
	TYPE_NAME VARCHAR2(100), 
	SK_ZB NUMBER(*,0), 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOCIAL_FILE_TYPES ***
 exec bpa.alter_policies('SOCIAL_FILE_TYPES');


COMMENT ON TABLE BARS.SOCIAL_FILE_TYPES IS 'Типы (виды) зачислений от ОСЗ';
COMMENT ON COLUMN BARS.SOCIAL_FILE_TYPES.TYPE_ID IS 'Код типа';
COMMENT ON COLUMN BARS.SOCIAL_FILE_TYPES.TYPE_NAME IS 'Название типа';
COMMENT ON COLUMN BARS.SOCIAL_FILE_TYPES.SK_ZB IS 'Позабалансовий символ';
COMMENT ON COLUMN BARS.SOCIAL_FILE_TYPES.TT IS '';




PROMPT *** Create  constraint PK_SOCIALFTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_FILE_TYPES ADD CONSTRAINT PK_SOCIALFTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALFILETYPES_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_FILE_TYPES ADD CONSTRAINT FK_SOCIALFILETYPES_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALFTYPES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_FILE_TYPES MODIFY (TYPE_ID CONSTRAINT CC_SOCIALFTYPES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALFTYPES_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_FILE_TYPES MODIFY (TYPE_NAME CONSTRAINT CC_SOCIALFTYPES_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOCIALFILETYPES_NN_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_FILE_TYPES MODIFY (TT CONSTRAINT CC_SOCIALFILETYPES_NN_TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOCIALFTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOCIALFTYPES ON BARS.SOCIAL_FILE_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOCIAL_FILE_TYPES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_FILE_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOCIAL_FILE_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOCIAL_FILE_TYPES to DPT_ADMIN;
grant SELECT                                                                 on SOCIAL_FILE_TYPES to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOCIAL_FILE_TYPES to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SOCIAL_FILE_TYPES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOCIAL_FILE_TYPES.sql =========*** End
PROMPT ===================================================================================== 
