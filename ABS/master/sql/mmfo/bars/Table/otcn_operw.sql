

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_OPERW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_OPERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_OPERW'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_OPERW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_OPERW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_OPERW ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_OPERW 
   (	REF NUMBER(38,0), 
	VALUE VARCHAR2(220)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_OPERW ***
 exec bpa.alter_policies('OTCN_OPERW');


COMMENT ON TABLE BARS.OTCN_OPERW IS '';
COMMENT ON COLUMN BARS.OTCN_OPERW.REF IS '';
COMMENT ON COLUMN BARS.OTCN_OPERW.VALUE IS '';




PROMPT *** Create  constraint SYS_C0010226 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_OPERW MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_OPERW ***
grant SELECT                                                                 on OTCN_OPERW      to BARSREADER_ROLE;
grant SELECT                                                                 on OTCN_OPERW      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_OPERW.sql =========*** End *** ==
PROMPT ===================================================================================== 
