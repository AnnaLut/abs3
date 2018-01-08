

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MV_TRANS_LIMIT150.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MV_TRANS_LIMIT150 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MV_TRANS_LIMIT150'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MV_TRANS_LIMIT150'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MV_TRANS_LIMIT150'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MV_TRANS_LIMIT150 ***
begin 
  execute immediate '
  CREATE TABLE BARS.MV_TRANS_LIMIT150 
   (	DOC VARCHAR2(4000), 
	SQ_TOTAL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MV_TRANS_LIMIT150 ***
 exec bpa.alter_policies('MV_TRANS_LIMIT150');


COMMENT ON COLUMN BARS.MV_TRANS_LIMIT150.DOC IS '';
COMMENT ON COLUMN BARS.MV_TRANS_LIMIT150.SQ_TOTAL IS '';




PROMPT *** Create  index I_MVTRANSLIMIT150_DOC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_MVTRANSLIMIT150_DOC ON BARS.MV_TRANS_LIMIT150 (DOC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MV_TRANS_LIMIT150 ***
grant SELECT                                                                 on MV_TRANS_LIMIT150 to BARSREADER_ROLE;
grant SELECT                                                                 on MV_TRANS_LIMIT150 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MV_TRANS_LIMIT150.sql =========*** End
PROMPT ===================================================================================== 
