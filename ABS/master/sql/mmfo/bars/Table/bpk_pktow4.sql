

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_PKTOW4.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_PKTOW4 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_PKTOW4'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_PKTOW4'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_PKTOW4'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_PKTOW4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_PKTOW4 
   (	ID NUMBER(22,0), 
	ND NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_PKTOW4 ***
 exec bpa.alter_policies('BPK_PKTOW4');


COMMENT ON TABLE BARS.BPK_PKTOW4 IS '';
COMMENT ON COLUMN BARS.BPK_PKTOW4.ID IS '';
COMMENT ON COLUMN BARS.BPK_PKTOW4.ND IS '';




PROMPT *** Create  constraint PK_BPKPKTOW4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_PKTOW4 ADD CONSTRAINT PK_BPKPKTOW4 PRIMARY KEY (ID, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKPKTOW4 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKPKTOW4 ON BARS.BPK_PKTOW4 (ID, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_PKTOW4 ***
grant DELETE,INSERT,SELECT                                                   on BPK_PKTOW4      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_PKTOW4      to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_PKTOW4.sql =========*** End *** ==
PROMPT ===================================================================================== 
