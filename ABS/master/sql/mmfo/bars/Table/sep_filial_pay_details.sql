

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_FILIAL_PAY_DETAILS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_FILIAL_PAY_DETAILS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_FILIAL_PAY_DETAILS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_FILIAL_PAY_DETAILS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_FILIAL_PAY_DETAILS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_FILIAL_PAY_DETAILS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_FILIAL_PAY_DETAILS 
   (	MFO VARCHAR2(6), 
	TT CHAR(3), 
	NLS VARCHAR2(14), 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(38), 
	SORT_CODE VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_FILIAL_PAY_DETAILS ***
 exec bpa.alter_policies('SEP_FILIAL_PAY_DETAILS');


COMMENT ON TABLE BARS.SEP_FILIAL_PAY_DETAILS IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_PAY_DETAILS.MFO IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_PAY_DETAILS.TT IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_PAY_DETAILS.NLS IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_PAY_DETAILS.OKPO IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_PAY_DETAILS.NMK IS '';
COMMENT ON COLUMN BARS.SEP_FILIAL_PAY_DETAILS.SORT_CODE IS '';




PROMPT *** Create  constraint PK_SEPFLPAYDETAILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS ADD CONSTRAINT PK_SEPFLPAYDETAILS PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPFLPAYDETAILS_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS MODIFY (MFO CONSTRAINT CC_SEPFLPAYDETAILS_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPFLPAYDETAILS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS MODIFY (TT CONSTRAINT CC_SEPFLPAYDETAILS_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPFLPAYDETAILS_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS MODIFY (NLS CONSTRAINT CC_SEPFLPAYDETAILS_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPFLPAYDETAILS_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS MODIFY (OKPO CONSTRAINT CC_SEPFLPAYDETAILS_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPFLPAYDETAILS_NMK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS MODIFY (NMK CONSTRAINT CC_SEPFLPAYDETAILS_NMK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEPFLPAYDETAILS_SCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_FILIAL_PAY_DETAILS MODIFY (SORT_CODE CONSTRAINT CC_SEPFLPAYDETAILS_SCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEPFLPAYDETAILS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEPFLPAYDETAILS ON BARS.SEP_FILIAL_PAY_DETAILS (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_FILIAL_PAY_DETAILS ***
grant SELECT                                                                 on SEP_FILIAL_PAY_DETAILS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEP_FILIAL_PAY_DETAILS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_FILIAL_PAY_DETAILS to SEP_RATES_ROLE;
grant SELECT                                                                 on SEP_FILIAL_PAY_DETAILS to UPLD;
grant FLASHBACK,SELECT                                                       on SEP_FILIAL_PAY_DETAILS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_FILIAL_PAY_DETAILS.sql =========**
PROMPT ===================================================================================== 
