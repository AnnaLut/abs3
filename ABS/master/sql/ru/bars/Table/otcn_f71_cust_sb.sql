

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_CUST_SB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_CUST_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_CUST_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_CUST_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_CUST_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F71_CUST_SB 
   (	RNK NUMBER, 
	OKPO VARCHAR2(10), 
	REZ NUMBER, 
	CUSTTYPE NUMBER, 
	P010 VARCHAR2(200), 
	P020 VARCHAR2(10), 
	P025 VARCHAR2(10), 
	P040 VARCHAR2(10), 
	P050 VARCHAR2(10), 
	P055 VARCHAR2(10), 
	P060 VARCHAR2(10), 
	P085 VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F71_CUST_SB ***
 exec bpa.alter_policies('OTCN_F71_CUST_SB');


COMMENT ON TABLE BARS.OTCN_F71_CUST_SB IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.OKPO IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.REZ IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P010 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P020 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P025 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P040 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P050 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P055 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P060 IS '';
COMMENT ON COLUMN BARS.OTCN_F71_CUST_SB.P085 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_CUST_SB.sql =========*** End 
PROMPT ===================================================================================== 
