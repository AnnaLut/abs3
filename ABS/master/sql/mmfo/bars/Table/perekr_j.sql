

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_J.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_J ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_J'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PEREKR_J'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PEREKR_J'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_J ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_J 
   (	ACC NUMBER(38,0), 
	ACCS NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	 CONSTRAINT PK_PEREKRJ PRIMARY KEY (ACC) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_J ***
 exec bpa.alter_policies('PEREKR_J');


COMMENT ON TABLE BARS.PEREKR_J IS 'Перекрытия. Соответствия счетов перекрытия.';
COMMENT ON COLUMN BARS.PEREKR_J.ACC IS 'Идентификатор пассивного счета';
COMMENT ON COLUMN BARS.PEREKR_J.ACCS IS 'Идентификатор активного счета';
COMMENT ON COLUMN BARS.PEREKR_J.KF IS '';




PROMPT *** Create  constraint CC_PEREKRJ_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_J MODIFY (ACC CONSTRAINT CC_PEREKRJ_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRJ_ACCS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_J MODIFY (ACCS CONSTRAINT CC_PEREKRJ_ACCS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRJ_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_J MODIFY (KF CONSTRAINT CC_PEREKRJ_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PEREKRJ ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_J ADD CONSTRAINT PK_PEREKRJ PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKRJ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKRJ ON BARS.PEREKR_J (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_J ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_J        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_J        to BARS015;
grant SELECT                                                                 on PEREKR_J        to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_J        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKR_J        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_J        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_J.sql =========*** End *** ====
PROMPT ===================================================================================== 
