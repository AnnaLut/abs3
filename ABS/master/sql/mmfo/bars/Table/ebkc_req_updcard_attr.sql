

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_REQ_UPDCARD_ATTR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_REQ_UPDCARD_ATTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_REQ_UPDCARD_ATTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_REQ_UPDCARD_ATTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_REQ_UPDCARD_ATTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_REQ_UPDCARD_ATTR 
   (	KF VARCHAR2(6), 
	RNK NUMBER(38,0), 
	QUALITY VARCHAR2(5), 
	NAME VARCHAR2(100), 
	VALUE VARCHAR2(4000), 
	RECOMMENDVALUE VARCHAR2(4000), 
	DESCR VARCHAR2(4000), 
	CUST_TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_REQ_UPDCARD_ATTR ***
 exec bpa.alter_policies('EBKC_REQ_UPDCARD_ATTR');


COMMENT ON TABLE BARS.EBKC_REQ_UPDCARD_ATTR IS 'Таблицa приема рекомендаций по карточкам (детаил)';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.KF IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.QUALITY IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.NAME IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.VALUE IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.RECOMMENDVALUE IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.DESCR IS '';
COMMENT ON COLUMN BARS.EBKC_REQ_UPDCARD_ATTR.CUST_TYPE IS '';




PROMPT *** Create  constraint SYS_C0032177 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_REQ_UPDCARD_ATTR MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032178 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_REQ_UPDCARD_ATTR MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_EBKC_REQ_UPDCARD_ATTR ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_EBKC_REQ_UPDCARD_ATTR ON BARS.EBKC_REQ_UPDCARD_ATTR (KF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_REQ_UPDCARD_ATTR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_REQ_UPDCARD_ATTR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_REQ_UPDCARD_ATTR to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_REQ_UPDCARD_ATTR.sql =========***
PROMPT ===================================================================================== 
