

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_CREDIT_PERCENT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_CREDIT_PERCENT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_CREDIT_PERCENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_CREDIT_PERCENT 
   (	BIC NUMBER(11,0), 
	IDCONTRACT VARCHAR2(40), 
	D_BEGIN DATE, 
	PRC_OSN NUMBER(11,0), 
	PRC_PRS NUMBER(11,0), 
	PRC_PIN NUMBER(11,0), 
	PRC_PNP NUMBER(11,0), 
	D_END DATE, 
	FLAG NUMBER(11,0), 
	PERCENT_N NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_CREDIT_PERCENT ***
 exec bpa.alter_policies('S6_S6_CREDIT_PERCENT');


COMMENT ON TABLE BARS.S6_S6_CREDIT_PERCENT IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.IDCONTRACT IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.D_BEGIN IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.PRC_OSN IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.PRC_PRS IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.PRC_PIN IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.PRC_PNP IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.D_END IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.FLAG IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_PERCENT.PERCENT_N IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_CREDIT_PERCENT.sql =========*** 
PROMPT ===================================================================================== 
