

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SHTERM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SHTERM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SHTERM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SHTERM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SHTERM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SHTERM ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SHTERM 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(50), 
	COMMENTS VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SHTERM ***
 exec bpa.alter_policies('DPT_SHTERM');


COMMENT ON TABLE BARS.DPT_SHTERM IS 'Справочник расчета длит-ти штрафования';
COMMENT ON COLUMN BARS.DPT_SHTERM.ID IS 'ID депозита';
COMMENT ON COLUMN BARS.DPT_SHTERM.NAME IS 'Название';
COMMENT ON COLUMN BARS.DPT_SHTERM.COMMENTS IS 'Комментарий';




PROMPT *** Create  constraint PK_DPTSHTERM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHTERM ADD CONSTRAINT PK_DPTSHTERM PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSHTERM_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHTERM MODIFY (ID CONSTRAINT CC_DPTSHTERM_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSHTERM_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHTERM MODIFY (NAME CONSTRAINT CC_DPTSHTERM_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTSHTERM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTSHTERM ON BARS.DPT_SHTERM (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_SHTERM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTERM      to ABS_ADMIN;
grant SELECT                                                                 on DPT_SHTERM      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTERM      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_SHTERM      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTERM      to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTERM      to DPT_ADMIN;
grant SELECT                                                                 on DPT_SHTERM      to START1;
grant SELECT                                                                 on DPT_SHTERM      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_SHTERM      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SHTERM.sql =========*** End *** ==
PROMPT ===================================================================================== 
