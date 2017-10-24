

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_P__SALDO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_P__SALDO ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_P__SALDO ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_P__SALDO 
   (	NLS VARCHAR2(25), 
	GROUP_U NUMBER(11,0), 
	I_VA NUMBER(11,0), 
	F_30 VARCHAR2(4), 
	MFO NUMBER(11,0), 
	OB22 VARCHAR2(2), 
	OB88 VARCHAR2(4), 
	P080 VARCHAR2(4), 
	R011 VARCHAR2(1), 
	R013 VARCHAR2(1), 
	R014 VARCHAR2(1), 
	R020_FA VARCHAR2(4), 
	S085 VARCHAR2(1), 
	S240 VARCHAR2(1), 
	TRKK VARCHAR2(2), 
	N_PROD VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_P__SALDO ***
 exec bpa.alter_policies('S6_S6_P__SALDO');


COMMENT ON TABLE BARS.S6_S6_P__SALDO IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.F_30 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.MFO IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.OB22 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.OB88 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.P080 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.R011 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.R013 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.R014 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.R020_FA IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.S085 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.S240 IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.TRKK IS '';
COMMENT ON COLUMN BARS.S6_S6_P__SALDO.N_PROD IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_P__SALDO.sql =========*** End **
PROMPT ===================================================================================== 
