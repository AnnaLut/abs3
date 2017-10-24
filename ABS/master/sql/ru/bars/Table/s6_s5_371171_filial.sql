

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S5_371171_FILIAL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S5_371171_FILIAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S5_371171_FILIAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S5_371171_FILIAL 
   (	KFIL NUMBER(5,0), 
	FF VARCHAR2(3), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S5_371171_FILIAL ***
 exec bpa.alter_policies('S6_S5_371171_FILIAL');


COMMENT ON TABLE BARS.S6_S5_371171_FILIAL IS '';
COMMENT ON COLUMN BARS.S6_S5_371171_FILIAL.KFIL IS '';
COMMENT ON COLUMN BARS.S6_S5_371171_FILIAL.FF IS '';
COMMENT ON COLUMN BARS.S6_S5_371171_FILIAL.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S5_371171_FILIAL.sql =========*** E
PROMPT ===================================================================================== 
