BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_RISK_S580'', ''FILIAL'' , null, null, null, null);
           end; 
          '; 
END; 
/

BEGIN 
        execute immediate  
          'begin  
               execute immediate ''DROP TABLE BARS.NBUR_REF_RISK_S580 cascade constraints'';
           exception when others then null;
           end; 
          '; 
END; 
/

CREATE TABLE BARS.NBUR_REF_RISK_S580
(
  R020  VARCHAR2(4 BYTE),
  T020  VARCHAR2(1 BYTE),
  R011  VARCHAR2(1 BYTE),
  S245  VARCHAR2(1 BYTE),
  S181  VARCHAR2(1 BYTE),
  T097  VARCHAR2(1 BYTE),
  S580  VARCHAR2(1 BYTE),
  COMM  VARCHAR2(2000 BYTE)
)
TABLESPACE BRSDYND;

CREATE INDEX BARS.I1_NBUR_REF_RISK_S580 ON BARS.NBUR_REF_RISK_S580
(R020, T020, R011, S245, S181, 
T097, S580)
TABLESPACE BRSDYNI;
