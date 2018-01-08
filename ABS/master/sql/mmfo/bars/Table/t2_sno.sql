

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T2_SNO.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T2_SNO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T2_SNO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T2_SNO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T2_SNO ***
begin 
  execute immediate '
  CREATE TABLE BARS.T2_SNO 
   (	ACC NUMBER, 
	OTM NUMBER, 
	SPN NUMBER, 
	ND NUMBER, 
	KV NUMBER, 
	NLS VARCHAR2(15), 
	ID NUMBER, 
	DAT DATE, 
	S NUMBER, 
	OSTF NUMBER, 
	SA NUMBER, 
	FDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T2_SNO ***
 exec bpa.alter_policies('T2_SNO');


COMMENT ON TABLE BARS.T2_SNO IS '"Временная" табл для хранения проекта ГПП';
COMMENT ON COLUMN BARS.T2_SNO.ACC IS '';
COMMENT ON COLUMN BARS.T2_SNO.OTM IS '';
COMMENT ON COLUMN BARS.T2_SNO.SPN IS '';
COMMENT ON COLUMN BARS.T2_SNO.ND IS '';
COMMENT ON COLUMN BARS.T2_SNO.KV IS '';
COMMENT ON COLUMN BARS.T2_SNO.NLS IS '';
COMMENT ON COLUMN BARS.T2_SNO.ID IS '';
COMMENT ON COLUMN BARS.T2_SNO.DAT IS '';
COMMENT ON COLUMN BARS.T2_SNO.S IS '';
COMMENT ON COLUMN BARS.T2_SNO.OSTF IS '';
COMMENT ON COLUMN BARS.T2_SNO.SA IS '';
COMMENT ON COLUMN BARS.T2_SNO.FDAT IS '';



PROMPT *** Create  grants  T2_SNO ***
grant INSERT,SELECT,UPDATE                                                   on T2_SNO          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T2_SNO.sql =========*** End *** ======
PROMPT ===================================================================================== 
