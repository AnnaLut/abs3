

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_FIELD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_FIELD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_FIELD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_FIELD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_FIELD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_FIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_FIELD 
   (	TAG CHAR(5), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 1 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_FIELD ***
 exec bpa.alter_policies('DPT_FIELD');


COMMENT ON TABLE BARS.DPT_FIELD IS 'Справочник доп.реквизитов вклада';
COMMENT ON COLUMN BARS.DPT_FIELD.TAG IS 'Код';
COMMENT ON COLUMN BARS.DPT_FIELD.NAME IS 'Наименование';




PROMPT *** Create  constraint SYS_C009768 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FIELD MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFIELD_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FIELD MODIFY (NAME CONSTRAINT CC_DPTFIELD_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FIELD ADD CONSTRAINT PK_DPTFIELD PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTFIELD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTFIELD ON BARS.DPT_FIELD (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_FIELD ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FIELD       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_FIELD       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FIELD       to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FIELD       to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FIELD       to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FIELD       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_FIELD       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_FIELD.sql =========*** End *** ===
PROMPT ===================================================================================== 
