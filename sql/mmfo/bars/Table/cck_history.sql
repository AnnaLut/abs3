

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_HISTORY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
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


COMMENT ON TABLE BARS.CCK_HISTORY IS '';
COMMENT ON COLUMN BARS.CCK_HISTORY.NAME IS '';
COMMENT ON COLUMN BARS.CCK_HISTORY.ID IS '';
COMMENT ON COLUMN BARS.CCK_HISTORY.COMM3 IS '';
COMMENT ON COLUMN BARS.CCK_HISTORY.COMM1 IS '';
COMMENT ON COLUMN BARS.CCK_HISTORY.COMM2 IS '';




PROMPT *** Create  constraint SYS_C004970 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_HISTORY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_HISTORY     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_HISTORY     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_HISTORY     to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_HISTORY     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_HISTORY     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_HISTORY.sql =========*** End *** =
PROMPT ===================================================================================== 
