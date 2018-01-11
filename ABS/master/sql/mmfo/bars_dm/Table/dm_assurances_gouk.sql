

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/DM_ASSURANCES_GOUK.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  table DM_ASSURANCES_GOUK ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DM_ASSURANCES_GOUK 
   (	PER_ID NUMBER, 
	KF VARCHAR2(6), 
	REF NUMBER, 
	NLS VARCHAR2(15), 
	COD VARCHAR2(60), 
	NDOG VARCHAR2(30), 
	S_PAY NUMBER(15,2), 
	S_COM NUMBER(15,2), 
	DEP_BANK VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.DM_ASSURANCES_GOUK IS 'Страховки для ГОУК';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.PER_ID IS '';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.KF IS '';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.REF IS '';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.NLS IS 'Рахунок зарахування';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.COD IS 'Код виду страхування';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.NDOG IS '№ договору страхування';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.S_PAY IS 'Сума страхового платежу';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.S_COM IS 'Комісія за страховим платежем';
COMMENT ON COLUMN BARS_DM.DM_ASSURANCES_GOUK.DEP_BANK IS 'Номер установи банку';




PROMPT *** Create  index I_DMASSGOUK_REL_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_DMASSGOUK_REL_PERID ON BARS_DM.DM_ASSURANCES_GOUK (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DM_ASSURANCES_GOUK ***
grant SELECT                                                                 on DM_ASSURANCES_GOUK to BARS;
grant SELECT                                                                 on DM_ASSURANCES_GOUK to BARSREADER_ROLE;
grant SELECT                                                                 on DM_ASSURANCES_GOUK to BARSUPL;
grant SELECT                                                                 on DM_ASSURANCES_GOUK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/DM_ASSURANCES_GOUK.sql =========***
PROMPT ===================================================================================== 
