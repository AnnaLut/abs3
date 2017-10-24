

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_NEINF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_NEINF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_NEINF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_NEINF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_NEINF ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_NEINF 
   (	NAME VARCHAR2(22), 
	ID NUMBER(*,0), 
	COMM3 VARCHAR2(200), 
	COMM1 VARCHAR2(200), 
	COMM2 VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_NEINF ***
 exec bpa.alter_policies('CCK_NEINF');


COMMENT ON TABLE BARS.CCK_NEINF IS 'ОБ:Негативна iнформацiя';
COMMENT ON COLUMN BARS.CCK_NEINF.NAME IS 'Назва';
COMMENT ON COLUMN BARS.CCK_NEINF.ID IS 'Код';
COMMENT ON COLUMN BARS.CCK_NEINF.COMM3 IS 'Коментар-3=ФО';
COMMENT ON COLUMN BARS.CCK_NEINF.COMM1 IS 'Коментар-1=Банки';
COMMENT ON COLUMN BARS.CCK_NEINF.COMM2 IS 'Коментар-2=ЮО';




PROMPT *** Create  constraint PK_CCKNEINF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NEINF ADD CONSTRAINT PK_CCKNEINF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKNEINF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKNEINF ON BARS.CCK_NEINF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_NEINF ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_NEINF       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_NEINF       to START1;
grant FLASHBACK,SELECT                                                       on CCK_NEINF       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_NEINF.sql =========*** End *** ===
PROMPT ===================================================================================== 
