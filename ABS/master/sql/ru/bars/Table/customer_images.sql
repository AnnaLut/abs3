

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_IMAGES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_IMAGES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_IMAGES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMER_IMAGES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_IMAGES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_IMAGES 
   (	RNK NUMBER(38,0), 
	TYPE_IMG VARCHAR2(10), 
	DATE_IMG DATE DEFAULT SYSDATE, 
	IMAGE BLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (IMAGE) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE NOLOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_IMAGES ***
 exec bpa.alter_policies('CUSTOMER_IMAGES');


COMMENT ON TABLE BARS.CUSTOMER_IMAGES IS '�������� ���������� �볺���';
COMMENT ON COLUMN BARS.CUSTOMER_IMAGES.RNK IS '������������ ����� �볺���';
COMMENT ON COLUMN BARS.CUSTOMER_IMAGES.TYPE_IMG IS '���  ����������';
COMMENT ON COLUMN BARS.CUSTOMER_IMAGES.DATE_IMG IS '���� ����������';
COMMENT ON COLUMN BARS.CUSTOMER_IMAGES.IMAGE IS '��� ����������';




PROMPT *** Create  constraint FK_CUSTOMERIMGS_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGES ADD CONSTRAINT FK_CUSTOMERIMGS_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERIMGS_TYPEIMG ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGES ADD CONSTRAINT FK_CUSTOMERIMGS_TYPEIMG FOREIGN KEY (TYPE_IMG)
	  REFERENCES BARS.CUSTOMER_IMAGE_TYPES (TYPE_IMG) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CUSTOMERIMGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGES ADD CONSTRAINT PK_CUSTOMERIMGS PRIMARY KEY (RNK, TYPE_IMG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERIMGS_DATEIMG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGES MODIFY (DATE_IMG CONSTRAINT CC_CUSTOMERIMGS_DATEIMG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERIMGS_TYPEIMG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGES MODIFY (TYPE_IMG CONSTRAINT CC_CUSTOMERIMGS_TYPEIMG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CUSTOMERIMGS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMER_IMAGES MODIFY (RNK CONSTRAINT CC_CUSTOMERIMGS_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CUSTOMERIMGS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CUSTOMERIMGS ON BARS.CUSTOMER_IMAGES (RNK, TYPE_IMG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_IMAGES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_IMAGES to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_IMAGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_IMAGES to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUSTOMER_IMAGES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_IMAGES.sql =========*** End *
PROMPT ===================================================================================== 
