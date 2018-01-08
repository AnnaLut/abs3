

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZERV.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZERV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZERV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZERV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZERV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZERV ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZERV 
   (	ID NUMBER(38,0), 
	NBS CHAR(4), 
	PAP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZERV ***
 exec bpa.alter_policies('REZERV');


COMMENT ON TABLE BARS.REZERV IS '';
COMMENT ON COLUMN BARS.REZERV.ID IS 'Код групи';
COMMENT ON COLUMN BARS.REZERV.NBS IS 'Бал рах';
COMMENT ON COLUMN BARS.REZERV.PAP IS 'АП';




PROMPT *** Create  constraint XPK_REZERV ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZERV ADD CONSTRAINT XPK_REZERV PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_REZERV_REZ0 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZERV ADD CONSTRAINT R_REZERV_REZ0 FOREIGN KEY (ID)
	  REFERENCES BARS.REZ0 (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_REZERV_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZERV ADD CONSTRAINT R_REZERV_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_REZERV_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZERV MODIFY (NBS CONSTRAINT NK_REZERV_NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REZERV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REZERV ON BARS.REZERV (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZERV ***
grant SELECT                                                                 on REZERV          to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZERV          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZERV.sql =========*** End *** ======
PROMPT ===================================================================================== 
