

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_TARGET.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_TARGET ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_TARGET ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_TARGET 
   (	ID NUMBER(11,0), 
	NAME VARCHAR2(80), 
	BLS NUMBER(11,0), 
	OSNSCH NUMBER(11,0), 
	ANALIT NUMBER(11,0), 
	OB22 NUMBER(11,0), 
	D30 NUMBER(11,0), 
	S181 NUMBER(11,0), 
	CLOSED DATE, 
	S260 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_TARGET ***
 exec bpa.alter_policies('S6_S6_TARGET');


COMMENT ON TABLE BARS.S6_S6_TARGET IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.ID IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.NAME IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.BLS IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.OSNSCH IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.ANALIT IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.OB22 IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.D30 IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.S181 IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.CLOSED IS '';
COMMENT ON COLUMN BARS.S6_S6_TARGET.S260 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_TARGET.sql =========*** End *** 
PROMPT ===================================================================================== 
