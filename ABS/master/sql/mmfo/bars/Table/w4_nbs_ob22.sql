

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_NBS_OB22.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_NBS_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_NBS_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_NBS_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''W4_NBS_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_NBS_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_NBS_OB22 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	OB_9129 CHAR(2), 
	OB_OVR CHAR(2), 
	OB_2207 CHAR(2), 
	OB_2208 CHAR(2), 
	OB_2209 CHAR(2), 
	OB_3570 CHAR(2), 
	OB_3579 CHAR(2), 
	TIP CHAR(3), 
	OB_2627 CHAR(2), 
	OB_2625X CHAR(2), 
	OB_2627X CHAR(2), 
	OB_2625D CHAR(2), 
	OB_2628 CHAR(2), 
	OB_6110 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
PROMPT *** Add  columns for Instolment ***
begin 
execute immediate'
alter table w4_nbs_ob22 add (
  OB_2203I     CHAR(2 BYTE),
  OB_2203OVDI  CHAR(2 BYTE),
  OB_2208I     CHAR(2 BYTE),
  OB_2208OVDI  CHAR(2 BYTE),
  OB_3570I     CHAR(2 BYTE),  
  OB_3570OVDI  CHAR(2 BYTE),
  OB_9129I     CHAR(2 BYTE))';
exception
 when others 
 then 
 if sqlcode = -1430 then null; 
 else raise;
 end if;
end;
/



PROMPT *** ALTER_POLICIES to W4_NBS_OB22 ***
 exec bpa.alter_policies('W4_NBS_OB22');


COMMENT ON TABLE BARS.W4_NBS_OB22 IS 'W4. Довiдник ОБ22 в портфелi БПК';
COMMENT ON COLUMN BARS.W4_NBS_OB22.NBS IS 'Осн.Бал.рах.(2625)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB22 IS 'Об22 до Осн.Бал.рах.';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_9129 IS 'Об22 до 9129';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_OVR IS 'Об22 до 2202';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2207 IS 'Об22 до 2207';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2208 IS 'Об22 до 2208';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2209 IS 'Об22 до 2209';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_3570 IS 'Об22 до 3570';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_3579 IS 'Об22 до 3579';
COMMENT ON COLUMN BARS.W4_NBS_OB22.TIP IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2627 IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2625X IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2627X IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2625D IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2628 IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_6110 IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2203I IS 'Короткострокові кредити на поточні потреби, що надані фізичним особам(Інстолмент)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2203OVDI IS 'Прострочена заборгованість за кредитами на поточні потреби, що надані фізичним особам(Інстолмент)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2208I IS 'Нараховані доходи за кредитами на поточні потреби, що надані фізичним особам(Інстолмент)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2208OVDI IS 'Прострочені нараховані доходи за кредитами на поточні потреби, що надані фізичним особам(Інстолмент)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_3570OVDI IS 'Прострочені інші нараховані доходи(Інстолмент)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_3570I IS 'Інші нараховані доходи(Інстолмент)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_9129I IS 'Iнші зобов''язання з кредитування, що надані кліїнтам(Інстолмент)';



PROMPT *** Create  constraint CC_W4NBSOB22_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 MODIFY (NBS CONSTRAINT CC_W4NBSOB22_NBS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4NBSOB22_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 MODIFY (OB22 CONSTRAINT CC_W4NBSOB22_OB22_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4NBSOB22_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 MODIFY (TIP CONSTRAINT CC_W4NBSOB22_TIP_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4NBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 ADD CONSTRAINT PK_W4NBSOB22 PRIMARY KEY (NBS, OB22, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4NBSOB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4NBSOB22 ON BARS.W4_NBS_OB22 (NBS, OB22, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_NBS_OB22 ***
grant SELECT                                                                 on W4_NBS_OB22     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_NBS_OB22     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_NBS_OB22     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_NBS_OB22     to OW;
grant SELECT                                                                 on W4_NBS_OB22     to UPLD;
grant FLASHBACK,SELECT                                                       on W4_NBS_OB22     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_NBS_OB22.sql =========*** End *** =
PROMPT ===================================================================================== 
