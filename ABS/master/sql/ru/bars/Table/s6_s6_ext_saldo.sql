

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_EXT_SALDO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_EXT_SALDO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_EXT_SALDO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_EXT_SALDO 
   (	BIC NUMBER(11,0), 
	I_VA NUMBER(11,0), 
	NLS VARCHAR2(25), 
	ID VARCHAR2(14), 
	NK VARCHAR2(80), 
	NP VARCHAR2(160), 
	DA DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_EXT_SALDO ***
 exec bpa.alter_policies('S6_S6_EXT_SALDO');


COMMENT ON TABLE BARS.S6_S6_EXT_SALDO IS '';
COMMENT ON COLUMN BARS.S6_S6_EXT_SALDO.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_EXT_SALDO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_EXT_SALDO.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_EXT_SALDO.ID IS '';
COMMENT ON COLUMN BARS.S6_S6_EXT_SALDO.NK IS '';
COMMENT ON COLUMN BARS.S6_S6_EXT_SALDO.NP IS '';
COMMENT ON COLUMN BARS.S6_S6_EXT_SALDO.DA IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_EXT_SALDO.sql =========*** End *
PROMPT ===================================================================================== 
