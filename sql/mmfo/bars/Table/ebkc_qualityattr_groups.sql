

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_QUALITYATTR_GROUPS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_QUALITYATTR_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_QUALITYATTR_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_QUALITYATTR_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_QUALITYATTR_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_QUALITYATTR_GROUPS 
   (	BATCHID VARCHAR2(50), 
	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	NAME VARCHAR2(50), 
	QUALITY NUMBER(6,2), 
	CUST_TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_QUALITYATTR_GROUPS ***
 exec bpa.alter_policies('EBKC_QUALITYATTR_GROUPS');


COMMENT ON TABLE BARS.EBKC_QUALITYATTR_GROUPS IS 'Таблица групп качеств по клиенту';
COMMENT ON COLUMN BARS.EBKC_QUALITYATTR_GROUPS.BATCHID IS '';
COMMENT ON COLUMN BARS.EBKC_QUALITYATTR_GROUPS.KF IS '';
COMMENT ON COLUMN BARS.EBKC_QUALITYATTR_GROUPS.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_QUALITYATTR_GROUPS.NAME IS '';
COMMENT ON COLUMN BARS.EBKC_QUALITYATTR_GROUPS.QUALITY IS '';
COMMENT ON COLUMN BARS.EBKC_QUALITYATTR_GROUPS.CUST_TYPE IS '';




PROMPT *** Create  index I1_EBKC_QUALATTR_GROUPS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_EBKC_QUALATTR_GROUPS ON BARS.EBKC_QUALITYATTR_GROUPS (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_EBKC_QUALATTR_GROUPS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_EBKC_QUALATTR_GROUPS ON BARS.EBKC_QUALITYATTR_GROUPS (NAME, QUALITY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_QUALITYATTR_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_QUALITYATTR_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_QUALITYATTR_GROUPS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_QUALITYATTR_GROUPS.sql =========*
PROMPT ===================================================================================== 
