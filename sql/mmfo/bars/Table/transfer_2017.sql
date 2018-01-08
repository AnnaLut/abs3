

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TRANSFER_2017.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TRANSFER_2017 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TRANSFER_2017'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TRANSFER_2017'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TRANSFER_2017 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TRANSFER_2017 
   (	R020_OLD CHAR(4), 
	OB_OLD CHAR(2), 
	R020_NEW CHAR(4), 
	OB_NEW CHAR(2), 
	DAT_BEG DATE, 
	DAT_END DATE, 
	COMM VARCHAR2(100), 
	COL NUMBER(*,0), 
	ID1 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TRANSFER_2017 ***
 exec bpa.alter_policies('TRANSFER_2017');


COMMENT ON TABLE BARS.TRANSFER_2017 IS '	';
COMMENT ON COLUMN BARS.TRANSFER_2017.R020_OLD IS 'Бал~OLD';
COMMENT ON COLUMN BARS.TRANSFER_2017.OB_OLD IS 'Ан~OLD  ';
COMMENT ON COLUMN BARS.TRANSFER_2017.R020_NEW IS 'Бал~NEW';
COMMENT ON COLUMN BARS.TRANSFER_2017.OB_NEW IS 'Ан~NEW  ';
COMMENT ON COLUMN BARS.TRANSFER_2017.DAT_BEG IS 'Дата поч~зміни';
COMMENT ON COLUMN BARS.TRANSFER_2017.DAT_END IS 'Дата кін~зміни';
COMMENT ON COLUMN BARS.TRANSFER_2017.COMM IS 'Коментар~';
COMMENT ON COLUMN BARS.TRANSFER_2017.COL IS 'Інд~кол';
COMMENT ON COLUMN BARS.TRANSFER_2017.ID1 IS '';




PROMPT *** Create  index XUK_TRANSFER_2017 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_TRANSFER_2017 ON BARS.TRANSFER_2017 (R020_OLD, OB_OLD, R020_NEW, OB_NEW) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TRANSFER_2017 ***
grant SELECT                                                                 on TRANSFER_2017   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TRANSFER_2017.sql =========*** End ***
PROMPT ===================================================================================== 
