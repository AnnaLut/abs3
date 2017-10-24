

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_C5_PROC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_C5_PROC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_C5_PROC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTC_C5_PROC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_C5_PROC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_C5_PROC 
   (	DATF DATE, 
	RNK NUMBER, 
	ND NUMBER, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	KODP VARCHAR2(35), 
	ZNAP NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_C5_PROC ***
 exec bpa.alter_policies('OTC_C5_PROC');


COMMENT ON TABLE BARS.OTC_C5_PROC IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.DATF IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.RNK IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.ND IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.ACC IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.NLS IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.KV IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.KODP IS '';
COMMENT ON COLUMN BARS.OTC_C5_PROC.ZNAP IS '';




PROMPT *** Create  index I1_OTC_C5_PROC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTC_C5_PROC ON BARS.OTC_C5_PROC (DATF, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTC_C5_PROC ***
grant SELECT                                                                 on OTC_C5_PROC     to START1;



PROMPT *** Create SYNONYM  to OTC_C5_PROC ***

  CREATE OR REPLACE PUBLIC SYNONYM OTC_C5_PROC FOR BARS.OTC_C5_PROC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_C5_PROC.sql =========*** End *** =
PROMPT ===================================================================================== 
