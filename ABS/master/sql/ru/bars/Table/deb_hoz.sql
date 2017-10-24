

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_HOZ.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_HOZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_HOZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEB_HOZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_HOZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEB_HOZ 
   (	NBS VARCHAR2(4), 
	KV NUMBER(3,0), 
	KAT NUMBER(*,0), 
	BV NUMBER, 
	BVQ NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	REZF NUMBER, 
	REZQF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_HOZ ***
 exec bpa.alter_policies('DEB_HOZ');


COMMENT ON TABLE BARS.DEB_HOZ IS 'Господарська дебіторка - итог';
COMMENT ON COLUMN BARS.DEB_HOZ.NBS IS 'Бал.рах.';
COMMENT ON COLUMN BARS.DEB_HOZ.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.DEB_HOZ.KAT IS 'Кат. якості';
COMMENT ON COLUMN BARS.DEB_HOZ.BV IS 'Балансова вартість ном.';
COMMENT ON COLUMN BARS.DEB_HOZ.BVQ IS 'Балансова вартість екв.';
COMMENT ON COLUMN BARS.DEB_HOZ.REZ IS 'Резерв в ном.';
COMMENT ON COLUMN BARS.DEB_HOZ.REZQ IS 'Резерв в екв.';
COMMENT ON COLUMN BARS.DEB_HOZ.REZF IS '';
COMMENT ON COLUMN BARS.DEB_HOZ.REZQF IS '';




PROMPT *** Create  constraint PK_DEB_HOZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_HOZ ADD CONSTRAINT PK_DEB_HOZ PRIMARY KEY (NBS, KV, KAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEB_HOZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEB_HOZ ON BARS.DEB_HOZ (NBS, KV, KAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEB_HOZ ***
grant SELECT                                                                 on DEB_HOZ         to RCC_DEAL;
grant SELECT                                                                 on DEB_HOZ         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_HOZ.sql =========*** End *** =====
PROMPT ===================================================================================== 
