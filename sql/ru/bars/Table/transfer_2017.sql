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

begin 
  execute immediate '
CREATE TABLE BARS.TRANSFER_2017
(
  R020_OLD  CHAR(4 BYTE),
  OB_OLD    CHAR(2 BYTE),
  R020_NEW  CHAR(4 BYTE),
  OB_NEW    CHAR(2 BYTE),
  DAT_BEG   DATE,
  DAT_END   DATE,
  COMM      VARCHAR2(100 BYTE),
  COL       INTEGER,
  ID1       NUMBER
)
TABLESPACE BRSDYND '
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS.TRANSFER_2017 IS '	';

COMMENT ON COLUMN BARS.TRANSFER_2017.R020_OLD IS 'Бал~OLD';

COMMENT ON COLUMN BARS.TRANSFER_2017.OB_OLD IS 'Ан~OLD  ';

COMMENT ON COLUMN BARS.TRANSFER_2017.R020_NEW IS 'Бал~NEW';

COMMENT ON COLUMN BARS.TRANSFER_2017.OB_NEW IS 'Ан~NEW  ';

COMMENT ON COLUMN BARS.TRANSFER_2017.DAT_BEG IS 'Дата поч~зміни';

COMMENT ON COLUMN BARS.TRANSFER_2017.DAT_END IS 'Дата кін~зміни';

COMMENT ON COLUMN BARS.TRANSFER_2017.COMM IS 'Коментар~';

COMMENT ON COLUMN BARS.TRANSFER_2017.COL IS 'Інд~кол';


GRANT SELECT ON BARS.TRANSFER_2017 TO UPLD;


begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_TRANSFER_2017 ON BARS.TRANSFER_2017 (R020_OLD, OB_OLD, R020_NEW, OB_NEW ) 
   TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

