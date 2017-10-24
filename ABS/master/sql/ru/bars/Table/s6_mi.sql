

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_MI.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_MI ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_MI ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_MI 
   (	NLS_FIL VARCHAR2(9), 
	KV NUMBER(9,0), 
	NLS_BARS VARCHAR2(9), 
	FILIAL VARCHAR2(9)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_MI ***
 exec bpa.alter_policies('S6_MI');


COMMENT ON TABLE BARS.S6_MI IS '';
COMMENT ON COLUMN BARS.S6_MI.NLS_FIL IS '';
COMMENT ON COLUMN BARS.S6_MI.KV IS '';
COMMENT ON COLUMN BARS.S6_MI.NLS_BARS IS '';
COMMENT ON COLUMN BARS.S6_MI.FILIAL IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_MI.sql =========*** End *** =======
PROMPT ===================================================================================== 
