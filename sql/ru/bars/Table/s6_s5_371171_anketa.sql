

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S5_371171_ANKETA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S5_371171_ANKETA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S5_371171_ANKETA ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S5_371171_ANKETA 
   (	SIGN VARCHAR2(15), 
	NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S5_371171_ANKETA ***
 exec bpa.alter_policies('S6_S5_371171_ANKETA');


COMMENT ON TABLE BARS.S6_S5_371171_ANKETA IS '';
COMMENT ON COLUMN BARS.S6_S5_371171_ANKETA.SIGN IS '';
COMMENT ON COLUMN BARS.S6_S5_371171_ANKETA.NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S5_371171_ANKETA.sql =========*** E
PROMPT ===================================================================================== 
