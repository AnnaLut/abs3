begin    
execute immediate  ' CREATE TABLE BARS.TMP_XOZ_OPER
(
  S1    NUMBER(24),
  S2    NUMBER(24),
  S     NUMBER(24),
  NLSA  VARCHAR2(14 BYTE),
  NAMA  VARCHAR2(38 BYTE),
  NLSB  VARCHAR2(14 BYTE),
  NAMB  VARCHAR2(38 BYTE),
  ND    CHAR(10 BYTE),
  MFOA  VARCHAR2(12 BYTE),
  MFOB  VARCHAR2(12 BYTE),
  SOS   NUMBER(1),
  REC   NUMBER(38),
  REF   NUMBER(38),
  DK    NUMBER(1)
)
 ' ;     
exception when others then   if SQLCODE = -00955 then null;   else raise; end if;  --- ORA-00955: name is already used by an existing object
end;
/
