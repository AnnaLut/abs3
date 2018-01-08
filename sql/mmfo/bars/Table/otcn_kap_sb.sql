

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_KAP_SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_KAP_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_KAP_SB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_KAP_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_KAP_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_KAP_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_KAP_SB 
   (	ACC NUMBER, 
	PR NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_KAP_SB ***
 exec bpa.alter_policies('OTCN_KAP_SB');


COMMENT ON TABLE BARS.OTCN_KAP_SB IS 'Процент субординированного долга для расчета регулят. капитала';
COMMENT ON COLUMN BARS.OTCN_KAP_SB.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_KAP_SB.PR IS '';
COMMENT ON COLUMN BARS.OTCN_KAP_SB.KF IS '';




PROMPT *** Create  constraint PK_OTCN_KAP_SB ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_KAP_SB ADD CONSTRAINT PK_OTCN_KAP_SB PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNKAPSB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_KAP_SB MODIFY (KF CONSTRAINT CC_OTCNKAPSB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007732 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_KAP_SB MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_KAP_SB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_KAP_SB ON BARS.OTCN_KAP_SB (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_KAP_SB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_KAP_SB     to ABS_ADMIN;
grant SELECT                                                                 on OTCN_KAP_SB     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_KAP_SB     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_KAP_SB     to BARS_DM;
grant SELECT                                                                 on OTCN_KAP_SB     to RPBN002;
grant SELECT                                                                 on OTCN_KAP_SB     to START1;
grant SELECT                                                                 on OTCN_KAP_SB     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_KAP_SB     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_KAP_SB.sql =========*** End *** =
PROMPT ===================================================================================== 
