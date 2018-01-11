

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CUSTOMER.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CUSTOMER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_CUSTOMER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_CUSTOMER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_CUSTOMER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CUSTOMER ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CUSTOMER 
   (	RNK NUMBER, 
	CUSTTYPE NUMBER, 
	COUNTRY NUMBER, 
	NMK VARCHAR2(70), 
	CODCAGENT NUMBER, 
	PRINSIDER NUMBER, 
	OKPO VARCHAR2(14), 
	C_REG NUMBER, 
	C_DST NUMBER, 
	DATE_ON DATE, 
	DATE_OFF DATE, 
	CRISK NUMBER, 
	ISE CHAR(5), 
	FS CHAR(2), 
	OE CHAR(5), 
	VED CHAR(5), 
	SED CHAR(4), 
	MB CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CUSTOMER ***
 exec bpa.alter_policies('TMP_CUSTOMER');


COMMENT ON TABLE BARS.TMP_CUSTOMER IS 'Архив внутренних файлов отчетности СБ';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.COUNTRY IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.NMK IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.CODCAGENT IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.PRINSIDER IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.C_REG IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.C_DST IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.DATE_ON IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.DATE_OFF IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.CRISK IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.ISE IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.FS IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.OE IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.VED IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.SED IS '';
COMMENT ON COLUMN BARS.TMP_CUSTOMER.MB IS '';




PROMPT *** Create  constraint PK_TMP_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CUSTOMER ADD CONSTRAINT PK_TMP_CUSTOMER PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_CUSTOMER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_CUSTOMER ON BARS.TMP_CUSTOMER (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CUSTOMER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CUSTOMER    to ABS_ADMIN;
grant SELECT                                                                 on TMP_CUSTOMER    to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_CUSTOMER    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_CUSTOMER    to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_CUSTOMER    to RPBN002;
grant SELECT                                                                 on TMP_CUSTOMER    to START1;
grant SELECT                                                                 on TMP_CUSTOMER    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_CUSTOMER    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CUSTOMER.sql =========*** End *** 
PROMPT ===================================================================================== 
