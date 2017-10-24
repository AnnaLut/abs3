

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_VALUES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_VALUES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_VALUES'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_VALUES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_VALUES 
   (	NESTED_TABLE_ID NUMBER(38,0), 
	NUMBER_VALUES NUMBER(38,12), 
	STRING_VALUES VARCHAR2(4000), 
	DATE_VALUES DATE, 
	BLOB_VALUES BLOB, 
	CLOB_VALUES CLOB
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSBIGD 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
  PARTITION BY HASH (NESTED_TABLE_ID) 
 (PARTITION SYS_P1766 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1767 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1768 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1769 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1770 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1771 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1772 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1773 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1774 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1775 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1776 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1777 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1778 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1779 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1780 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1781 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1782 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1783 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1784 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1785 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1786 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1787 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1788 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1789 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1790 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1791 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1792 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1793 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1794 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1795 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1796 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS , 
 PARTITION SYS_P1797 SEGMENT CREATION IMMEDIATE 
 LOB (BLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
 LOB (CLOB_VALUES) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ) 
  TABLESPACE BRSBIGD 
 NOCOMPRESS ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_VALUES ***
 exec bpa.alter_policies('ATTRIBUTE_VALUES');


COMMENT ON TABLE BARS.ATTRIBUTE_VALUES IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUES.BLOB_VALUES IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUES.CLOB_VALUES IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUES.STRING_VALUES IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUES.DATE_VALUES IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUES.NESTED_TABLE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_VALUES.NUMBER_VALUES IS '';




PROMPT *** Create  constraint SYS_C0025696 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_VALUES MODIFY (NESTED_TABLE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ATTRIBUTE_VALUES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ATTRIBUTE_VALUES ON BARS.ATTRIBUTE_VALUES (NESTED_TABLE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION SYS_P234979 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234980 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234981 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234982 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234983 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234984 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234985 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234986 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234987 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234988 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234989 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234990 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234991 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234992 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234993 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234994 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234995 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234996 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234997 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234998 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P234999 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235000 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235001 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235002 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235003 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235004 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235005 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235006 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235007 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235008 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235009 
  TABLESPACE BRSBIGD , 
 PARTITION SYS_P235010 
  TABLESPACE BRSBIGD ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_VALUES ***
grant SELECT                                                                 on ATTRIBUTE_VALUES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_VALUES.sql =========*** End 
PROMPT ===================================================================================== 
