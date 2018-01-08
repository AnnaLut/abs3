

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TRUSTEE_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TRUSTEE_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TRUSTEE_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TRUSTEE_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_TRUSTEE_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TRUSTEE_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TRUSTEE_TYPE 
   (	ID CHAR(1), 
	FL_OWNER NUMBER(1,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TRUSTEE_TYPE ***
 exec bpa.alter_policies('DPT_TRUSTEE_TYPE');


COMMENT ON TABLE BARS.DPT_TRUSTEE_TYPE IS 'Типы доверенных лиц - совкладчиков';
COMMENT ON COLUMN BARS.DPT_TRUSTEE_TYPE.ID IS 'Код типа';
COMMENT ON COLUMN BARS.DPT_TRUSTEE_TYPE.FL_OWNER IS 'Признак владельца';
COMMENT ON COLUMN BARS.DPT_TRUSTEE_TYPE.NAME IS 'Наименование типа совкладчика';




PROMPT *** Create  constraint CC_DPTTRUSTEETYPE_FLOWNER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE_TYPE MODIFY (FL_OWNER CONSTRAINT CC_DPTTRUSTEETYPE_FLOWNER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEETYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE_TYPE MODIFY (NAME CONSTRAINT CC_DPTTRUSTEETYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTTRUSTEETYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE_TYPE ADD CONSTRAINT PK_DPTTRUSTEETYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTTRUSTEETYPE_FLOWNER ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_TRUSTEE_TYPE ADD CONSTRAINT CC_DPTTRUSTEETYPE_FLOWNER CHECK (fl_owner IN (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTTRUSTEETYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTTRUSTEETYPE ON BARS.DPT_TRUSTEE_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_TRUSTEE_TYPE ***
grant SELECT                                                                 on DPT_TRUSTEE_TYPE to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_TRUSTEE_TYPE to BARSUPL;
grant SELECT                                                                 on DPT_TRUSTEE_TYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TRUSTEE_TYPE to BARS_DM;
grant SELECT                                                                 on DPT_TRUSTEE_TYPE to DPT_ROLE;
grant SELECT                                                                 on DPT_TRUSTEE_TYPE to KLBX;
grant SELECT                                                                 on DPT_TRUSTEE_TYPE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TRUSTEE_TYPE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TRUSTEE_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
