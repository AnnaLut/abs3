

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DOC_TEMPLATE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DOC_TEMPLATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DOC_TEMPLATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_TEMPLATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DOC_TEMPLATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DOC_TEMPLATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DOC_TEMPLATE 
   (	TEMPLATE_ID NUMBER(38,0), 
	TEMPLATE_NAME VARCHAR2(30), 
	NLS_A VARCHAR2(15), 
	KV_A NUMBER(3,0), 
	MFO_A VARCHAR2(12), 
	NAM_A VARCHAR2(70), 
	ID_A VARCHAR2(14), 
	NLS_B VARCHAR2(15), 
	KV_B NUMBER(3,0), 
	MFO_B VARCHAR2(12), 
	NAM_B VARCHAR2(70), 
	ID_B VARCHAR2(14), 
	NAZN VARCHAR2(160), 
	USER_ID NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DOC_TEMPLATE ***
 exec bpa.alter_policies('DOC_TEMPLATE');


COMMENT ON TABLE BARS.DOC_TEMPLATE IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.TEMPLATE_ID IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.TEMPLATE_NAME IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.NLS_A IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.KV_A IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.MFO_A IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.NAM_A IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.ID_A IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.NLS_B IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.KV_B IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.MFO_B IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.NAM_B IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.ID_B IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.NAZN IS '';
COMMENT ON COLUMN BARS.DOC_TEMPLATE.USER_ID IS '';




PROMPT *** Create  constraint PK_DOC_TEMPLATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DOC_TEMPLATE ADD CONSTRAINT PK_DOC_TEMPLATE PRIMARY KEY (TEMPLATE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DOC_TEMPLATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DOC_TEMPLATE ON BARS.DOC_TEMPLATE (TEMPLATE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DOC_TEMPLATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_TEMPLATE    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DOC_TEMPLATE    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DOC_TEMPLATE    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DOC_TEMPLATE.sql =========*** End *** 
PROMPT ===================================================================================== 
