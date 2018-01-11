

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_DOG_SYNC_PARAMS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_SYNC_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_DOG_SYNC_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_SYNC_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_SYNC_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_DOG_SYNC_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_DOG_SYNC_PARAMS 
   (	ND NUMBER(38,0), 
	MFO VARCHAR2(6), 
	DATA_TYPE NUMBER(1,0), 
	SYNC_TYPE NUMBER(1,0), 
	IS_SYNC NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_DOG_SYNC_PARAMS ***
 exec bpa.alter_policies('CIG_DOG_SYNC_PARAMS');


COMMENT ON TABLE BARS.CIG_DOG_SYNC_PARAMS IS 'Перелік договорів по яким необхідна разова відправка';
COMMENT ON COLUMN BARS.CIG_DOG_SYNC_PARAMS.ND IS 'Номер договору';
COMMENT ON COLUMN BARS.CIG_DOG_SYNC_PARAMS.MFO IS 'МФО';
COMMENT ON COLUMN BARS.CIG_DOG_SYNC_PARAMS.DATA_TYPE IS 'Вид договору (1 - звичайні кредити, 2 - кредитна лінія, 3 - БПК, 4 - овердрафти, 5 - гарантіі, 6,7 - міжбанківські)';
COMMENT ON COLUMN BARS.CIG_DOG_SYNC_PARAMS.SYNC_TYPE IS 'Вид відправки 1 - закриття договору';
COMMENT ON COLUMN BARS.CIG_DOG_SYNC_PARAMS.IS_SYNC IS 'Ознака відправки 0 - не відлявляти, 1 - відправляти';




PROMPT *** Create  constraint PK_CIGDOGSYNCPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_SYNC_PARAMS ADD CONSTRAINT PK_CIGDOGSYNCPAR PRIMARY KEY (ND, MFO, DATA_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGSYNCPAR_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_SYNC_PARAMS MODIFY (MFO CONSTRAINT CC_CIGDOGSYNCPAR_MFO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGSYNCPAR_DATATYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_SYNC_PARAMS MODIFY (DATA_TYPE CONSTRAINT CC_CIGDOGSYNCPAR_DATATYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGSYNCPAR_SYNC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_SYNC_PARAMS MODIFY (IS_SYNC CONSTRAINT CC_CIGDOGSYNCPAR_SYNC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGDOGSYNCPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGDOGSYNCPAR ON BARS.CIG_DOG_SYNC_PARAMS (ND, MFO, DATA_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_DOG_SYNC_PARAMS ***
grant SELECT                                                                 on CIG_DOG_SYNC_PARAMS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_DOG_SYNC_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_DOG_SYNC_PARAMS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_DOG_SYNC_PARAMS to CIG_ROLE;
grant SELECT                                                                 on CIG_DOG_SYNC_PARAMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_DOG_SYNC_PARAMS.sql =========*** E
PROMPT ===================================================================================== 
