

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_3570.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_3570 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_3570'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_3570'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RKO_3570'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_3570 ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_3570 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ACC NUMBER, 
	 CONSTRAINT PK_RKO3570 PRIMARY KEY (KF, ACC) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_3570 ***
 exec bpa.alter_policies('RKO_3570');


COMMENT ON TABLE BARS.RKO_3570 IS 'Рахунки, по яких плата за РО тiльки нарах.на 3570';
COMMENT ON COLUMN BARS.RKO_3570.KF IS 'Код філії';
COMMENT ON COLUMN BARS.RKO_3570.ACC IS 'ACC рахунку';




PROMPT *** Create  constraint CC_RKO3570_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_3570 MODIFY (KF CONSTRAINT CC_RKO3570_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKO3570_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_3570 MODIFY (ACC CONSTRAINT CC_RKO3570_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_RKO3570 ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_3570 ADD CONSTRAINT PK_RKO3570 PRIMARY KEY (KF, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKO3570 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKO3570 ON BARS.RKO_3570 (KF, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_3570 ***
grant SELECT                                                                 on RKO_3570        to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on RKO_3570        to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on RKO_3570        to RKO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_3570.sql =========*** End *** ====
PROMPT ===================================================================================== 
