

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_NBS4CUST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_NBS4CUST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_NBS4CUST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_NBS4CUST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_NBS4CUST ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_NBS4CUST 
   (	K013 CHAR(1), 
	NBS_DEP CHAR(4), 
	S181 VARCHAR2(1), 
	NBS_INT VARCHAR2(4) GENERATED ALWAYS AS (SUBSTR(NBS_DEP,1,3)||''8'') VIRTUAL VISIBLE , 
	NBS_EXP VARCHAR2(4) GENERATED ALWAYS AS (CASE  WHEN K013=''1'' THEN ''7030'' WHEN (K013=''2'' AND S181=''0'') THEN ''7070'' WHEN (K013=''2'' AND S181<>''0'') THEN ''7071'' WHEN (K013=''5'' AND S181=''0'') THEN ''7040'' WHEN (K013=''5'' AND S181<>''0'') THEN ''7041'' ELSE CASE S181 WHEN ''0'' THEN ''7020'' ELSE ''7021'' END  END) VIRTUAL VISIBLE , 
	NBS_RED VARCHAR2(4) GENERATED ALWAYS AS (''6399'') VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_NBS4CUST ***
 exec bpa.alter_policies('DPU_NBS4CUST');


COMMENT ON TABLE BARS.DPU_NBS4CUST IS 'Виды клиентов (K013) <-> бал.счета депозитов юр.лиц';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_INT IS '';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_EXP IS '';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_RED IS '';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.S181 IS '';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.K013 IS 'Код вида клиента';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_DEP IS 'Код строку договору';




PROMPT *** Create  constraint FK_DPUNBS4CUST_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST ADD CONSTRAINT FK_DPUNBS4CUST_PS FOREIGN KEY (NBS_DEP)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUNBS4CUST_S181_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST MODIFY (S181 CONSTRAINT CC_DPUNBS4CUST_S181_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUNBS4CUST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST ADD CONSTRAINT PK_DPUNBS4CUST PRIMARY KEY (K013, NBS_DEP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUNBS4CUST_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST MODIFY (NBS_DEP CONSTRAINT CC_DPUNBS4CUST_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUNBS4CUST_K013_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST MODIFY (K013 CONSTRAINT CC_DPUNBS4CUST_K013_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUNBS4CUST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUNBS4CUST ON BARS.DPU_NBS4CUST (K013, NBS_DEP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_NBS4CUST ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_NBS4CUST    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_NBS4CUST    to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_NBS4CUST    to DPT_ADMIN;
grant SELECT                                                                 on DPU_NBS4CUST    to DPT_ROLE;
grant SELECT                                                                 on DPU_NBS4CUST    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPU_NBS4CUST    to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPU_NBS4CUST ***

  CREATE OR REPLACE PUBLIC SYNONYM DPU_NBS4CUST FOR BARS.DPU_NBS4CUST;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_NBS4CUST.sql =========*** End *** 
PROMPT ===================================================================================== 
