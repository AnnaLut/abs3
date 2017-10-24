

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_PERCENVID.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_PERCENVID ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_PERCENVID ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_PERCENVID 
   (	ID NUMBER(11,0), 
	NAME VARCHAR2(60), 
	P_KD NUMBER(11,0), 
	IDPARENT NUMBER(11,0), 
	SORTID NUMBER(11,0), 
	MINPERCEN NUMBER(18,8), 
	MAXPERCEN NUMBER(18,8), 
	CONST NUMBER(11,0), 
	ALLOWPRC NUMBER(18,8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_PERCENVID ***
 exec bpa.alter_policies('S6_S6_PERCENVID');


COMMENT ON TABLE BARS.S6_S6_PERCENVID IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.ID IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.NAME IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.P_KD IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.IDPARENT IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.SORTID IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.MINPERCEN IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.MAXPERCEN IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.CONST IS '';
COMMENT ON COLUMN BARS.S6_S6_PERCENVID.ALLOWPRC IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_PERCENVID.sql =========*** End *
PROMPT ===================================================================================== 
