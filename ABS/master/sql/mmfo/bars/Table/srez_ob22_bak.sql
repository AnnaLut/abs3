

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZ_OB22_BAK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZ_OB22_BAK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZ_OB22_BAK'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''SREZ_OB22_BAK'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''SREZ_OB22_BAK'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZ_OB22_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZ_OB22_BAK 
   (	NBS CHAR(4), 
	OB22 VARCHAR2(2), 
	S080 VARCHAR2(1), 
	CUSTTYPE VARCHAR2(2), 
	KV VARCHAR2(3), 
	NBS_REZ CHAR(4), 
	OB22_REZ VARCHAR2(2), 
	NBS_7F CHAR(4), 
	OB22_7F VARCHAR2(2), 
	NBS_7R CHAR(4), 
	OB22_7R VARCHAR2(2), 
	PR NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZ_OB22_BAK ***
 exec bpa.alter_policies('SREZ_OB22_BAK');


COMMENT ON TABLE BARS.SREZ_OB22_BAK IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.NBS IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.OB22 IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.S080 IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.KV IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.NBS_REZ IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.OB22_REZ IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.NBS_7F IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.OB22_7F IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.NBS_7R IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.OB22_7R IS '';
COMMENT ON COLUMN BARS.SREZ_OB22_BAK.PR IS '';



PROMPT *** Create  grants  SREZ_OB22_BAK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZ_OB22_BAK   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZ_OB22_BAK   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZ_OB22_BAK   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZ_OB22_BAK.sql =========*** End ***
PROMPT ===================================================================================== 
