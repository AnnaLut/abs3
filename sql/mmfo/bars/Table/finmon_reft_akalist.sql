

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_REFT_AKALIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_REFT_AKALIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_REFT_AKALIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT_AKALIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_REFT_AKALIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_REFT_AKALIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_REFT_AKALIST 
   (	C1 NUMBER(38,0), 
	C6 VARCHAR2(350), 
	C7 VARCHAR2(350), 
	C8 VARCHAR2(350), 
	C9 VARCHAR2(350), 
	ID NUMBER(38,0), 
	NAME_HASH VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_REFT_AKALIST ***
 exec bpa.alter_policies('FINMON_REFT_AKALIST');


COMMENT ON TABLE BARS.FINMON_REFT_AKALIST IS 'Перелік-2 юридичних та фізичних осіб, пов`язаних зі здійсненням терористичної діяльності';
COMMENT ON COLUMN BARS.FINMON_REFT_AKALIST.C1 IS 'Номер особи в Переліку осіб';
COMMENT ON COLUMN BARS.FINMON_REFT_AKALIST.C6 IS 'Прізвище резидента / ім`я 1 нерезидента / найменування юридичної особи';
COMMENT ON COLUMN BARS.FINMON_REFT_AKALIST.C7 IS 'Ім`я резидента / ім`я 2 нерезидента';
COMMENT ON COLUMN BARS.FINMON_REFT_AKALIST.C8 IS 'По батькові резидента / ім`я 3 нерезидента';
COMMENT ON COLUMN BARS.FINMON_REFT_AKALIST.C9 IS 'Ім`я 4 нерезидента ';
COMMENT ON COLUMN BARS.FINMON_REFT_AKALIST.ID IS '';
COMMENT ON COLUMN BARS.FINMON_REFT_AKALIST.NAME_HASH IS '';




PROMPT *** Create  constraint PK_FINMON_REFT_AKALIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT_AKALIST ADD CONSTRAINT PK_FINMON_REFT_AKALIST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_FINMON_REFT_AKALIST_NAME ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_FINMON_REFT_AKALIST_NAME ON BARS.FINMON_REFT_AKALIST (NAME_HASH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINMON_REFT_AKALIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINMON_REFT_AKALIST ON BARS.FINMON_REFT_AKALIST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_FINMON_REFT_AKALIST_C1 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_FINMON_REFT_AKALIST_C1 ON BARS.FINMON_REFT_AKALIST (C1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_REFT_AKALIST ***
grant SELECT                                                                 on FINMON_REFT_AKALIST to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on FINMON_REFT_AKALIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_REFT_AKALIST to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FINMON_REFT_AKALIST to FINMON;
grant SELECT                                                                 on FINMON_REFT_AKALIST to UPLD;



PROMPT *** Create SYNONYM  to FINMON_REFT_AKALIST ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_REFT_AKALIST FOR BARS.FINMON_REFT_AKALIST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_REFT_AKALIST.sql =========*** E
PROMPT ===================================================================================== 
