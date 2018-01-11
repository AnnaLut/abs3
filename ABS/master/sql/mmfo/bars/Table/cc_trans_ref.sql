

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_TRANS_REF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_TRANS_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_TRANS_REF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_TRANS_REF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_TRANS_REF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_TRANS_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_TRANS_REF 
   (	NPP NUMBER(*,0), 
	REF NUMBER(*,0), 
	S_REF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_TRANS_REF ***
 exec bpa.alter_policies('CC_TRANS_REF');


COMMENT ON TABLE BARS.CC_TRANS_REF IS '';
COMMENT ON COLUMN BARS.CC_TRANS_REF.NPP IS 'ID транша';
COMMENT ON COLUMN BARS.CC_TRANS_REF.REF IS 'Референс погашення';
COMMENT ON COLUMN BARS.CC_TRANS_REF.S_REF IS 'Сума погашення в даному референсі';
COMMENT ON COLUMN BARS.CC_TRANS_REF.KF IS '';




PROMPT *** Create  constraint PK_CCTRANSREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS_REF ADD CONSTRAINT PK_CCTRANSREF PRIMARY KEY (NPP, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCTRANSREF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_TRANS_REF MODIFY (KF CONSTRAINT CC_CCTRANSREF_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCTRANSREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCTRANSREF ON BARS.CC_TRANS_REF (NPP, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_TRANS_REF ***
grant SELECT                                                                 on CC_TRANS_REF    to BARSREADER_ROLE;
grant SELECT                                                                 on CC_TRANS_REF    to BARSUPL;
grant INSERT,SELECT                                                          on CC_TRANS_REF    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_TRANS_REF    to BARS_DM;
grant INSERT,SELECT                                                          on CC_TRANS_REF    to RCC_DEAL;
grant SELECT                                                                 on CC_TRANS_REF    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_TRANS_REF.sql =========*** End *** 
PROMPT ===================================================================================== 
