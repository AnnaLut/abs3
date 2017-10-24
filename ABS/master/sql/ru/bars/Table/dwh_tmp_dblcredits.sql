

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_TMP_DBLCREDITS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_TMP_DBLCREDITS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_TMP_DBLCREDITS'', ''FILIAL'' , ''M'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DWH_TMP_DBLCREDITS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_TMP_DBLCREDITS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_TMP_DBLCREDITS 
   (	G00 DATE, 
	GT NUMBER, 
	GR VARCHAR2(1), 
	G59 NUMBER, 
	MAXACC NUMBER, 
	MAXOST NUMBER, 
	G19 VARCHAR2(4), 
	CNT NUMBER, 
	NBS VARCHAR2(4), 
	G21 NUMBER, 
	ACC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_TMP_DBLCREDITS ***
 exec bpa.alter_policies('DWH_TMP_DBLCREDITS');


COMMENT ON TABLE BARS.DWH_TMP_DBLCREDITS IS '������� ��� ���������� �������� �������� �� ������� ���� � ������� 2202 � 2233��� 2203';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.G00 IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.GT IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.GR IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.G59 IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.MAXACC IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.MAXOST IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.G19 IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.CNT IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.NBS IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.G21 IS '';
COMMENT ON COLUMN BARS.DWH_TMP_DBLCREDITS.ACC IS '';




PROMPT *** Create  constraint SYS_C001995214 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_TMP_DBLCREDITS MODIFY (GR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001995213 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_TMP_DBLCREDITS MODIFY (GT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C001995212 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_TMP_DBLCREDITS MODIFY (G00 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_TMP_DBLCREDITS ***
grant SELECT                                                                 on DWH_TMP_DBLCREDITS to BARSDWH_ACCESS_USER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_TMP_DBLCREDITS.sql =========*** En
PROMPT ===================================================================================== 
