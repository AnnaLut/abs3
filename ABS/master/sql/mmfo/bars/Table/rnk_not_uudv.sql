

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RNK_NOT_UUDV.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RNK_NOT_UUDV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RNK_NOT_UUDV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RNK_NOT_UUDV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RNK_NOT_UUDV ***
begin 
  execute immediate '
  CREATE TABLE BARS.RNK_NOT_UUDV 
   (	RNK NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RNK_NOT_UUDV ***
 exec bpa.alter_policies('RNK_NOT_UUDV');


COMMENT ON TABLE BARS.RNK_NOT_UUDV IS 'РНК для яких не враховується % державної власності';
COMMENT ON COLUMN BARS.RNK_NOT_UUDV.RNK IS 'РНК';




PROMPT *** Create  constraint PK_RNK_NOT_UUDV ***
begin   
 execute immediate '
  ALTER TABLE BARS.RNK_NOT_UUDV ADD CONSTRAINT PK_RNK_NOT_UUDV PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RNK_NOT_UUDV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RNK_NOT_UUDV ON BARS.RNK_NOT_UUDV (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RNK_NOT_UUDV ***
grant SELECT                                                                 on RNK_NOT_UUDV    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK_NOT_UUDV    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK_NOT_UUDV    to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on RNK_NOT_UUDV    to START1;
grant SELECT                                                                 on RNK_NOT_UUDV    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RNK_NOT_UUDV.sql =========*** End *** 
PROMPT ===================================================================================== 
