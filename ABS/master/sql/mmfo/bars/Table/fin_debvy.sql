

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_DEBVY.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_DEBVY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_DEBVY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_DEBVY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_DEBVY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_DEBVY ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_DEBVY 
   (	FIN NUMBER(*,0), 
	PROD VARCHAR2(6), 
	KV NUMBER(*,0), 
	NLS VARCHAR2(15), 
	ACC NUMBER, 
	OST NUMBER, 
	ND NUMBER, 
	SERR VARCHAR2(50), 
	NMS VARCHAR2(40), 
	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_DEBVY ***
 exec bpa.alter_policies('FIN_DEBVY');


COMMENT ON TABLE BARS.FIN_DEBVY IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.FIN IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.PROD IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.KV IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.NLS IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.ACC IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.OST IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.ND IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.SERR IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.NMS IS '';
COMMENT ON COLUMN BARS.FIN_DEBVY.RNK IS '';



PROMPT *** Create  grants  FIN_DEBVY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_DEBVY       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEBVY       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_DEBVY       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_DEBVY.sql =========*** End *** ===
PROMPT ===================================================================================== 
