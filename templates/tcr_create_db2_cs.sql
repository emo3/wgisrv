-- Licensed Materials - Property of IBM
--
-- BI and PM: CM
--
-- (C) Copyright IBM Corp. 2010
--
-- US Government Users Restricted Rights - Use, duplication or disclosure
-- restricted by GSA ADP Schedule Contract with IBM Corp.

-- Copyright (C) 2008 Cognos ULC, an IBM Company. All rights reserved.
-- Cognos (R) is a trademark of Cognos ULC, (formerly Cognos Incorporated).

-- Use this script to create the IBM Cognos content database.
-- TCRDB : Database name
-- omni01 : User ID, this account is used by the product to connect to the content store
-- This script must be run as a user that has sufficient privileges to access and create the database.
-- The database user account needs to exist for the product to function.

CREATE DATABASE TCRDB ALIAS TCRDB USING CODESET UTF-8 TERRITORY US;
CHANGE DATABASE TCRDB COMMENT WITH 'IBM Cognos Content Store';

CONNECT TO TCRDB;
UPDATE DATABASE CONFIGURATION USING APPLHEAPSZ 1024 DEFERRED;
UPDATE DATABASE CONFIGURATION USING LOCKTIMEOUT 240 DEFERRED;
CONNECT RESET;

CONNECT TO TCRDB;
CREATE BUFFERPOOL TCRDB_08KBP IMMEDIATE SIZE 1000 PAGESIZE 8K;
CREATE BUFFERPOOL TCRDB_32KBP IMMEDIATE SIZE 1000 PAGESIZE 32K;
CONNECT RESET;

CONNECT TO TCRDB;
CREATE SYSTEM TEMPORARY TABLESPACE TSN_SYS_TCRDB IN DATABASE PARTITION GROUP IBMTEMPGROUP PAGESIZE 32K BUFFERPOOL TCRDB_32KBP;
CREATE USER TEMPORARY TABLESPACE TSN_USR_TCRDB IN DATABASE PARTITION GROUP IBMDEFAULTGROUP PAGESIZE 8K BUFFERPOOL TCRDB_08KBP;
CREATE REGULAR TABLESPACE TSN_REG_TCRDB IN DATABASE PARTITION GROUP IBMDEFAULTGROUP PAGESIZE 8K BUFFERPOOL TCRDB_08KBP;
CONNECT RESET;

CONNECT TO TCRDB;
CREATE SCHEMA omni01 AUTHORIZATION omni01;
COMMENT ON SCHEMA omni01 IS 'IBM Cognos Content Store';
GRANT CREATETAB,BINDADD,CONNECT,IMPLICIT_SCHEMA ON DATABASE TO USER omni01;
GRANT CREATEIN,DROPIN,ALTERIN ON SCHEMA omni01 TO USER omni01 WITH GRANT OPTION;
GRANT USE OF TABLESPACE TSN_USR_TCRDB TO USER omni01;
GRANT USE OF TABLESPACE TSN_REG_TCRDB TO USER omni01;
CONNECT RESET;
