

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_CHECK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_CHECK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_CHECK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_CHECK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_CHECK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_CHECK 
   (	ID NUMBER, 
	COMM VARCHAR2(150)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_CHECK ***
 exec bpa.alter_policies('CP_CHECK');


COMMENT ON TABLE BARS.CP_CHECK IS '������ �� ��� �������� ������� ������� ��� ����� ��������� �������';
COMMENT ON COLUMN BARS.CP_CHECK.ID IS '������������� ��';
COMMENT ON COLUMN BARS.CP_CHECK.COMM IS '�����������';




PROMPT *** Create  constraint FK_CP_CHECK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_CHECK ADD CONSTRAINT FK_CP_CHECK FOREIGN KEY (ID)
	  REFERENCES BARS.CP_KOD (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_CHECK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_CHECK ON BARS.CP_CHECK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_CHECK ***
grant SELECT                                                                 on CP_CHECK        to BARSUPL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CP_CHECK        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_CHECK.sql =========*** End *** ====
PROMPT ===================================================================================== 
