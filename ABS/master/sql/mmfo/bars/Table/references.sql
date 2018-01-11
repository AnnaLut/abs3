

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REFERENCES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REFERENCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REFERENCES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REFERENCES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REFERENCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REFERENCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.REFERENCES 
   (	TABID NUMBER(*,0), 
	TYPE NUMBER(38,0), 
	DLGNAME VARCHAR2(200), 
	ROLE2EDIT VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REFERENCES ***
 exec bpa.alter_policies('REFERENCES');


COMMENT ON TABLE BARS.REFERENCES IS 'СПРАВОЧНИКИ';
COMMENT ON COLUMN BARS.REFERENCES.TABID IS 'Код таблицы';
COMMENT ON COLUMN BARS.REFERENCES.TYPE IS 'Тип справочника';
COMMENT ON COLUMN BARS.REFERENCES.DLGNAME IS 'Имя диалогового  окна';
COMMENT ON COLUMN BARS.REFERENCES.ROLE2EDIT IS 'Имя роли';




PROMPT *** Create  constraint PK_REFERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES ADD CONSTRAINT PK_REFERS PRIMARY KEY (TABID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006028 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES MODIFY (TABID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFERS_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REFERENCES MODIFY (TYPE CONSTRAINT CC_REFERS_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REFERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REFERS ON BARS.REFERENCES (TABID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REFERENCES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REFERENCES      to ABS_ADMIN;
grant SELECT                                                                 on REFERENCES      to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on REFERENCES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REFERENCES      to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on REFERENCES      to REF0000;
grant DELETE,INSERT,SELECT,UPDATE                                            on REFERENCES      to REFER_1;
grant SELECT                                                                 on REFERENCES      to START1;
grant SELECT                                                                 on REFERENCES      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REFERENCES      to WR_ALL_RIGHTS;
grant SELECT                                                                 on REFERENCES      to WR_METATAB;
grant FLASHBACK,SELECT                                                       on REFERENCES      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REFERENCES.sql =========*** End *** ==
PROMPT ===================================================================================== 
