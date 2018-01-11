

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_DET_AGR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_DET_AGR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_DET_AGR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_DET_AGR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_DET_AGR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_DET_AGR ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_DET_AGR 
   (	IDD NUMBER, 
	AGR_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_DET_AGR ***
 exec bpa.alter_policies('STO_DET_AGR');


COMMENT ON TABLE BARS.STO_DET_AGR IS '';
COMMENT ON COLUMN BARS.STO_DET_AGR.IDD IS '';
COMMENT ON COLUMN BARS.STO_DET_AGR.AGR_ID IS '';



PROMPT *** Create  grants  STO_DET_AGR ***
grant SELECT                                                                 on STO_DET_AGR     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DET_AGR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_DET_AGR     to BARS_DM;
grant SELECT                                                                 on STO_DET_AGR     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_DET_AGR.sql =========*** End *** =
PROMPT ===================================================================================== 
