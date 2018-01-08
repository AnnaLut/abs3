

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GROUPS_STAFF_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GROUPS_STAFF_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GROUPS_STAFF_ACC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GROUPS_STAFF_ACC'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''GROUPS_STAFF_ACC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GROUPS_STAFF_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.GROUPS_STAFF_ACC 
   (	IDA NUMBER(38,0), 
	IDG NUMBER(38,0), 
	 CONSTRAINT PK_GROUPSSTAFFACC PRIMARY KEY (IDA, IDG) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GROUPS_STAFF_ACC ***
 exec bpa.alter_policies('GROUPS_STAFF_ACC');


COMMENT ON TABLE BARS.GROUPS_STAFF_ACC IS 'Связь групп счетов и групп пользователей';
COMMENT ON COLUMN BARS.GROUPS_STAFF_ACC.IDA IS 'Идентификатор группы счетов';
COMMENT ON COLUMN BARS.GROUPS_STAFF_ACC.IDG IS 'Идентификатор группы пользователей';




PROMPT *** Create  constraint FK_GROUPSSTAFFACC_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF_ACC ADD CONSTRAINT FK_GROUPSSTAFFACC_GROUPS FOREIGN KEY (IDG)
	  REFERENCES BARS.GROUPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFFACC_IDA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF_ACC MODIFY (IDA CONSTRAINT CC_GROUPSSTAFFACC_IDA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFFACC_IDG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF_ACC MODIFY (IDG CONSTRAINT CC_GROUPSSTAFFACC_IDG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_GROUPSSTAFFACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF_ACC ADD CONSTRAINT PK_GROUPSSTAFFACC PRIMARY KEY (IDA, IDG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GROUPSSTAFFACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GROUPSSTAFFACC ON BARS.GROUPS_STAFF_ACC (IDA, IDG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GROUPS_STAFF_ACC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPS_STAFF_ACC to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_STAFF_ACC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GROUPS_STAFF_ACC to BARS_DM;
grant SELECT                                                                 on GROUPS_STAFF_ACC to KLBX;
grant SELECT                                                                 on GROUPS_STAFF_ACC to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_STAFF_ACC to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on GROUPS_STAFF_ACC to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GROUPS_STAFF_ACC.sql =========*** End 
PROMPT ===================================================================================== 
