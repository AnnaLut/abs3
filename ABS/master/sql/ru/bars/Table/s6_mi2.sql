

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_MI2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_MI2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_MI2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_MI2 
   (	NLS_FIL VARCHAR2(23), 
	KV NUMBER(6,0), 
	NLS_BARS VARCHAR2(19), 
	FILIAL VARCHAR2(7)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_MI2 ***
 exec bpa.alter_policies('S6_MI2');


COMMENT ON TABLE BARS.S6_MI2 IS '';
COMMENT ON COLUMN BARS.S6_MI2.NLS_FIL IS '';
COMMENT ON COLUMN BARS.S6_MI2.KV IS '';
COMMENT ON COLUMN BARS.S6_MI2.NLS_BARS IS '';
COMMENT ON COLUMN BARS.S6_MI2.FILIAL IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_MI2.sql =========*** End *** ======
PROMPT ===================================================================================== 
