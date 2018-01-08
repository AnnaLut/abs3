

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_COMPLEX.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BONUS_COMPLEX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BONUS_COMPLEX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_BONUS_COMPLEX'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_BONUS_COMPLEX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BONUS_COMPLEX ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BONUS_COMPLEX 
   (	VIDD NUMBER(38,0), 
	FUNC_NAME VARCHAR2(4000), 
	FUNC_ACTIVITY CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BONUS_COMPLEX ***
 exec bpa.alter_policies('DPT_BONUS_COMPLEX');


COMMENT ON TABLE BARS.DPT_BONUS_COMPLEX IS 'Спр-к функций расчетов результ.льгот для видов депозитных договоров ФЛ';
COMMENT ON COLUMN BARS.DPT_BONUS_COMPLEX.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_BONUS_COMPLEX.FUNC_NAME IS 'Имя функции для расчета результир.льготы';
COMMENT ON COLUMN BARS.DPT_BONUS_COMPLEX.FUNC_ACTIVITY IS 'Признак активности';




PROMPT *** Create  constraint PK_DPTBONUSCMPLX ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_COMPLEX ADD CONSTRAINT PK_DPTBONUSCMPLX PRIMARY KEY (VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSCMPLX_FUNCACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_COMPLEX ADD CONSTRAINT CC_DPTBONUSCMPLX_FUNCACTIVITY CHECK (func_activity IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSCMPLX_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_COMPLEX ADD CONSTRAINT FK_DPTBONUSCMPLX_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSCMPLX_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_COMPLEX MODIFY (VIDD CONSTRAINT CC_DPTBONUSCMPLX_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSCMPLX_FUNCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_COMPLEX MODIFY (FUNC_NAME CONSTRAINT CC_DPTBONUSCMPLX_FUNCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSCMPLX_FUNCACT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_COMPLEX MODIFY (FUNC_ACTIVITY CONSTRAINT CC_DPTBONUSCMPLX_FUNCACT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTBONUSCMPLX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTBONUSCMPLX ON BARS.DPT_BONUS_COMPLEX (VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_BONUS_COMPLEX ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_BONUS_COMPLEX to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_BONUS_COMPLEX to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_BONUS_COMPLEX to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_BONUS_COMPLEX to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_COMPLEX.sql =========*** End
PROMPT ===================================================================================== 
