

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_P086.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_P086 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SB_P086'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P086'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SB_P086'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_P086 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_P086 
   (	R020 VARCHAR2(4), 
	P080 VARCHAR2(4), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_P086 ***
 exec bpa.alter_policies('SB_P086');


COMMENT ON TABLE BARS.SB_P086 IS '';
COMMENT ON COLUMN BARS.SB_P086.R020 IS '';
COMMENT ON COLUMN BARS.SB_P086.P080 IS '';
COMMENT ON COLUMN BARS.SB_P086.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_P086.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_P086.COD_ACT IS '';



PROMPT *** Create  grants  SB_P086 ***
grant SELECT                                                                 on SB_P086         to BARSREADER_ROLE;
grant SELECT                                                                 on SB_P086         to BARS_DM;
grant SELECT                                                                 on SB_P086         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_P086.sql =========*** End *** =====
PROMPT ===================================================================================== 
