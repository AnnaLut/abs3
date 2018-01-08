

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_NBS_GRP_LST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_NBS_GRP_LST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_NBS_GRP_LST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VIP_NBS_GRP_LST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_NBS_GRP_LST ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_NBS_GRP_LST 
   (	R020 CHAR(4), 
	GRP_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_NBS_GRP_LST ***
 exec bpa.alter_policies('VIP_NBS_GRP_LST');


COMMENT ON TABLE BARS.VIP_NBS_GRP_LST IS 'Довідник груп рахунків з обмеженим доступом';
COMMENT ON COLUMN BARS.VIP_NBS_GRP_LST.R020 IS 'Номер балансового рахунка';
COMMENT ON COLUMN BARS.VIP_NBS_GRP_LST.GRP_ID IS 'Ід. групи рахунків';




PROMPT *** Create  constraint CC_VIPNBSGRPLST_R020_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_NBS_GRP_LST MODIFY (R020 CONSTRAINT CC_VIPNBSGRPLST_R020_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VIPNBSGRPLST_GRPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_NBS_GRP_LST MODIFY (GRP_ID CONSTRAINT CC_VIPNBSGRPLST_GRPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VIPNBSGRPLST_GROUPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_NBS_GRP_LST ADD CONSTRAINT FK_VIPNBSGRPLST_GROUPSACC FOREIGN KEY (GRP_ID)
	  REFERENCES BARS.GROUPS_ACC (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_VIPNBSGRPLST_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_NBS_GRP_LST ADD CONSTRAINT FK_VIPNBSGRPLST_PS FOREIGN KEY (R020)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_VIPNBSGRPLST ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_NBS_GRP_LST ADD CONSTRAINT PK_VIPNBSGRPLST PRIMARY KEY (R020, GRP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VIPNBSGRPLST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VIPNBSGRPLST ON BARS.VIP_NBS_GRP_LST (R020, GRP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_NBS_GRP_LST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_NBS_GRP_LST to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VIP_NBS_GRP_LST to START1;
grant FLASHBACK,SELECT                                                       on VIP_NBS_GRP_LST to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_NBS_GRP_LST.sql =========*** End *
PROMPT ===================================================================================== 
