

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_CERTIFICATES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_CERTIFICATES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_CERTIFICATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_CERTIFICATES 
   (	BIC NUMBER(11,0), 
	GROUP_C NUMBER(11,0), 
	IDCLIENT NUMBER(11,0), 
	CERTIFICAT NUMBER(11,0), 
	SERIES VARCHAR2(7), 
	NUMBER VARCHAR2(20), 
	WHATDIST VARCHAR2(150), 
	DATEDIST DATE, 
	D_MODIFY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_CERTIFICATES ***
 exec bpa.alter_policies('S6_S6_CERTIFICATES');


COMMENT ON TABLE BARS.S6_S6_CERTIFICATES IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.IDCLIENT IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.CERTIFICAT IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.SERIES IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.NUMBER IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.WHATDIST IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.DATEDIST IS '';
COMMENT ON COLUMN BARS.S6_S6_CERTIFICATES.D_MODIFY IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_CERTIFICATES.sql =========*** En
PROMPT ===================================================================================== 
