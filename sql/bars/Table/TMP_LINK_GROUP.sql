begin 
  execute immediate '
     DROP TABLE BARS.TMP_LINK_GROUP CASCADE CONSTRAINTS';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
     CREATE GLOBAL TEMPORARY TABLE BARS.TMP_LINK_GROUP
    ( RNK         NUMBER(38)                        NOT NULL,
      LINK_GROUP  NUMBER,
      LINK_CODE   VARCHAR2(3 BYTE),
      LINK_NAME   VARCHAR2(70 BYTE)
    )
     ON COMMIT PRESERVE ROWS
     RESULT_CACHE (MODE DEFAULT)
     NOCACHE';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
     CREATE INDEX BARS.I1_TMP_LINK_GROUP ON BARS.TMP_LINK_GROUP
     (RNK)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin 
  execute immediate '
     CREATE INDEX BARS.I2_TMP_LINK_GROUP ON BARS.TMP_LINK_GROUP
     (LINK_GROUP, RNK)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


GRANT SELECT ON BARS.TMP_LINK_GROUP TO RPBN002;
