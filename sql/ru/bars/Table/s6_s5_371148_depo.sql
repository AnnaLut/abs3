

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S5_371148_DEPO.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S5_371148_DEPO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S5_371148_DEPO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S5_371148_DEPO 
   (	BALS VARCHAR2(4), 
	NLS NUMBER(15,0), 
	I_VA NUMBER(4,0), 
	OB22 VARCHAR2(2), 
	KOTL_OLD NUMBER(14,0), 
	KOTL NUMBER(14,0), 
	BRANCH VARCHAR2(22)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S5_371148_DEPO ***
 exec bpa.alter_policies('S6_S5_371148_DEPO');


COMMENT ON TABLE BARS.S6_S5_371148_DEPO IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_DEPO.BALS IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_DEPO.NLS IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_DEPO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_DEPO.OB22 IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_DEPO.KOTL_OLD IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_DEPO.KOTL IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_DEPO.BRANCH IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S5_371148_DEPO.sql =========*** End
PROMPT ===================================================================================== 
