

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/YES_NO.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to YES_NO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''YES_NO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''YES_NO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''YES_NO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table YES_NO ***
begin 
  execute immediate '
  CREATE TABLE BARS.YES_NO 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to YES_NO ***
 exec bpa.alter_policies('YES_NO');


COMMENT ON TABLE BARS.YES_NO IS 'Довідник значень';
COMMENT ON COLUMN BARS.YES_NO.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.YES_NO.NAME IS 'Значение';




PROMPT *** Create  constraint PK_YES_NO ***
begin   
 execute immediate '
  ALTER TABLE BARS.YES_NO ADD CONSTRAINT PK_YES_NO PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_YES_NO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_YES_NO ON BARS.YES_NO (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  YES_NO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on YES_NO          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on YES_NO          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on YES_NO          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/YES_NO.sql =========*** End *** ======
PROMPT ===================================================================================== 
