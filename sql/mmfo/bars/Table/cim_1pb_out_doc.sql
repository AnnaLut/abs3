

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_1PB_OUT_DOC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_1PB_OUT_DOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_1PB_OUT_DOC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_1PB_OUT_DOC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_1PB_OUT_DOC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_1PB_OUT_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_1PB_OUT_DOC 
   (	REF_CA NUMBER(38,0), 
	VDAT DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	MFOA VARCHAR2(6), 
	MFOB VARCHAR2(6), 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	KOD_N_CA VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_1PB_OUT_DOC ***
 exec bpa.alter_policies('CIM_1PB_OUT_DOC');


COMMENT ON TABLE BARS.CIM_1PB_OUT_DOC IS 'Таблиця документів РУ через котловий 2909 (для 1ПБ)';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.REF_CA IS 'Референс ЦА';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.VDAT IS 'Дата валютування';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.S IS 'Сума';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.MFOA IS 'МФО рахунку надходження';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.MFOB IS 'МФО рахунку зарахування';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.NLSA IS 'Рахунок надходження';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.NLSB IS 'Рахунок зарахування';
COMMENT ON COLUMN BARS.CIM_1PB_OUT_DOC.KOD_N_CA IS 'Код призначення (у ЦА)';




PROMPT *** Create  constraint PK_CIM1PBOUTDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_OUT_DOC ADD CONSTRAINT PK_CIM1PBOUTDOC PRIMARY KEY (REF_CA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIM1PBOUTDOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIM1PBOUTDOC ON BARS.CIM_1PB_OUT_DOC (REF_CA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_1PB_OUT_DOC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_OUT_DOC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_1PB_OUT_DOC to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_OUT_DOC to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_1PB_OUT_DOC.sql =========*** End *
PROMPT ===================================================================================== 
