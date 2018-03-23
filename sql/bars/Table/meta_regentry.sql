

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_REGENTRY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_REGENTRY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_REGENTRY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_REGENTRY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_REGENTRY ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_REGENTRY 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(35), 
	SEMANTIC VARCHAR2(140), 
	ISFOLDER NUMBER(38,0), 
	PID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_REGENTRY ***
 exec bpa.alter_policies('META_REGENTRY');


COMMENT ON TABLE BARS.META_REGENTRY IS 'Метаописание. Клиентские конфигурационные параметры';
COMMENT ON COLUMN BARS.META_REGENTRY.ID IS 'Код параметра';
COMMENT ON COLUMN BARS.META_REGENTRY.NAME IS 'Наименование параметра';
COMMENT ON COLUMN BARS.META_REGENTRY.SEMANTIC IS 'Семантика параметра';
COMMENT ON COLUMN BARS.META_REGENTRY.ISFOLDER IS 'Признак параметр/папка (0/1)';
COMMENT ON COLUMN BARS.META_REGENTRY.PID IS 'Код родительского параметра';




PROMPT *** Create  constraint FK_METAREGENTRY_METAREGENTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY ADD CONSTRAINT FK_METAREGENTRY_METAREGENTRY FOREIGN KEY (PID)
	  REFERENCES BARS.META_REGENTRY (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAREGENTRY_ISFOLDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY ADD CONSTRAINT CC_METAREGENTRY_ISFOLDER CHECK (isfolder in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_METAREGENTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY ADD CONSTRAINT PK_METAREGENTRY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAREGENTRY_ISFOLDER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY MODIFY (ISFOLDER CONSTRAINT CC_METAREGENTRY_ISFOLDER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAREGENTRY_SEMANTIC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY MODIFY (SEMANTIC CONSTRAINT CC_METAREGENTRY_SEMANTIC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAREGENTRY_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY MODIFY (NAME CONSTRAINT CC_METAREGENTRY_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METAREGENTRY_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_REGENTRY MODIFY (ID CONSTRAINT CC_METAREGENTRY_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAREGENTRY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAREGENTRY ON BARS.META_REGENTRY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_REGENTRY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_REGENTRY   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_REGENTRY   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_REGENTRY   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_REGENTRY   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_REGENTRY.sql =========*** End ***
PROMPT ===================================================================================== 
