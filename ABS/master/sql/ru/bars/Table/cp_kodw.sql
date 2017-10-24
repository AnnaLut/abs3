

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_KODW.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_KODW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_KODW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_KODW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_KODW ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_KODW 
   (	ID NUMBER, 
	TAG VARCHAR2(5), 
	VALUE VARCHAR2(500)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_KODW ***
 exec bpa.alter_policies('CP_KODW');


COMMENT ON TABLE BARS.CP_KODW IS '���. �������� ��';
COMMENT ON COLUMN BARS.CP_KODW.ID IS '��� ��';
COMMENT ON COLUMN BARS.CP_KODW.TAG IS '��� ���. ��������';
COMMENT ON COLUMN BARS.CP_KODW.VALUE IS '�������� ���. ��������';




PROMPT *** Create  constraint CP_KODW_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KODW ADD CONSTRAINT CP_KODW_TAG FOREIGN KEY (TAG)
	  REFERENCES BARS.CP_TAG (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CPKODW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_KODW ADD CONSTRAINT XPK_CPKODW PRIMARY KEY (ID, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CPKODW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CPKODW ON BARS.CP_KODW (ID, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_KODW.sql =========*** End *** =====
PROMPT ===================================================================================== 
