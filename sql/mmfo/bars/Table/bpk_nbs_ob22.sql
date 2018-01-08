

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_NBS_OB22.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_NBS_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_NBS_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_NBS_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_NBS_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_NBS_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_NBS_OB22 
   (	TIP CHAR(3), 
	NBS CHAR(4), 
	OB22 CHAR(2), 
	OB_9129 CHAR(2), 
	OB_2202 CHAR(2), 
	OB_2207 CHAR(2), 
	OB_2208 CHAR(2), 
	OB_2209 CHAR(2), 
	OB_3570 CHAR(2), 
	OB_3579 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_NBS_OB22 ***
 exec bpa.alter_policies('BPK_NBS_OB22');


COMMENT ON TABLE BARS.BPK_NBS_OB22 IS 'Довiдник ОБ22 в портфелi БПК';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.TIP IS 'Тип рахунку';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.NBS IS 'Осн.Бал.рах.(2625)';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB22 IS 'Об22 до Осн.Бал.рах.';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB_9129 IS 'Об22 до 9129';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB_2202 IS 'Об22 до 2202';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB_2207 IS 'Об22 до 2207';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB_2208 IS 'Об22 до 2208';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB_2209 IS 'Об22 до 2209';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB_3570 IS 'Об22 до 3570';
COMMENT ON COLUMN BARS.BPK_NBS_OB22.OB_3579 IS 'Об22 до 3579';




PROMPT *** Create  constraint FK_BPKNBSOB22_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS_OB22 ADD CONSTRAINT FK_BPKNBSOB22_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPKNBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS_OB22 ADD CONSTRAINT PK_BPKNBSOB22 PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKNBSOB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKNBSOB22 ON BARS.BPK_NBS_OB22 (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_NBS_OB22 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BPK_NBS_OB22    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_NBS_OB22    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BPK_NBS_OB22    to OBPC;
grant FLASHBACK,SELECT                                                       on BPK_NBS_OB22    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_NBS_OB22.sql =========*** End *** 
PROMPT ===================================================================================== 
