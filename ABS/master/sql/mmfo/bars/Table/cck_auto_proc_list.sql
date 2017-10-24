

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_AUTO_PROC_LIST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_AUTO_PROC_LIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_AUTO_PROC_LIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_AUTO_PROC_LIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_AUTO_PROC_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_AUTO_PROC_LIST 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(500), 
	FUNC VARCHAR2(500), 
	TYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_AUTO_PROC_LIST ***
 exec bpa.alter_policies('CCK_AUTO_PROC_LIST');


COMMENT ON TABLE BARS.CCK_AUTO_PROC_LIST IS 'Таблиця по автоматичним операціям КП';
COMMENT ON COLUMN BARS.CCK_AUTO_PROC_LIST.ID IS '';
COMMENT ON COLUMN BARS.CCK_AUTO_PROC_LIST.NAME IS '';
COMMENT ON COLUMN BARS.CCK_AUTO_PROC_LIST.FUNC IS '';
COMMENT ON COLUMN BARS.CCK_AUTO_PROC_LIST.TYPE IS '';




PROMPT *** Create  constraint SYS_C00120330 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_AUTO_PROC_LIST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_AUTO_PROC_LIST ***
grant INSERT,SELECT,UPDATE                                                   on CCK_AUTO_PROC_LIST to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_AUTO_PROC_LIST.sql =========*** En
PROMPT ===================================================================================== 
