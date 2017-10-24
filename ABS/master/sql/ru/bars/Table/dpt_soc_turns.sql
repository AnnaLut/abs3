

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SOC_TURNS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SOC_TURNS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SOC_TURNS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SOC_TURNS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SOC_TURNS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SOC_TURNS 
   (	ACC NUMBER, 
	DATE1 DATE, 
	DATE2 DATE, 
	OST_REAL NUMBER, 
	DOS_REAL NUMBER, 
	KOS_REAL NUMBER, 
	DOS_SOCIAL NUMBER, 
	KOS_SOCIAL NUMBER, 
	OST_SOCIAL NUMBER, 
	REFS VARCHAR2(40), 
	OST_FOR_TAX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SOC_TURNS ***
 exec bpa.alter_policies('DPT_SOC_TURNS');


COMMENT ON TABLE BARS.DPT_SOC_TURNS IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.ACC IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.DATE1 IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.DATE2 IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.OST_REAL IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.DOS_REAL IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.KOS_REAL IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.DOS_SOCIAL IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.KOS_SOCIAL IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.OST_SOCIAL IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.REFS IS '';
COMMENT ON COLUMN BARS.DPT_SOC_TURNS.OST_FOR_TAX IS '';




PROMPT *** Create  index PK_DPT_SOC_TURNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPT_SOC_TURNS ON BARS.DPT_SOC_TURNS (ACC, DATE1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SOC_TURNS.sql =========*** End ***
PROMPT ===================================================================================== 
