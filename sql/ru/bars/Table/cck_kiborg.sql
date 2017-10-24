

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_KIBORG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_KIBORG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_KIBORG'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_KIBORG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_KIBORG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_KIBORG 
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




PROMPT *** ALTER_POLICIES to CCK_KIBORG ***
 exec bpa.alter_policies('CCK_KIBORG');


COMMENT ON TABLE BARS.CCK_KIBORG IS 'ОБ:Забезпечення та коефіцієнт покриття боргу';
COMMENT ON COLUMN BARS.CCK_KIBORG.NAME IS 'Назва';
COMMENT ON COLUMN BARS.CCK_KIBORG.ID IS 'Код';
COMMENT ON COLUMN BARS.CCK_KIBORG.COMM3 IS 'Коментар-3=ФО';
COMMENT ON COLUMN BARS.CCK_KIBORG.COMM1 IS 'Коментар-1=Банки';
COMMENT ON COLUMN BARS.CCK_KIBORG.COMM2 IS 'Коментар-2=ЮО';




PROMPT *** Create  constraint PK_CCKKIBORG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_KIBORG ADD CONSTRAINT PK_CCKKIBORG PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKKIBORG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKKIBORG ON BARS.CCK_KIBORG (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_KIBORG ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_KIBORG      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_KIBORG      to START1;
grant FLASHBACK,SELECT                                                       on CCK_KIBORG      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_KIBORG.sql =========*** End *** ==
PROMPT ===================================================================================== 
