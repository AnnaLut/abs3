

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S5_371171_SHABLON.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S5_371171_SHABLON ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S5_371171_SHABLON ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S5_371171_SHABLON 
   (	BALS VARCHAR2(4), 
	MASKA VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S5_371171_SHABLON ***
 exec bpa.alter_policies('S6_S5_371171_SHABLON');


COMMENT ON TABLE BARS.S6_S5_371171_SHABLON IS '';
COMMENT ON COLUMN BARS.S6_S5_371171_SHABLON.BALS IS '';
COMMENT ON COLUMN BARS.S6_S5_371171_SHABLON.MASKA IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S5_371171_SHABLON.sql =========*** 
PROMPT ===================================================================================== 
