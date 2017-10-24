

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_HISTORY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_HISTORY'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_HISTORY 
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




PROMPT *** ALTER_POLICIES to CCK_HISTORY ***
 exec bpa.alter_policies('CCK_HISTORY');


COMMENT ON TABLE BARS.CCK_HISTORY IS 'ОБ:Кредитна iсторiя';
COMMENT ON COLUMN BARS.CCK_HISTORY.NAME IS 'Назва';
COMMENT ON COLUMN BARS.CCK_HISTORY.ID IS 'Код';
COMMENT ON COLUMN BARS.CCK_HISTORY.COMM3 IS 'Коментар-3=ФО';
COMMENT ON COLUMN BARS.CCK_HISTORY.COMM1 IS 'Коментар-1=Банки';
COMMENT ON COLUMN BARS.CCK_HISTORY.COMM2 IS 'Коментар-2=ЮО';




PROMPT *** Create  constraint PK_CCKHISTORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_HISTORY ADD CONSTRAINT PK_CCKHISTORY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCKHISTORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCKHISTORY ON BARS.CCK_HISTORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_HISTORY ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_HISTORY     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_HISTORY     to START1;
grant FLASHBACK,SELECT                                                       on CCK_HISTORY     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_HISTORY.sql =========*** End *** =
PROMPT ===================================================================================== 
