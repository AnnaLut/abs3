

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LCS_DESCIPTION_EXCEPT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LCS_DESCIPTION_EXCEPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LCS_DESCIPTION_EXCEPT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LCS_DESCIPTION_EXCEPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LCS_DESCIPTION_EXCEPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.LCS_DESCIPTION_EXCEPT 
   (	ID NUMBER, 
	NAME VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LCS_DESCIPTION_EXCEPT ***
 exec bpa.alter_policies('LCS_DESCIPTION_EXCEPT');


COMMENT ON TABLE BARS.LCS_DESCIPTION_EXCEPT IS 'Словник даних для поля LCSDE - Опис виключення ';
COMMENT ON COLUMN BARS.LCS_DESCIPTION_EXCEPT.ID IS 'Ід. запису';
COMMENT ON COLUMN BARS.LCS_DESCIPTION_EXCEPT.NAME IS 'Опис виключення';




PROMPT *** Create  constraint SYS_C0012999 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LCS_DESCIPTION_EXCEPT ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012999 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012999 ON BARS.LCS_DESCIPTION_EXCEPT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LCS_DESCIPTION_EXCEPT ***
grant SELECT                                                                 on LCS_DESCIPTION_EXCEPT to ABS_ADMIN;
grant SELECT                                                                 on LCS_DESCIPTION_EXCEPT to BARSREADER_ROLE;
grant SELECT                                                                 on LCS_DESCIPTION_EXCEPT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LCS_DESCIPTION_EXCEPT to BARS_DM;
grant SELECT                                                                 on LCS_DESCIPTION_EXCEPT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LCS_DESCIPTION_EXCEPT.sql =========***
PROMPT ===================================================================================== 
