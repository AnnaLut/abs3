
PROMPT *** ALTER_POLICY_INFO to FR_PRINT_FORMAT ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FR_PRINT_FORMAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FR_PRINT_FORMAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FR_PRINT_FORMAT ***

BEGIN 
        execute immediate  
          'CREATE TABLE BARS.FR_PRINT_FORMAT
(
  ID               NUMBER(3),
  FR_PRINT_FORMAT  VARCHAR2(30 BYTE)
)
TABLESPACE BRSDYND
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to FR_PRINT_FORMAT ***
 exec bpa.alter_policies('FR_PRINT_FORMAT');

COMMENT ON  COLUMN BARS.FR_PRINT_FORMAT.FR_PRINT_FORMAT IS 'Формат друку';
COMMENT ON  COLUMN BARS.FR_PRINT_FORMAT.ID              IS 'Код формату';

PROMPT *** Create  constraint PK_FRPRINTFORMAT ***

begin   
 execute immediate '
ALTER TABLE BARS.FR_PRINT_FORMAT ADD (
  CONSTRAINT PK_FRPRINTFORMAT
  PRIMARY KEY
  (ID)
  ENABLE VALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  FR_PRINT_FORMAT ***

grant SELECT on FR_PRINT_FORMAT to BARS_ACCESS_DEFROLE;
/  
  