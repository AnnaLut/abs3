

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZERV_ERRORS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZERV_ERRORS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZERV_ERRORS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SREZERV_ERRORS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SREZERV_ERRORS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZERV_ERRORS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZERV_ERRORS 
   (	DAT DATE, 
	USERID NUMBER(10,0), 
	ERROR_TYPE NUMBER(3,0), 
	NBS VARCHAR2(10), 
	S080 VARCHAR2(1), 
	CUSTTYPE VARCHAR2(1), 
	KV VARCHAR2(3), 
	BRANCH VARCHAR2(100), 
	NBS_REZ VARCHAR2(20), 
	NBS_7F VARCHAR2(10), 
	NBS_7R VARCHAR2(10), 
	SZ NUMBER, 
	ERROR_TXT VARCHAR2(1000), 
	DESRC VARCHAR2(1000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZERV_ERRORS ***
 exec bpa.alter_policies('SREZERV_ERRORS');


COMMENT ON TABLE BARS.SREZERV_ERRORS IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.KF IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.DAT IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.USERID IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.ERROR_TYPE IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.NBS IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.S080 IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.KV IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.BRANCH IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.NBS_REZ IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.NBS_7F IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.NBS_7R IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.SZ IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.ERROR_TXT IS '';
COMMENT ON COLUMN BARS.SREZERV_ERRORS.DESRC IS '';




PROMPT *** Create  constraint CC_SREZERVERRORS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZERV_ERRORS MODIFY (KF CONSTRAINT CC_SREZERVERRORS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SREZERV_ERRORS ***
grant SELECT                                                                 on SREZERV_ERRORS  to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on SREZERV_ERRORS  to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT,UPDATE                                                   on SREZERV_ERRORS  to RCC_DEAL;
grant SELECT                                                                 on SREZERV_ERRORS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZERV_ERRORS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZERV_ERRORS.sql =========*** End **
PROMPT ===================================================================================== 
