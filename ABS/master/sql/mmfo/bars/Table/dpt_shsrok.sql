

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SHSROK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SHSROK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SHSROK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SHSROK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_SHSROK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SHSROK ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SHSROK 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SHSROK ***
 exec bpa.alter_policies('DPT_SHSROK');


COMMENT ON TABLE BARS.DPT_SHSROK IS 'Справочник видов вычисления штрафа по типу срока';
COMMENT ON COLUMN BARS.DPT_SHSROK.ID IS 'ID';
COMMENT ON COLUMN BARS.DPT_SHSROK.NAME IS 'Название';




PROMPT *** Create  constraint SYS_C005117 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHSROK MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSHSROK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHSROK MODIFY (NAME CONSTRAINT CC_DPTSHSROK_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTSHSROK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHSROK ADD CONSTRAINT PK_DPTSHSROK PRIMARY KEY (ID)
  USING INDEX PCTFREE 1 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTSHSROK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTSHSROK ON BARS.DPT_SHSROK (ID) 
  PCTFREE 1 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_SHSROK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHSROK      to ABS_ADMIN;
grant SELECT                                                                 on DPT_SHSROK      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHSROK      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_SHSROK      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHSROK      to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHSROK      to DPT_ADMIN;
grant SELECT                                                                 on DPT_SHSROK      to START1;
grant SELECT                                                                 on DPT_SHSROK      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_SHSROK      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SHSROK.sql =========*** End *** ==
PROMPT ===================================================================================== 
