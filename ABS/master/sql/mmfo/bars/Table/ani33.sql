

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI33.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI33 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI33'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI33'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI33'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI33 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI33 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(38), 
	S NUMBER, 
	R NUMBER, 
	TYPE NUMBER(1,0), 
	ORD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI33 ***
 exec bpa.alter_policies('ANI33');


COMMENT ON TABLE BARS.ANI33 IS 'Группы отчета "Динаміка основних показників ліквідності"';
COMMENT ON COLUMN BARS.ANI33.ID IS 'Код Группы ';
COMMENT ON COLUMN BARS.ANI33.NAME IS 'Наимен.Группы ';
COMMENT ON COLUMN BARS.ANI33.S IS 'Суммы ';
COMMENT ON COLUMN BARS.ANI33.R IS 'Сред % ст. ';
COMMENT ON COLUMN BARS.ANI33.TYPE IS 'Залучено/Розміщено';
COMMENT ON COLUMN BARS.ANI33.ORD IS 'Порядок сортування';




PROMPT *** Create  constraint PK_ANI33 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI33 ADD CONSTRAINT PK_ANI33 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ANI33 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ANI33 ON BARS.ANI33 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANI33 ***
grant SELECT                                                                 on ANI33           to BARSREADER_ROLE;
grant SELECT                                                                 on ANI33           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI33           to BARS_DM;
grant SELECT                                                                 on ANI33           to START1;
grant SELECT                                                                 on ANI33           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI33.sql =========*** End *** =======
PROMPT ===================================================================================== 
