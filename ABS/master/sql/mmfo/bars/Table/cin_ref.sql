

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_REF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_REF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_REF 
   (	TK NUMBER, 
	REF NUMBER, 
	S NUMBER, 
	VDAT DATE, 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_REF ***
 exec bpa.alter_policies('CIN_REF');


COMMENT ON TABLE BARS.CIN_REF IS '';
COMMENT ON COLUMN BARS.CIN_REF.TK IS '';
COMMENT ON COLUMN BARS.CIN_REF.REF IS '';
COMMENT ON COLUMN BARS.CIN_REF.S IS '';
COMMENT ON COLUMN BARS.CIN_REF.VDAT IS '';
COMMENT ON COLUMN BARS.CIN_REF.NLSA IS '';
COMMENT ON COLUMN BARS.CIN_REF.MFOB IS '';
COMMENT ON COLUMN BARS.CIN_REF.NLSB IS '';



PROMPT *** Create  grants  CIN_REF ***
grant SELECT                                                                 on CIN_REF         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_REF.sql =========*** End *** =====
PROMPT ===================================================================================== 
