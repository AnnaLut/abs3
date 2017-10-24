

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONCLUSION.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONCLUSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONCLUSION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONCLUSION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONCLUSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONCLUSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONCLUSION 
   (	ID NUMBER, 
	CONTR_ID NUMBER, 
	ORG_ID NUMBER, 
	OUT_NUM VARCHAR2(16), 
	OUT_DATE DATE, 
	KV NUMBER, 
	S NUMBER, 
	BEGIN_DATE DATE, 
	END_DATE DATE, 
	CREATE_DATE DATE, 
	CREATE_UID NUMBER, 
	DELETE_DATE DATE, 
	DELETE_UID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONCLUSION ***
 exec bpa.alter_policies('CIM_CONCLUSION');


COMMENT ON TABLE BARS.CIM_CONCLUSION IS 'висновки';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.ID IS 'id висновку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.CONTR_ID IS 'id контракту';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.ORG_ID IS 'орган, який видав висновок';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.OUT_NUM IS 'Вихідний номер висновку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.OUT_DATE IS 'Вихідна дата висновку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.KV IS 'код валюти';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.S IS 'Сума висновку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.BEGIN_DATE IS 'дата початку строку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.END_DATE IS 'дата закінчення строку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.CREATE_DATE IS 'дата введення висновку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.CREATE_UID IS 'користувач, який ввів висновок';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.DELETE_DATE IS 'дата видалення висновку';
COMMENT ON COLUMN BARS.CIM_CONCLUSION.DELETE_UID IS 'користувач, який видалив висновок';




PROMPT *** Create  constraint CC_CIMCONCLUSION_CONTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (CONTR_ID CONSTRAINT CC_CIMCONCLUSION_CONTRID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMCONCLUSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION ADD CONSTRAINT PK_CIMCONCLUSION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONCLUSION_CREATEUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (CREATE_UID CONSTRAINT CC_CIMCONCLUSION_CREATEUID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONCLUSION_ORGID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (ORG_ID CONSTRAINT CC_CIMCONCLUSION_ORGID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONCLUSION_CREATEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (CREATE_DATE CONSTRAINT CC_CIMCONCLUSION_CREATEDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONCLUSION_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (S CONSTRAINT CC_CIMCONCLUSION_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONCLUSION_BEGINDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (BEGIN_DATE CONSTRAINT CC_CIMCONCLUSION_BEGINDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONCLUSION_ENDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (END_DATE CONSTRAINT CC_CIMCONCLUSION_ENDDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONCLUSION_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONCLUSION MODIFY (KV CONSTRAINT CC_CIMCONCLUSION_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMCONCLUSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMCONCLUSION ON BARS.CIM_CONCLUSION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONCLUSION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONCLUSION  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CONCLUSION  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONCLUSION  to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONCLUSION.sql =========*** End **
PROMPT ===================================================================================== 
