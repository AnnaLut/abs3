

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MSF.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MSF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MSF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MSF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MSF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MSF ***
begin 
  execute immediate '
  CREATE TABLE BARS.MSF 
   (	FM VARCHAR2(4), 
	NAME VARCHAR2(35), 
	TEST_REQ CHAR(1), 
	TAG_TEXT CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MSF ***
 exec bpa.alter_policies('MSF');


COMMENT ON TABLE BARS.MSF IS 'Справочник форматов межбанковских
сообщений';
COMMENT ON COLUMN BARS.MSF.FM IS 'Код формата межбанковских сообщений';
COMMENT ON COLUMN BARS.MSF.NAME IS 'Наименование формата сообщений';
COMMENT ON COLUMN BARS.MSF.TEST_REQ IS 'Флаг необходимости расчета TESTKEY';
COMMENT ON COLUMN BARS.MSF.TAG_TEXT IS 'Флаг необходимости текстовой расшифровки поля';




PROMPT *** Create  constraint XPK_MSF ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSF ADD CONSTRAINT XPK_MSF PRIMARY KEY (FM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006705 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSF MODIFY (FM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_MSF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_MSF ON BARS.MSF (FM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MSF ***
grant SELECT                                                                 on MSF             to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MSF             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MSF             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MSF             to MSF;
grant DELETE,INSERT,SELECT,UPDATE                                            on MSF             to SEP_ROLE;
grant SELECT                                                                 on MSF             to START1;
grant SELECT                                                                 on MSF             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MSF             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on MSF             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MSF.sql =========*** End *** =========
PROMPT ===================================================================================== 
