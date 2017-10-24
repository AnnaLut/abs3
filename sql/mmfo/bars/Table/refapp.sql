

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REFAPP.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REFAPP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REFAPP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REFAPP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REFAPP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REFAPP ***
begin 
  execute immediate '
  CREATE TABLE BARS.REFAPP 
   (	TABID NUMBER(38,0), 
	CODEAPP VARCHAR2(30 CHAR), 
	ACODE VARCHAR2(8) DEFAULT ''RO'', 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REFAPP ***
 exec bpa.alter_policies('REFAPP');


COMMENT ON TABLE BARS.REFAPP IS 'СПРАВОЧНИКИ <->  АРМ - ы';
COMMENT ON COLUMN BARS.REFAPP.TABID IS 'Код таблицы АБС';
COMMENT ON COLUMN BARS.REFAPP.CODEAPP IS 'Код приложения';
COMMENT ON COLUMN BARS.REFAPP.ACODE IS 'Код доступа к справочнику';
COMMENT ON COLUMN BARS.REFAPP.APPROVE IS 'Признак подтверждения';
COMMENT ON COLUMN BARS.REFAPP.ADATE1 IS '';
COMMENT ON COLUMN BARS.REFAPP.ADATE2 IS '';
COMMENT ON COLUMN BARS.REFAPP.RDATE1 IS '';
COMMENT ON COLUMN BARS.REFAPP.RDATE2 IS '';
COMMENT ON COLUMN BARS.REFAPP.REVERSE IS '';
COMMENT ON COLUMN BARS.REFAPP.REVOKED IS 'Пометка на удаление ресурса';
COMMENT ON COLUMN BARS.REFAPP.GRANTOR IS 'Кто выдал ресурс';




PROMPT *** Create  constraint FK_REFAPP_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT FK_REFAPP_STAFF FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFAPP_METATACCESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT FK_REFAPP_METATACCESS FOREIGN KEY (ACODE)
	  REFERENCES BARS.META_TACCESS (ACODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFAPP_REVOKED ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT CC_REFAPP_REVOKED CHECK (revoked in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFAPP_REVERSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT CC_REFAPP_REVERSE CHECK (reverse in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFAPP_RDATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT CC_REFAPP_RDATE1 CHECK (rdate1 <= rdate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFAPP_ADATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT CC_REFAPP_ADATE1 CHECK (adate1 <= adate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFAPP_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT CC_REFAPP_APPROVE CHECK (approve in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFAPP_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT FK_REFAPP_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007296 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP MODIFY (TABID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007297 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFAPP_ACODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP MODIFY (ACODE CONSTRAINT CC_REFAPP_ACODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_REFAPP ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFAPP ADD CONSTRAINT PK_REFAPP PRIMARY KEY (TABID, CODEAPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REFAPP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REFAPP ON BARS.REFAPP (TABID, CODEAPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REFAPP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REFAPP          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REFAPP          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REFAPP          to BARS_DM;
grant SELECT                                                                 on REFAPP          to REF0000;
grant DELETE,INSERT,SELECT,UPDATE                                            on REFAPP          to REFAPP;
grant SELECT                                                                 on REFAPP          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REFAPP          to WR_ALL_RIGHTS;
grant SELECT                                                                 on REFAPP          to WR_METATAB;
grant FLASHBACK,SELECT                                                       on REFAPP          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REFAPP.sql =========*** End *** ======
PROMPT ===================================================================================== 
