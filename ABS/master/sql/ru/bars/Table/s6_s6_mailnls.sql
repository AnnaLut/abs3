

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_MAILNLS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_MAILNLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_MAILNLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_MAILNLS 
   (	ABON VARCHAR2(10), 
	NLS VARCHAR2(25), 
	KSS VARCHAR2(1), 
	GROUP_U NUMBER(11,0), 
	I_VA NUMBER(11,0), 
	OKPO VARCHAR2(14), 
	NAME VARCHAR2(38), 
	VISIBLE NUMBER(11,0), 
	FLAGS VARCHAR2(20), 
	ISP NUMBER(11,0), 
	DEPART NUMBER(11,0), 
	ISP_OWNER NUMBER(11,0), 
	LIMIT NUMBER(18,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_MAILNLS ***
 exec bpa.alter_policies('S6_S6_MAILNLS');


COMMENT ON TABLE BARS.S6_S6_MAILNLS IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.ABON IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.KSS IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.OKPO IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.NAME IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.VISIBLE IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.FLAGS IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.ISP IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.DEPART IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.ISP_OWNER IS '';
COMMENT ON COLUMN BARS.S6_S6_MAILNLS.LIMIT IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_MAILNLS.sql =========*** End ***
PROMPT ===================================================================================== 
