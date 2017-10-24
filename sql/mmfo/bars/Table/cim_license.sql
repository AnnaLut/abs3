

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_LICENSE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_LICENSE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_LICENSE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_LICENSE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_LICENSE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_LICENSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_LICENSE 
   (	LICENSE_ID NUMBER, 
	OKPO VARCHAR2(14), 
	NUM VARCHAR2(16), 
	TYPE NUMBER, 
	KV NUMBER, 
	S NUMBER, 
	BEGIN_DATE DATE, 
	END_DATE DATE, 
	COMMENTS VARCHAR2(64), 
	DELETE_DATE DATE, 
	DELETE_UID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_LICENSE ***
 exec bpa.alter_policies('CIM_LICENSE');


COMMENT ON TABLE BARS.CIM_LICENSE IS 'Ліцензії мінекономіки';
COMMENT ON COLUMN BARS.CIM_LICENSE.LICENSE_ID IS 'ID ліцензії';
COMMENT ON COLUMN BARS.CIM_LICENSE.OKPO IS 'ОКПО резидента';
COMMENT ON COLUMN BARS.CIM_LICENSE.NUM IS 'Номер ліцензії';
COMMENT ON COLUMN BARS.CIM_LICENSE.TYPE IS 'Тип ліцензії';
COMMENT ON COLUMN BARS.CIM_LICENSE.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.CIM_LICENSE.S IS 'Сума';
COMMENT ON COLUMN BARS.CIM_LICENSE.BEGIN_DATE IS 'Дата ліцензії (скасування санкції)';
COMMENT ON COLUMN BARS.CIM_LICENSE.END_DATE IS 'Дата закінчення дії ліцензії';
COMMENT ON COLUMN BARS.CIM_LICENSE.COMMENTS IS 'Примітка';
COMMENT ON COLUMN BARS.CIM_LICENSE.DELETE_DATE IS 'Дата видалення';
COMMENT ON COLUMN BARS.CIM_LICENSE.DELETE_UID IS 'id користувача, який видалив висновок';




PROMPT *** Create  constraint CC_CIMLICENSE_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE MODIFY (OKPO CONSTRAINT CC_CIMLICENSE_OKPO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIMLICENSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE ADD CONSTRAINT PK_CIMLICENSE PRIMARY KEY (LICENSE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLICENSE_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE MODIFY (TYPE CONSTRAINT CC_CIMLICENSE_TYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLICENSE_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE MODIFY (KV CONSTRAINT CC_CIMLICENSE_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLICENSE_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE MODIFY (S CONSTRAINT CC_CIMLICENSE_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLICENSE_BEGINDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE MODIFY (BEGIN_DATE CONSTRAINT CC_CIMLICENSE_BEGINDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMLICENSE_ENDDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_LICENSE MODIFY (END_DATE CONSTRAINT CC_CIMLICENSE_ENDDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIMLICENSE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIMLICENSE ON BARS.CIM_LICENSE (LICENSE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_LICENSE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LICENSE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_LICENSE     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_LICENSE     to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_LICENSE.sql =========*** End *** =
PROMPT ===================================================================================== 
