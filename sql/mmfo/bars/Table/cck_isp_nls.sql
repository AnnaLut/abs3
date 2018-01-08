

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_ISP_NLS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_ISP_NLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_ISP_NLS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_ISP_NLS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CCK_ISP_NLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_ISP_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_ISP_NLS 
   (	ID NUMBER(38,0), 
	ISP NUMBER(38,0), 
	ORD NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_ISP_NLS ***
 exec bpa.alter_policies('CCK_ISP_NLS');


COMMENT ON TABLE BARS.CCK_ISP_NLS IS '';
COMMENT ON COLUMN BARS.CCK_ISP_NLS.ID IS 'Iнiцiатор проводок';
COMMENT ON COLUMN BARS.CCK_ISP_NLS.ISP IS 'Прiоритет вiдповiдального виконавця';
COMMENT ON COLUMN BARS.CCK_ISP_NLS.ORD IS '';
COMMENT ON COLUMN BARS.CCK_ISP_NLS.KF IS 'Код фiлiалу';
COMMENT ON COLUMN BARS.CCK_ISP_NLS.BRANCH IS 'Бранч обслуговування виконавцем';




PROMPT *** Create  constraint CCK_ISP_NLS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS ADD CONSTRAINT CCK_ISP_NLS_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_ISP_NLS_ISP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS ADD CONSTRAINT CCK_ISP_NLS_ISP FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_ISP_NLS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS ADD CONSTRAINT CCK_ISP_NLS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_ISP_NLS_ISP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS MODIFY (ISP CONSTRAINT CCK_ISP_NLS_ISP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_ISP_NLS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS MODIFY (KF CONSTRAINT CCK_ISP_NLS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_ISP_NLS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_ISP_NLS MODIFY (BRANCH CONSTRAINT CCK_ISP_NLS_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_ISP_NLS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_ISP_NLS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_ISP_NLS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_ISP_NLS     to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CCK_ISP_NLS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_ISP_NLS.sql =========*** End *** =
PROMPT ===================================================================================== 
