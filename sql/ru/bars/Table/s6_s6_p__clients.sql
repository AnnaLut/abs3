

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_P__CLIENTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_P__CLIENTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_P__CLIENTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_P__CLIENTS 
   (	BIC NUMBER(11,0), 
	GROUP_C NUMBER(11,0), 
	IDCLIENT NUMBER(11,0), 
	CLASS VARCHAR2(1), 
	D_D1 VARCHAR2(1), 
	DATIVE VARCHAR2(150), 
	GENITIVE VARCHAR2(150), 
	K013 VARCHAR2(1), 
	K014 VARCHAR2(1), 
	K015 VARCHAR2(1), 
	K016 VARCHAR2(1), 
	ORG VARCHAR2(100), 
	PROF VARCHAR2(100), 
	PS_CLERK NUMBER(11,0), 
	TIES NUMBER(11,0), 
	WORKSDATE DATE, 
	PS_FSGROUP NUMBER(11,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_P__CLIENTS ***
 exec bpa.alter_policies('S6_S6_P__CLIENTS');


COMMENT ON TABLE BARS.S6_S6_P__CLIENTS IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.GROUP_C IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.IDCLIENT IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.CLASS IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.D_D1 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.DATIVE IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.GENITIVE IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.K013 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.K014 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.K015 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.K016 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.ORG IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.PROF IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.PS_CLERK IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.TIES IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.WORKSDATE IS '';
COMMENT ON COLUMN BARS.S6_S6_P__CLIENTS.PS_FSGROUP IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_P__CLIENTS.sql =========*** End 
PROMPT ===================================================================================== 
