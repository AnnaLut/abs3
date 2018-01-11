

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STMT.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STMT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STMT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STMT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STMT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STMT ***
begin 
  execute immediate '
  CREATE TABLE BARS.STMT 
   (	STMT NUMBER(5,0), 
	FREQ NUMBER(5,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STMT ***
 exec bpa.alter_policies('STMT');


COMMENT ON TABLE BARS.STMT IS 'Виды выписки клиентам';
COMMENT ON COLUMN BARS.STMT.STMT IS 'Код';
COMMENT ON COLUMN BARS.STMT.FREQ IS 'Код периодичности всяких событий (рассылка выписок, списания процентов и т.д.)';
COMMENT ON COLUMN BARS.STMT.NAME IS 'Наименование';




PROMPT *** Create  constraint CC_STMT_STMT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STMT MODIFY (STMT CONSTRAINT CC_STMT_STMT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STMT_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STMT MODIFY (NAME CONSTRAINT CC_STMT_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.STMT ADD CONSTRAINT PK_STMT PRIMARY KEY (STMT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STMT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STMT ON BARS.STMT (STMT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STMT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STMT            to ABS_ADMIN;
grant SELECT                                                                 on STMT            to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STMT            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STMT            to BARS_DM;
grant SELECT                                                                 on STMT            to CUST001;
grant SELECT                                                                 on STMT            to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STMT            to STMT;
grant SELECT                                                                 on STMT            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STMT            to WR_ALL_RIGHTS;
grant SELECT                                                                 on STMT            to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on STMT            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STMT.sql =========*** End *** ========
PROMPT ===================================================================================== 
