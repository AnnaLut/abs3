

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TICKETS_ADVERTISING_BRANCH.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TICKETS_ADVERTISING_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TICKETS_ADVERTISING_BRANCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TICKETS_ADVERTISING_BRANCH'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''TICKETS_ADVERTISING_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TICKETS_ADVERTISING_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TICKETS_ADVERTISING_BRANCH 
   (	ADVERTISING_ID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TICKETS_ADVERTISING_BRANCH ***
 exec bpa.alter_policies('TICKETS_ADVERTISING_BRANCH');


COMMENT ON TABLE BARS.TICKETS_ADVERTISING_BRANCH IS 'Довідник рекламне повідомлення - бранч';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING_BRANCH.ADVERTISING_ID IS 'Ід. реклами';
COMMENT ON COLUMN BARS.TICKETS_ADVERTISING_BRANCH.BRANCH IS 'Бранч';




PROMPT *** Create  constraint SYS_C009414 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_ADVERTISING_BRANCH MODIFY (ADVERTISING_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009415 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TICKETS_ADVERTISING_BRANCH MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TICKETS_ADVERTISING_BRANCH ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TICKETS_ADVERTISING_BRANCH to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TICKETS_ADVERTISING_BRANCH.sql =======
PROMPT ===================================================================================== 
