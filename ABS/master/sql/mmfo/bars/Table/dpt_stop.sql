

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_STOP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_STOP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_STOP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_STOP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_STOP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_STOP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_STOP 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(50), 
	FL NUMBER(2,0) DEFAULT 1, 
	SH_PROC NUMBER(2,0) DEFAULT 0, 
	SH_OST NUMBER(2,0) DEFAULT 1, 
	MOD_CODE VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_STOP ***
 exec bpa.alter_policies('DPT_STOP');


COMMENT ON TABLE BARS.DPT_STOP IS 'Справочник штрафов';
COMMENT ON COLUMN BARS.DPT_STOP.ID IS 'Код штрафа';
COMMENT ON COLUMN BARS.DPT_STOP.NAME IS 'Наименование штрафа';
COMMENT ON COLUMN BARS.DPT_STOP.FL IS 'Код единицы измерения срока вклада для расчета штрафа';
COMMENT ON COLUMN BARS.DPT_STOP.SH_PROC IS 'Тип штрафа';
COMMENT ON COLUMN BARS.DPT_STOP.SH_OST IS 'Признак безжалостного штрафа при условии,что вклад не вылежал полный месяц';
COMMENT ON COLUMN BARS.DPT_STOP.MOD_CODE IS 'Код модуля для штрафу (null - загальний)';




PROMPT *** Create  constraint PK_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP ADD CONSTRAINT PK_DPTSTOP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP MODIFY (ID CONSTRAINT CC_DPTSTOP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOP_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP MODIFY (NAME CONSTRAINT CC_DPTSTOP_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOP_FL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP MODIFY (FL CONSTRAINT CC_DPTSTOP_FL_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOP_SHPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP MODIFY (SH_PROC CONSTRAINT CC_DPTSTOP_SHPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTOP_SHOST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STOP MODIFY (SH_OST CONSTRAINT CC_DPTSTOP_SHOST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTSTOP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTSTOP ON BARS.DPT_STOP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_STOP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STOP        to ABS_ADMIN;
grant SELECT                                                                 on DPT_STOP        to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_STOP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_STOP        to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_STOP        to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STOP        to DPT_ADMIN;
grant SELECT                                                                 on DPT_STOP        to START1;
grant SELECT                                                                 on DPT_STOP        to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STOP        to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_STOP        to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPT_STOP        to WR_DEPOSIT_U;
grant FLASHBACK,SELECT                                                       on DPT_STOP        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_STOP.sql =========*** End *** ====
PROMPT ===================================================================================== 
