

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TASK_METHOD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TASK_METHOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TASK_METHOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TASK_METHOD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TASK_METHOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TASK_METHOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TASK_METHOD 
   (	METHOD NUMBER, 
	NAME VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TASK_METHOD ***
 exec bpa.alter_policies('TASK_METHOD');


COMMENT ON TABLE BARS.TASK_METHOD IS '';
COMMENT ON COLUMN BARS.TASK_METHOD.METHOD IS '';
COMMENT ON COLUMN BARS.TASK_METHOD.NAME IS '';




PROMPT *** Create  constraint XPK_TASK_METHOD_METHOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.TASK_METHOD ADD CONSTRAINT XPK_TASK_METHOD_METHOD PRIMARY KEY (METHOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TASK_METHOD_METHOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TASK_METHOD_METHOD ON BARS.TASK_METHOD (METHOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TASK_METHOD ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on TASK_METHOD     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TASK_METHOD     to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TASK_METHOD     to TASK_LIST;
grant DELETE,INSERT,SELECT,UPDATE                                            on TASK_METHOD     to TASK_METHOD;
grant FLASHBACK,SELECT                                                       on TASK_METHOD     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TASK_METHOD.sql =========*** End *** =
PROMPT ===================================================================================== 
