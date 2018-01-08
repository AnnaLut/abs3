PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IFRS.sql =========*** Run *** =====
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to IFRS ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IFRS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IFRS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IFRS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table IFRS ***
begin 
  execute immediate '
CREATE TABLE BARS.IFRS
(
  IFRS_ID    VARCHAR2(15 BYTE) NOT NULL,
  IFRS_NAME  VARCHAR2(100 BYTE)
) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
  NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON TABLE BARS.IFRS IS 'Класифікаіція за МСФЗ';

COMMENT ON COLUMN BARS.IFRS.IFRS_ID IS 'Параметр';

COMMENT ON COLUMN BARS.IFRS.IFRS_NAME IS 'Наименование параметра';



PROMPT *** Create  constraint PK_IFRS***
begin   
 execute immediate '
  ALTER TABLE BARS.IFRS  ADD CONSTRAINT PK_IFRS  PRIMARY KEY (IFRS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  IFRS ***
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.IFRS TO BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IFRS.sql =========*** End *** =====
PROMPT ===================================================================================== 