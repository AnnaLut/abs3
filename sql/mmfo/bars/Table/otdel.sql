

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTDEL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTDEL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTDEL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTDEL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTDEL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTDEL ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTDEL 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTDEL ***
 exec bpa.alter_policies('OTDEL');


COMMENT ON TABLE BARS.OTDEL IS 'Справочник подразделений банка';
COMMENT ON COLUMN BARS.OTDEL.ID IS 'Код подразделения';
COMMENT ON COLUMN BARS.OTDEL.NAME IS 'Наименование подразделения';




PROMPT *** Create  constraint PK_OTDEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTDEL ADD CONSTRAINT PK_OTDEL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008454 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTDEL MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTDEL_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTDEL MODIFY (NAME CONSTRAINT CC_OTDEL_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTDEL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTDEL ON BARS.OTDEL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTDEL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTDEL           to ABS_ADMIN;
grant SELECT                                                                 on OTDEL           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTDEL           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTDEL           to BARS_DM;
grant SELECT                                                                 on OTDEL           to RPBN001;
grant SELECT                                                                 on OTDEL           to SALGL;
grant SELECT                                                                 on OTDEL           to START1;
grant SELECT                                                                 on OTDEL           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTDEL           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OTDEL           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTDEL.sql =========*** End *** =======
PROMPT ===================================================================================== 
