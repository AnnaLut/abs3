

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_CORPS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_CORPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_CORPS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_CORPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_CORPS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_CORPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_CORPS 
   (	RNK NUMBER(38,0), 
	NMKU VARCHAR2(250), 
	RUK VARCHAR2(70), 
	TELR VARCHAR2(20), 
	BUH VARCHAR2(70), 
	TELB VARCHAR2(20), 
	TEL_FAX VARCHAR2(20), 
	E_MAIL VARCHAR2(100), 
	SEAL_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_CORPS ***
 exec bpa.alter_policies('CLV_CORPS');


COMMENT ON TABLE BARS.CLV_CORPS IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.RNK IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.NMKU IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.RUK IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.TELR IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.BUH IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.TELB IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.TEL_FAX IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.E_MAIL IS '';
COMMENT ON COLUMN BARS.CLV_CORPS.SEAL_ID IS '';




PROMPT *** Create  constraint PK_CLVCORPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CORPS ADD CONSTRAINT PK_CLVCORPS PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCORPS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CORPS MODIFY (RNK CONSTRAINT CC_CLVCORPS_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVCORPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVCORPS ON BARS.CLV_CORPS (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_CORPS ***
grant SELECT                                                                 on CLV_CORPS       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_CORPS       to BARS_DM;
grant SELECT                                                                 on CLV_CORPS       to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_CORPS.sql =========*** End *** ===
PROMPT ===================================================================================== 
