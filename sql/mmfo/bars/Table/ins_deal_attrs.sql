

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_DEAL_ATTRS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_DEAL_ATTRS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_DEAL_ATTRS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_DEAL_ATTRS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_DEAL_ATTRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_DEAL_ATTRS 
   (	DEAL_ID NUMBER, 
	ATTR_ID VARCHAR2(100), 
	VAL VARCHAR2(1024), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_DEAL_ATTRS ***
 exec bpa.alter_policies('INS_DEAL_ATTRS');


COMMENT ON TABLE BARS.INS_DEAL_ATTRS IS 'Список додаткових реквізитів договору страхування';
COMMENT ON COLUMN BARS.INS_DEAL_ATTRS.KF IS '';
COMMENT ON COLUMN BARS.INS_DEAL_ATTRS.DEAL_ID IS 'id договору';
COMMENT ON COLUMN BARS.INS_DEAL_ATTRS.ATTR_ID IS 'id атрибуту';
COMMENT ON COLUMN BARS.INS_DEAL_ATTRS.VAL IS 'Значення атрибуту';




PROMPT *** Create  constraint PK_INSDLSATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_ATTRS ADD CONSTRAINT PK_INSDLSATTRS PRIMARY KEY (DEAL_ID, ATTR_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSATTRS_DID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_ATTRS MODIFY (DEAL_ID CONSTRAINT CC_INSDLSATTRS_DID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSATTRS_AID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_ATTRS MODIFY (ATTR_ID CONSTRAINT CC_INSDLSATTRS_AID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSATTRS_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_ATTRS MODIFY (VAL CONSTRAINT CC_INSDLSATTRS_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSDLSATTRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSDLSATTRS ON BARS.INS_DEAL_ATTRS (DEAL_ID, ATTR_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** ALTER TABLE BARS.INS_DEAL_ATTRS VAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_ATTRS MODIFY (VAL VARCHAR2(4000))';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_DEAL_ATTRS ***
grant SELECT                                                                 on INS_DEAL_ATTRS  to BARSREADER_ROLE;
grant SELECT                                                                 on INS_DEAL_ATTRS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_DEAL_ATTRS.sql =========*** End **
PROMPT ===================================================================================== 
