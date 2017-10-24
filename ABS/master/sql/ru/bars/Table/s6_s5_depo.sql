

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S5_DEPO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S5_DEPO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S5_DEPO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S5_DEPO 
   (	BALS VARCHAR2(4), 
	NLS VARCHAR2(15), 
	I_VA VARCHAR2(3), 
	OB22 VARCHAR2(2), 
	KOTL VARCHAR2(15), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S5_DEPO ***
 exec bpa.alter_policies('S6_S5_DEPO');


COMMENT ON TABLE BARS.S6_S5_DEPO IS '';
COMMENT ON COLUMN BARS.S6_S5_DEPO.BALS IS '';
COMMENT ON COLUMN BARS.S6_S5_DEPO.NLS IS '';
COMMENT ON COLUMN BARS.S6_S5_DEPO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S5_DEPO.OB22 IS '';
COMMENT ON COLUMN BARS.S6_S5_DEPO.KOTL IS '';
COMMENT ON COLUMN BARS.S6_S5_DEPO.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S5_DEPO.sql =========*** End *** ==
PROMPT ===================================================================================== 
