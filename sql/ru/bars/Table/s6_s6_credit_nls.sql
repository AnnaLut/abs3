

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_CREDIT_NLS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_CREDIT_NLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_CREDIT_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_CREDIT_NLS 
   (	BIC NUMBER(11,0), 
	IDCONTRACT VARCHAR2(40), 
	NLS VARCHAR2(25), 
	KSS VARCHAR2(1), 
	TYPE NUMBER(11,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_CREDIT_NLS ***
 exec bpa.alter_policies('S6_S6_CREDIT_NLS');


COMMENT ON TABLE BARS.S6_S6_CREDIT_NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_NLS.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_NLS.IDCONTRACT IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_NLS.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_NLS.KSS IS '';
COMMENT ON COLUMN BARS.S6_S6_CREDIT_NLS.TYPE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_CREDIT_NLS.sql =========*** End 
PROMPT ===================================================================================== 
