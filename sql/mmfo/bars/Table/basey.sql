

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BASEY.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BASEY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BASEY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BASEY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BASEY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BASEY ***
begin 
  execute immediate '
  CREATE TABLE BARS.BASEY 
   (	BASEY NUMBER(*,0), 
	NAME VARCHAR2(35), 
	NAME_MB VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BASEY ***
 exec bpa.alter_policies('BASEY');


COMMENT ON TABLE BARS.BASEY IS '% Базовые года';
COMMENT ON COLUMN BARS.BASEY.BASEY IS 'Код года';
COMMENT ON COLUMN BARS.BASEY.NAME IS 'Наименование базового года';
COMMENT ON COLUMN BARS.BASEY.NAME_MB IS 'Наим базы для TELEX';




PROMPT *** Create  constraint CC_BASEY_BASEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BASEY MODIFY (BASEY CONSTRAINT CC_BASEY_BASEY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BASEY_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BASEY MODIFY (NAME CONSTRAINT CC_BASEY_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.BASEY ADD CONSTRAINT PK_BASEY PRIMARY KEY (BASEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BASEY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BASEY ON BARS.BASEY (BASEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BASEY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BASEY           to ABS_ADMIN;
grant SELECT                                                                 on BASEY           to BARS010;
grant SELECT                                                                 on BASEY           to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BASEY           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BASEY           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BASEY           to BASEY;
grant SELECT                                                                 on BASEY           to CC_DOC;
grant SELECT                                                                 on BASEY           to CUST001;
grant SELECT                                                                 on BASEY           to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on BASEY           to DPT_ADMIN;
grant SELECT                                                                 on BASEY           to START1;
grant SELECT                                                                 on BASEY           to UPLD;
grant SELECT                                                                 on BASEY           to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BASEY           to WR_ALL_RIGHTS;
grant SELECT                                                                 on BASEY           to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on BASEY           to WR_REFREAD;
grant SELECT                                                                 on BASEY           to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BASEY.sql =========*** End *** =======
PROMPT ===================================================================================== 
