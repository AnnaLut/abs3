

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NBS_2401.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NBS_2401 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NBS_2401 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NBS_2401 
   (	NBS VARCHAR2(4), 
	OB22 VARCHAR2(4), 
	GRP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NBS_2401 ***
 exec bpa.alter_policies('TMP_NBS_2401');


COMMENT ON TABLE BARS.TMP_NBS_2401 IS 'Продукти кредитів портфельного методу';
COMMENT ON COLUMN BARS.TMP_NBS_2401.NBS IS 'Бал.рахунок';
COMMENT ON COLUMN BARS.TMP_NBS_2401.OB22 IS 'ОБ22';
COMMENT ON COLUMN BARS.TMP_NBS_2401.GRP IS 'Ном.групи';




PROMPT *** Create  constraint PK_TMP_NBS_2401 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBS_2401 ADD CONSTRAINT PK_TMP_NBS_2401 PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_NBS_2401 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_NBS_2401 ON BARS.TMP_NBS_2401 (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_NBS_2401 ***
grant SELECT                                                                 on TMP_NBS_2401    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_NBS_2401    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBS_2401    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NBS_2401    to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NBS_2401    to START1;
grant SELECT                                                                 on TMP_NBS_2401    to UPLD;
grant FLASHBACK,SELECT                                                       on TMP_NBS_2401    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NBS_2401.sql =========*** End *** 
PROMPT ===================================================================================== 
