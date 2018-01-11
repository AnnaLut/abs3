

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_NBS4CUST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_NBS4CUST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_NBS4CUST'', ''CENTER'' , null, null, null, null);
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
	IRVK VARCHAR2(1), 
	NBS_DEP CHAR(4), 
	NBS_INT CHAR(4) GENERATED ALWAYS AS (SUBSTR(NBS_DEP,1,3)||''8'') VIRTUAL VISIBLE , 
	NBS_EXP CHAR(4) GENERATED ALWAYS AS (CASE  WHEN K013=''1'' THEN ''7030'' WHEN K013=''2'' THEN ''707''||IRVK WHEN K013=''5'' THEN ''704''||IRVK ELSE ''702''||IRVK END) VIRTUAL VISIBLE , 
	NBS_RED CHAR(4) GENERATED ALWAYS AS (''6350'') VIRTUAL VISIBLE 
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


COMMENT ON TABLE BARS.DPU_NBS4CUST IS 'Види клієнтів (K013) <-> бал.рах. депозитів ЮО';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.K013 IS 'Код виду клиента';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.IRVK IS '1 - безвідкличний (строковий) / 0 - відкличний (на вимогу)';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_DEP IS 'Бал. рах. депозиту';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_INT IS 'Бал. рах. відсотків';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_EXP IS 'Бал. рах. витрат';
COMMENT ON COLUMN BARS.DPU_NBS4CUST.NBS_RED IS 'Бал. рах. повернення';




PROMPT *** Create  constraint CC_DPUNBS4CUST_K013_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST MODIFY (K013 CONSTRAINT CC_DPUNBS4CUST_K013_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUNBS4CUST_IRVK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST MODIFY (IRVK CONSTRAINT CC_DPUNBS4CUST_IRVK_NN NOT NULL ENABLE)';
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




PROMPT *** Create  constraint CC_DPUNBS4CUST_K013 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST ADD CONSTRAINT CC_DPUNBS4CUST_K013 CHECK ( K013 <> ''5'' ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUNBS4CUST_IRVCBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST ADD CONSTRAINT CC_DPUNBS4CUST_IRVCBL CHECK ( IRVK in (''0'',''1'') ) ENABLE';
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
grant SELECT                                                                 on DPU_NBS4CUST    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_NBS4CUST    to DPT_ADMIN;
grant SELECT                                                                 on DPU_NBS4CUST    to DPT_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_NBS4CUST.sql =========*** End *** 
PROMPT ===================================================================================== 
