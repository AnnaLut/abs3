

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_FORM_XOZ.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_FORM_XOZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_FORM_XOZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_FORM_XOZ 
   (	ID NUMBER(11,0), 
	NAME VARCHAR2(80), 
	K051 NUMBER(11,0), 
	K052 NUMBER(11,0), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_FORM_XOZ ***
 exec bpa.alter_policies('S6_S6_FORM_XOZ');


COMMENT ON TABLE BARS.S6_S6_FORM_XOZ IS '';
COMMENT ON COLUMN BARS.S6_S6_FORM_XOZ.ID IS '';
COMMENT ON COLUMN BARS.S6_S6_FORM_XOZ.NAME IS '';
COMMENT ON COLUMN BARS.S6_S6_FORM_XOZ.K051 IS '';
COMMENT ON COLUMN BARS.S6_S6_FORM_XOZ.K052 IS '';
COMMENT ON COLUMN BARS.S6_S6_FORM_XOZ.D_OPEN IS '';
COMMENT ON COLUMN BARS.S6_S6_FORM_XOZ.D_CLOSE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_FORM_XOZ.sql =========*** End **
PROMPT ===================================================================================== 
