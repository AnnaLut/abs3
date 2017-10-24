

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MOS_TAG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MOS_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MOS_TAG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MOS_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MOS_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.MOS_TAG 
   (	TAG VARCHAR2(8), 
	NAME VARCHAR2(80), 
	PRZ NUMBER(*,0), 
	CUSTTYPE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MOS_TAG ***
 exec bpa.alter_policies('MOS_TAG');


COMMENT ON TABLE BARS.MOS_TAG IS '';
COMMENT ON COLUMN BARS.MOS_TAG.TAG IS '';
COMMENT ON COLUMN BARS.MOS_TAG.NAME IS '';
COMMENT ON COLUMN BARS.MOS_TAG.PRZ IS '';
COMMENT ON COLUMN BARS.MOS_TAG.CUSTTYPE IS '2=ﬁÀ, 3=‘À, ËÌ‡˜Â=ﬁÀ+‘À';




PROMPT *** Create  constraint PK_MOS_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.MOS_TAG ADD CONSTRAINT PK_MOS_TAG PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MOS_TAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MOS_TAG ON BARS.MOS_TAG (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MOS_TAG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MOS_TAG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MOS_TAG         to CIG_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MOS_TAG.sql =========*** End *** =====
PROMPT ===================================================================================== 
