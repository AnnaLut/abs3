

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REZERV23_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REZERV23_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REZERV23_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REZERV23_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REZERV23_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REZERV23_UPDATE 
   (	ID NUMBER(*,0), 
	REF NUMBER, 
	DATE_REPORT DATE, 
	S_REZERV23 NUMBER, 
	CHANGETYPE CHAR(1), 
	USERID NUMBER, 
	EFFECTDATE TIMESTAMP (6) DEFAULT sysdate, 
	CP_COUNT NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REZERV23_UPDATE ***
 exec bpa.alter_policies('CP_REZERV23_UPDATE');


COMMENT ON TABLE BARS.CP_REZERV23_UPDATE IS '����� �� ������� �������� � ������� ����� ��';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.ID IS 'ID ��';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.REF IS 'REF ������';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.DATE_REPORT IS '�������� ���� ��� �������23';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.S_REZERV23 IS '����� ��� �������23';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.CHANGETYPE IS '��� ���������';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.USERID IS '����� ������������, �������� ���������';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.EFFECTDATE IS '����� ����-�����';
COMMENT ON COLUMN BARS.CP_REZERV23_UPDATE.CP_COUNT IS '���������� ���� � ������';




PROMPT *** Create  constraint SYS_C002945892 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REZERV23_UPDATE MODIFY (DATE_REPORT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_REZERV23_UPDATE ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_REZERV23_UPDATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REZERV23_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
