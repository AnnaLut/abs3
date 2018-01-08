

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_REC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_REC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_REC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_REC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_REC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_REC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_REC 
   (	TK NUMBER, 
	REC NUMBER, 
	S NUMBER, 
	DK NUMBER(*,0), 
	DAT_A DATE, 
	MFOA VARCHAR2(12), 
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




PROMPT *** ALTER_POLICIES to CIN_REC ***
 exec bpa.alter_policies('CIN_REC');


COMMENT ON TABLE BARS.CIN_REC IS '';
COMMENT ON COLUMN BARS.CIN_REC.TK IS '';
COMMENT ON COLUMN BARS.CIN_REC.REC IS '';
COMMENT ON COLUMN BARS.CIN_REC.S IS '';
COMMENT ON COLUMN BARS.CIN_REC.DK IS '';
COMMENT ON COLUMN BARS.CIN_REC.DAT_A IS '';
COMMENT ON COLUMN BARS.CIN_REC.MFOA IS '';
COMMENT ON COLUMN BARS.CIN_REC.NLSA IS '';
COMMENT ON COLUMN BARS.CIN_REC.MFOB IS '';
COMMENT ON COLUMN BARS.CIN_REC.NLSB IS '';



PROMPT *** Create  grants  CIN_REC ***
grant SELECT                                                                 on CIN_REC         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_REC.sql =========*** End *** =====
PROMPT ===================================================================================== 
