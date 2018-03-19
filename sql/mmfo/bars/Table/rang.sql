

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RANG.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RANG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RANG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RANG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RANG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RANG ***
begin 
  execute immediate '
  CREATE TABLE BARS.RANG 
   (	RANG NUMBER(3,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RANG ***
 exec bpa.alter_policies('RANG');


COMMENT ON TABLE BARS.RANG IS 'Виды блокировок счетов';
COMMENT ON COLUMN BARS.RANG.RANG IS 'Код';
COMMENT ON COLUMN BARS.RANG.NAME IS 'Наименование';




PROMPT *** Create  constraint CC_RANG_RANG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RANG MODIFY (RANG CONSTRAINT CC_RANG_RANG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RANG_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RANG MODIFY (NAME CONSTRAINT CC_RANG_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_RANG ***
begin   
 execute immediate '
  ALTER TABLE BARS.RANG ADD CONSTRAINT PK_RANG PRIMARY KEY (RANG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RANG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RANG ON BARS.RANG (RANG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RANG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RANG            to ABS_ADMIN;
grant SELECT                                                                 on RANG            to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RANG            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RANG            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RANG            to FINMON01;
grant SELECT                                                                 on RANG            to JBOSS_USR;
grant SELECT                                                                 on RANG            to OPERKKK;
grant DELETE,INSERT,SELECT,UPDATE                                            on RANG            to RANG;
grant SELECT                                                                 on RANG            to START1;
grant SELECT                                                                 on RANG            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RANG            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RANG            to WR_REFREAD;
grant SELECT                                                                 on RANG            to WR_VIEWACC;
grant SELECT                                                                 on RANG            to BARS_INTGR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RANG.sql =========*** End *** ========
PROMPT ===================================================================================== 
