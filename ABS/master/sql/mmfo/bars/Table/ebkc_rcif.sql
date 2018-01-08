

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_RCIF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_RCIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_RCIF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EBKC_RCIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''EBKC_RCIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_RCIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_RCIF 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	RCIF NUMBER(38,0), 
	SEND NUMBER(1,0), 
	CUST_TYPE VARCHAR2(1), 
	 CONSTRAINT PK_EBKCRCIF PRIMARY KEY (KF, RCIF, SEND) ENABLE
   ) ORGANIZATION INDEX COMPRESS 1 PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLD 
 PCTTHRESHOLD 50 INCLUDING CUST_TYPE OVERFLOW
 PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_RCIF ***
 exec bpa.alter_policies('EBKC_RCIF');


COMMENT ON TABLE BARS.EBKC_RCIF IS 'Ідентифікатори майстер-картки на рівні РУ (рівні РНК)';
COMMENT ON COLUMN BARS.EBKC_RCIF.KF IS '';
COMMENT ON COLUMN BARS.EBKC_RCIF.RCIF IS '';
COMMENT ON COLUMN BARS.EBKC_RCIF.SEND IS '';
COMMENT ON COLUMN BARS.EBKC_RCIF.CUST_TYPE IS '';




PROMPT *** Create  constraint SYS_C0034007 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_RCIF MODIFY (KF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0034008 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_RCIF MODIFY (RCIF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0034009 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_RCIF MODIFY (SEND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EBKCRCIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_RCIF ADD CONSTRAINT PK_EBKCRCIF PRIMARY KEY (KF, RCIF, SEND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EBKCRCIF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EBKCRCIF ON BARS.EBKC_RCIF (KF, RCIF, SEND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_RCIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_RCIF       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_RCIF.sql =========*** End *** ===
PROMPT ===================================================================================== 
