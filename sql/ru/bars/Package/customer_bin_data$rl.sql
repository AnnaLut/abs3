
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/customer_bin_data$rl.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CUSTOMER_BIN_DATA$RL as
  PROCEDURE blob_update (
    "pk_ID" IN NUMBER,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN BLOB,
    old_length$ IN NUMBER,
    new_range$ IN BLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR);
  PROCEDURE clob_update (
    "pk_ID" IN NUMBER,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN CLOB,
    old_length$ IN NUMBER,
    new_range$ IN CLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR);
  PROCEDURE nclob_update (
    "pk_ID" IN NUMBER,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN NCLOB,
    old_length$ IN NUMBER,
    new_range$ IN NCLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR);
end "CUSTOMER_BIN_DATA$RL";
/
CREATE OR REPLACE PACKAGE BODY BARS.CUSTOMER_BIN_DATA$RL as
  PROCEDURE blob_update (
    "pk_ID" IN NUMBER,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN BLOB,
    old_length$ IN NUMBER,
    new_range$ IN BLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR) IS
  BEGIN
    DBMS_REPCAT_INTERNAL_PACKAGE.CALL(
      'BARS','CUSTOMER_BIN_DATA','BLOB_UPDATE',9);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ID");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(col_id$);
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG(operation$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(offset$);
    DBMS_REPCAT_INTERNAL_PACKAGE.BLOB_ARG(old_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(old_length$);
    DBMS_REPCAT_INTERNAL_PACKAGE.BLOB_ARG(new_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.RAW_ARG(flag$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CHAR_ARG(propagation_flag$);
  END BLOB_UPDATE;
  PROCEDURE clob_update (
    "pk_ID" IN NUMBER,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN CLOB,
    old_length$ IN NUMBER,
    new_range$ IN CLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR) IS
  BEGIN
    DBMS_REPCAT_INTERNAL_PACKAGE.CALL(
      'BARS','CUSTOMER_BIN_DATA','CLOB_UPDATE',9);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ID");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(col_id$);
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG(operation$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(offset$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(old_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(old_length$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(new_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.RAW_ARG(flag$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CHAR_ARG(propagation_flag$);
  END CLOB_UPDATE;
  PROCEDURE nclob_update (
    "pk_ID" IN NUMBER,
    col_id$ IN NUMBER,
    operation$ IN VARCHAR2,
    offset$ IN NUMBER,
    old_range$ IN NCLOB,
    old_length$ IN NUMBER,
    new_range$ IN NCLOB,
    flag$ IN RAW,
    propagation_flag$ IN CHAR) IS
  BEGIN
    DBMS_REPCAT_INTERNAL_PACKAGE.CALL(
      'BARS','CUSTOMER_BIN_DATA','NCLOB_UPDATE',9);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG( "pk_ID");
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(col_id$);
    DBMS_REPCAT_INTERNAL_PACKAGE.VARCHAR2_ARG(operation$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(offset$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(old_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.NUMBER_ARG(old_length$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CLOB_ARG(new_range$);
    DBMS_REPCAT_INTERNAL_PACKAGE.RAW_ARG(flag$);
    DBMS_REPCAT_INTERNAL_PACKAGE.CHAR_ARG(propagation_flag$);
  END NCLOB_UPDATE;
end "CUSTOMER_BIN_DATA$RL";
/
 show err;
 
PROMPT *** Create  grants  CUSTOMER_BIN_DATA$RL ***
grant EXECUTE                                                                on CUSTOMER_BIN_DATA$RL to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/customer_bin_data$rl.sql =========**
 PROMPT ===================================================================================== 
 